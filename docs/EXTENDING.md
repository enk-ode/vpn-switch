# Extending vpn-switch

vpn-switch grows along two axes:

- **Platforms** — *how* commands run on an OS (the command catalog + init
  integration). Adding one is the common case; this guide walks through it
  end-to-end using the verified Alpine Linux port.
- **Protocols** — *what* is run (WireGuard, OpenVPN). Adding one means new
  anchor functions and phase scripts.

Read [ARCHITECTURE.md](ARCHITECTURE.md) first for the combinator/interpreter
model; this document assumes it.

---

## Orientation: the database on disk

Everything a platform/protocol touches lives under `$VPN_SWITCH_BASE`.
`vpn-switch bootstrap <dir> <profile>` creates it (`_database_init0`,
`VPN_SWITCH_INIT_DIR_CONFIG` in `vpn-switch.sh`):

```
$VPN_SWITCH_BASE/
├── .env/
│   ├── default/         # profile-cached variables (set by 'sync')
│   └── local/           # your overrides (set by 'setenv')
├── .include/
│   └── phase/           # phase scripts LIFTED from template/phase/ at bootstrap
│       └── base/{firewall,dns}/<backend>.sh
├── .session/<pid>/      # one dir per live session (keyed off the VPN process PID)
│   ├── pid protocol interface started original
│   ├── <iface>.conf     # the patched config actually handed to wg-quick/openvpn
│   └── connect.sh disconnect.sh
├── .log/<date>/         # per-command *.log / *.trace
├── .tmp/
├── session/             # named saved sessions: <name> -> ../.session/<pid>
├── wireguard/           # imported WireGuard configs + category dirs + aliases
├── openvpn/             # imported OpenVPN configs
├── conf  -> wireguard/  # extension-link convenience aliases
└── ovpn  -> openvpn/
```

Two things make this work without hard-coded logic:

- **Phase lifting.** `bootstrap` copies `template/phase/` into the DB's
  `.include/phase/` and rewrites each plain template into a terminal function.
  The running tool only ever reads the DB copy, so a database is
  self-contained and portable.
- **Symlinks as state.** Categories, aliases, the `default` selector, and saved
  sessions are all symlinks — inspectable with `ls -l`, no index file.

---

## Resolving strategies (how a name becomes a config or a session)

When you run `vpn-switch wireguard start <name>`, `<name>` is resolved by
location, not by parsing:

1. **A category** (a directory under `wireguard/`) → pick a config *inside* it.
2. **A config or alias** → use it directly.
3. **No argument** → resolve the protocol directory itself.

Picking inside a directory uses `resolve_default_or_random()`
(`vpn-switch.sh:941`):

- if the directory has a **`default` symlink**, follow it;
- otherwise **pick at random** among the entries (excluding `default`,
  `latest`, and sub-directories).

So `ln -s wg-CH-12.conf wireguard/streaming/default` pins a category to one
server; without it, the category load-balances by random choice. The same
helper drives no-arg `start` (random server) and category selection.

Phases resolve by `resolve_phase_script()` (`vpn-switch.sh:1764`):

- a **bare** phase name (`firewall`) → the protocol-specific script
  `.include/phase/<protocol>/<direction>/<phase>.sh`;
- a **backend-qualified** phase (`firewall:iptables`, `dns:resolvconf`) →
  `.include/phase/<profile>/<phase>/<backend>.sh`.

This distinction matters for new platforms — see the caveat below.

---

## Adding a platform (worked example: Alpine Linux)

A platform is two files plus a detection entry. Alpine (busybox userland,
OpenRC init) is a good example because it differs from the existing Linux
plugin in instructive ways. It ships as a **Tier-2** platform (walkthrough-
verified, see *Tiers* below).

### 1. The command catalog — `template/platform/<os>.sh`

This file assigns the `EXAMINE_*` (read-only) and `MODIFY_*` (state-changing)
command variables the generated scripts use. **Derive it from the closest
existing platform and override only what genuinely differs** — do not write it
from scratch.

A key, non-obvious fact: although the catalog defines ~100 variables, the
runtime only *invokes* a small subset (filesystem ops, `ip addr/route show`,
`lsmod`, `wg show`, `kill -0`, the `ln`/`cp`/`chmod` family). You can confirm
which with:

```sh
grep -rhoE '\$\{?(EXAMINE|MODIFY)_[A-Z_]+\}?' include/ vpn-switch.sh \
    template/phase/ | tr -d '${}' | sort -u
```

For Alpine, *every variable in that used subset behaves identically to the
generic `linux.sh`* (Alpine ships real `iproute2`/`iptables`/`wireguard-tools`/
`openresolv`). So `alpine.sh` is `linux.sh` with a handful of honest
corrections for the parts busybox/OpenRC do differently — each flagged with an
`ALPINE:` comment:

| Area | `linux.sh` (systemd/coreutils) | `alpine.sh` (busybox/OpenRC) |
|---|---|---|
| File birth time | `stat -c %W` | `stat -c %Z` (busybox has no `%W`) |
| Process by PID | `ps -p` | `kill -0` (busybox `ps` lacks `-p`) |
| "is it running" | `pgrep -q` | `pgrep -x` (busybox `pgrep` lacks `-q`) |
| Service manager | `systemctl <action> <name>` | `rc-service <name> <action>` |

The file is **self-contained** (it does not `source linux.sh`) so the test
harness can load it directly via the `default` symlink.

### 2. The install plugin — `template/platform/<os>.mk`

Included by the top-level `GNUmakefile` via `include template/platform/$(PLATFORM).mk`.
It must define `install-platform` and `uninstall-platform`, which install the
OS's service integration:

- FreeBSD (`freebsd.mk`) → an `rc.d` script
- Linux (`linux.mk`) → a systemd template unit `vpn-switch@.service`
- Alpine (`alpine.mk`) → an OpenRC init script installed to `/etc/init.d`,
  using OpenRC's symlink-naming convention (`vpn-switch.<session>`) to mirror
  systemd's `vpn-switch@<name>` instances.

### 3. Platform detection (keep three sites in sync)

`uname` alone cannot tell Alpine from Debian — both report `Linux`. Detection
is therefore two-level: kernel via `uname`, and for Linux the distro via
`/etc/os-release`'s `ID`. The identical logic lives in **three** places and
must stay consistent:

- `GNUmakefile` — the `PLATFORM` variable (drives the `platform` target and the
  `.mk` include);
- `include/validate.sh` — `_install_validate0` (checks the installed `default`
  symlink matches the detected platform);
- `vpn-switch-integration-test.sh` — the install-layout check.

```sh
kernel=$(uname -s | tr A-Z a-z)
if [ "$kernel" = linux ] && [ -r /etc/os-release ]; then
    case "$(. /etc/os-release; echo "$ID")" in
        alpine) platform=alpine ;;
        *)      platform=linux ;;
    esac
else
    platform=$kernel          # freebsd, openbsd, ...
fi
```

At runtime the platform is chosen by `VPN_SWITCH_PLATFORM` (default: the
`template/platform/default` symlink, set by `gmake platform`/`gmake install`).

### 4. Verify the port

```sh
gmake platform                 # sets default -> alpine.sh (uses the detection above)
gmake check                    # POSIX-sh syntax (busybox sh)
VPN_SWITCH_BASE=~/t bootstrap ~/t minimal   # bootstrap + phase lifting
vpn-switch validate            # platform symlink + layout health
gmake test                     # or: ./scripts/run-all-tests.sh local
```

`validate` reporting `✓ Install layout OK` confirms detection and the symlink
agree.

A real end-to-end connect closes the loop. On Alpine this surfaced one
platform-specific prerequisite: **openresolv must be initialised once** before
the first WireGuard connect. A provider config carrying a `DNS =` line makes
`wg-quick` call `resolvconf`, which on a fresh Alpine fails with
`resolvconf: signature mismatch: /etc/resolv.conf` (the file was not created by
openresolv) and aborts the interface bring-up. Run `resolvconf -u` once to fix
the signature, after which `vpn-switch wireguard start` brings the tunnel up
through its phase pipeline (verified: `✓ VPN interface up: wg0`, session
created, egress IP changed to the provider's exit). This is exactly the kind of
finding a Tier-2 walkthrough exists to capture.

### Caveat: bare phases are FreeBSD-tuned; use backends for portability

The **bare** protocol phase scripts (`template/phase/wireguard/connect/firewall.sh`,
`dns.sh`) were written for FreeBSD — the firewall script drives `pfctl` and
`/etc/pf.*`, the DNS script expects FreeBSD's `local_unbound`. On a Linux/Alpine
host a *bare* connect (`PHASES_CONNECT="firewall vpn dns"`) therefore fails in
the firewall phase. The **`vpn` phase is portable** (`wg-quick`/`openvpn`).

The portable configuration is **backend-qualified phases**:

```sh
vpn-switch setenv VPN_SWITCH_PHASES_CONNECT "firewall:iptables vpn dns:resolvconf"
```

These resolve to `template/phase/base/firewall/iptables.sh` and
`base/dns/resolvconf.sh`, which are Linux-correct. This is by design (explicit
over automatic) — a new platform does not need new phase scripts, only the
right backend selection. To add a genuinely new backend (e.g. `firewall:pf` for
OpenBSD), drop `template/phase/base/firewall/pf/...` and select it with
`firewall:pf`.

### Second worked example: OpenBSD

OpenBSD is FreeBSD's sibling here: BSD `stat -f`, `ifconfig`, `netstat -rn`,
`pfctl`, `ps -p` and `pgrep -q` all behave identically, so `openbsd.sh` is
derived from `freebsd.sh` with only a handful of `OPENBSD:`-flagged deltas:
`rcctl` (action-first) instead of `service`; `sed -i` with no extension
argument (FreeBSD needs `''`); no `resolvconf` (DNS via `resolvd`/`/etc/resolv.conf`
— use the `dns:none` backend); a monolithic kernel (no loadable modules — the
`KMOD_*` vars are no-ops, WireGuard and `tun` are in-kernel); `doas` instead of
`sudo` (an interpreter/env concern, not the catalog). Detection needs no
`/etc/os-release` step — `uname` returns `openbsd` directly. `openbsd.mk`
installs an `/etc/rc.d` script managed by `rcctl`.

The live connect surfaced an OpenBSD-specific config issue (again the
provider-config-is-Linux theme): OpenBSD's `wg-quick` refuses `AllowedIPs`
containing `::/0` when the interface has only an IPv4 `Address`, failing with
`Local IPv6 address must be set to have routes`. Linux and FreeBSD tolerate
this; OpenBSD does not. Drop `::/0` (IPv4-only tunnel) or give the interface an
IPv6 address. After that the tunnel comes up via the phase pipeline (verified:
handshake + transfer, egress through the exit). Note also that OpenBSD's
`wg-quick` replaces the default route without policy-routing tricks, so a
full-tunnel briefly flaps an existing SSH session over the same path — the
directly-connected LAN route still wins, so management access recovers.

---

## Adding a protocol

Protocols are added by convention, not configuration — dispatch is unchanged.

1. **Anchor functions** named `_<protocol>_<operation><arity>`, classified by
   underscore prefix (terminal `_`, combinator `__`, batch `___`) and suffixed
   with their argument count. Put them in a new `include/<protocol>.sh`, mirror
   the existing `wireguard`/`openvpn` operation set (`import`, `add`, `list`,
   `start`, `connect`, `validate`, …).
2. **Phase scripts** under `template/phase/<protocol>/{connect,disconnect,inspect}/`
   (at minimum `vpn.sh`; reuse the `base/` firewall and DNS backends).
3. **Regenerate metadata**: `gmake metadata` re-scans the sources and rebuilds
   `ANCHOR_FUNCTIONS` and `FUNCTION_MODULES`. No dispatch code changes.
4. Add unit/architecture tests; the architecture test exercises every anchor on
   its success and error paths.

---

## Platform tiers

- **Tier-1** — exercised in the CI matrix: **FreeBSD**, **Debian/Linux**.
- **Tier-2** — walkthrough-verified on a real VM, best-effort: **Alpine Linux**
  and **OpenBSD** (both walked through below). Ports are added by the same
  recipe; promotion to Tier-1 means joining the automated matrix.

See [DESIGN_DECISIONS.md](DESIGN_DECISIONS.md) for *why* the platform layer and
phase backends are shaped this way, and [COMMAND_INSPECTION.md](COMMAND_INSPECTION.md)
for inspecting what the generated scripts actually emit on your platform.
