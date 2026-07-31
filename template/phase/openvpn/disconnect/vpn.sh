#!/bin/sh
# VPN phase for OpenVPN disconnection
# Stops OpenVPN daemon

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
                echo "WARNING: OpenVPN PID file not found" >&2
                echo "WARNING: OpenVPN may not be running or was started manually" >&2
                # Non-fatal - continue with cleanup
            else
                echo "✓ VPN disconnect ready" >&2
            fi
            ;;
        execute)
            if [ "$exit_code" -ne 0 ]; then
                echo "WARNING: OpenVPN stop failed" >&2
                echo "WARNING: Process may still be running" >&2
                # Non-fatal - continue with cleanup
            else
                echo "✓ OpenVPN stopped successfully" >&2
            fi
            ;;
    esac
}
EOF
        ;;

    prepare)
        cat <<'EOF'
echo "==> Phase: vpn (prepare)" >&2
# Check if PID file exists
test -f "$session_dir/vpn.pid"
verify_vpn prepare $?
EOF
        ;;

    execute)
        cat <<'EOF'
echo "==> Phase: vpn (execute)" >&2

# Stop OpenVPN daemon
if [ -f "$session_dir/vpn.pid" ]; then
    vpn_pid=$(cat "$session_dir/vpn.pid")
    if [ -n "$vpn_pid" ]; then
        # Send SIGTERM to OpenVPN
        kill -TERM "$vpn_pid" 2>/dev/null
        exit_code=$?

        # Wait briefly for clean shutdown
        sleep 1

        # Force kill if still running
        if kill -0 "$vpn_pid" 2>/dev/null; then
            kill -KILL "$vpn_pid" 2>/dev/null || true
        fi
    else
        exit_code=1
    fi
    rm -f "$session_dir/vpn.pid"
else
    exit_code=1
fi

verify_vpn execute $exit_code
EOF
        ;;

    *)
        echo "Usage: $0 {verify|prepare|execute}" >&2
        exit 1
        ;;
esac
