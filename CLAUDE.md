# vpn-switch - Project Instructions for Claude

## Quick Reference

**Documentation:**
- [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) - Combinator architecture and design
- [docs/REQUIREMENTS.md](docs/REQUIREMENTS.md) - Technical requirements
- [docs/DESIGN_DECISIONS.md](docs/DESIGN_DECISIONS.md) - Key architectural decisions
- [docs/DEBUGGING_GUIDE.md](docs/DEBUGGING_GUIDE.md) - Debugging methodology
- [QUICK_REFERENCE.md](QUICK_REFERENCE.md) - Command cheatsheet
- [COMMIT_CHECKLIST.md](COMMIT_CHECKLIST.md) - Definition of done
- [README.md](README.md) - User documentation

---

## Project Description

`vpn-switch` is a POSIX shell script to manage VPN connections (WireGuard, OpenVPN).

**Core capabilities:**
- Switch between VPN protocols and servers
- Manage configuration files from any VPN provider
- Handle firewall and DNS integration automatically
- Session caching and resumption
- Profile-based configuration (minimal/all/custom)
- Database dump/restore for migration
- One-switch debugging mode

**Architecture:** Combinator-based implementation (~5100 lines)
- Build-time metadata generation for fast dispatch
- Intrinsic classification (underscore count determines behavior)
- Per-function interpreter control (dry-run, logging, custom execution)
- Environment isolation via `env -` pattern
- Phase-based connect/disconnect scripts (modular, inspectable)
- Modular includes (`include/*.sh` for protocol-specific code)

---

## Current Status: Phase 5 (Polish & Release Prep) 🚀

**Phase 4 COMPLETE!** ✅ Major features (inspect, robust init, phase backends)
**Phase 3 COMPLETE!** ✅ OpenVPN, protocol-agnostic commands, phase-based scripts

**Current Work:**
- Documentation cleanup and synchronization
- GNUmakefile for cross-platform installation (FreeBSD + Linux)
- VPN_SWITCH_LIBDIR for FHS-compliant installation

**Path to 1.0:**
- **Phase 5**: Polish & release prep (docs, refactoring, ports)
- **Phase 6**: Release candidate & 1.0

---

## Development Guidelines

### Building & Testing

```bash
# Generate metadata (only needed after function name changes or module definition changes)
gmake metadata

# Run tests
gmake test                    # All tests
gmake test-unit               # Unit tests only
gmake test-integration        # Integration tests only
gmake test-arch               # Architecture tests only

# Linting
gmake check                   # Syntax check
gmake shellcheck              # ShellCheck linting
gmake lint                    # Both

# Installation
gmake install                 # Install to /usr/local
gmake install PREFIX=/usr     # Install to /usr
```

### Before Committing

See [COMMIT_CHECKLIST.md](COMMIT_CHECKLIST.md) for full checklist.

**Quick check:**
```bash
gmake check                   # Syntax OK?
gmake test-unit               # Tests pass?
```

---

## Key Architecture Concepts

### Combinator Pattern

Functions are classified by underscore prefix:
- `_func` (terminal): Output final data, use `cat` interpreter
- `__func` (combinator): Output 1 vpn-switch command, use `sh` interpreter
- `___func` (batch combinator): Output N vpn-switch commands

**Execution flow:**
```
dispatch "$@" → resolve function → run function → pipe to interpreter
```

### Directory Structure

```
vpn-switch/
├── vpn-switch.sh              # Main script (~5100 lines)
├── vpn-switch-*-test.sh       # Test suites (unit, integration, architecture)
├── GNUmakefile                # Build system (GNU make)
├── include/                   # Modular code (database.sh, session.sh, etc.)
├── template/                  # Templates
│   ├── environment/           # Environment variable templates
│   ├── phase/                 # Phase scripts (connect/disconnect)
│   └── platform/              # Platform-specific variables
├── scripts/                   # Development scripts
├── files/                     # Deployment files (rc.d, resolvconf helpers)
├── docs/                      # Documentation
└── test-configs/              # Test configuration files
```

### Key Variables

- `VPN_SWITCH_BASE` - Database directory (user data)
- `VPN_SWITCH_LIBDIR` - Library directory (include/, template/)
- `VPN_SWITCH_TEMPLATE_DIR` - Template directory (derived from LIBDIR)

---

## Debugging

**Rule: 99% of issues are environment-related**

```bash
# Check effective environment
vpn-switch printenv

# Enable tracing
vpn-switch setenv VPN_SWITCH_RETENTION_DAYS_TRACE 1
vpn-switch <command>
cat $VPN_SWITCH_BASE/.log/*/*.trace
```

See [docs/DEBUGGING_GUIDE.md](docs/DEBUGGING_GUIDE.md) for detailed methodology.

---

## Testing

**Test suites:**
- `vpn-switch-unit-test.sh` - Unit tests (~374 assertions)
- `vpn-switch-integration-test.sh` - Integration tests (~296 assertions)
- `vpn-switch-architecture-test.sh` - Architecture pattern validation

**Always capture output:**
```bash
gmake test 2>&1 | tee /tmp/test-output.txt
```

---

## Quick Command Reference

```bash
# Connection
vpn-switch start <config>           # Auto-detect protocol, start VPN
vpn-switch stop                     # Stop all VPN sessions

# Session management
vpn-switch session list             # List active sessions
vpn-switch session save <name>      # Save current session

# Config management
vpn-switch wireguard import <path>  # Import config
vpn-switch wireguard list           # List configs
vpn-switch openvpn import <path>    # Import OpenVPN config

# Database
vpn-switch bootstrap <dir> minimal  # Initialize new database
vpn-switch dump                     # Export database
vpn-switch restore <file>           # Import database

# Diagnostics
vpn-switch inspect                  # Show system state
vpn-switch validate                 # Validate database
```

---

## Known Issues

### Grep Tool Limitation
The ripgrep-based Grep tool may fail with certain patterns. Use bash grep as fallback:
```bash
grep -n 'pattern' /path/to/file
```

---

*Project developed with assistance from Claude (Anthropic), October 2024 - December 2025.*
