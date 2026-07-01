# vpn-switch - Migration & Backup Tutorial

This tutorial covers `vpn-switch dump` / `vpn-switch restore` for backing
up a database and migrating between hosts. Every command was verified
against debian-host (Debian 12) and freebsd-host (FreeBSD 15.0) on 2026-05-21.

**Prerequisites:** Complete [TUTORIAL_QUICKSTART.md](TUTORIAL_QUICKSTART.md)
and have a working `$VPN_SWITCH_BASE` with at least one imported config.

---

## What `dump` Does (and Doesn't)

`vpn-switch dump` walks the active database and emits a portable shell
script that, when fed back through `vpn-switch restore`, recreates:

- `setenv` calls for the environment in `.env/local/` (a minimal profile
  subset in the prologue, the full set in the epilogue)
- `wireguard import` and `openvpn import` calls for every config
- Category and link structure for both protocols (`add` / `link` calls)
- Named-session metadata (`session create`/`populate`, `patch`,
  `configure`, `session save`)

What `dump` does **not** capture:

- The actual VPN process state (sessions in `active` state are dumped as
  metadata only — there's no live process to restore).
- The original config files. The dump references them by **absolute
  source path** (e.g.
  `/home/user/.vpn-switch/db/wireguard/wg-CH-12.conf`). For migration to a
  different host or path, you must transfer the config files separately
  and either keep the paths identical or rewrite them (see
  [Cross-host migration](#step-3-cross-host-migration-with-path-rewriting)
  below).
- Log files, trace files, batch-exit records (`.log/`, `.tmp/`).

The dump output is a regular shell script — read it before running it.

---

## Step 1: Dump the Database

```console
$ vpn-switch dump > ~/backup-$(date +%F).sh
$ head -10 ~/backup-2026-05-21.sh
# vpn-switch database dump
# Generated: 2026-05-21 16:08:08

# Prologue - Transfer OLD database settings (safe minimal set for restore)
"$VPN_SWITCH_CONTEXT_SCRIPT" setenv VPN_SWITCH_TERMINAL_INTERPRETER "sh"
"$VPN_SWITCH_CONTEXT_SCRIPT" setenv VPN_SWITCH_INTERFACE_wireguard "test_wg0"
"$VPN_SWITCH_CONTEXT_SCRIPT" setenv VPN_SWITCH_PHASES_CONNECT "firewall:none vpn dns:none"
"$VPN_SWITCH_CONTEXT_SCRIPT" setenv VPN_SWITCH_PHASES_DISCONNECT "dns:none vpn firewall:none"

# openvpn protocol dump
```

The structure is:

1. **Header** — date stamp.
2. **Prologue** — `setenv` calls for the minimal env vars the restore
   process itself needs (interface, terminal interpreter, phases).
3. **Protocol body** — one block per protocol (openvpn, wireguard) with
   `import`/`link`/`add` calls.
4. **Session block** — `session create`/`populate`/`save` calls for
   every named session. **Note:** sessions don't round-trip through a
   dump; see [Step 4](#step-4-sessions-dont-round-trip--recreate-them).
5. **Epilogue** — `setenv` calls for the rest of `.env/local/`.

---

## Step 2: Same-Host Restore (Simplest Case)

Use this for: backups that you'll restore on the same machine, snapshots
before a risky `setenv` change, or duplicating a DB to a parallel location.

```console
$ vpn-switch bootstrap ~/.vpn-switch/db-restored minimal
# Created: .session (mode 0700)
...
# Bootstrap complete: /home/user/.vpn-switch/db-restored (minimal)

$ VPN_SWITCH_BASE=~/.vpn-switch/db-restored vpn-switch restore ~/backup-2026-05-21.sh
```

`restore` reads the dump and executes it through the batch interpreter.
Both setenv and wireguard import calls run against the new DB.

**Recommended:** strip the session-dump block before restoring, since
sessions don't round-trip — see
[Step 4](#step-4-sessions-dont-round-trip--recreate-them):

```console
$ sed -e '/^# Session dump/,/^# Epilogue/d' \
      ~/backup-2026-05-21.sh > ~/backup-no-sessions.sh
$ VPN_SWITCH_BASE=~/.vpn-switch/db-restored vpn-switch restore ~/backup-no-sessions.sh
```

(The `sed` deletes the lines from the `# Session dump` header through the
`# Epilogue` header inclusive. The prologue and protocol body are untouched,
and the epilogue's `setenv` lines — which follow the deleted header — still
run.)

Verify:

```console
$ ls ~/.vpn-switch/db-restored/.env/local/
VPN_SWITCH_INTERFACE_wireguard
VPN_SWITCH_PHASES_CONNECT
VPN_SWITCH_PHASES_DISCONNECT
VPN_SWITCH_TERMINAL_INTERPRETER
...

$ ls ~/.vpn-switch/db-restored/wireguard/
wg-CH-12.conf
```

Env vars and configs match the source. Done.

---

## Step 3: Cross-host Migration (with Path Rewriting)

Use this when moving a database from one machine to another with a
different home directory layout or path conventions.

The challenge: `vpn-switch dump` writes the config import lines using
**absolute source paths**. Those paths almost certainly won't exist on
the target machine. There are two ways around this:

### Approach A: Stage configs in a known location, rewrite the dump

This is the recommended approach — it's explicit and reproducible.

**On the source host (debian-host):**

```console
debian-host$ vpn-switch dump > /tmp/backup.sh
debian-host$ tar czf /tmp/wg-configs.tar.gz -C $VPN_SWITCH_BASE wireguard
debian-host$ ls -la /tmp/backup.sh /tmp/wg-configs.tar.gz
-rw-r--r--  1 user  user  1802 May 21 16:08 /tmp/backup.sh
-rw-r--r--  1 user  user   434 May 21 16:08 /tmp/wg-configs.tar.gz
```

(Repeat the `tar` with `openvpn` if you use OpenVPN configs.)

**Transfer to the target host:**

```console
freebsd-host$ scp debian-host.local:/tmp/backup.sh /tmp/debian-host-backup.sh
freebsd-host$ scp debian-host.local:/tmp/wg-configs.tar.gz /tmp/debian-host-configs.tar.gz
```

**On the target host (freebsd-host) — extract configs to a staging dir
*outside* the new DB:**

```console
freebsd-host$ mkdir -p /tmp/debian-host-staging
freebsd-host$ tar xzf /tmp/debian-host-configs.tar.gz -C /tmp/debian-host-staging
freebsd-host$ ls /tmp/debian-host-staging/wireguard/
wg-CH-12.conf
```

**Bootstrap the destination DB:**

```console
freebsd-host$ vpn-switch bootstrap ~/.vpn-switch/db-from-debian-host minimal
# Bootstrap complete: /home/user/.vpn-switch/db-from-debian-host (minimal)
```

**Rewrite the dump file** so `wireguard import` reads from the staging
directory instead of the (nonexistent) source path, and strip the
session block:

```console
freebsd-host$ sed \
    -e 's|/home/user/.vpn-switch/tutorial/wireguard/|/tmp/debian-host-staging/wireguard/|g' \
    -e '/^# Session dump/,/^# Epilogue/d' \
    /tmp/debian-host-backup.sh > /tmp/restore.sh
```

Replace the first pattern with whatever the source's `$VPN_SWITCH_BASE`
was. Inspect the result before running:

```console
freebsd-host$ grep 'wireguard import' /tmp/restore.sh
"$VPN_SWITCH_CONTEXT_SCRIPT" wireguard import "/tmp/debian-host-staging/wireguard/wg-CH-12.conf"
```

**Restore:**

```console
freebsd-host$ VPN_SWITCH_BASE=~/.vpn-switch/db-from-debian-host vpn-switch restore /tmp/restore.sh
```

**Verify:**

```console
freebsd-host$ ls ~/.vpn-switch/db-from-debian-host/.env/local/ ~/.vpn-switch/db-from-debian-host/wireguard/
.env/local:
VPN_SWITCH_INTERFACE_wireguard
VPN_SWITCH_PHASES_CONNECT
VPN_SWITCH_PHASES_DISCONNECT
VPN_SWITCH_TERMINAL_INTERPRETER

wireguard:
wg-CH-12.conf

freebsd-host$ VPN_SWITCH_BASE=~/.vpn-switch/db-from-debian-host vpn-switch wireguard list
# === WireGuard Configurations ===
#
# Configuration files:
wireguard/wg-CH-12.conf
#
# Categories: (use 'wireguard list <category>' to see contents)
```

Done — env vars and configs match the source, and you can now use the DB
to start a session as in [TUTORIAL_QUICKSTART.md](TUTORIAL_QUICKSTART.md).

### Approach B: Pure-tar backup (no `dump` at all)

For full-fidelity preservation (including session metadata, log retention
settings, `.tmp/` state), skip `dump` entirely and tar the whole
database directory:

```console
debian-host$ tar czf db.tar.gz -C ~ .vpn-switch/db
freebsd-host$ scp debian-host.local:db.tar.gz ~
freebsd-host$ tar xzf ~/db.tar.gz -C ~
```

Caveats:
- Session metadata refers to PIDs that don't exist on the target, so
  `session list` shows everything as `stopped`. That's expected.
- If the home-directory paths differ between hosts, the absolute paths in
  `.env/local/` and `.session/<pid>/original` become stale. Inspect with
  `grep` and rewrite if needed.

Approach A tolerates home-dir differences; Approach B is simpler when both
machines have identical paths.

---

## Step 4: Sessions Don't Round-Trip — Recreate Them

For each named session, the `# Session dump` block emits these commands
(one set per session, using a literal `"$$"` PID placeholder):

```
"$VPN_SWITCH_CONTEXT_SCRIPT" session create "$$"
"$VPN_SWITCH_CONTEXT_SCRIPT" session populate "$$" "wireguard" "<interface>"
"$VPN_SWITCH_CONTEXT_SCRIPT" wireguard patch "$$" "<original-config-path>"
"$VPN_SWITCH_CONTEXT_SCRIPT" wireguard configure "$$"
"$VPN_SWITCH_CONTEXT_SCRIPT" session save <session-name>
```

A session is tied to a live process: `session create "$$"` keys the
session directory off the PID of the restoring shell, and the original
config path it records (`wireguard patch`) is the absolute path from the
*source* database, which won't exist on a different host. A named session
is therefore derived state — easiest to recreate on the target rather
than replay through the dump.

**Recommended:** strip the session block before restoring (shown in Steps
2 and 3), then recreate the sessions you need by starting and saving them:

```console
$ VPN_SWITCH_BASE=~/.vpn-switch/db-restored vpn-switch wireguard start wg-CH-12
...
$ VPN_SWITCH_BASE=~/.vpn-switch/db-restored vpn-switch session save work
# Saving session 12345 as 'work'
# Session saved: work -> 12345
```

---

## Troubleshooting

### `Restore file not found`

The dump file path passed to `restore` doesn't exist or isn't readable
by the calling user.

```console
$ vpn-switch restore /tmp/backup.sh
# Error: Restore file not found: /tmp/backup.sh
```

Verify with `ls -la` and use an absolute path.

### `Config already exists: wireguard/<name>.conf`

You ran the restore against a DB that already has the same config
imported (or pre-extracted the configs into the DB). `wireguard import`
fails on duplicate. Solutions:

- Use a fresh `bootstrap`'d destination DB (don't pre-populate).
- Use Approach A above with a staging dir *outside* the DB.

### Restore reports failures but keeps going

Restore runs the batch in keep-going mode (`VPN_SWITCH_BATCH_KEEP_GOING=1`,
set by `restore`), so a failed command is logged and the rest still run;
the overall command then exits with a batch code ≥ 128. Scan the output for
`# Error:` lines to find which steps failed. The usual culprit is a config
path that doesn't exist on the target host; re-run the path-rewrite `sed`
from Step 3.

### `wireguard list` shows nothing on restored DB

You probably extracted configs into a staging dir but the dump's
`wireguard import` references still pointed at the source path. Either
the import silently failed, or the configs went into a separate location.
Confirm the dump's import lines now reference the staging dir:

```console
$ grep 'wireguard import' /tmp/restore.sh
```

If they don't, redo the `sed` substitution.

---

## Use Cases

### Snapshot before a risky change

```console
$ vpn-switch dump > ~/snapshots/$(date +%F-%H%M).sh
$ # ...make changes...
$ # if something breaks:
$ vpn-switch bootstrap ~/.vpn-switch/rollback minimal
$ VPN_SWITCH_BASE=~/.vpn-switch/rollback vpn-switch restore ~/snapshots/2026-05-21-1530.sh
```

### Share a tested configuration with a colleague

Dump, manually trim to what you want to share (remove personal session
names and host-specific paths), and send the result. The recipient runs
`bootstrap` + `restore` against the trimmed file.

### Periodic backups

Run `vpn-switch dump > /backup/dir/$(date +%F).sh` from cron. Combine
with `tar czf /backup/dir/$(date +%F)-configs.tar.gz -C $VPN_SWITCH_BASE
wireguard openvpn` if you want a self-contained restore bundle.

---

## Next Steps

- [TUTORIAL_QUICKSTART.md](TUTORIAL_QUICKSTART.md) — first VPN connection
- [TUTORIAL_SESSIONS.md](TUTORIAL_SESSIONS.md) — saving and switching sessions
- [TUTORIAL_SUDO.md](TUTORIAL_SUDO.md) — sudo configuration for cross-user setups
