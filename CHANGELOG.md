# Changelog

All notable changes to vpn-switch are documented here. The format is based on
[Keep a Changelog](https://keepachangelog.com/), and the project aims to follow
[Semantic Versioning](https://semver.org/).

## [Unreleased] — towards 1.0.0

- FreeBSD rc.d: the devd `linkup` does nothing until the boot's own `start`
  has run (`/var/run/vpn_switch.started`): the uplink's LINK_UP is queued
  before devd runs, so `linkup` used to start the session before pf and the
  routes ("Firewall configuration failed") and `start` then ran it again
  (illyria 2026-09-18). Two starts at once (a flapping uplink) are
  serialized by the lock directory `/var/run/vpn_switch.lock`; the loser
  prints one line and returns 0.

The first public release. vpn-switch was developed privately from 2024 to 2026;
rather than replay that history commit by commit, this entry summarises the
capabilities present at 1.0.

### Added

**Boot integration (FreeBSD)**

- The rc.d service `vpn_switch` now does what its name promises: it brings
  the saved default session up at boot, ordered before `ntpdate`/`ntpd`/
  `openntpd` (a firewall that only lets the tunnel out leaves the time
  daemons without DNS until the VPN egress exists), after waiting for the
  uplink to have link and an address. A devd rule (`etc/devd/vpn_switch.conf`)
  calls `service vpn_switch linkup` whenever the uplink reports `LINK_UP`;
  both paths are no-ops while a session is connected.
- The service runs vpn-switch as the database owner. `gmake install`
  derives user, database (`~/.vpn-switch/db`) and uplink (default `lagg0`)
  from `SUDO_USER` and writes them to `etc/rc.conf.d/vpn_switch` once;
  `VPN_SWITCH_RC_USER` / `VPN_SWITCH_RC_IFNAME` override at install time.
  The previous placeholder script (credentials.txt under /data/vpn, a start
  that only ran `status`) is gone.

**Shell completion**

- `vpn-switch complete <words...>` prints completion candidates for a
  partially typed command line, derived from the `#@help` corpus: command
  words from the `@command` usages, placeholder values (configs, categories,
  sessions, variables, phases, profiles) from the database. New corpus tags
  `@defcompletion <placeholder> <source>` (one table in `include/help.sh`) and
  `@completion <placeholder> <source>` (per-command override); architecture
  test C fails if a usage placeholder has no source.
- `completion/vpn-switch.bash`: the bash side, a thin loop over that output,
  installed to `share/bash-completion/completions/vpn-switch` by `gmake
  install`. Existing databases pick up the display pin with `vpn-switch env
  sync`.
- Usage lines `helpenv [<name> [<location>]]` and `helpintp <fn> [<location>]`
  now write the layer placeholder in angle brackets like every other one.

**Protocols & connection**

- WireGuard and OpenVPN support behind a shared command surface.
- Protocol-agnostic `start` / `stop` / `status`. `start` auto-detects the
  protocol and, with no argument, resumes the default session or picks one at
  random.
- Patched WireGuard configs get `PersistentKeepalive` injected when the
  provider config sets none, so tunnels survive NAT rebinds and link flaps
  instead of staying silent until rebuilt by hand. Default 25 s, configurable
  via `VPN_SWITCH_KEEPALIVE_wireguard` (`0` disables, an explicit value in the
  config always wins).

**Configuration database**

- Filesystem-based config database with per-protocol `import`, `list`, `add`,
  `link`, `remove`, `validate`, `clean`, `info`, `patch`, and `dump`.
- Categories / groups and symlink aliases to organise many configurations.

**Sessions**

- Session caching: each connect writes a replayable `connect.sh` for instant
  reconnects.
- Named sessions — `session save` / `start` / `stop` / `show` / `list` /
  `remove` / `clean` — plus `session refresh` to reconcile interface ownership
  against the peers actually loaded.

**Database lifecycle**

- `bootstrap` / `init` with selectable profiles (minimal / all / custom).
- `dump` / `restore` / `batch` for portable backup and migration.
- `sync` (phases + env + version) and `version` drift detection against the
  installed source templates.

**Environment & customisation**

- Two-tier environment (`.env/default` + `.env/local`) via `setenv` / `getenv`
  / `unsetenv` / `printenv`, plus `environment cache` / `environment inspect`.
- Phase-based connect/disconnect scripts with a lifting engine and backend
  selection (firewall: pf / ipfw / iptables; DNS: resolvconf / unbound / …).
- Per-function interpreters — execute, display (dry-run), log, or replace any
  step by setting one variable.

**Diagnostics**

- `validate` with 12 sub-checks (each also runnable on its own), `inspect` for
  a full descriptive state dump, and `logs validate` / `logs clean`.

**Help & documentation**

- Generated help system: `vpn-switch help`, per-group and per-command help,
  rendered from in-source doc-blocks. The `vpn-switch(1)` man page COMMANDS
  section is generated from the same corpus, so help and the man page cannot
  drift apart.
- Install guide, quick-start / sessions / migration / troubleshooting tutorials,
  and architecture / design documentation.

**Platform & packaging**

- Pure POSIX `/bin/sh` — no language runtime, daemon, or third-party
  dependencies.
- Cross-platform install (FreeBSD rc.d service + Linux systemd unit template),
  FHS-compliant layout, and a `GNUmakefile` for build / install / test.

### Tested

- 1736 tests / 4734 assertions, green on FreeBSD and Debian, across unit,
  integration, and architecture suites.

[Unreleased]: https://github.com/enk-ode/vpn-switch
