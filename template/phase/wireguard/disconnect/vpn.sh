#!/bin/sh
# VPN phase for WireGuard disconnection
# Brings down WireGuard interface using wg-quick

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
                echo "ERROR: VPN disconnect prepare failed" >&2
                exit 1  # Fatal
            fi
            echo "✓ VPN disconnect ready" >&2
            ;;
        execute)
            if [ "$exit_code" -ne 0 ]; then
                echo "WARNING: VPN interface disconnect failed" >&2
                echo "WARNING: Interface may still be up" >&2
                # Non-fatal - continue with cleanup
            else
                echo "✓ VPN interface down: $interface" >&2
            fi
            ;;
    esac
}
EOF
        ;;

    prepare)
        cat <<'EOF'
echo "==> Phase: vpn (prepare)" >&2
# VPN disconnect prepare step - verification happens in execute
verify_vpn prepare 0
EOF
        ;;

    execute)
        # Expand command at generation time, keep runtime variables escaped
        cat <<EOF
echo "==> Phase: vpn (execute)" >&2

# Bring down WireGuard interface
$VPN_SWITCH_BINARY_wireguard down "\$config_path"
exit_code=\$?

# Kill wg-quick process group if PID file exists
if [ -f "\$session_dir/vpn.pid" ]; then
    vpn_pid=\$(cat "\$session_dir/vpn.pid")
    if [ -n "\$vpn_pid" ]; then
        # Kill process group to clean up any child processes
        kill -TERM -\$vpn_pid 2>/dev/null || true
    fi
    rm -f "\$session_dir/vpn.pid"
fi

verify_vpn execute \$exit_code
EOF
        ;;

    *)
        echo "Usage: $0 {verify|prepare|execute}" >&2
        exit 1
        ;;
esac
