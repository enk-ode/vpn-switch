#!/bin/sh
# FreeBSD Packet Filter (PF) - Default firewall backend
#
# Available context variables (expanded at generation time):
#   $dns_server  - VPN DNS server IP address
#   $remote_ips  - VPN server IPs (space-separated)
#   $interface   - Network interface (wg0, tun0, etc.)

# Update PF macros for interface
cat > /etc/pf.macros/interfaces <<PFEOF
ext_if = "${VPN_SWITCH_EXT_IF:-em0}"
vpn_if = "$interface"
PFEOF

# Update PF table for VPN DNS
cat > /etc/pf.tables/vpn_dns <<PFEOF
$dns_server
PFEOF

# Update PF table for VPN remotes
cat > /etc/pf.tables/vpn_remotes <<PFEOF
$remote_ips
PFEOF

# Reload PF configuration
pfctl -f /etc/pf.conf
