#!/bin/sh
# DNS phase for WireGuard disconnection
# Restores original DNS configuration

# Unpack context variables (for generation-time expansion)
eval "$VPN_SWITCH_CONTEXT_CONNECT"

case "$1" in
    verify)
        cat <<'EOF'
# Verify function for dns phase
verify_dns() {
    local step="$1"
    local exit_code="$2"

    case "$step" in
        prepare)
            # DNS restoration is optional
            echo "✓ DNS restore ready" >&2
            ;;
        execute)
            if [ "$exit_code" -ne 0 ]; then
                echo "WARNING: DNS restoration failed" >&2
                # Non-fatal
            else
                echo "✓ DNS restored successfully" >&2
            fi
            ;;
    esac
}
EOF
        ;;

    prepare)
        cat <<'EOF'
echo "==> Phase: dns (prepare)" >&2
# No prerequisites for DNS restoration
verify_dns prepare 0
EOF
        ;;

    execute)
        cat <<'EOF'
echo "==> Phase: dns (execute)" >&2
# Restore DNS via resolvconf helper
if [ -x /usr/local/sbin/wg-resolvconf-down ]; then
    /usr/local/sbin/wg-resolvconf-down "$interface"
    verify_dns execute $?
else
    verify_dns execute 1
fi
EOF
        ;;

    *)
        echo "Usage: $0 {verify|prepare|execute}" >&2
        exit 1
        ;;
esac
