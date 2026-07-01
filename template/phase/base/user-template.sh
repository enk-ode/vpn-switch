#!/bin/sh
# User Template - Guide for creating custom phase backends
#
# This template demonstrates how to create custom phase backends for
# vpn-switch. Copy this file and modify it to create your own backends.
#
# AVAILABLE CONTEXT VARIABLES (expanded at phase generation time):
#
#   Connection phases (connect.sh):
#     $dns_server    - VPN DNS server IP address (e.g., "10.2.0.1")
#     $remote_ips    - VPN server IPs, space-separated (e.g., "1.2.3.4 5.6.7.8")
#     $interface     - Network interface name (e.g., "wg0" or "tun0")
#     $session_dir   - Session directory path (e.g., "/data/vpn/.session/12345")
#     $config_file   - VPN config file path in session directory
#
#   Disconnection phases (disconnect.sh):
#     $interface     - Network interface name to tear down
#     $session_dir   - Session directory path
#
# VARIABLE ESCAPING RULES:
#
#   Context variables (listed above):
#     - Written as: $dns_server, $interface, etc.
#     - Expanded ONCE at phase generation time
#     - Result appears literally in connect.sh/disconnect.sh
#
#   Runtime variables (shell special variables):
#     - Examples: $?, $1-$9, $@, $*, $$
#     - Automatically escaped by lifting engine
#     - Will execute in the final connect.sh/disconnect.sh script
#
# USAGE:
#
#   1. Copy this template to your custom backend:
#      cp template/phase/base/user-template.sh \
#         template/phase/base/firewall/my-firewall.sh
#
#   2. Edit the file to add your custom commands
#
#   3. Use your backend in configuration:
#      vpn-switch setenv VPN_SWITCH_PHASES_CONNECT "firewall:my-firewall vpn dns"
#
#   4. Initialize database to lift your backend:
#      vpn-switch init
#
# EXAMPLES:
#
#   Firewall backend example:
#     # Allow VPN DNS traffic
#     iptables -A OUTPUT -d $dns_server -j ACCEPT
#
#   DNS backend example:
#     # Update resolv.conf
#     echo "nameserver $dns_server" > /etc/resolv.conf
#
#   VPN backend example (protocol-specific):
#     # Start WireGuard interface
#     wg-quick up $interface
#
# ADVANCED FEATURES:
#
#   Multi-line constructs (heredocs):
#     cat > /etc/config.conf <<EOF
#     server = $dns_server
#     interface = $interface
#     EOF
#
#   Conditional logic:
#     if [ -f /etc/custom.conf ]; then
#         echo "Using custom config" >&2
#     fi
#
#   Error handling:
#     # Runtime exit codes are automatically checked by verify function
#     my-command || exit 1
#
# PHASE-SPECIFIC BACKENDS:
#
#   Different phases can use different backends:
#     VPN_SWITCH_PHASES_CONNECT="firewall:pf vpn dns:unbound"
#
#   This uses:
#     - firewall phase: pf backend
#     - vpn phase: default (protocol-specific) backend
#     - dns phase: unbound backend
#
# NOTES:
#
#   - Keep templates simple and focused on one task
#   - Test your backend before committing
#   - Document required external dependencies
#   - Use stderr (>&2) for progress messages
#   - Let the verify function handle error checking
#

#-----------------------------------------------------------------------------
# YOUR CUSTOM COMMANDS GO HERE
#-----------------------------------------------------------------------------

# Example: Echo context variables to verify they're available
echo "==> Custom phase backend executing" >&2
echo "    DNS server: $dns_server" >&2
echo "    Interface: $interface" >&2

# Add your custom commands here
# Replace this section with your actual implementation

# Example: Create a simple config file
cat > /tmp/vpn-custom.conf <<EOF
# Custom VPN configuration
dns_server = $dns_server
interface = $interface
EOF

echo "==> Custom phase complete" >&2
