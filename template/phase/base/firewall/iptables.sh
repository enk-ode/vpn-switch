#!/bin/sh
# Linux iptables - Firewall backend for Linux systems
#
# Available context variables (expanded at generation time):
#   $dns_server  - VPN DNS server IP address
#   $remote_ips  - VPN server IPs (space-separated)
#   $interface   - Network interface (wg0, tun0, etc.)

# Allow traffic to VPN DNS
iptables -A OUTPUT -d $dns_server -j ACCEPT
iptables -A INPUT -s $dns_server -j ACCEPT

# Allow traffic to VPN endpoints
for ip in $remote_ips; do
  iptables -A OUTPUT -d $ip -p udp --dport 51820 -j ACCEPT
done

# Allow traffic through VPN interface
iptables -A OUTPUT -o $interface -j ACCEPT
iptables -A INPUT -i $interface -j ACCEPT

# Drop all other traffic (kill switch)
iptables -A OUTPUT -j DROP
