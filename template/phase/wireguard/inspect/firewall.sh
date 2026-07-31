#!/bin/sh
# WireGuard firewall inspect - Diagnostic output for firewall configuration
# Variables are expanded at execution time (not generation time)

cat <<'EOF'
echo "### Firewall Phase"
echo "DNS Server: $dns_server"
echo "Remote IPs: $remote_ips"
echo ""
echo "PF Status:"
$pfctl -sr 2>/dev/null || echo "⚠ Cannot read PF rules (permission denied?)"
echo ""
echo "VPN DNS Table:"
$pfctl -t vpn_dns -T show 2>/dev/null || echo "⚠ vpn_dns table not found"
echo ""
echo "VPN Remotes Table:"
$pfctl -t vpn_remotes -T show 2>/dev/null || echo "⚠ vpn_remotes table not found"
EOF
