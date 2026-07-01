#!/bin/sh
# FreeBSD IP Firewall (IPFW) - Alternative firewall backend
#
# Available context variables (expanded at generation time):
#   $dns_server  - VPN DNS server IP address
#   $remote_ips  - VPN server IPs (space-separated)
#   $interface   - Network interface (wg0, tun0, etc.)

# Allow traffic to VPN DNS
ipfw add 100 allow ip from any to $dns_server
ipfw add 101 allow ip from $dns_server to any

# Allow traffic to VPN endpoints
for ip in $remote_ips; do
  ipfw add 110 allow udp from any to $ip dst-port 51820
done

# Allow traffic through VPN interface
ipfw add 120 allow ip from any to any via $interface
