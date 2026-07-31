# vpn-switch - sudo Configuration Tutorial

This tutorial explains how to configure `sudo` for `vpn-switch` so that the
database, configuration, and session metadata stay owned by your normal user
while network operations (interface up/down, routing, firewall, DNS) run as
`root`.

**Prerequisites:** [TUTORIAL_QUICKSTART.md](TUTORIAL_QUICKSTART.md) (Step 4
already configures `wireguard_connect1` with `sudo sh`).

---

## Safe Experimentation: Test Interface + Scratch Database

Before changing sudo configuration on a production database with active
sessions, set up a separate playground. The pattern is:

1. A scratch database in `~/.vpn-switch/tutorial` (won't touch your real
   `$VPN_SWITCH_BASE`).
2. A test interface name (`test_wg0` for WireGuard, `test_tun0` for
   OpenVPN) so any `start`/`stop` you experiment with doesn't collide with
   a running `wg0`/`tun0`.

```console
$ vpn-switch bootstrap ~/.vpn-switch/tutorial minimal
# Created: .session (mode 0700)
# Validated: .tmp
...
# Bootstrap complete: /home/user/.vpn-switch/tutorial (minimal)

$ export VPN_SWITCH_BASE=~/.vpn-switch/tutorial
$ vpn-switch setenv VPN_SWITCH_INTERFACE_wireguard test_wg0
# Set VPN_SWITCH_INTERFACE_wireguard (effective next command)
$ vpn-switch setenv VPN_SWITCH_TERMINAL_INTERPRETER sh
# Set VPN_SWITCH_TERMINAL_INTERPRETER (effective next command)
```

Verify the interface name took effect:

```console
$ vpn-switch status
=== VPN Status ===
Status: Disconnected

=== Network Interfaces ===
test_wg0: not found
```

The `test_wg0: not found` line is what you want — it confirms `vpn-switch`
is looking for `test_wg0` (your test interface), not `wg0` (your
production interface). When you're done experimenting, your real DB and
production session are untouched; either delete `~/.vpn-switch/tutorial`
or just leave it for the next round.

All commands in the rest of this tutorial are safe to run against the
scratch database. Re-export `VPN_SWITCH_BASE` to switch back to your real
DB when finished.

---

## Overview

Every `vpn-switch` command pipes through a per-function *interpreter* that
controls whether output is executed, dry-run, or logged — and **as which user**
it runs. This separates two privilege boundaries:

1. **Database access** — reading/writing `$VPN_SWITCH_BASE/...` (configs,
   sessions, environment variables). Stays as the normal user.
2. **Network operations** — creating interfaces, adding routes, modifying
   firewall rules, restarting DNS resolvers. Requires `root`.

Keep the database under `~/.vpn-switch/db` owned by `user:user`, and escalate
to root only for the handful of functions that touch network state.

---

## Configuration Surface

### Protocol Interpreters (connect/disconnect)

These run the generated phase scripts that bring interfaces up and down. They
**must** be configured with `sudo`:

```bash
# WireGuard
vpn-switch setenv VPN_SWITCH_INTERPRETER_wireguard_connect1    'sudo sh'
vpn-switch setenv VPN_SWITCH_INTERPRETER_wireguard_disconnect1 'sudo sh'

# OpenVPN
vpn-switch setenv VPN_SWITCH_INTERPRETER_openvpn_connect1    'sudo sh'
vpn-switch setenv VPN_SWITCH_INTERPRETER_openvpn_disconnect1 'sudo sh'

# Session resume (executes a session's cached connect.sh)
vpn-switch setenv VPN_SWITCH_INTERPRETER_session_connect 'sudo sh'
```

`sudo sh | cut -b3-` is also valid — the `cut -b3-` strips the defensive
`# ` prefix from terminal-function output (see CLAUDE.md memory note on the
hash prefix).

### Status / Inspect Interpreters

These read kernel state that's only visible to root on most systems:

```bash
vpn-switch setenv VPN_SWITCH_INTERPRETER_status0             'sudo sh'
vpn-switch setenv VPN_SWITCH_INTERPRETER_phases_inspect0     'sudo sh'
vpn-switch setenv VPN_SWITCH_INTERPRETER_wireguard_enumerate0 'sudo sh | cut -b3-'
vpn-switch setenv VPN_SWITCH_INTERPRETER_openvpn_enumerate0   'sudo sh | cut -b3-'
```

Note: `status0` ships with the default `sh` interpreter — set it to `sudo sh`
only if you want root-only details. Without sudo, `status`/`inspect` still run
but omit firewall rules (`pfctl`/`iptables` need root to dump) and
connection-tracking state. WireGuard visibility differs by platform: on FreeBSD
non-root sees peer/endpoint/handshake/transfer counters; on Linux `wg show`
refuses entirely without sudo. See
[Troubleshooting](#vpn-switch-status-is-gated-on-linux-but-not-on-freebsd) for
the precise per-platform output.

---

## Platform Variables in Detail

`vpn-switch` is portable across BSD and Linux because it never hard-codes
`ifconfig`, `stat`, `pfctl`, `iptables`, etc. directly. Instead, every
OS-specific command lives in a *platform variable* defined in
`template/platform/freebsd.sh` or `template/platform/linux.sh` (102 vars per
platform). The active platform is selected by the
`template/platform/default` symlink.

### Two families

The platform vars split into two kinds, distinguished by prefix:

- **`EXAMINE_*`** — read-only inspection (e.g. `EXAMINE_FILE_PERMS`,
  `EXAMINE_NETWORK_INTERFACES`, `EXAMINE_FIREWALL_RULES`). Safe to call from
  any function type, including combinators.
- **`MODIFY_*`** — state-changing operations (e.g.
  `MODIFY_NETWORK_INTERFACE_CREATE`, `MODIFY_FIREWALL_RELOAD`,
  `MODIFY_DIR_CREATE`). **Forbidden in combinators and batch combinators** —
  may only appear in terminal functions, because combinators are supposed to
  emit shell *commands*, not execute them.

This split is documented inline at `template/platform/freebsd.sh:6-9`.

### Why most MODIFY_* vars don't need a sudo prefix

In a typical Scenario-A setup, you might assume that
`MODIFY_NETWORK_INTERFACE_CREATE='ifconfig create'` would need to become
`'sudo ifconfig create'` so a non-root user can bring an interface up.
**It doesn't** — and this is the central design decision.

The connect/disconnect flow works like this:

```
vpn-switch wireguard start <config>
  └─> _wireguard_connect1 (terminal function)
      └─> emits shell commands using $MODIFY_NETWORK_INTERFACE_CREATE etc.
      └─> piped through interpreter VPN_SWITCH_INTERPRETER_wireguard_connect1
          └─> "sudo sh"  ← privilege escalation happens HERE
```

The `sudo sh` wraps the *entire* connect script as a single root invocation.
Every `ifconfig`, `route`, `pfctl`, `chmod`, `mkdir` inside that script then
runs as root for free — no individual command needs a `sudo` prefix.

This is also why the combinator pattern *forbids* `MODIFY_*` calls outside
terminal functions: a combinator's output is a command string for the next
stage to execute, and that next stage is the one that decides privileges
via its own interpreter.

### The three actual sudo exceptions

A handful of platform vars are called from contexts that are **not** wrapped
by `sudo sh` and therefore may need an individual `sudo` prefix in cross-user
scenarios:

| Variable                    | Called from                          | When sudo helps                          |
|-----------------------------|--------------------------------------|------------------------------------------|
| `EXAMINE_PROCESS_EXISTS`    | `is_session_alive()` in `vpn-switch.sh:1203` | Checking a root-owned VPN process from the user's `session list` |
| `EXAMINE_FILE_OWNER`        | `_setenv2` in `include/database.sh:501` | Reading `.env/default` ownership when DB is root-owned |
| `MODIFY_FILE_OWNER`         | `_setenv2` in `include/database.sh:520` | Keeping `.env/local/*` ownership aligned with `.env/default` across user boundaries |

Configure them only if you actually hit the corresponding scenario:

```bash
vpn-switch setenv EXAMINE_PROCESS_EXISTS 'sudo kill -0'
vpn-switch setenv MODIFY_FILE_OWNER      'sudo chown'
```

Modern sessions track interface ownership via the
`session/latest-$interface` symlink, and `is_session_alive()` checks
*interface existence* first — so `EXAMINE_PROCESS_EXISTS` is only consulted
as a fallback for legacy sessions without ownership tracking. Most users
never need to override it.

### Cross-platform reference

The following vars **differ between FreeBSD and Debian/Linux** — these are
the ones to know if you're writing platform-aware sudoers, troubleshooting
across hosts, or porting to another OS:

| Variable                          | FreeBSD                  | Debian / Linux            |
|-----------------------------------|--------------------------|---------------------------|
| `EXAMINE_FILE_PERMS`              | `stat -f %Lp`            | `stat -c %a`              |
| `EXAMINE_FILE_OWNER`              | `stat -f %u:%g`          | `stat -c %u:%g`           |
| `EXAMINE_FILE_CTIME`              | `stat -f %B`             | `stat -c %W`              |
| `EXAMINE_FILE_MTIME`              | `stat -f %m`             | `stat -c %Y`              |
| `EXAMINE_NETWORK_INTERFACES`      | `ifconfig`               | `ip addr show`            |
| `EXAMINE_NETWORK_INTERFACE_EXISTS`| `ifconfig`               | `ip link show`            |
| `EXAMINE_NETWORK_ROUTES`          | `netstat -rn`            | `ip route show`           |
| `EXAMINE_NETWORK_CONNECTIONS`     | `netstat -an`            | `ss -an`                  |
| `EXAMINE_NETWORK_SOCKETS`         | `sockstat`               | `ss -lnp`                 |
| `EXAMINE_FIREWALL_RULES`          | `pfctl -sr`              | `iptables -L -n`          |
| `EXAMINE_FIREWALL_NAT`            | `pfctl -sn`              | `iptables -t nat -L -n`   |
| `EXAMINE_FIREWALL_STATE`          | `pfctl -s state`         | `conntrack -L`            |
| `EXAMINE_FIREWALL_NFT`            | `true` (N/A)             | `nft list ruleset`        |
| `MODIFY_NETWORK_INTERFACE_CREATE` | `ifconfig create`        | `ip link add`             |
| `MODIFY_INTERFACE_DESTROY_FMT`    | `ifconfig %s destroy`    | `ip link delete %s`       |
| `MODIFY_FILE_SED_INPLACE`         | `sed -i ''`              | `sed -i`                  |
| `MODIFY_FIREWALL_RELOAD`          | `pfctl -f`               | `iptables-restore`        |

Identical across platforms (and therefore safe to assume in scripts):
`EXAMINE_PROCESS_EXISTS='kill -0'`, `MODIFY_FILE_PERMS='chmod'`,
`MODIFY_FILE_OWNER='chown'`, `MODIFY_DIR_CREATE='mkdir -p'`,
`MODIFY_LINK_CREATE='ln -s'`, `MODIFY_LINK_FORCE='ln -sfn'`.

For the full list, see the platform files themselves — they're small enough
to read end-to-end.

---

## Scenarios

### Scenario A: DB owned by normal user, VPN runs as root *(recommended)*

This is the default model used by [TUTORIAL_QUICKSTART.md](TUTORIAL_QUICKSTART.md).

**Setup:**

```console
$ ls -ld ~/.vpn-switch/db
drwx------ 1 user user ... /home/user/.vpn-switch/db
```

**Interpreters:**

```bash
vpn-switch setenv VPN_SWITCH_TERMINAL_INTERPRETER             'sh'
vpn-switch setenv VPN_SWITCH_INTERPRETER_wireguard_connect1    'sudo sh'
vpn-switch setenv VPN_SWITCH_INTERPRETER_wireguard_disconnect1 'sudo sh'
vpn-switch setenv VPN_SWITCH_INTERPRETER_session_connect       'sudo sh'
vpn-switch setenv VPN_SWITCH_INTERPRETER_status0               'sudo sh'
```

**sudoers (FreeBSD):**

```sudoers
# /usr/local/etc/sudoers.d/vpn-switch
user ALL=(root) NOPASSWD: /bin/sh
```

**sudoers (Debian/Ubuntu):**

```sudoers
# /etc/sudoers.d/vpn-switch
user ALL=(root) NOPASSWD: /bin/sh
```

A single `NOPASSWD: /bin/sh` rule covers all the interpreters above, since
each one ultimately invokes `sudo sh`. This is broad (a user with this rule
can run anything as root via `sh`), but it matches the trust model: if you
trust the user to run a VPN, you trust them with root.

### Scenario B: DB owned by root, user runs `sudo vpn-switch …`

**Setup:**

```console
$ ls -ld /root/.vpn-switch
drwx------ 1 root wheel ... /root/.vpn-switch
```

**Pitfall:** Running `sudo vpn-switch setenv FOO bar` as your normal user
creates `/root/.vpn-switch/.env/local/FOO` owned `root:wheel 0600` — which
your normal user can no longer read.

**Solutions:**

- Always invoke via `sudo`: `sudo vpn-switch setenv ...`
- Or chmod the local env files: `sudo chmod 0640 /root/.vpn-switch/.env/local/*`
  (group-readable; combine with adding your user to `wheel`).

**sudoers:**

```sudoers
user ALL=(root) NOPASSWD: /usr/local/bin/vpn-switch
```

In this scenario you don't need `NOPASSWD: /bin/sh` because all sudoing
happens at the outer command, not via interpreters.

### Scenario C: System-wide installation, multi-user

**Setup:**

```console
$ ls -ld /usr/local/etc/vpn-switch
drwxr-x--- 1 root wheel ... /usr/local/etc/vpn-switch
```

Every operator has their own user account; all share one root-owned DB.

**Configuration:**

- DB readable by `wheel` group: `chmod -R g+r /usr/local/etc/vpn-switch`
- Users in `wheel`: `pw groupmod wheel -m alice,bob` (FreeBSD) /
  `usermod -aG sudo alice` (Linux)
- Same sudoers as Scenario A, but rule applies to the `wheel` group:

```sudoers
%wheel ALL=(root) NOPASSWD: /bin/sh
```

This is rarely what you want — sessions, named links, and `.env/local`
become shared state across operators. Prefer Scenario A with separate
per-user databases.

---

## Security Considerations

### Principle of Least Privilege

`NOPASSWD: /bin/sh` grants full root via sudo. If that's too broad for your
threat model, consider:

1. **Require a password** — drop `NOPASSWD` and accept that every `vpn-switch
   start` / `stop` prompts once per sudo timestamp window (default 5 min):

   ```sudoers
   user ALL=(root) /bin/sh
   ```

2. **Restrict the caller** — sudo can match by parent process, but this is
   brittle and not recommended.

3. **Tighten platform vars only** — if you only want cross-user *visibility*
   (status, session detection) without granting connect/disconnect, set just
   the EXAMINE/MODIFY platform vars to sudo and leave connect interpreters
   as `sh` (the VPN won't start without manual root invocation):

   ```sudoers
   user ALL=(root) NOPASSWD: /bin/kill, /usr/sbin/chown
   ```

### Audit Trail

`sudo` logs every invocation to syslog (`/var/log/auth.log` on Debian,
`/var/log/auth.log` or `/var/log/messages` on FreeBSD). With `sudo sh` you'll
see *that* root was invoked, but not *what* the shell ran. For per-command
audit, enable session logging in `sudoers`:

```sudoers
Defaults log_input, log_output
Defaults iolog_dir=/var/log/sudo-io
```

I/O logs land in `/var/log/sudo-io/<user>/<seq>/` and can be replayed with
`sudoreplay`.

### Why not setuid?

`vpn-switch` is a POSIX shell script. `setuid` on scripts is disabled on
every modern OS for soundness reasons (TOCTOU between kernel exec and
interpreter resolution). `sudo` with a tight `NOPASSWD` rule is the
intended mechanism.

---

## Troubleshooting

`vpn-switch validate` (or `vpn-switch sudo validate` to run just this check)
scans your `VPN_SWITCH_INTERPRETER_*` settings for any that use `sudo` and runs
`sudo -n true` to confirm passwordless sudo is configured. If it fails, it warns
that every start/stop will prompt for a password and points back here.

### `sudo: a password is required`

The sudoers rule is missing or doesn't match. Test directly:

```console
$ sudo -n sh -c 'echo ok'
sudo: a password is required
```

Fix: confirm the rule is loaded (`visudo -c`), confirm the binary path
(`which sh`), and confirm the user/group matches.

### `Permission denied` reading `.env/local/*`

Database files are owned by a different user than the one running the
command. `setenv` warns about this on creation:

```
# Warning: Database owned by UID 0, running as UID 1000
# Files created will have mismatched ownership. Consider:
#   - Running with correct user: sudo -u #0 vpn-switch setenv ...
#   - Configuring MODIFY_FILE_OWNER with sudo in platform config
```

Fix: either set `MODIFY_FILE_OWNER='sudo chown'` so subsequent `setenv` calls
preserve ownership, or chmod the affected files manually:

```console
$ sudo chmod 0640 $VPN_SWITCH_BASE/.env/local/*
$ sudo chown user:user $VPN_SWITCH_BASE/.env/local/*
```

### `vpn-switch status` is gated on Linux but not on FreeBSD

Underneath, `status` calls `wg show $VPN_SWITCH_INTERFACE_wireguard`.
Whether that works for a non-root user differs sharply by platform —
verified by running `wg show` on an active interface as both `user` and
`root`:

- **FreeBSD non-root:** peer, endpoint, handshake, and transfer counters
  are visible. The `private key:` line is *omitted entirely* from the
  output (not just blanked).
- **FreeBSD root:** same output, plus an extra `private key: (hidden)`
  line. The literal string `(hidden)` is what `wg` prints — it doesn't
  display the actual key even for root.
- **Linux non-root:** the whole call refuses with
  `Unable to access interface: Operation not permitted`. No fields are
  visible.
- **Linux root:** full output, same shape as FreeBSD-root including the
  `private key: (hidden)` masking.

The private key itself is never shown by plain `wg show`, on either OS,
regardless of caller — `wg show <iface> private-key` is the explicit
command for that.

To get full `status`/`inspect` info as a non-root user (especially on
Linux), escalate the interpreter:

```console
$ vpn-switch setenv VPN_SWITCH_INTERPRETER_status0 'sudo sh'
```

### `vpn-switch status` says `Disconnected` even though the VPN is up

`_status0` (in `include/help.sh:219`) detects an active VPN by running
`pgrep -q -f "wg-quick.*$VPN_SWITCH_BASE"`. On Linux, `wg-quick`
exits as soon as it has finished setting up the interface — there's no
long-running daemon — so `pgrep` finds nothing and `status` reports
`Disconnected`, even when the WireGuard interface is alive in the
kernel and traffic is flowing.

Cross-check with `session list` (which uses ownership symlinks +
interface existence, not process search) and with `ip link show
<iface>` directly. This is a `status0` quirk, not a sudo issue.

### `session list` shows session as `stopped` but VPN is actually running

The session was started by `root` but you're listing as a normal user. The
ownership symlink check works without root, but if the symlink is missing
(old session) the process-existence fallback fails silently. Fix:

```console
$ vpn-switch setenv EXAMINE_PROCESS_EXISTS 'sudo kill -0'
```

Or simply re-save the session to rebuild the ownership symlink:

```console
$ sudo vpn-switch session save <name>
```

### sudo command echo pollutes output

Some sudo configurations print `[sudo] password for user:` even with
`NOPASSWD`. Suppress via `-n`:

```console
$ vpn-switch setenv VPN_SWITCH_INTERPRETER_wireguard_connect1 'sudo -n sh'
```

`-n` makes sudo fail rather than prompt — useful for non-interactive use,
and avoids stray prompts in scripts.

---

## End-to-End Verification

This walks the sudo-enabled lifecycle against the test interface — recorded
outputs from `debian-host` (Debian 12) on 2026-05-21. Substitute your own
WireGuard config name.

**Preconditions:** scratch DB + `test_wg0` from
[Safe Experimentation](#safe-experimentation-test-interface--scratch-database),
plus the connect/disconnect sudo interpreters from
[Configuration Surface](#configuration-surface).

```console
$ vpn-switch wireguard import ~/.vpn-switch/db/wireguard/wg-CH-12.conf
# Imported: wireguard/wg-CH-12.conf

$ vpn-switch wireguard start wg-CH-12
==> Phase: vpn (prepare)
✓ VPN prerequisites met
==> Phase: vpn (execute)
[#] ip link add test_wg0 type wireguard
[#] wg setconf test_wg0 /dev/fd/63
[#] ip -4 address add 10.2.0.2/32 dev test_wg0
[#] ip link set mtu 1420 up dev test_wg0
[#] ip -4 route add 0.0.0.0/0 dev test_wg0 table 51820
✓ VPN interface up: test_wg0
```

Confirm the interface is real (note: `wg show` needs `sudo` on Linux):

```console
$ sudo wg show test_wg0
interface: test_wg0
  public key: ExampleInterfacePublicKeySUDOdocsdocsdocs00=
  private key: (hidden)
  listening port: 40693

peer: ExamplePeerPublicKeySUDOdocsdocsdocsdocs000=
  endpoint: 203.0.113.4:51820
  latest handshake: 11 seconds ago

$ wg show test_wg0          # without sudo, on Linux
Unable to access interface: Operation not permitted
```

`session list` works for the normal user — no sudo needed, because the
ownership-symlink + interface-existence checks (see
[The three actual sudo exceptions](#the-three-actual-sudo-exceptions)) don't
require root:

```console
$ vpn-switch session list
PID    SESSION  PROTOCOL   IFACE    STATE              CONFIG         STARTED
---    -------  --------   -----    -----              ------         -------
210412 -        wireguard  test_wg0 active/referenced  wg-CH-12.conf  2026-05-21 15:19:48
```

Then stop and confirm cleanup:

```console
$ vpn-switch stop
==> Phase: vpn (prepare)
✓ VPN disconnect ready
==> Phase: vpn (execute)
[#] ip link delete dev test_wg0
✓ VPN interface down: test_wg0

$ vpn-switch session list
210412 -        wireguard  test_wg0 stopped/referenced wg-CH-12.conf  2026-05-21 15:19:48
```

State flips to `stopped/referenced`. The metadata persists for resume; clean up
with `vpn-switch session remove 210412` or `vpn-switch session clean`.

---

## Platform-Specific Notes

### FreeBSD

- `sudoers` lives in `/usr/local/etc/sudoers` (drop-ins in
  `/usr/local/etc/sudoers.d/`).
- `sh` is `/bin/sh` (a minimal shell, not bash).
- `kill` is `/bin/kill`, `chown` is `/usr/sbin/chown`.
- Use `pw` (not `usermod`) to manage group membership:
  `pw groupmod wheel -m alice`.
- `wg-quick` requires root for `ifconfig wg create` — there's no
  rootless WireGuard on FreeBSD.

### Debian / Ubuntu

- `sudoers` lives in `/etc/sudoers` (drop-ins in `/etc/sudoers.d/`).
- `sh` is `/usr/bin/sh` per `which sh`, but `/bin/sh` also exists as a
  symlink to `dash` — both paths are valid in sudoers rules.
- `kill` is `/usr/bin/kill` per `which kill`; `/bin/kill` exists too
  on Bookworm (separate file, same content).
- `chown` is `/usr/bin/chown` only — there is **no** `/bin/chown` on
  modern Debian, despite some older docs claiming so.
- Use `usermod -aG sudo alice` (not `wheel`) for sudo group on Debian.
- Linux has unprivileged WireGuard via `wg-quick` + capabilities, but
  `vpn-switch` doesn't currently target that path.

### Path discovery

For a portable sudoers rule, resolve binary paths on the target system rather
than hard-coding them. Use `which sh kill chown` — not `command -v`, which
returns just `kill` because it's a shell builtin on both platforms.

---

## Next Steps

- [TUTORIAL_QUICKSTART.md](TUTORIAL_QUICKSTART.md) — first VPN connection
- [TUTORIAL_SESSIONS.md](TUTORIAL_SESSIONS.md) — saving and switching sessions
- [DEBUGGING_GUIDE.md](DEBUGGING_GUIDE.md) — `vpn-switch printenv`,
  `VPN_SWITCH_RETENTION_DAYS_TRACE`, and friends
