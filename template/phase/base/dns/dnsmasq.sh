#!/bin/sh
# dnsmasq - DNS backend using dnsmasq forwarding resolver
#
# Available context variables (expanded at generation time):
#   $dns_server  - VPN DNS server IP address
#   $interface   - Network interface (wg0, tun0, etc.)

# Update dnsmasq configuration to use VPN DNS
cat > /etc/dnsmasq.d/vpn.conf <<DNSMASQEOF
# VPN DNS server
server=$dns_server
# Bind to VPN interface
interface=$interface
DNSMASQEOF

# Restart dnsmasq to pick up changes
service dnsmasq restart
