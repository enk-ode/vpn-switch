# Installation Guide

System-wide installation of `vpn-switch` on FreeBSD and Linux.

This document covers **installation only** — copying the script, libraries,
templates, and helpers into a system prefix (default `/usr/local`).
Per-user database setup (bootstrap, sudo configuration, DNS backend selection)
is covered separately by [TUTORIAL_QUICKSTART.md](TUTORIAL_QUICKSTART.md).

---

## Quick start

### FreeBSD

```sh
pkg install devel/gmake        # if not already present
git clone https://github.com/enk-ode/vpn-switch
cd vpn-switch
sudo gmake install             # installs to /usr/local
vpn-switch validate            # verify
```

### Linux (Debian / Ubuntu / Alpine)

```sh
git clone https://github.com/enk-ode/vpn-switch
cd vpn-switch
sudo make install              # 'make' is GNU make on Linux
vpn-switch validate            # verify
```

No manual symlink fixes, no platform configuration: the installer detects the
OS and lays everything down correctly. Detection uses `uname -s` (FreeBSD), and
for Linux refines via `/etc/os-release` `ID` to tell Alpine from other distros
(GNUmakefile lines 91-95).

---

## What gets installed where (FHS layout)

With the default `PREFIX=/usr/local`:

| Path | Contents | Why this location |
|---|---|---|
| `$(PREFIX)/bin/vpn-switch` | Main CLI script | User-runnable, never needs root |
| `$(PREFIX)/sbin/{wg,ovpn}-resolvconf-{up,down}` | DNS helper scripts | Root-only (reload `local_unbound`). Phase scripts call them by absolute path. |
| `$(PREFIX)/lib/vpn-switch/include/*.sh` | Shell module library | Package-private code |
| `$(PREFIX)/lib/vpn-switch/template/` | Templates: env defaults, phase scripts, platform variables | Package-private data; sourced at runtime via `VPN_SWITCH_LIBDIR` |
| `$(PREFIX)/share/doc/vpn-switch/` | `README.md`, `LICENSE`, `QUICK_REFERENCE.md` | Standard FHS doc location |
| `$(PREFIX)/share/man/man1/vpn-switch.1` | Man page (`man vpn-switch`), if `docs/vpn-switch.1` is present | Standard FHS man location |
| `$(PREFIX)/etc/rc.d/vpn_switch` | rc.d service script | **FreeBSD only** |
| `$(PREFIX)/lib/systemd/system/vpn-switch@.service` | Templated systemd unit | **Linux (systemd) only** |
| `/etc/init.d/vpn-switch` | OpenRC init script | **Alpine only** |

The platform symlink `$(PREFIX)/lib/vpn-switch/template/platform/default` points
to `freebsd.sh`, `linux.sh`, or `alpine.sh` per the detected platform, in the
install destination only (your source tree is untouched — see "platform target"
below).

### Why `lib/` for both code and templates?

FHS does not mandate where a shell-based package puts its private files; both
`lib/vpn-switch/` and `share/vpn-switch/` are acceptable for package-private
trees. We use `lib/` for cohesion: the script sources
`$VPN_SWITCH_LIBDIR/include/*.sh` and reads `$VPN_SWITCH_LIBDIR/template/...`
from one root, one variable.

---

## Prerequisites

| | FreeBSD | Debian/Ubuntu | Alpine |
|---|---|---|---|
| make | `pkg install devel/gmake` (then `gmake`) | `make` (already GNU make) | `apk add make` |
| WireGuard | `pkg install wireguard-tools` | `apt install wireguard-tools` | `apk add wireguard-tools` |
| OpenVPN (optional) | `pkg install openvpn` | `apt install openvpn` | `apk add openvpn` |
| ShellCheck (dev) | `pkg install hs-ShellCheck` | `apt install shellcheck` | `apk add shellcheck` |

vpn-switch itself is pure POSIX `/bin/sh` — no other runtime dependencies.

---

## Common install variants

### Custom PREFIX

```sh
sudo gmake install PREFIX=/usr           # install into /usr
sudo gmake install PREFIX=/opt/local     # install into /opt/local
```

`$(BINDIR)`, `$(SBINDIR)`, `$(LIBDIR)`, `$(DOCDIR)` derive from `$(PREFIX)`
automatically.

### Packaging staging (DESTDIR)

```sh
gmake install DESTDIR=/tmp/staging       # no sudo — staged tree
find /tmp/staging                        # inspect what would be installed
```

The standard packaging pattern: build with `DESTDIR`, then create the package
(`.pkg`, `.deb`, `.apk`, `.rpm`) from the staged tree.

### Repo-only platform target (for development)

If you cloned the repo to run tests or hack on it without installing, set the
in-repo platform symlink so the script works directly from the source tree:

```sh
gmake platform                           # sets template/platform/default in the repo
./vpn-switch.sh help                     # runs from repo, no install needed
```

This is **separate from `install`**. `gmake platform` operates only in the repo;
`gmake install` sets the symlink in the install destination.

---

## Verification

After install, the canonical check is:

```sh
vpn-switch validate
```

This runs a full system check: install layout, platform symlink correctness vs.
detected OS, `template/VERSION` presence, resolvconf helper presence at
`/usr/local/sbin/`, configured binaries (`wg`, `wg-quick`, `openvpn`, `pfctl`),
and — if you have bootstrapped a database — DB structure, permissions, and
version drift. See [TUTORIAL_TROUBLESHOOTING.md](TUTORIAL_TROUBLESHOOTING.md)
for walking through validate output.

Quick spot-checks:

```sh
which vpn-switch                                   # /usr/local/bin/vpn-switch
ls -l /usr/local/sbin/{wg,ovpn}-resolvconf-*       # 4 files, mode 0755
ls -l /usr/local/lib/vpn-switch/template/platform/default
                                                   # → freebsd.sh / linux.sh / alpine.sh
vpn-switch help                                    # prints command summary
```

---

## Uninstall

```sh
sudo gmake uninstall                     # or with custom PREFIX
sudo gmake uninstall PREFIX=/opt/local
```

Removes everything `install` deposited (script, helpers, libs, templates, docs,
man page, plus the platform service script). Your **database** at
`$VPN_SWITCH_BASE` (default `$HOME/.vpn-switch/db`) is **not touched** — it is
user data, separate from install.

---

## Platform-specific notes

### FreeBSD

The installer drops `vpn_switch` in `$(PREFIX)/etc/rc.d/` so the host's service
manager knows about it. Enable and start as usual:

```sh
service vpn_switch enable                # or via /etc/rc.conf
```

The DNS helpers (`wg-resolvconf-up/down`, `ovpn-resolvconf-up/down`) are
**FreeBSD-oriented**: they call `service local_unbound restart` to flush DNS
state after a VPN comes up or down. If you use `local_unbound` as your resolver,
they integrate transparently. With a different DNS setup, switch the DNS phase
backend, e.g. `VPN_SWITCH_PHASES_CONNECT="firewall vpn dns:none"`.

### Linux (systemd)

The installer drops a templated **systemd unit** (`vpn-switch@.service`) to
`$(PREFIX)/lib/systemd/system/` so you can manage saved sessions through
`systemctl`:

```sh
sudo systemctl daemon-reload                    # after install
sudo systemctl edit vpn-switch@work             # set User= + VPN_SWITCH_BASE=
sudo systemctl start vpn-switch@work            # bring up the 'work' session
sudo systemctl enable vpn-switch@work           # at boot
```

`systemctl edit` creates a drop-in under
`/etc/systemd/system/vpn-switch@work.service.d/`. Set at minimum:

```ini
[Service]
User=user
Environment=VPN_SWITCH_BASE=/home/user/.vpn-switch/db
```

Without these overrides the unit runs as root with no `VPN_SWITCH_BASE`, which
is rarely what you want. Per-session drop-ins keep each session pinned to its
owning user's database.

The session name (`work` above) must already exist — create it with
`vpn-switch session save work` after the first manual `vpn-switch start`.

### Alpine (OpenRC)

The installer drops an OpenRC init script at `/etc/init.d/vpn-switch`. Create a
per-session instance via OpenRC's symlink convention:

```sh
ln -s /etc/init.d/vpn-switch /etc/init.d/vpn-switch.work
rc-update add vpn-switch.work default            # at boot
rc-service vpn-switch.work start                 # bring up the 'work' session
```

### DNS integration on Linux

The resolvconf helpers in `$(SBINDIR)` are FreeBSD-oriented (they reload
`local_unbound`). On Linux, set `VPN_SWITCH_PHASES_CONNECT="firewall vpn"` to
skip the DNS phase, or wire up your distro's resolvconf integration manually.

---

## PATH architecture (background)

vpn-switch maintains **two distinct PATH-like variables** for different
execution contexts:

| Variable | Used by | Default | Purpose |
|---|---|---|---|
| `PATH` | `vpn-switch.sh` itself | `/sbin:/bin:/usr/bin:/usr/local/bin` | Management ops, file/text tools, inspection |
| `VPN_SWITCH_PATH` | Generated connect/disconnect scripts | `/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin` | VPN admin tools (pfctl, wg-quick, openvpn) |

Two paths because the contexts have different needs: management never needs the
privileged `sbin` admin binaries, while connect/disconnect do.

Customisation lives in `$VPN_SWITCH_BASE/.env/local/`; never edit
`.env/default/` (it gets overwritten on `vpn-switch sync`). See
[TUTORIAL_QUICKSTART.md](TUTORIAL_QUICKSTART.md) for the environment override
workflow.

---

## Troubleshooting install issues

| Symptom | Likely cause | Fix |
|---|---|---|
| `No rule to make target 'install-platform'` | `template/platform/$(PLATFORM).mk` missing for the detected platform | Confirm `freebsd.mk`, `linux.mk`, or `alpine.mk` exists. Porting to a new OS means adding a new `.mk` modelled on those. |
| `vpn-switch: not found` after install | `$(PREFIX)/bin` not in `PATH` | `export PATH="/usr/local/bin:$PATH"` |
| `template/VERSION: No such file` during install | First-time clone, no metadata generated yet | `install` depends on `metadata`; if bypassed, run `gmake metadata` first. |
| Platform symlink points to wrong OS | Stale install | `sudo gmake install` rewrites it per the detected platform. |

For runtime debugging beyond install, see
[DEBUGGING_GUIDE.md](DEBUGGING_GUIDE.md) (trace files, command inspection) and
[TUTORIAL_TROUBLESHOOTING.md](TUTORIAL_TROUBLESHOOTING.md)
(`vpn-switch validate` walkthrough).
</content>
</invoke>
