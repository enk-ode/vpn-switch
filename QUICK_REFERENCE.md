# vpn-switch Quick Reference

One-page command reference for common operations.

**Full documentation:** [README.md](README.md)
**Install:** [docs/INSTALL.md](docs/INSTALL.md)
**Help system:** `vpn-switch help`, `vpn-switch wireguard help`, `vpn-switch session help`

---

## Essential Commands

### Connect & Disconnect
```bash
vpn-switch start <config>            # Connect; resolves config/group/alias to its protocol
vpn-switch start                     # No arg: resume default session, else random config
vpn-switch wireguard start <config>  # Protocol-explicit start
vpn-switch openvpn start <config>    # Protocol-explicit start
vpn-switch stop                      # Stop every active VPN session
```

### Status & Information
```bash
vpn-switch status                    # Is the VPN up? Brief VPN + interface state
vpn-switch session list              # Show all active sessions
vpn-switch session show              # Show latest session details
vpn-switch session show <name|PID>   # Show specific session
vpn-switch printenv                  # Show effective configuration
vpn-switch version                   # DB SHA + source SHA (drift detection)
vpn-switch validate                  # Health check: install, DB, sessions, perms
vpn-switch inspect                   # Full descriptive state dump
```

---

## Config Management

### Import & List
```bash
vpn-switch wireguard import <path>   # Import WireGuard config
vpn-switch openvpn import <path>     # Import OpenVPN config
vpn-switch wireguard list            # List all WireGuard configs
vpn-switch openvpn list              # List all OpenVPN configs
vpn-switch wireguard info <group>    # Show group details with expiry info
```

### Organize (Groups & Aliases)
```bash
vpn-switch wireguard add streaming              # Create group (category)
vpn-switch wireguard add streaming wg-CH-12.conf ch-fast  # Link config into group, with alias
vpn-switch wireguard link ch wg-CH-12.conf      # Alias <name> -> config
vpn-switch link wg wireguard                    # Alias <name> -> protocol directory
```

### Maintenance
```bash
vpn-switch wireguard validate        # Check for broken symlinks
vpn-switch wireguard clean           # Generate commands to remove broken links
vpn-switch wireguard remove <name>   # Remove config (with safety checks)
```

---

## Session Management

### Save & Resume
```bash
vpn-switch session save work         # Save current session as "work"
vpn-switch session save              # Save as default session
vpn-switch session start work        # Resume "work" session
vpn-switch session start             # Resume default session
```

### Manage
```bash
vpn-switch session list              # Show all active sessions
vpn-switch session show <name|PID>   # Show cached connect script + metadata
vpn-switch session remove <name|PID> # Remove a stopped session (refuses if active)
vpn-switch session clean             # Generate commands to clean stale sessions
```
See [docs/TUTORIAL_SESSIONS.md](docs/TUTORIAL_SESSIONS.md) for the save/resume workflow.

---

## Database Management

### Initialize, Sync, Restore
```bash
vpn-switch bootstrap /path minimal   # Create new database (minimal profile)
vpn-switch bootstrap /path all       # Create new database (all profile)
vpn-switch sync                      # Refresh DB against source templates after upgrade
vpn-switch version                   # Report db: and source: SHAs (drift detection)
vpn-switch dump                      # Export database as a restorable script
vpn-switch dump > backup.sh          # Save dump to file
vpn-switch restore backup.sh         # Replay a dump into a bootstrapped database
```
See [docs/TUTORIAL_MIGRATION.md](docs/TUTORIAL_MIGRATION.md) for the full dump/restore workflow.

### Configuration
```bash
vpn-switch printenv                  # Show all effective settings
vpn-switch setenv VAR value          # Set environment variable
vpn-switch getenv VAR                # Get environment variable
vpn-switch unsetenv VAR              # Unset environment variable
```

---

## Debugging & Diagnostics

### Logging
Logs and traces land in `$VPN_SWITCH_BASE/.log/<date>/` (default: 1 day retention).
```bash
ls -la $VPN_SWITCH_BASE/.log/$(date +%Y-%m-%d)/
cat $VPN_SWITCH_BASE/.log/$(date +%Y-%m-%d)/*.log     # external-command stderr
cat $VPN_SWITCH_BASE/.log/$(date +%Y-%m-%d)/*.trace   # execution traces

# Keep more (or disable with 0)
vpn-switch setenv VPN_SWITCH_RETENTION_DAYS_LOG 7
vpn-switch setenv VPN_SWITCH_RETENTION_DAYS_TRACE 7
```

### Cleanup
```bash
vpn-switch validate                  # Health check — start here when something is off
vpn-switch logs validate             # Check for old logs
vpn-switch logs clean                # Generate rm commands for old logs
vpn-switch logs clean | sh           # Execute cleanup (after review)
```
See [docs/TUTORIAL_TROUBLESHOOTING.md](docs/TUTORIAL_TROUBLESHOOTING.md) for `validate` walkthrough.

---

## Common Workflows

### Initial Setup
```bash
# 1. Install (system-wide; see docs/INSTALL.md)
sudo gmake install

# 2. Create per-user database (default path: ~/.vpn-switch/db)
vpn-switch bootstrap ~/.vpn-switch/db minimal

# 3. Import configs (one file per call)
vpn-switch wireguard import ~/Downloads/wg-CH-12.conf
vpn-switch openvpn import ~/Downloads/ch.ovpn
# Many files? Loop in your shell:
for f in ~/Downloads/*.conf; do vpn-switch wireguard import "$f"; done

# 4. Organize by purpose (create groups, then link configs in with aliases)
vpn-switch wireguard add streaming
vpn-switch wireguard add privacy
vpn-switch wireguard add streaming wg-DE-22.conf de-fast
vpn-switch wireguard add privacy wg-CH-12.conf ch-quiet

# 5. Verify
vpn-switch validate
```

### Daily Use
```bash
# Connect
vpn-switch start ch-quiet

# Check status
vpn-switch session list

# Disconnect
vpn-switch stop
```

### Work/Home Sessions
```bash
# At work: Connect and save
vpn-switch start de-fast
vpn-switch session save work

# At home: Connect and save
vpn-switch start ch-quiet
vpn-switch session save home

# Quick switch: Resume saved session
vpn-switch session start work
vpn-switch session start home
```

### Backup & Migration
```bash
# On old machine
vpn-switch dump > /tmp/vpn-backup.sh

# On new machine
vpn-switch bootstrap ~/.vpn-switch/db minimal
vpn-switch restore /tmp/vpn-backup.sh
vpn-switch validate                  # confirm restore
```
See [docs/TUTORIAL_MIGRATION.md](docs/TUTORIAL_MIGRATION.md) for details.

### Debugging Issues
```bash
vpn-switch validate                  # check this first
vpn-switch setenv VPN_SWITCH_RETENTION_DAYS_TRACE 7  # capture traces
vpn-switch start <config>            # reproduce
cat $VPN_SWITCH_BASE/.log/$(date +%Y-%m-%d)/*.trace  # read traces
vpn-switch session show <name|PID>   # inspect the connect script
```
For the full debugging methodology: [docs/DEBUGGING_GUIDE.md](docs/DEBUGGING_GUIDE.md)

---

## Environment Variables

### Essential
```bash
VPN_SWITCH_BASE                      # DB location (default: $HOME/.vpn-switch/db)
VPN_SWITCH_LIBDIR                    # Install location (set by installer, default: /usr/local/lib/vpn-switch)
```

### Debugging (Retention Days)
```bash
VPN_SWITCH_RETENTION_DAYS_LOG        # Log retention (default: 1 day, 0=disable)
VPN_SWITCH_RETENTION_DAYS_TRACE      # Trace retention (default: 1 day, 0=disable)
```

### Interface Names
```bash
VPN_SWITCH_INTERFACE_wireguard       # WireGuard interface (default: wg0)
VPN_SWITCH_INTERFACE_openvpn         # OpenVPN interface (default: tun0)
```

### Profiles (chosen at bootstrap)
```bash
minimal                              # Cache only the essential variables (recommended)
all                                  # Cache the full variable set
# (a 'custom' profile also exists for hand-picked variable sets)
```

---

## Protocol-Specific Notes

### WireGuard
- `info` estimates expiry as **1 year after the config file's creation date** (typical VPN-provider lifetime); not a real-time query
- Uses `wg-quick up/down` for interface management
- DNS scripts: `/usr/local/sbin/wg-resolvconf-{up,down}`

### OpenVPN
- `import`/`patch` rewrite the config for daemon mode (adds `daemon`, `writepid`)
- Runs via `openvpn --daemon` with a PID file for background operation
- DNS scripts: `/usr/local/sbin/ovpn-resolvconf-{up,down}`

---

## Tips & Tricks

- **Default chains**: Symlinks express defaults (`default → protocol → group → config`)
- **Group resolution**: Starting a group uses its `default` symlink, or picks one at random
- **Inspect before running**: `session show` prints the exact connect script
- **Safe by default**: `clean` and `remove` emit commands for review; pipe to `sh` to run
- **Multi-protocol**: WireGuard and OpenVPN can run at the same time
- **Named sessions**: Save common setups (`session save`) and resume them (`session start`)

---

## Getting Help

```bash
vpn-switch help                      # Main help
vpn-switch wireguard help            # WireGuard-specific help
vpn-switch openvpn help              # OpenVPN-specific help
vpn-switch session help              # Session management help
```

**Full documentation:** [README.md](README.md)
**Architecture:** [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)
