# Troubleshooting Tutorial

When something doesn't work as expected, follow this guide. The central
tool is `vpn-switch validate`. Everything else builds on what it tells you.

This tutorial is the **first stop**. For deeper investigation
(trace files, command inspection at each rewrite step), see
[DEBUGGING_GUIDE.md](DEBUGGING_GUIDE.md).

---

## TL;DR

```sh
vpn-switch validate
```

Read the output top to bottom. Each block is one check. Every line is
prefixed with `# `; `✓` means fine, `[WARNING]` means probably-not-blocking-
but-fix-it, `[ERROR]` means something is broken.

If everything is `✓` and a problem still happens, jump to
[DEBUGGING_GUIDE.md](DEBUGGING_GUIDE.md) for command-inspection methodology.

---

## How `vpn-switch validate` is organised

It runs these checks in sequence, each independently (current order in
`___validate0`):

| # | Check | What it covers |
|---|---|---|
| 1 | Per-protocol validate (`<proto> validate`) | Symlink integrity inside `wireguard/`, `openvpn/` |
| 2 | `session validate` | Session symlink + metadata consistency |
| 3 | `logs validate` | Log retention vs `VPN_SWITCH_RETENTION_DAYS_LOG` |
| 4 | `database validate` | Required DB directories + extension symlinks present |
| 5 | `binaries validate` | wg-quick, openvpn, pfctl, etc. available in `$PATH` |
| 6 | `phases validate` | Phase scripts present + executable for configured `PHASES_CONNECT/DISCONNECT` |
| 7 | `network validate` | Interface collisions; VPN interfaces not already up; ext_if exists |
| 8 | `permissions validate` | DB dir perms (`0700`), session configs (`0400`), phase scripts executable |
| 9 | `environment validate` | `VPN_SWITCH_BASE`, `INTERFACE_*`, `PHASES_*` set |
| 10 | `install validate` | `$VPN_SWITCH_LIBDIR` layout, platform symlink, `template/VERSION`, resolvconf helpers |
| 11 | `version validate` | DB `.version` vs source `template/VERSION` (drift) |
| 12 | `sudo validate` | Passwordless sudo works (only if interpreters use sudo) |

Each can be run alone for a focused look:

```sh
vpn-switch install validate
vpn-switch version validate
vpn-switch permissions validate
```

---

## Common scenarios

### "I just installed it. Did it work?"

```sh
vpn-switch validate
```

Look at **install validate**. Common findings:
- `✓ Install layout OK` — script + libs + helpers are where they should be, platform symlink matches your OS.
- `[ERROR] VPN_SWITCH_LIBDIR not found: <path>` — install didn't run, used the wrong PREFIX, or `$VPN_SWITCH_LIBDIR` is overridden incorrectly. Re-run `sudo gmake install` and verify with `which vpn-switch`.
- `[WARNING] Platform symlink → freebsd.sh but detected platform is linux` — the FreeBSD platform plugin is linked on a Linux box. Re-run `sudo gmake install` (the installer detects the platform from `uname -s` and sets the symlink).
- `[WARNING] Resolvconf helper missing or not executable: /usr/local/sbin/<helper>` — the DNS helper scripts the phase scripts call by absolute path aren't installed there. Re-install fixes it: `gmake uninstall && sudo gmake install`.

### "VPN starts but DNS doesn't work"

Almost always one of:

1. **Resolvconf helpers missing** — `vpn-switch install validate` will tell you.
2. **`local_unbound` not running** (FreeBSD) — `service local_unbound status`.
3. **DNS phase backend disabled** — `vpn-switch printenv | grep PHASES_CONNECT`. If it doesn't include `dns`, the connect script never touched DNS.

For the FreeBSD `local_unbound`-rc.d-quirk fix, see [INSTALL.md](INSTALL.md#freebsd).

### "I get a sudo password prompt for every VPN start"

```sh
vpn-switch sudo validate
```

Output tells you which interpreters use sudo and whether `sudo -n true`
works. If it doesn't, you have two options:

1. Configure passwordless sudo for the specific binaries (recommended) —
   see [TUTORIAL_SUDO.md](TUTORIAL_SUDO.md) for the exact sudoers rules.
2. Live with the prompt.

Either is a fine choice. The check just makes the situation visible.

### "I upgraded vpn-switch and something is off"

```sh
vpn-switch version validate
```

Three outcomes:

- `✓ Version in sync (db == source)` — your DB is aligned with the
  installed source.
- `[WARNING] Version drift: db=... source=... — run 'vpn-switch sync'` —
  the source is newer than your DB's last sync. Run the suggested
  `vpn-switch sync` to refresh phase scripts, environment defaults, and
  the version stamp.
- `[WARNING] DB never synced` — your DB doesn't have a `.version` file
  yet (e.g., restored from an old `dump`). Same fix: `vpn-switch sync`.

### "Something started failing without me changing anything"

Start with:

```sh
vpn-switch validate 2>&1 | grep -E '\[ERROR\]|\[WARNING\]'
```

This filters down to just the findings. Common silent breakages caught here:

- **Permissions check**: a `chmod` somewhere stripped the executable bit
  off a phase script.
- **Network check**: a stale interface exists from a previous session that
  didn't clean up (`[WARNING] VPN interface already exists: <if> (stale session?)`).
- **Binaries check**: a package update moved or removed `wg-quick` /
  `openvpn` from `$PATH`.
- **Database check**: a required directory got deleted manually.

### "I want to know what would run, without running it"

That's not a `validate` use case — that's `inspect` plus interpreter
switching. See [ARCHITECTURE.md](ARCHITECTURE.md) "Why Different Interpreter
Signatures?" and [DEBUGGING_GUIDE.md](DEBUGGING_GUIDE.md) Pillar 2.

Short version:

```sh
vpn-switch setenv VPN_SWITCH_INTERPRETER_wireguard_connect1 cat
vpn-switch wireguard start <config>
# Shows the would-run shell commands instead of executing them
```

### "When the database feels stale" — dump/restore as a cleanup tool

A saved session's cached scripts are generated when the session is saved.
If they were generated by an older vpn-switch version, they can carry over
bugs that have since been fixed — DNS that works for new sessions but not
an old one, behaviour that differs from what `vpn-switch wireguard configure`
generates today.

`vpn-switch sync` refreshes `.env/default/` and the phase templates under
`.include/phase/`, but it does **not** rewrite a saved session's cached
scripts. Those are baked in at save time.

**The clean fix is dump → restore into a fresh database.** `vpn-switch dump`
emits each saved session as a sequence of `session create` / `session
populate` / `<proto> patch` / `<proto> configure` / `session save` commands
(see `___session_dump0`), **not** as cached scripts. On restore those
commands run against the *current* code and produce fresh scripts. Same
session names, fresh contents.

End-to-end:

```sh
vpn-switch stop                                  # close any active session
vpn-switch dump > /tmp/db-migrate.sh             # capture configs + saved sessions

# Option A — replace in place
mv ~/.vpn-switch/db ~/.vpn-switch/db.old   # keep old DB as a safety net
vpn-switch bootstrap ~/.vpn-switch/db minimal  # fresh DB at the same path
sh /tmp/db-migrate.sh                              # re-imports configs, regenerates sessions

# Option B — side by side
vpn-switch bootstrap ~/.vpn-switch/db.new minimal
VPN_SWITCH_BASE=~/.vpn-switch/db.new sh /tmp/db-migrate.sh
# Try the new DB; if happy, swap the symlink/env to point at it
```

What you get after restore:

- All saved session names preserved
- Cached scripts regenerated from current templates → carry today's fixes
- Unreferenced stale session directories gone (they're not in the dump)

`vpn-switch dump` also captures your `.env/local/` overrides: the prologue
emits the profile subset and the epilogue emits the complete set, both as
`setenv` commands (see `___dump0` / `___dumpenv1`). What you *don't* get is
the active session state — you stopped before dumping, by design.

See [TUTORIAL_MIGRATION.md](TUTORIAL_MIGRATION.md) for the full dump/restore
workflow, including moving between machines.

---

## `validate` vs `inspect`

Both look at system state. They differ in intent:

| | `validate` | `inspect` |
|---|---|---|
| Mood | Prescriptive ("here are the problems") | Descriptive ("here is everything that's there") |
| Output | Findings + ✓/[WARNING]/[ERROR] markers | Full state dump (sessions, config, phase setup) |
| Exit code | Non-zero on critical findings | Always 0 |
| When to use | Health check, after-upgrade sanity, CI | Understanding the current setup |

Use **`validate` first**. If it's clean and you still want to understand
what's going on, then `inspect`.

---

## Beyond validate

`validate` is the first 80% of triage. The remaining 20% — actual
trace-level debugging when validate is clean but something still misbehaves
— is covered by:

- **[DEBUGGING_GUIDE.md](DEBUGGING_GUIDE.md)** — Three-pillar methodology:
  environment inspection (`printenv`), command inspection (interpreter
  switching), log/trace inspection (`.log/` and `.trace/` files).
- **[ARCHITECTURE.md](ARCHITECTURE.md)** — Understanding the combinator
  rewrite chain so you can reason about what's happening at each step.

---

## Quick reference

```sh
vpn-switch validate                       # Full health check (start here)
vpn-switch install validate               # Install layout only
vpn-switch version validate               # Source/DB version drift
vpn-switch sudo validate                  # Sudo passwordless setup
vpn-switch permissions validate           # Perms (DB/sessions/phase scripts)
vpn-switch environment validate           # VPN_SWITCH_* env vars
vpn-switch binaries validate              # wg-quick, openvpn, pfctl in PATH

vpn-switch validate 2>&1 | grep -E '\[ERROR\]|\[WARNING\]'   # findings only
vpn-switch inspect                        # full state dump (no judgment)

vpn-switch printenv                       # effective environment
vpn-switch session list                   # live sessions
```
