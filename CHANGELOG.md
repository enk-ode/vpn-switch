# Changelog

All notable changes to vpn-switch are documented here. The format is based on
[Keep a Changelog](https://keepachangelog.com/), and the project aims to follow
[Semantic Versioning](https://semver.org/).

## [Unreleased] — towards 1.0.0

The first public release. vpn-switch was developed privately from 2024 to 2026;
rather than replay that history commit by commit, this entry summarises the
capabilities present at 1.0.

### Added

**Protocols & connection**

- WireGuard and OpenVPN support behind a shared command surface.
- Protocol-agnostic `start` / `stop` / `status`. `start` auto-detects the
  protocol and, with no argument, resumes the default session or picks one at
  random.

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
