#!/bin/sh
# DNS phase for OpenVPN connection
# Configures DNS resolution via resolvconf

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
            if [ "$exit_code" -ne 0 ]; then
                echo "WARNING: DNS prepare failed (resolvconf not available)" >&2
                echo "WARNING: VPN will work but DNS may not be configured" >&2
                # Non-fatal - VPN can work without DNS configuration
            else
                echo "✓ DNS prerequisites met" >&2
            fi
            ;;
        execute)
            if [ "$exit_code" -ne 0 ]; then
                echo "WARNING: DNS configuration failed" >&2
                echo "WARNING: You may need to configure DNS manually" >&2
                # Non-fatal - VPN is already up
            else
                echo "✓ DNS configured successfully" >&2
            fi
            ;;
    esac
}
EOF
        ;;

    prepare)
        cat <<'EOF'
echo "==> Phase: dns (prepare)" >&2
# Check resolvconf availability (optional - VPN works without it)
command -v /usr/local/sbin/ovpn-resolvconf-up >/dev/null 2>&1
verify_dns prepare $?
EOF
        ;;

    execute)
        # Variables like $dns_server expanded at generation time (from context)
        cat <<EOF
echo "==> Phase: dns (execute)" >&2
# Configure DNS via resolvconf (VPN provider uses fixed DNS per protocol)
# OpenVPN: 10.96.0.1, WireGuard: 10.2.0.1
if command -v /sbin/resolvconf >/dev/null 2>&1; then
    echo "nameserver $VPN_DNS_SERVER" | /sbin/resolvconf -x -a "\$interface.inet"
    resolvconf_exit=\$?

    # Reload local_unbound to pick up resolvconf changes (critical!)
    if service local_unbound status >/dev/null 2>&1; then
        service local_unbound reload >/dev/null 2>&1 || true
    fi

    verify_dns execute \$resolvconf_exit
else
    echo "WARNING: resolvconf not available" >&2
    verify_dns execute 1
fi
EOF
        ;;

        *)
        echo "Usage: $0 {verify|prepare|execute}" >&2
        exit 1
        ;;
esac
