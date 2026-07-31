# Quick Start Tutorial

This tutorial walks through installing and using vpn-switch on a fresh system.

**Tested on:** FreeBSD 15.1-RELEASE, Debian 12

## Prerequisites

- WireGuard support (`wireguard-tools` package)
- VPN provider account with WireGuard configuration files
- Root access for installation, normal user for operation

## Step 1: Install Dependencies

**FreeBSD:**
```console
# pkg install -y gmake wireguard-tools
```

**Debian/Ubuntu:**
```console
# apt install -y make wireguard-tools
```

## Step 2: Install vpn-switch

Clone and install:

**FreeBSD:**
```console
$ cd /tmp
$ git clone https://github.com/enk-ode/vpn-switch.git
$ cd vpn-switch
$ sudo gmake install
```

**Debian/Ubuntu:**
```console
$ cd /tmp
$ git clone https://github.com/enk-ode/vpn-switch.git
$ cd vpn-switch
$ sudo make install
```

`gmake install` auto-detects the platform (FreeBSD, Debian/Ubuntu, or Alpine)
from `uname` and installs the matching command set — no manual platform step is
needed.

Verify installation:

```console
$ vpn-switch help
vpn-switch v2.0 - Manage VPN connections

Usage:
  vpn-switch wireguard start <category>   Start VPN with category
  vpn-switch stop                         Stop all VPN connections
  vpn-switch status                       Show VPN status
  vpn-switch help                         Show this help
...
```

## Step 3: Bootstrap Database

Create your personal vpn-switch database:

```console
$ vpn-switch bootstrap ~/.vpn-switch/db minimal
# Created: .session (mode 0700)
# Validated: .tmp
# Validated: .tmp/batch-exits
# Validated: .log
# Created: .env (mode 0700)
# Created: .env/default (mode 0700)
# Created: .env/local (mode 0700)
# Created: .include (mode 0700)
# Created: .include/phase (mode 0700)
# Created: session (mode 0700)
# Created: wireguard (mode 0700)
# Created: openvpn (mode 0700)
# Database ready: /home/user/.vpn-switch/db
# Installed minimal profile
# Copied phase templates to: /home/user/.vpn-switch/db/.include/phase/
✓ Lifted: /usr/local/lib/vpn-switch/template/phase/base/dns/resolvconf.sh → /home/user/.vpn-switch/db/.include/phase/base/dns/resolvconf.sh
# ✓ Lifted: dns
✓ Lifted: /usr/local/lib/vpn-switch/template/phase/base/dns/none.sh → /home/user/.vpn-switch/db/.include/phase/base/dns/none.sh
# ✓ Lifted: dns
...
# Bootstrap complete: /home/user/.vpn-switch/db (minimal)
```

`$HOME/.vpn-switch/db` is the default base directory, so bootstrapping into
that path lets you run `vpn-switch` without setting `VPN_SWITCH_BASE`. If you
bootstrap anywhere else, export the variable:

```bash
export VPN_SWITCH_BASE="/path/to/your/db"
```

To keep one database per provider while leaving the default path untouched,
make `db` a symlink and re-point it to switch providers:

```console
$ cd ~/.vpn-switch
$ ln -sfn mullvad db         # switch to one provider
$ ln -sfn nordvpn db         # later: switch to another
```

`vpn-switch` then follows the symlink to whichever provider you've activated.

## Step 4: Configure Interpreters

vpn-switch runs as a normal user but needs `sudo` for the commands that bring
the VPN interface up and down.

Auto-execute terminal-function output instead of just printing it:

```console
$ vpn-switch setenv VPN_SWITCH_TERMINAL_INTERPRETER sh
# Set VPN_SWITCH_TERMINAL_INTERPRETER (effective next command)
```

Run the connect and disconnect scripts under `sudo` (these are the privileged
network operations):

```console
$ vpn-switch setenv VPN_SWITCH_INTERPRETER_wireguard_connect1 "sudo sh"
# Set VPN_SWITCH_INTERPRETER_wireguard_connect1 (effective next command)
$ vpn-switch setenv VPN_SWITCH_INTERPRETER_wireguard_disconnect1 "sudo sh"
# Set VPN_SWITCH_INTERPRETER_wireguard_disconnect1 (effective next command)
```

`sudo sh` wraps the entire generated script as one root invocation. See
[TUTORIAL_SUDO.md](TUTORIAL_SUDO.md) for cross-user setups and a tighter
sudoers rule.

## Step 5: Configure Phases

Connect and disconnect each run an ordered list of phases (firewall, vpn, dns).
If you don't manage a firewall or DNS through vpn-switch, skip those phases with
the `:none` backend. Set both lists so connect and disconnect stay symmetric:

```console
$ vpn-switch setenv VPN_SWITCH_PHASES_CONNECT "firewall:none vpn dns:none"
# Set VPN_SWITCH_PHASES_CONNECT (effective next command)
$ vpn-switch setenv VPN_SWITCH_PHASES_DISCONNECT "dns:none vpn firewall:none"
# Set VPN_SWITCH_PHASES_DISCONNECT (effective next command)
```

This runs only the `vpn` phase and skips the `firewall` and `dns` phases in
both directions. (The defaults are `firewall vpn dns` for connect and
`dns vpn firewall` for disconnect.)

## Step 6: Import WireGuard Configuration

Download your WireGuard configuration from VPN provider and import it:

```console
$ vpn-switch wireguard import ~/Downloads/wg-server.conf
# Imported: wireguard/wg-server.conf
```

List available configurations:

```console
$ vpn-switch wireguard list
# === WireGuard Configurations ===
#
# Configuration files:
wireguard/wg-server.conf
#
# Categories: (use 'wireguard list <category>' to see contents)
```

## Step 7: Connect to VPN

Start the VPN connection:

```console
$ vpn-switch wireguard start wg-server
```

**FreeBSD output:**
```console
==> Phase: vpn (prepare)
✓ VPN prerequisites met
==> Phase: vpn (execute)
[#] ifconfig wg create name wg0
[#] wg setconf wg0 /dev/stdin
[#] ifconfig wg0 inet 10.2.0.2/32 alias
[#] ifconfig wg0 mtu 1420
[#] ifconfig wg0 up
[#] route -q -n add -inet 0.0.0.0/1 -interface wg0
[#] route -q -n add -inet 128.0.0.0/1 -interface wg0
[+] Backgrounding route monitor
✓ VPN interface up: wg0
```

**Linux output** (verified on Debian 12 with the `firewall:none vpn dns:none`
phase config from Step 5):
```console
==> Phase: vpn (prepare)
✓ VPN prerequisites met
==> Phase: vpn (execute)
[#] ip link add wg0 type wireguard
[#] wg setconf wg0 /dev/fd/63
[#] ip -4 address add 10.2.0.2/32 dev wg0
[#] ip link set mtu 1420 up dev wg0
[#] resolvconf -a tun.wg0 -m 0 -x
[#] wg set wg0 fwmark 51820
[#] ip -6 route add ::/0 dev wg0 table 51820
[#] ip -6 rule add not fwmark 51820 table 51820
[#] ip -6 rule add table main suppress_prefixlength 0
[#] nft -f /dev/fd/63
[#] ip -4 route add 0.0.0.0/0 dev wg0 table 51820
[#] ip -4 rule add not fwmark 51820 table 51820
[#] ip -4 rule add table main suppress_prefixlength 0
[#] sysctl -q net.ipv4.conf.all.src_valid_mark=1
[#] nft -f /dev/fd/63
✓ VPN interface up: wg0
```

The `resolvconf` and `nft` lines appear when those tools are installed (they
are on a default Debian server install). The output is what `wg-quick`
emits; `vpn-switch` doesn't add or remove lines.

Verify connection (run with `sudo` — on Linux, `wg show` refuses entirely
for non-root users with `Unable to access interface: Operation not
permitted`; on FreeBSD non-root sees most fields but omits `private key:`):

```console
$ sudo wg show wg0
interface: wg0
  public key: ExampleInterfacePublicKeyQUICKSTARTdocs0000=
  private key: (hidden)
  listening port: 37647
  fwmark: 0xca6c

peer: ExamplePeerPublicKeyQUICKSTARTdocsdocs00000=
  endpoint: 203.0.113.98:51820
  allowed ips: ::/0, 0.0.0.0/0
  latest handshake: 1 minute, 23 seconds ago
  transfer: 25.41 KiB received, 16.77 KiB sent
```

`(hidden)` is what `wg show` always prints in the `private key:` slot —
to actually display the key, use `sudo wg show wg0 private-key`.

Test internet access:

**FreeBSD:**
```console
$ fetch -qo- https://ifconfig.me/ip
203.0.113.108
```

**Linux:**
```console
$ curl -s ifconfig.me/ip
203.0.113.108
```

## Step 8: Disconnect

Stop all VPN sessions:

```console
$ vpn-switch stop
```

**FreeBSD output:**
```console
==> Phase: vpn (prepare)
✓ VPN disconnect ready
==> Phase: vpn (execute)
[#] ifconfig wg0 destroy
✓ VPN interface down: wg0
```

**Linux output** (verified on Debian 12):
```console
==> Phase: vpn (prepare)
✓ VPN disconnect ready
==> Phase: vpn (execute)
[#] ip -4 rule delete table 51820
[#] ip -4 rule delete table main suppress_prefixlength 0
[#] ip -6 rule delete table 51820
[#] ip -6 rule delete table main suppress_prefixlength 0
[#] ip link delete dev wg0
[#] resolvconf -d tun.wg0 -f
[#] nft -f /dev/fd/63
✓ VPN interface down: wg0
```

With `dns:none vpn firewall:none` set as the disconnect list in Step 5, only
the `vpn` phase runs; the skipped `dns` and `firewall` phases emit nothing.

## Session Management

List active sessions:

```console
$ vpn-switch session list
VPN Sessions:

PID    SESSION      PROTOCOL   IFACE    STATE                 CONFIG                 STARTED
---    -------      --------   -----    -----                 ------                 -------
56685  -            wireguard  wg0      active/unreferenced   wg-server.conf         2024-12-19 15:30:00

States: active=VPN running, stopped=VPN disconnected, referenced=has saved links, unreferenced=no links
```

Show connect script for a session:

```console
$ vpn-switch session show 56685
Session Show

Session: 56685
Protocol: wireguard
Interface: wg0
Config: wg-server.conf

Connect script (/home/user/.vpn-switch/db/.session/56685/connect.sh):

#!/bin/sh
# =============================================================================
# WireGuard VPN Connection Script (Self-Contained)
# =============================================================================
# Generated: 2024-12-19 15:30:00
# Session: 56685
...
```

## Configuration Summary

After setup, your `~/.vpn-switch/db/.env/local/` contains:

| File | Value | Purpose |
|------|-------|---------|
| `VPN_SWITCH_TERMINAL_INTERPRETER` | `sh` | Auto-execute command output |
| `VPN_SWITCH_INTERPRETER_wireguard_connect1` | `sudo sh` | Bring interface up (root) |
| `VPN_SWITCH_INTERPRETER_wireguard_disconnect1` | `sudo sh` | Tear interface down (root) |
| `VPN_SWITCH_PHASES_CONNECT` | `firewall:none vpn dns:none` | Skip firewall/DNS on connect |
| `VPN_SWITCH_PHASES_DISCONNECT` | `dns:none vpn firewall:none` | Skip firewall/DNS on disconnect |

## Troubleshooting

### "VPN base directory not found"

Set `VPN_SWITCH_BASE` environment variable:

```console
$ export VPN_SWITCH_BASE="$HOME/.vpn-switch/db"
```

### No handshake / "0 B received"

- Check that UDP port 51820 is allowed outbound
- Verify the WireGuard endpoint is reachable: `ping <endpoint-ip>`
- Check routing:
  - FreeBSD: `netstat -rn | grep wg0`
  - Linux: `ip route show table 51820`

### Permission denied

Ensure both the connect and disconnect interpreters use sudo:

```console
$ vpn-switch setenv VPN_SWITCH_INTERPRETER_wireguard_connect1 "sudo sh"
$ vpn-switch setenv VPN_SWITCH_INTERPRETER_wireguard_disconnect1 "sudo sh"
```

### Wrong commands executed (e.g. ifconfig on Linux)

`gmake install` picks the platform from `uname`, so the installed copy normally
runs the right command set. If it does not, check that the installed platform
symlink points to the correct file (path may vary with `PREFIX`):

```console
$ ls -l /usr/local/lib/vpn-switch/template/platform/default
```

If it points at the wrong file, re-running `gmake install` from the source tree
on the target host re-detects and resets it.

## Verification Status

The commands in this tutorial were verified end-to-end on Debian 12 using the
firewall/DNS-skipping phase configuration from Step 5 — the Linux output blocks
are what the commands produced. The FreeBSD blocks reflect the same commands run
with the BSD platform plugin; their structure is verified, but the exact text
has not been re-captured against current main since the platform templates last
changed.

For a more defensive approach to experimentation (separate scratch DB,
test interface name, no risk to a running session), see
[TUTORIAL_SUDO.md → Safe Experimentation](TUTORIAL_SUDO.md#safe-experimentation-test-interface--scratch-database).

## Next Steps

- [TUTORIAL_SESSIONS.md](TUTORIAL_SESSIONS.md) - Save, switch, and resume sessions
- [TUTORIAL_SUDO.md](TUTORIAL_SUDO.md) - sudo configuration and cross-user setups
- [TUTORIAL_MIGRATION.md](TUTORIAL_MIGRATION.md) - Backup and cross-host migration
- [QUICK_REFERENCE.md](../QUICK_REFERENCE.md) - Command cheatsheet
- [ARCHITECTURE.md](ARCHITECTURE.md) - How vpn-switch works
- [README.md](../README.md) - Full documentation
