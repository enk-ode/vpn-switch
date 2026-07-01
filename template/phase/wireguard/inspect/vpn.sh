#!/bin/sh
# WireGuard VPN inspect - Diagnostic output for VPN interface and process

cat <<'EOF'
echo "### VPN Phase"
echo "Interface: $interface"
echo ""
echo "WireGuard Status:"
wg show "$interface" 2>/dev/null || echo "⚠ Interface $interface not found"
echo ""
echo "Interface Configuration:"
$ifconfig_cmd "$interface" 2>/dev/null || echo "⚠ Cannot read interface configuration"
EOF
