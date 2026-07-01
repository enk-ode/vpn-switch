# vpn-switch

A POSIX-shell-based VPN connection manager for FreeBSD and Linux. Handles
WireGuard and OpenVPN, automates firewall and DNS integration, and lets
you switch between configurations from any VPN provider with a single
command.

```sh
vpn-switch start privacy           # connect using the 'privacy' config
vpn-switch session save work       # name the live session
vpn-switch stop                    # tear it down
```

> **Platform support.** FreeBSD and Linux are the primary, tested platforms.
> FreeBSD ships an rc.d service and `resolvconf` / `local_unbound` DNS
> integration; Linux is supported for core connection and configuration
> management, with a systemd unit and an Alpine platform plugin. Alpine and
> OpenBSD are additionally verified as Tier-2 platforms (live walkthroughs in
> [EXTENDING.md](docs/EXTENDING.md)). The platform is auto-detected (`uname`
> plus `/etc/os-release`), and a new OS is added by dropping in a platform
> plugin. See [INSTALL.md](docs/INSTALL.md) for details.

---

## Why does this exist?

VPN provider documentation typically tells you: download a config file, run
`wg-quick up` or `openvpn`, manually patch firewall rules, manually update
DNS, repeat the inverse on disconnect. For a single config that's tolerable.
For dozens of configs across countries, protocols, and purposes, it isn't.

vpn-switch organises VPN configurations as a **filesystem database** — directories
group configurations by purpose, symlinks express defaults and named sessions,
and a small set of commands does the rest:

- **Switch between protocols and providers** without leaving the shell
- **Firewall + DNS handled automatically** via composable phase scripts
- **Session caching and resumption** — saved sessions reconnect instantly
- **Dry-run by default** for terminals — see the commands before they run
- **Per-function interpreter overrides** — log, validate, or replace any step
- **Pure POSIX `/bin/sh`** — no Python, no Go, no daemons, no dependencies

The same handful of commands covers one config or dozens across several
providers.

---

## Quick example

Source: <https://github.com/enk-ode/vpn-switch>. After install and `bootstrap`
(see the Documentation map below):

```sh
vpn-switch wireguard import ~/Downloads/wg-CH-12.conf       # ingest a config
vpn-switch wireguard add privacy wg-CH-12.conf switzerland  # group + alias it
vpn-switch start switzerland                                # connect
vpn-switch session list                                     # see what's running
vpn-switch session save work                                # name it
# ... use the VPN ...
vpn-switch stop                                             # disconnect
vpn-switch session start work                               # resume later
```

---

## Documentation map

**Start here:**
- [INSTALL.md](docs/INSTALL.md) — System-wide installation (FreeBSD + Linux)
- [TUTORIAL_QUICKSTART.md](docs/TUTORIAL_QUICKSTART.md) — From install to first VPN connection
- [QUICK_REFERENCE.md](QUICK_REFERENCE.md) — One-page command cheatsheet

**Use the tool:**
- [TUTORIAL_SESSIONS.md](docs/TUTORIAL_SESSIONS.md) — Named sessions, save/resume
- [TUTORIAL_SUDO.md](docs/TUTORIAL_SUDO.md) — Per-function privilege escalation
- [TUTORIAL_MIGRATION.md](docs/TUTORIAL_MIGRATION.md) — dump/restore, moving the database
- [TUTORIAL_TROUBLESHOOTING.md](docs/TUTORIAL_TROUBLESHOOTING.md) — `vpn-switch validate` and beyond

**Understand the design:**
- [ARCHITECTURE.md](docs/ARCHITECTURE.md) — Combinator pattern, dispatch, interpreters
- [DESIGN_DECISIONS.md](docs/DESIGN_DECISIONS.md) — Why this works the way it does
- [REQUIREMENTS.md](docs/REQUIREMENTS.md) — Technical requirements & constraints

**Debug & contribute:**
- [DEBUGGING_GUIDE.md](docs/DEBUGGING_GUIDE.md) — Three-pillar debugging methodology
- [EXTENDING.md](docs/EXTENDING.md) — Add a platform or protocol (Alpine + OpenBSD walkthroughs)
- [COMMIT_CHECKLIST.md](COMMIT_CHECKLIST.md) — Definition of done
- [CONTRIBUTING.md](CONTRIBUTING.md) — Issues, pull requests, and project stance
- [SECURITY.md](SECURITY.md) — How to report a vulnerability
- [CHANGELOG.md](CHANGELOG.md) — What's in each release

---

## Project status

Heading toward the first public release (1.0). Recent milestones:

- Unit, integration, architecture, and ownership test suites passing on
  FreeBSD and Linux (~860 tests, ~2350 assertions per platform)
- `vpn-switch sync` for upgrade-time DB refresh (phases + env + version)
  against source templates, and `vpn-switch version` for source/DB drift
- Cross-platform installer (FreeBSD + Linux, with an Alpine plugin) and an
  FHS-compliant layout

---

## Architecture at a glance

vpn-switch is built around a **combinator pattern**: every command is one
of three function types — terminal (`_`), combinator (`__`), or batch
combinator (`___`) — and each function outputs the next rewrite step
rather than executing side effects directly. Per-function "interpreters"
determine what happens to that output: execute it as shell (`sh`), display
it for inspection (`cat`), recurse it back through dispatch (`xargs sh -c`),
or anything else you set.

The result is a small, composable, deeply debuggable system. You can
inspect any rewrite step before execution by switching one variable:

```sh
vpn-switch setenv VPN_SWITCH_INTERPRETER_start cat
vpn-switch start privacy
# Shows what 'start' would dispatch to — no execution
```

For the full picture, see [ARCHITECTURE.md](docs/ARCHITECTURE.md).

---

## Phases & the patch step

Provider config files are usually written for Linux — a WireGuard file, for
example, embeds `PostUp`/`PostDown` DNS hooks that call Linux's `resolvconf`.
vpn-switch never runs the downloaded file as-is: at start time it **patches** a
session copy — stripping those Linux-specific hooks (DNS is handed to the DNS
phase instead) and, for OpenVPN, injecting the up/down scripts, daemon mode,
and the interface. One config then works on FreeBSD and Linux alike. Preview it
with `vpn-switch wireguard patch <config>` (or `openvpn patch`).

What the tunnel then does *around* itself — firewall, DNS, and more — is an
ordered list of **phases**:

```sh
VPN_SWITCH_PHASES_CONNECT    = firewall vpn dns     # disconnect runs the reverse
```

Each phase is generated from a swappable **backend** (firewall: `pf` / `ipfw` /
`iptables` / `none`; DNS: `resolvconf` / `unbound` / `djbdns` / `dnsmasq` /
`none`), chosen per phase via a `phase:backend` syntax — and you can drop in your
own backend script. That is what lets one tool serve a `pf`+`unbound` laptop and
an `iptables`+`dnsmasq` server without special-casing. Details:
`vpn-switch help phases`.

---

## Repository layout

```
vpn-switch/
├── vpn-switch.sh                  # Main script
├── vpn-switch-{unit,integration,architecture}-test.sh   # Test suites
├── GNUmakefile                    # Build/install/test
├── include/                       # Sourced shell modules (database.sh, session.sh, ...)
├── template/                      # Templates: env defaults, phase scripts, platform
│   ├── environment/               # VPN_SWITCH_* default values
│   ├── phase/                     # connect/disconnect/inspect phase scripts
│   └── platform/                  # OS-specific variables + Makefile plugins
├── scripts/                       # Build/dev tooling (generate-metadata, run-all-tests)
├── docs/                          # All documentation
└── README.md                      # You are here
```

---

## Requirements

- POSIX `/bin/sh` (FreeBSD ash, dash, bash all work)
- WireGuard tools (`wireguard-tools` package) and/or OpenVPN (`openvpn` package)
- GNU `make` (called `gmake` on FreeBSD; default `make` on Linux)
- That's it. No language runtime, no daemon.

See [INSTALL.md](docs/INSTALL.md) for the per-OS package list and the
install procedure.

---

## License

BSD 2-Clause — see [LICENSE](LICENSE).

---

## Acknowledgements

Project developed by Dr. Johannes Brügmann with assistance from Claude
(Anthropic), 2024–2026.
