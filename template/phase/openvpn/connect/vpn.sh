#!/bin/sh
# VPN phase for OpenVPN connection
# Starts OpenVPN daemon

# Unpack context variables (for generation-time expansion)
eval "$VPN_SWITCH_CONTEXT_CONNECT"

case "$1" in
    verify)
        cat <<'EOF'
# Verify function for vpn phase
verify_vpn() {
    local step="$1"
    local exit_code="$2"

    case "$step" in
        prepare)
            if [ "$exit_code" -ne 0 ]; then
                echo "ERROR: VPN prepare failed (openvpn not available)" >&2
                exit 1  # Fatal
            fi
            echo "✓ VPN prerequisites met" >&2
            ;;
        execute)
            if [ "$exit_code" -ne 0 ]; then
                echo "ERROR: OpenVPN failed to start" >&2
                exit 1  # Fatal
            fi
            echo "✓ OpenVPN started successfully" >&2
            ;;
    esac
}
EOF
        ;;

    prepare)
        cat <<'EOF'
echo "==> Phase: vpn (prepare)" >&2
# VPN prepare step - verification happens in execute
verify_vpn prepare 0
EOF
        ;;

    execute)
        # Expand command at generation time, keep runtime variables escaped
        cat <<EOF
echo "==> Phase: vpn (execute)" >&2

# Start OpenVPN in daemon mode with PID file
$VPN_SWITCH_BINARY_openvpn \\
    --config "\$config_path" \\
    --daemon \\
    --writepid "\$session_dir/vpn.pid"

exit_code=\$?
chmod 0640 "\$session_dir/vpn.pid" 2>/dev/null || true
verify_vpn execute \$exit_code
EOF
        ;;

    *)
        echo "Usage: $0 {verify|prepare|execute}" >&2
        exit 1
        ;;
esac
