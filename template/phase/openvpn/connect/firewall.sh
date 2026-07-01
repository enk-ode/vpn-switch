#!/bin/sh
# Firewall phase for OpenVPN connection
# Configures PF packet filter with VPN DNS and remote endpoints

# Unpack context variables (for generation-time expansion)
eval "$VPN_SWITCH_CONTEXT_CONNECT"

case "$1" in
    verify)
        cat <<'EOF'
# Verify function for firewall phase
verify_firewall() {
    local step="$1"
    local exit_code="$2"

    case "$step" in
        prepare)
            if [ "$exit_code" -ne 0 ]; then
                echo "ERROR: Firewall prepare failed (pfctl not available)" >&2
                exit 1  # Fatal - can't proceed without firewall
            fi
            echo "✓ Firewall prerequisites met" >&2
            ;;
        execute)
            if [ "$exit_code" -ne 0 ]; then
                echo "ERROR: Firewall configuration failed" >&2
                exit 1  # Fatal
            fi
            echo "✓ Firewall configured successfully" >&2
            ;;
    esac
}
EOF
        ;;

    prepare)
        cat <<'EOF'
echo "==> Phase: firewall (prepare)" >&2
# Firewall prepare step - verification happens in execute
verify_firewall prepare 0
EOF
        ;;

    execute)
        # Variables like $VPN_DNS_SERVER expanded at generation time (from context)
        cat <<EOF
echo "==> Phase: firewall (execute)" >&2

# Update PF macros for interface
tmp=\$(mktemp)
cat > "\$tmp" <<PFEOF
ext_if = "${VPN_SWITCH_EXT_IF:-em0}"
vpn_if = "$VPN_INTERFACE"
PFEOF
\$install -m 0644 -o root -g wheel "\$tmp" /etc/pf.macros/interfaces
rm "\$tmp"

# Update PF table for VPN DNS
tmp=\$(mktemp)
cat > "\$tmp" <<PFEOF
$VPN_DNS_SERVER
PFEOF
\$install -m 0644 -o root -g wheel "\$tmp" /etc/pf.tables/vpn_dns
rm "\$tmp"

# Update PF table for VPN remotes
tmp=\$(mktemp)
cat > "\$tmp" <<PFEOF
$VPN_REMOTE_IPS
PFEOF
\$install -m 0644 -o root -g wheel "\$tmp" /etc/pf.tables/vpn_remotes
rm "\$tmp"

# Reload PF configuration (uses \$pfctl from prologue)
\$pfctl -f /etc/pf.conf 2>/dev/null
verify_firewall execute \$?
EOF
        ;;

    *)
        echo "Usage: $0 {verify|prepare|execute}" >&2
        exit 1
        ;;
esac
