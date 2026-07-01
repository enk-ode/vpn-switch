#!/bin/sh
# WireGuard DNS inspect - Diagnostic output for DNS configuration

cat <<'EOF'
echo "### DNS Phase"
echo "DNS Server (from config): $dns_server"
echo ""
echo "Current DNS Configuration:"
cat /etc/resolv.conf 2>/dev/null || echo "⚠ Cannot read /etc/resolv.conf"
echo ""
echo "Resolvconf Helper Status:"
if [ -x /usr/local/sbin/wg-resolvconf-up ]; then
    echo "✓ wg-resolvconf-up available"
else
    echo "⚠ wg-resolvconf-up not found (DNS may not be configured)"
fi
EOF
