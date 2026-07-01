# Session Management Tutorial

This tutorial covers vpn-switch session management: saving, resuming, and
switching between VPN configurations.

**Prerequisites:** Complete [TUTORIAL_QUICKSTART.md](TUTORIAL_QUICKSTART.md) first.

## What are Sessions?

When you start a VPN (`vpn-switch wireguard start`, `vpn-switch openvpn start`),
vpn-switch creates a **session**: a self-contained snapshot of that connection,
keyed by the PID of the process that created it. A session can be resumed
without re-processing the config, named for easy reference, and switched between.

A session directory (`.session/<pid>/`) holds:

- `connect.sh` / `disconnect.sh` — cached, self-contained phase scripts
- `protocol`, `interface` — metadata
- `original` — path to the source config
- `started` — timestamp
- `pid` — the session PID
- `vpn.pid` — the VPN process PID (only while running)
- `<iface>.conf` — the patched config

## Sessions, links, and `latest`

Sessions live under two directories:

- `.session/<pid>/` — the per-session metadata above
- `session/` — symlinks pointing at sessions

`session save <name>` creates a symlink `session/<name> -> ../.session/<pid>`.
It does **not** copy files — the named session is just a pointer to the
underlying PID-keyed directory.

Starting a VPN also creates two system-managed symlinks:

- `latest` → the session just started (used by `session save` to know which
  session to name)
- `latest-<iface>` → marks which session currently owns that interface

`latest` is reserved — you cannot `session save latest`. The no-argument
`session start` resumes the **`default`** session (not `latest`), so set a
`default` with `session save default` if you want a one-word resume.

## Step 1: Your first session

Start a VPN:

```console
$ vpn-switch wireguard start privacy
==> Phase: vpn (execute)
[#] ip link add wg0 type wireguard
...
✓ VPN interface up: wg0
```

List sessions:

```console
$ vpn-switch session list
VPN Sessions:

PID    SESSION      PROTOCOL   IFACE    STATE                 CONFIG                 STARTED
---    -------      --------   -----    -----                 ------                 -------
45123  -            wireguard  wg0      active/referenced     wg-privacy.conf        2024-12-26 10:30:15

States: active=VPN running, stopped=VPN disconnected, referenced=has saved links, unreferenced=no links
```

The state is a pair `<vpn>/<ref>`:

- `active` — the VPN process is running; `stopped` — it is not
- `referenced` — at least one symlink (named, `latest`, or `latest-<iface>`)
  points at the session; `unreferenced` — none do, so it is a cleanup candidate

A freshly started session is already `referenced` because `latest` and
`latest-<iface>` point at it. The SESSION column shows `-` until you save a
name — `latest`/`latest-*` are not displayed there.

## Step 2: Save a named session

```console
$ vpn-switch session save work
# Saving session 45123 as 'work'
# Session saved: work -> 45123
```

The session now shows its name and you can reference it by `work` instead of by
PID:

```console
$ vpn-switch session list
PID    SESSION      PROTOCOL   IFACE    STATE                 CONFIG                 STARTED
---    -------      --------   -----    -----                 ------                 -------
45123  work         wireguard  wg0      active/referenced     wg-privacy.conf        2024-12-26 10:30:15
```

`session save` always names the **most recent** session (the one `latest`
points at). With no argument it saves under the name `default`.

## Step 3: Stop and resume

Stop the VPN (the session directory is preserved):

```console
$ vpn-switch stop
==> Phase: vpn (execute)
[#] ip link delete dev wg0
✓ VPN interface down: wg0
```

The session is now `stopped/referenced`:

```console
$ vpn-switch session list
PID    SESSION      PROTOCOL   IFACE    STATE                 CONFIG                 STARTED
---    -------      --------   -----    -----                 ------                 -------
45123  work         wireguard  wg0      stopped/referenced    wg-privacy.conf        2024-12-26 10:30:15
```

Resume by name — instant, no config re-processing, because it replays the
cached connect script:

```console
$ vpn-switch session start work
# Resume session: 45123 (via self-contained script)
==> Phase: vpn (execute)
[#] ip link add wg0 type wireguard
...
✓ VPN interface up: wg0
```

`session start` accepts a name or a PID; with no argument it resumes the
`default` session.

## Step 4: Switching between sessions

Each `start` creates a new session. To keep several around, save each:

```console
$ vpn-switch wireguard start streaming
$ vpn-switch session save home

$ vpn-switch wireguard start switzerland
$ vpn-switch session save travel
```

```console
$ vpn-switch session list
PID    SESSION      PROTOCOL   IFACE    STATE                 CONFIG                 STARTED
---    -------      --------   -----    -----                 ------                 -------
45123  work         wireguard  wg0      stopped/referenced    wg-privacy.conf        2024-12-26 10:30:15
45678  home         wireguard  wg0      stopped/referenced    wg-streaming.conf      2024-12-26 11:15:00
46012  travel       wireguard  wg0      active/referenced      wg-switzerland.conf   2024-12-26 12:00:30
```

Switch by stopping the active one and starting another:

```console
$ vpn-switch session stop travel
$ vpn-switch session start home
```

`session stop` accepts a name or PID and routes through the disconnect chain,
which is idempotent — stopping an already-stopped session is a safe no-op.

**With no argument, `session stop` stops _every_ session**, not just the active
one. This is intentional: the disconnect chain is idempotent, so emitting a stop
for each session reliably tears down whatever is live without having to guess
which one.

```console
$ vpn-switch session stop          # stops all sessions
$ vpn-switch session stop work     # stops only 'work' (no-op if already stopped)
```

## Step 5: Inspect a session

`session show` prints the cached connect script and metadata. It accepts a name
or PID (with no argument it shows the most recently modified session):

```console
$ vpn-switch session show work
Session Show

Session: 45123
Protocol: wireguard
Interface: wg0
Config: wg-privacy.conf

Connect script (/home/user/.vpn-switch/db/.session/45123/connect.sh):

#!/bin/sh
# WireGuard VPN Connection Script (Self-Contained)
# Generated: 2024-12-26 10:30:15
# Session: 45123
...
```

This is the exact script `session start` executes, so it is also a debugging
tool:

```console
$ vpn-switch session show work | sed 's/^# //' > /tmp/connect-work.sh
```

## Step 6: Cleanup

Remove a stopped session by PID or name (a name resolves to the underlying PID).
`session remove` refuses to remove an active session — stop it first.

```console
$ vpn-switch session remove home
Removing session: 45678
Session removed: 45678
```

Removing the session directory leaves its named symlink dangling.
`session clean` reviews and removes dangling symlinks and dead, unreferenced
session directories:

```console
$ vpn-switch session clean
# Session cleanup (symlinks + stale sessions)
#
# Part 1: Stale symlink cleanup
# Removing stale link: home → 45678
#
# Part 2: Stale session cleanup
# No sessions found
#
# Summary
# Removed 1 stale symlink(s)
# Session cleanup complete
```

Note that `session clean` is a database-only operation: it never destroys
network interfaces (that is the job of `vpn-switch stop`). Dead-but-referenced
sessions are kept so you can still resume them.

Clean up when `session list` shows broken links, after removing configs, or
after a reboot leaves stale entries.

## Troubleshooting

### "Session not found" / "Stale session link"

A bare PID that no longer exists reports `Session not found`. A name whose
target directory was removed reports a stale link:

```console
$ vpn-switch session start work
Error: Stale session link work: 45123
  Session directory removed - run vpn-switch session clean
```

Run `vpn-switch session clean` to drop the dangling link.

### After a reboot

Session directories survive reboots but the VPN processes do not, so every
session shows `stopped`. Resume the one you want (`session start <name>`) or
`session clean` to discard them.

### Interface ownership drift

If a resume re-points interface ownership but the interface was already up with
a different config, `session list` can attribute the interface to the wrong
session. `vpn-switch session refresh` reconciles `latest-<iface>` ownership
against the WireGuard peers actually loaded on the interface, repointing it to
the session whose stored config matches. It acts only on positive evidence and
needs no root.

## Session directory structure

```
$VPN_SWITCH_BASE/
├── .session/                       # PID-keyed session metadata
│   └── 45123/
│       ├── pid
│       ├── protocol
│       ├── interface
│       ├── original
│       ├── started
│       ├── vpn.pid                 # only while the VPN is running
│       ├── wg0.conf                # patched config
│       ├── connect.sh
│       └── disconnect.sh
└── session/                        # symlinks into .session/
    ├── work          → ../.session/45123
    ├── default       → ../.session/45123   # user-managed
    ├── latest        → ../.session/45123   # system-managed (most recent)
    └── latest-wg0    → ../.session/45123   # system-managed (interface owner)
```

Named symlinks (including `default`) are exported by `vpn-switch dump`;
`latest` is skipped, since it is transient state recreated on the next start.

## Advanced: session state via `inspect`

`vpn-switch inspect` includes a `Session Status` section that combines the
session table, the named-symlink listing, and per-session script sizes:

```console
$ vpn-switch inspect
...
# Section: Session Status
VPN Sessions:

PID    SESSION      PROTOCOL   IFACE    STATE                 CONFIG                 STARTED
---    -------      --------   -----    -----                 ------                 -------
45123  work         wireguard  wg0      active/referenced     wg-privacy.conf        2024-12-26 10:30:15

States: active=VPN running, stopped=VPN disconnected, referenced=has saved links, unreferenced=no links

Named Sessions

default → ../.session/45123
latest → ../.session/45123
work → ../.session/45123

Session Scripts

Session 45123 (wireguard / wg0):
  Connect: /home/user/.vpn-switch/db/.session/45123/connect.sh
  Disconnect: /home/user/.vpn-switch/db/.session/45123/disconnect.sh
  Connect size: 211 lines
  Disconnect size: 165 lines
...
```

## End-to-End Verification

Full lifecycle on Debian 12 (debian-host), 2026-05-23, using a scratch database
(`$HOME/.vpn-switch/tutorial-e2e`) and the `test_wg0` interface for safe
experimentation
(see [TUTORIAL_SUDO.md → Safe Experimentation](TUTORIAL_SUDO.md#safe-experimentation-test-interface--scratch-database)).

### 1. Empty state

```console
$ vpn-switch session list
VPN Sessions:

- No active sessions
```

### 2. Start (creates session + `latest`/`latest-test_wg0`)

```console
$ vpn-switch wireguard start wg-CH-12
# Created session 1561012
```

(Phase output goes to stdout; truncated. See the QUICKSTART verification section
for the full `ip link add … wg setconf … sysctl …` sequence.)

```console
$ vpn-switch session list
PID     SESSION  PROTOCOL   IFACE     STATE                CONFIG          STARTED
---     -------  --------   -----     -----                ------          -------
1561012 -        wireguard  test_wg0  active/referenced    wg-CH-12.conf   2026-05-23 07:35:49
```

### 3. Save by name

```console
$ vpn-switch session save mywork
# Saving session 1561012 as 'mywork'
# Session saved: mywork -> 1561012
```

### 4. Show by PID and by name resolve identically

```console
$ vpn-switch session show mywork
Session Show

Session: 1561012
Protocol: wireguard
Interface: test_wg0
Config: wg-CH-12.conf

Connect script (/home/user/.vpn-switch/tutorial-e2e/.session/1561012/connect.sh):
...
```

`vpn-switch session show 1561012` produces byte-identical output: the name
resolves to the PID before lookup.

### 5. Stop with no argument (stops all sessions)

```console
$ vpn-switch session stop
==> Phase: vpn (prepare)
✓ VPN disconnect ready
==> Phase: vpn (execute)
[#] ip -4 rule delete table 51820
[#] ip -6 rule delete table 51820
[#] ip link delete dev test_wg0
[#] resolvconf -d tun.test_wg0 -f
[#] nft -f /dev/fd/63
✓ VPN interface down: test_wg0
# Disconnecting WireGuard interface: test_wg0 (session: 1561012)
```

The no-arg variant emits a stop for every session; here there is one. List
confirms `stopped/referenced`:

```console
$ vpn-switch session list
PID     SESSION  PROTOCOL   IFACE     STATE                 CONFIG          STARTED
---     -------  --------   -----     -----                 ------          -------
1561012 mywork   wireguard  test_wg0  stopped/referenced    wg-CH-12.conf   2026-05-23 07:35:49
```

### 6. Resume by name

```console
$ vpn-switch session start mywork
==> Phase: vpn (prepare)
✓ VPN prerequisites met
==> Phase: vpn (execute)
[#] ip link add test_wg0 type wireguard
[#] wg setconf test_wg0 /dev/fd/63
[#] ip -4 address add 192.0.2.2/32 dev test_wg0
[#] ip link set mtu 1420 up dev test_wg0
...
✓ VPN interface up: test_wg0
```

### 7. Stop, remove, and clean

```console
$ vpn-switch session stop mywork
...
✓ VPN interface down: test_wg0

$ vpn-switch session remove mywork
Removing session: 1561012
Session removed: 1561012

$ vpn-switch session clean
# Removing stale link: latest → 1561012
# Removing stale link: latest-test_wg0 → 1561012
# Removing stale link: mywork → 1561012
# No sessions found
# Removed 3 stale symlink(s)
# Session cleanup complete
```

Removing the session directory left `mywork` and the system-managed `latest` /
`latest-test_wg0` dangling; `session clean` removed all three.

### Behaviours verified

| Command | Notes |
|---|---|
| `session list` | Empty, active, and stopped states render correctly |
| `wireguard start` | Creates session, sets `latest` and `latest-<iface>` |
| `session save <name>` | Two-line confirmation; names the `latest` session |
| `session show <PID>` / `<name>` | Name resolves to PID; identical output |
| `session stop` (no arg) | Stops every session (idempotent disconnect) |
| `session stop <name>` / `start <name>` | Resolves name, then dispatches |
| `session remove <name>` | Refuses if active; removes the session dir |
| `session clean` | Removes dangling symlinks + dead unreferenced sessions |

## Next Steps

- [TUTORIAL_MIGRATION.md](TUTORIAL_MIGRATION.md) — Database migration with dump/restore
- [QUICK_REFERENCE.md](../QUICK_REFERENCE.md) — Command cheatsheet
- [README.md](../README.md) — Full documentation
</content>
</invoke>
