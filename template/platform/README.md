# Platform Configuration Files

Platform-specific command definitions for vpn-switch. All program logic is
platform-agnostic; these files are the only place OS-specific commands live, and
they expand into the generated scripts at generation time.

## Platform selection

vpn-switch loads the file the `default` symlink points to:

- FreeBSD: `default -> freebsd.sh`
- Linux:   `default -> linux.sh`

Set it with `gmake platform` (derived from `uname`), or by hand:

```sh
cd template/platform && ln -sfn linux.sh default
```

Override at runtime with `VPN_SWITCH_PLATFORM=<name>` (advanced).

## What a platform file defines

Two families of command variables:

- `EXAMINE_*` — read-only inspection (stat, network, firewall, kernel modules,
  processes, services, VPN status).
- `MODIFY_*` — state-changing operations (file/dir/symlink ops, in-place sed,
  network-interface create/destroy/up/down).

(An older `CMD_*` prefix is deprecated — use `EXAMINE_*` / `MODIFY_*`.)

Completeness check — every variable the code uses must be defined:

```sh
grep -ohE '\$(EXAMINE|MODIFY)_[A-Z_]+' ../../vpn-switch.sh ../../include/*.sh | tr -d '$' | sort -u
grep -oE  '^(EXAMINE|MODIFY)_[A-Z_]+' linux.sh | sort -u
# the two lists should match
```

## Adding a platform

Copy `freebsd.sh` (the reference), adapt each `EXAMINE_*` / `MODIFY_*` command to
your OS, add `<os>.mk` plus any service files under `<os>/`, point the `default`
symlink at it, and verify with
`VPN_SWITCH_PLATFORM=<os> ./vpn-switch-unit-test.sh minimal`.

## Files

- `freebsd.sh`, `linux.sh` — platform command definitions (freebsd is the reference)
- `freebsd.mk`, `linux.mk` — install hooks (rc.d / systemd)
- `freebsd/`, `linux/` — service files installed per platform
- `default` — symlink to the active platform
