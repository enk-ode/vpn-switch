#!/bin/sh
# djbdns (dnscache) - DNS backend using Daniel J. Bernstein's DNS cache
#
# Available context variables (expanded at generation time):
#   $dns_server  - VPN DNS server IP address
#   $interface   - Network interface (wg0, tun0, etc.)

# Update dnscache root servers to use VPN DNS
# Assumes dnscache is running in /service/dnscache
echo "$dns_server" > /service/dnscache/root/servers/@

# Restart dnscache to pick up changes
svc -t /service/dnscache
