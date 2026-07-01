#!/bin/sh
# Unbound - DNS backend using Unbound recursive resolver
#
# Available context variables (expanded at generation time):
#   $dns_server  - VPN DNS server IP address
#   $interface   - Network interface (wg0, tun0, etc.)

# Update unbound configuration to forward to VPN DNS
cat > /var/unbound/etc/unbound-vpn.conf <<UNBOUNDEOF
forward-zone:
  name: "."
  forward-addr: $dns_server
UNBOUNDEOF

# Reload unbound configuration
unbound-control reload
