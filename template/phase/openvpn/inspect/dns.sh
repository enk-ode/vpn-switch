#!/bin/sh
# OpenVPN DNS inspect - Diagnostic output for DNS configuration

cat <<'EOF'
echo "### DNS Phase"
echo "DNS Server (from config): $dns_server"
echo ""
echo "Current DNS Configuration:"
cat /etc/resolv.conf 2>/dev/null || echo "⚠ Cannot read /etc/resolv.conf"
echo ""
echo "Resolvconf Helper Status:"
if [ -x /usr/local/sbin/ovpn-resolvconf-up ]; then
    echo "✓ ovpn-resolvconf-up available"
else
    echo "⚠ ovpn-resolvconf-up not found (DNS may not be configured)"
fi
EOF
