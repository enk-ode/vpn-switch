#!/bin/sh
# OpenBSD platform configuration
# Loaded at generation time by vpn-switch.sh
#
# OpenBSD is "FreeBSD's sibling" for this tool's purposes: the same BSD stat,
# ifconfig, route, pf/pfctl, ps and pgrep all behave identically, so most of
# this catalog matches freebsd.sh exactly. The genuine deltas are flagged with
# an "OPENBSD:" comment:
#   - service manager is rcctl (action-first), not service
#   - sed -i takes no extension argument (FreeBSD requires '')
#   - no resolvconf (DNS via /etc/resolv.conf / resolvd) — use the dns:none phase
#   - monolithic kernel: no loadable modules (WireGuard and tun are in-kernel)
#   - no sockstat (use netstat/fstat)
#   - privilege escalation is doas, not sudo (an interpreter/env concern, not here)
#
# Self-contained (does NOT source freebsd.sh) so the test harness can load it
# directly via the 'default' symlink.
#
# VARIABLE NAMING CONVENTION:
#   EXAMINE_* - Read-only system inspection (safe in all function types)
#   MODIFY_*  - State modification (FORBIDDEN in combinators/batch combinators)

# =============================================================================
# LEGACY VARIABLES (for compatibility during migration)
# =============================================================================

CMD_STAT_PERMS='stat -f %Lp'  # Get file permissions (octal, e.g., 0400)
CMD_STAT_CTIME='stat -f %B'   # Get file creation time (Unix epoch; 0 if unavailable)
CMD_STAT_MTIME='stat -f %m'   # Get file modification time (Unix epoch)

CMD_NETIF='ifconfig'             # Show network interfaces
CMD_ROUTE='netstat -rn'          # Show routing table

CMD_KMOD='true'               # OPENBSD: monolithic kernel — no module list
CMD_KMOD_GREP='grep -E '"'"'(wg|tun|tap)'"'"''  # (kept for interface filtering)

# =============================================================================
# FILESYSTEM - Examination (read-only)
# =============================================================================

EXAMINE_FILE_PERMS='stat -f %Lp'   # Get file permissions (octal, e.g., 0400)
EXAMINE_FILE_OWNER='stat -f %u:%g' # Get file owner (uid:gid)
EXAMINE_FILE_CTIME='stat -f %B'    # Get file creation time (Unix epoch; 0 if unavailable)
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
MODIFY_FILE_SED_INPLACE='sed -i'     # OPENBSD: in-place edit; takes NO extension arg (FreeBSD needs '')

# =============================================================================
# NETWORK - Examination (read-only)
# =============================================================================

EXAMINE_NETWORK_INTERFACES='ifconfig'        # Show all network interfaces
EXAMINE_NETWORK_INTERFACE_EXISTS='ifconfig'  # Check if specific interface exists (needs interface name)
EXAMINE_NETWORK_ROUTES='netstat -rn'         # Show routing table
EXAMINE_NETWORK_CONNECTIONS='netstat -an'    # Show all connections
EXAMINE_NETWORK_SOCKETS='netstat -an'        # OPENBSD: no sockstat — netstat (or fstat) instead

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
# OpenBSD is pf's upstream; pfctl behaves as on FreeBSD.

EXAMINE_FIREWALL_RULES='pfctl -sr'          # Show rules
EXAMINE_FIREWALL_NAT='pfctl -sn'            # Show NAT rules
EXAMINE_FIREWALL_TABLES='pfctl -sT'         # Show all tables
EXAMINE_FIREWALL_TABLE='pfctl -t'           # Show specific table (needs -T show)
EXAMINE_FIREWALL_STATE='pfctl -s state'     # Show state table
EXAMINE_FIREWALL_INFO='pfctl -si'           # Show PF status/info
EXAMINE_FIREWALL_SAVE='pfctl -sr'           # Show all rules (same as RULES for PF)
EXAMINE_FIREWALL_NFT='true'                 # N/A (nftables is Linux-only)

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
MODIFY_FIREWALL_ADD='true'                  # N/A (PF uses rule files, not commands)
MODIFY_FIREWALL_DELETE='true'               # N/A (PF uses rule files, not commands)
MODIFY_FIREWALL_NFT_LOAD='true'             # N/A (nftables is Linux-only)

# =============================================================================
# DNS - Modification (state-changing)
# =============================================================================
# OPENBSD: no resolvconf. DNS is /etc/resolv.conf, managed by resolvd(8) from
# route messages. vpn-switch's DNS belongs in the dns phase — use the dns:none
# backend on OpenBSD (or a custom backend that edits resolv.conf).

MODIFY_DNS_SET='true'                       # OPENBSD: no resolvconf (see note above)
MODIFY_DNS_UNSET='true'                     # OPENBSD: no resolvconf
MODIFY_DNS_UPDATE='true'                    # OPENBSD: no resolvconf

# =============================================================================
# VPN - WireGuard - Examination (read-only)
# =============================================================================
# WireGuard is in-kernel on OpenBSD (ifconfig wgN create); wg(8)/wg-quick(8)
# come from the wireguard-tools package.

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
# OPENBSD: rcctl is action-first (rcctl <action> <name>), so the name appended
# by the caller lands in the right place — unlike FreeBSD's 'service <name> <action>'.

EXAMINE_SERVICE_STATUS='rcctl check'        # OPENBSD: rcctl check <name>  -> "<name>(ok)"
EXAMINE_SERVICE_LIST='rcctl ls all'         # OPENBSD: list all services
EXAMINE_SERVICE_ENABLED='rcctl ls on'       # OPENBSD: list enabled services

# =============================================================================
# SERVICE - Modification (state-changing)
# =============================================================================

MODIFY_SERVICE_START='rcctl start'          # OPENBSD: rcctl start <name>
MODIFY_SERVICE_STOP='rcctl stop'            # OPENBSD: rcctl stop <name>
MODIFY_SERVICE_RELOAD='rcctl reload'        # OPENBSD: rcctl reload <name>
MODIFY_SERVICE_RESTART='rcctl restart'      # OPENBSD: rcctl restart <name>

# =============================================================================
# KERNEL MODULE - Examination (read-only)
# =============================================================================
# OPENBSD: monolithic kernel — no loadable modules. WireGuard and tun are
# compiled in, so there is nothing to list/load. Vars are harmless no-ops.

EXAMINE_KMOD_LIST='true'                    # OPENBSD: no module list
EXAMINE_KMOD_LOADED='true'                  # OPENBSD: modules are in-kernel
EXAMINE_KMOD_INFO='true'                    # OPENBSD: n/a

# =============================================================================
# KERNEL MODULE - Modification (state-changing)
# =============================================================================

MODIFY_KMOD_LOAD='true'                     # OPENBSD: cannot load modules (static kernel)
MODIFY_KMOD_UNLOAD='true'                   # OPENBSD: cannot unload modules
