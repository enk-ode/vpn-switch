#!/bin/sh
# VPN phase for WireGuard connection
# Brings up WireGuard interface using wg-quick

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
                echo "ERROR: VPN prepare failed (wg-quick not available)" >&2
                exit 1  # Fatal
            fi
            echo "✓ VPN prerequisites met" >&2
            ;;
        execute)
            if [ "$exit_code" -ne 0 ]; then
                echo "ERROR: VPN interface failed to start" >&2
                exit 1  # Fatal
            fi
            echo "✓ VPN interface up: $interface" >&2
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

# Start WireGuard with pre-patched config and capture PID
# Background the process to capture PID, then wait for completion
$VPN_SWITCH_BINARY_wireguard up "\$config_path" &
vpn_pid=\$!
echo "\$vpn_pid" > "\$session_dir/vpn.pid"
chmod 0640 "\$session_dir/vpn.pid"
wait \$vpn_pid
verify_vpn execute \$?
EOF
        ;;

    *)
        echo "Usage: $0 {verify|prepare|execute}" >&2
        exit 1
        ;;
esac
