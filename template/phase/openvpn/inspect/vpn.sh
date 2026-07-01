#!/bin/sh
# OpenVPN VPN inspect - Diagnostic output for VPN interface and process

cat <<'EOF'
echo "### VPN Phase"
echo "Interface: $interface"
echo ""
echo "OpenVPN Process Status:"
if [ -f "$session_dir/vpn.pid" ]; then
    vpn_pid=$(cat "$session_dir/vpn.pid" 2>/dev/null)
    if [ -n "$vpn_pid" ] && ps -p "$vpn_pid" >/dev/null 2>&1; then
        echo "✓ OpenVPN running (PID: $vpn_pid)"
    else
        echo "⚠ VPN PID file exists but process not running"
    fi
else
    echo "⚠ VPN PID file not found"
fi
echo ""
echo "Interface Configuration:"
$ifconfig_cmd "$interface" 2>/dev/null || echo "⚠ Cannot read interface configuration"
EOF
