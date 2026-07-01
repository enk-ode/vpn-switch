#!/bin/sh
# GNU/Linux platform configuration
# Loaded at generation time by vpn-switch.sh
#
# VARIABLE NAMING CONVENTION:
#   EXAMINE_* - Read-only system inspection (safe in all function types)
#   MODIFY_*  - State modification (FORBIDDEN in combinators/batch combinators)
#
# LEGACY: CMD_* variables (deprecated, use EXAMINE_* instead)
#   grep 'CMD_' include/*.sh        - Find all usage
#   grep 'CMD_' template/platform/* - Find all definitions

# =============================================================================
# LEGACY VARIABLES (for compatibility during migration)
# =============================================================================

# stat commands - file/directory inspection
CMD_STAT_PERMS='stat -c %a'   # Get file permissions (octal, e.g., 0400)
CMD_STAT_CTIME='stat -c %W'   # Get file creation time (Unix epoch, 0 if unavailable)
CMD_STAT_MTIME='stat -c %Y'   # Get file modification time (Unix epoch)

# Network inspection commands
CMD_NETIF='ip addr show'        # Show network interfaces
CMD_ROUTE='ip route show'       # Show routing table

# Kernel module inspection
CMD_KMOD='lsmod'                # List loaded kernel modules
CMD_KMOD_GREP='grep -E '"'"'(wireguard|tun|tap)'"'"''  # Filter for VPN modules

# =============================================================================
# FILESYSTEM - Examination (read-only)
# =============================================================================

EXAMINE_FILE_PERMS='stat -c %a'       # Get file permissions (octal, e.g., 0400)
EXAMINE_FILE_OWNER='stat -c %u:%g'    # Get file owner (uid:gid)
EXAMINE_FILE_CTIME='stat -c %W'       # Get file creation time (Unix epoch, 0 if unavailable)
EXAMINE_FILE_MTIME='stat -c %Y'       # Get file modification time (Unix epoch)
EXAMINE_DATE_NOW='date "+%Y-%m-%d %H:%M:%S"'  # Get current date/time (human-readable)
EXAMINE_FILE_EXISTS='test -f'           # Check if file exists
EXAMINE_DIR_EXISTS='test -d'            # Check if directory exists
EXAMINE_LINK_TARGET='readlink'          # Read symlink target

# =============================================================================
# FILESYSTEM - Modification (state-changing)
# =============================================================================

MODIFY_FILE_PERMS='chmod'               # Change file permissions
MODIFY_FILE_PERMS_RECURSIVE='chmod -R'  # Change file permissions recursively
MODIFY_FILE_OWNER='chown'               # Change file owner (uid:gid or user:group)
MODIFY_FILE_CREATE='touch'              # Create empty file
MODIFY_FILE_REMOVE='rm -f'              # Remove file
MODIFY_FILE_MOVE='mv'                   # Move/rename file
MODIFY_FILE_COPY='cp'                   # Copy file
MODIFY_DIR_CREATE='mkdir -p'            # Create directory (with parents)
MODIFY_DIR_REMOVE='rm -rf'              # Remove directory recursively
MODIFY_DIR_COPY='cp -Rf'                # Copy directory recursively (force)
MODIFY_LINK_CREATE='ln -s'              # Create symbolic link
MODIFY_LINK_FORCE='ln -sfn'             # Force create/overwrite symbolic link (n=no-dereference)
MODIFY_LINK_REMOVE='rm -f'              # Remove symbolic link
MODIFY_FILE_COPY_FORCE='cp -f'          # Copy file (force overwrite)
MODIFY_FILE_SED_INPLACE='sed -i'        # In-place file editing (GNU syntax)

# =============================================================================
# NETWORK - Examination (read-only)
# =============================================================================

EXAMINE_NETWORK_INTERFACES='ip addr show'      # Show all network interfaces
EXAMINE_NETWORK_INTERFACE_EXISTS='ip link show'  # Check if specific interface exists (needs interface name)
EXAMINE_NETWORK_ROUTES='ip route show'         # Show routing table
EXAMINE_NETWORK_CONNECTIONS='ss -an'           # Show all connections (ss replaces netstat)
EXAMINE_NETWORK_SOCKETS='ss -lnp'              # Show listening sockets with process info

# =============================================================================
# NETWORK - Modification (state-changing)
# =============================================================================

MODIFY_NETWORK_INTERFACE_CREATE='ip link add'     # Create interface
MODIFY_NETWORK_INTERFACE_DESTROY='ip link delete' # Destroy interface
MODIFY_INTERFACE_DESTROY_FMT='ip link delete %s'  # Template: destroy interface (printf format)
MODIFY_NETWORK_INTERFACE_UP='ip link set up'      # Bring interface up
MODIFY_NETWORK_INTERFACE_DOWN='ip link set down'  # Bring interface down
MODIFY_NETWORK_ROUTE_ADD='ip route add'           # Add route
MODIFY_NETWORK_ROUTE_DELETE='ip route delete'     # Delete route

# =============================================================================
# FIREWALL (iptables/nftables) - Examination (read-only)
# =============================================================================

EXAMINE_FIREWALL_RULES='iptables -L -n'        # Show iptables rules
EXAMINE_FIREWALL_NAT='iptables -t nat -L -n'   # Show NAT rules
EXAMINE_FIREWALL_SAVE='iptables-save'          # Show all rules (save format)
EXAMINE_FIREWALL_NFT='nft list ruleset'        # Show nftables rules (if using nft)
EXAMINE_FIREWALL_INFO='iptables -L -v -n'      # Show detailed firewall status
EXAMINE_FIREWALL_STATE='conntrack -L'          # Show connection tracking state
EXAMINE_FIREWALL_TABLE='ipset list'            # Show specific ipset (needs set name)
EXAMINE_FIREWALL_TABLES='ipset list -n'        # List all ipset names

# =============================================================================
# FIREWALL (iptables/nftables) - Modification (state-changing)
# =============================================================================

MODIFY_FIREWALL_RESTORE='iptables-restore'     # Restore iptables rules
MODIFY_FIREWALL_FLUSH='iptables -F'            # Flush all chains
MODIFY_FIREWALL_FLUSH_ALL='iptables -F && iptables -t nat -F && iptables -X'  # Flush all
MODIFY_FIREWALL_ADD='iptables -A'              # Add rule
MODIFY_FIREWALL_DELETE='iptables -D'           # Delete rule
MODIFY_FIREWALL_NFT_LOAD='nft -f'              # Load nftables ruleset
MODIFY_FIREWALL_RELOAD='iptables-restore'      # Reload configuration (same as restore)
MODIFY_FIREWALL_ENABLE='true'                  # N/A on Linux (iptables always active)
MODIFY_FIREWALL_DISABLE='true'                 # N/A on Linux (use flush instead)
MODIFY_FIREWALL_TABLE_ADD='ipset add'          # Add to ipset (needs set name + value)
MODIFY_FIREWALL_TABLE_DELETE='ipset del'       # Delete from ipset (needs set name + value)
MODIFY_FIREWALL_TABLE_FLUSH='ipset flush'      # Flush ipset (needs set name)

# =============================================================================
# DNS - Modification (state-changing)
# =============================================================================
# Note: DNS operations are typically write-only (no examination needed)

MODIFY_DNS_SET='resolvconf -a'                 # Add DNS configuration
MODIFY_DNS_UNSET='resolvconf -d'               # Delete DNS configuration
MODIFY_DNS_UPDATE='resolvconf -u'              # Update DNS configuration

# =============================================================================
# VPN - WireGuard - Examination (read-only)
# =============================================================================

EXAMINE_VPN_WIREGUARD_STATUS='wg show'              # Show all WireGuard interfaces
EXAMINE_VPN_WIREGUARD_INTERFACE='wg show'           # Show specific interface (needs interface name)
EXAMINE_VPN_WIREGUARD_INTERFACES='wg show interfaces'  # List interface names only
EXAMINE_VPN_WIREGUARD_CONFIG='wg showconf'          # Show configuration (needs interface name)
EXAMINE_VPN_WIREGUARD_PEERS='wg show peers'         # Show peers (needs interface name)
EXAMINE_VPN_WIREGUARD_ENDPOINTS='wg show endpoints' # Show endpoints (needs interface name)

# =============================================================================
# VPN - WireGuard - Modification (state-changing)
# =============================================================================

MODIFY_VPN_WIREGUARD_UP='wg-quick up'               # Start WireGuard interface
MODIFY_VPN_WIREGUARD_DOWN='wg-quick down'           # Stop WireGuard interface
MODIFY_VPN_WIREGUARD_SETCONF='wg setconf'           # Set configuration (needs interface name)
MODIFY_VPN_WIREGUARD_SYNCCONF='wg syncconf'         # Sync configuration (needs interface name)
MODIFY_VPN_WIREGUARD_SET='wg set'                   # Set interface parameters
MODIFY_VPN_WIREGUARD_ADDCONF='wg addconf'           # Add configuration

# =============================================================================
# VPN - OpenVPN - Examination (read-only)
# =============================================================================

EXAMINE_VPN_OPENVPN_PROCESS='ps -p'                 # Check if process running (needs PID)
EXAMINE_VPN_OPENVPN_PROCESSES='pgrep openvpn'       # Find OpenVPN processes
EXAMINE_VPN_OPENVPN_RUNNING='pgrep -q openvpn'      # Check if any OpenVPN running (exit code)

# =============================================================================
# VPN - OpenVPN - Modification (state-changing)
# =============================================================================

MODIFY_VPN_OPENVPN_START='openvpn --daemon'         # Start OpenVPN daemon
MODIFY_VPN_OPENVPN_STOP='kill'                      # Stop process (needs signal + PID)
MODIFY_VPN_OPENVPN_RELOAD='kill -HUP'               # Reload configuration (needs PID)
MODIFY_VPN_OPENVPN_TERM='kill -TERM'                # Graceful termination (needs PID)
MODIFY_VPN_OPENVPN_KILL='kill -9'                   # Force kill (needs PID)

# =============================================================================
# PROCESS - Examination (read-only)
# =============================================================================

EXAMINE_PROCESS_EXISTS='kill -0'            # Check if process exists (needs PID)
EXAMINE_PROCESS_LIST='ps aux'               # List all processes
EXAMINE_PROCESS_INFO='ps -p'                # Get process info (needs PID)
EXAMINE_PROCESS_TREE='pstree'               # Show process tree
EXAMINE_PROCESS_FIND='pgrep'                # Find processes by name
EXAMINE_PROCESS_CHILDREN='pgrep -P'         # Find child processes (needs parent PID)

# =============================================================================
# PROCESS - Modification (state-changing)
# =============================================================================

MODIFY_PROCESS_SIGNAL='kill'                # Send signal to process
MODIFY_PROCESS_TERM='kill -TERM'            # Graceful termination
MODIFY_PROCESS_KILL='kill -9'               # Force kill
MODIFY_PROCESS_HUP='kill -HUP'              # Hangup signal (reload)
MODIFY_PROCESS_INT='kill -INT'              # Interrupt signal
MODIFY_PROCESS_KILLALL='pkill'              # Kill by name

# =============================================================================
# SERVICE - Examination (read-only)
# =============================================================================

EXAMINE_SERVICE_STATUS='systemctl status'       # Check service status (needs service name)
EXAMINE_SERVICE_LIST='systemctl list-units'     # List all services
EXAMINE_SERVICE_ENABLED='systemctl list-unit-files --state=enabled'  # List enabled services

# =============================================================================
# SERVICE - Modification (state-changing)
# =============================================================================

MODIFY_SERVICE_START='systemctl start'          # Start service (needs service name)
MODIFY_SERVICE_STOP='systemctl stop'            # Stop service (needs service name)
MODIFY_SERVICE_RELOAD='systemctl reload'        # Reload service configuration
MODIFY_SERVICE_RESTART='systemctl restart'      # Restart service

# =============================================================================
# KERNEL MODULE - Examination (read-only)
# =============================================================================

EXAMINE_KMOD_LIST='lsmod'                   # List loaded kernel modules
EXAMINE_KMOD_LOADED='lsmod | grep -q'       # Check if module loaded (needs module name)
EXAMINE_KMOD_INFO='modinfo'                 # Show module information

# =============================================================================
# KERNEL MODULE - Modification (state-changing)
# =============================================================================

MODIFY_KMOD_LOAD='modprobe'                 # Load kernel module
MODIFY_KMOD_UNLOAD='modprobe -r'            # Unload kernel module
