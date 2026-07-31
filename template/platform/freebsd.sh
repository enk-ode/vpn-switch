#!/bin/sh
# FreeBSD platform configuration
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
CMD_STAT_PERMS='stat -f %Lp'  # Get file permissions (octal, e.g., 0400)
CMD_STAT_CTIME='stat -f %B'   # Get file creation time (Unix epoch)
CMD_STAT_MTIME='stat -f %m'   # Get file modification time (Unix epoch)

# Network inspection commands
CMD_NETIF='ifconfig'             # Show network interfaces
CMD_ROUTE='netstat -rn'          # Show routing table

# Kernel module inspection
CMD_KMOD='kldstat'               # List loaded kernel modules
CMD_KMOD_GREP='grep -E '"'"'(wg|if_tun|if_tap)'"'"''  # Filter for VPN modules

# =============================================================================
# FILESYSTEM - Examination (read-only)
# =============================================================================

EXAMINE_FILE_PERMS='stat -f %Lp'   # Get file permissions (octal, e.g., 0400)
EXAMINE_FILE_OWNER='stat -f %u:%g' # Get file owner (uid:gid)
EXAMINE_FILE_CTIME='stat -f %B'    # Get file creation time (Unix epoch)
EXAMINE_FILE_MTIME='stat -f %m'    # Get file modification time (Unix epoch)
EXAMINE_DATE_NOW='date "+%Y-%m-%d %H:%M:%S"'  # Get current date/time (human-readable)
EXAMINE_FILE_EXISTS='test -f'        # Check if file exists
EXAMINE_DIR_EXISTS='test -d'         # Check if directory exists
EXAMINE_LINK_TARGET='readlink'       # Read symlink target

# =============================================================================
# FILESYSTEM - Modification (state-changing)
# =============================================================================

MODIFY_FILE_PERMS='chmod'            # Change file permissions
MODIFY_FILE_PERMS_RECURSIVE='chmod -R'  # Change file permissions recursively
MODIFY_FILE_OWNER='chown'            # Change file owner (uid:gid or user:group)
MODIFY_FILE_CREATE='touch'           # Create empty file
MODIFY_FILE_REMOVE='rm -f'           # Remove file
MODIFY_FILE_MOVE='mv'                # Move/rename file
MODIFY_FILE_COPY='cp'                # Copy file
MODIFY_DIR_CREATE='mkdir -p'         # Create directory (with parents)
MODIFY_DIR_REMOVE='rm -rf'           # Remove directory recursively
MODIFY_DIR_COPY='cp -Rf'             # Copy directory recursively (force)
MODIFY_LINK_CREATE='ln -s'           # Create symbolic link
MODIFY_LINK_FORCE='ln -sfn'          # Force create/overwrite symbolic link
MODIFY_LINK_REMOVE='rm -f'           # Remove symbolic link
MODIFY_FILE_COPY_FORCE='cp -f'       # Copy file (force overwrite)
MODIFY_FILE_SED_INPLACE="sed -i ''"  # In-place file editing (BSD syntax)

# =============================================================================
# NETWORK - Examination (read-only)
# =============================================================================

EXAMINE_NETWORK_INTERFACES='ifconfig'        # Show all network interfaces
EXAMINE_NETWORK_INTERFACE_EXISTS='ifconfig'  # Check if specific interface exists (needs interface name)
EXAMINE_NETWORK_ROUTES='netstat -rn'         # Show routing table
EXAMINE_NETWORK_CONNECTIONS='netstat -an'    # Show all connections
EXAMINE_NETWORK_SOCKETS='sockstat'           # Show socket connections

# =============================================================================
# NETWORK - Modification (state-changing)
# =============================================================================

MODIFY_NETWORK_INTERFACE_CREATE='ifconfig create'    # Create interface
MODIFY_NETWORK_INTERFACE_DESTROY='ifconfig destroy'  # Destroy interface
MODIFY_INTERFACE_DESTROY_FMT='ifconfig %s destroy'   # Template: destroy interface (printf format)
MODIFY_NETWORK_INTERFACE_UP='ifconfig up'            # Bring interface up
MODIFY_NETWORK_INTERFACE_DOWN='ifconfig down'        # Bring interface down
MODIFY_NETWORK_ROUTE_ADD='route add'                 # Add route
MODIFY_NETWORK_ROUTE_DELETE='route delete'           # Delete route

# =============================================================================
# FIREWALL (PF) - Examination (read-only)
# =============================================================================

EXAMINE_FIREWALL_RULES='pfctl -sr'          # Show rules
EXAMINE_FIREWALL_NAT='pfctl -sn'            # Show NAT rules
EXAMINE_FIREWALL_TABLES='pfctl -sT'         # Show all tables
EXAMINE_FIREWALL_TABLE='pfctl -t'           # Show specific table (needs -T show)
EXAMINE_FIREWALL_STATE='pfctl -s state'     # Show state table
EXAMINE_FIREWALL_INFO='pfctl -si'           # Show PF status/info
EXAMINE_FIREWALL_SAVE='pfctl -sr'           # Show all rules (same as RULES for PF)
EXAMINE_FIREWALL_NFT='true'                 # N/A on FreeBSD (nftables is Linux-only)

# =============================================================================
# FIREWALL (PF) - Modification (state-changing)
# =============================================================================

MODIFY_FIREWALL_RELOAD='pfctl -f'           # Reload configuration
MODIFY_FIREWALL_ENABLE='pfctl -e'           # Enable PF
MODIFY_FIREWALL_DISABLE='pfctl -d'          # Disable PF
MODIFY_FIREWALL_TABLE_ADD='pfctl -t'        # Add to table (needs -T add)
MODIFY_FIREWALL_TABLE_DELETE='pfctl -t'     # Delete from table (needs -T delete)
MODIFY_FIREWALL_TABLE_FLUSH='pfctl -t'      # Flush table (needs -T flush)
MODIFY_FIREWALL_FLUSH_ALL='pfctl -F all'    # Flush all
MODIFY_FIREWALL_FLUSH='pfctl -F rules'      # Flush rules only
MODIFY_FIREWALL_RESTORE='pfctl -f'          # Restore/load rules (same as reload for PF)
MODIFY_FIREWALL_ADD='true'                  # N/A on FreeBSD (PF uses rule files, not commands)
MODIFY_FIREWALL_DELETE='true'               # N/A on FreeBSD (PF uses rule files, not commands)
MODIFY_FIREWALL_NFT_LOAD='true'             # N/A on FreeBSD (nftables is Linux-only)

# =============================================================================
# DNS - Modification (state-changing)
# =============================================================================
# Note: DNS operations are typically write-only (no examination needed)

MODIFY_DNS_SET='resolvconf -a'              # Add DNS configuration
MODIFY_DNS_UNSET='resolvconf -d'            # Delete DNS configuration
MODIFY_DNS_UPDATE='resolvconf -u'           # Update DNS configuration

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
EXAMINE_PROCESS_TREE='pstree'               # Show process tree (if installed)
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

EXAMINE_SERVICE_STATUS='service status'     # Check service status (needs service name)
EXAMINE_SERVICE_LIST='service -l'           # List all services
EXAMINE_SERVICE_ENABLED='service -e'        # List enabled services

# =============================================================================
# SERVICE - Modification (state-changing)
# =============================================================================

MODIFY_SERVICE_START='service start'        # Start service (needs service name)
MODIFY_SERVICE_STOP='service stop'          # Stop service (needs service name)
MODIFY_SERVICE_RELOAD='service reload'      # Reload service configuration
MODIFY_SERVICE_RESTART='service restart'    # Restart service

# =============================================================================
# KERNEL MODULE - Examination (read-only)
# =============================================================================

EXAMINE_KMOD_LIST='kldstat'                 # List loaded kernel modules
EXAMINE_KMOD_LOADED='kldstat -q -m'         # Check if module loaded (needs module name)
EXAMINE_KMOD_INFO='kldstat -v'              # Verbose module information

# =============================================================================
# KERNEL MODULE - Modification (state-changing)
# =============================================================================

MODIFY_KMOD_LOAD='kldload'                  # Load kernel module
MODIFY_KMOD_UNLOAD='kldunload'              # Unload kernel module
