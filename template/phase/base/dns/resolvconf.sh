#!/bin/sh
# FreeBSD resolvconf - Default DNS backend
#
# Available context variables (expanded at generation time):
#   $dns_server  - VPN DNS server IP address
#   $interface   - Network interface (wg0, tun0, etc.)

# Call resolvconf helper script
# These scripts are installed in /usr/local/sbin/ by deployment
/usr/local/sbin/wg-resolvconf-up $interface $dns_server
