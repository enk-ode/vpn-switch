#!/bin/sh
# vpn-switch Ownership Reconciliation Unit Tests
#
# Deterministic, function-level tests for the interface-ownership logic added to
# prevent and repair "ownership drift" (session/latest-$interface pointing at a
# session whose config is not the one actually loaded on the interface).
#
# Why a dedicated file (not the black-box vpn-switch-unit-test.sh suite):
#   The core of this logic compares the LIVE peer set (`wg show <iface>`) against
#   a session's stored config. The black-box suite cannot stub that live output -
#   EXAMINE_* variables are re-sourced from the platform file at startup
#   (overriding setenv), and PATH injection does not reach the examination
#   subshell. So here we extract the two functions under test from source and
#   drive them directly with a stubbed examiner and a temp database, which is
#   fully deterministic and needs no real WireGuard interface.
#
# Functions under test:
#   session_peer_matches_interface  (vpn-switch.sh) - used by is_session_alive()
#   _session_refresh0               (include/session.sh) - 'session refresh'
#
# POSIX shell compliant.

set -u

PASS=0
FAIL=0
ok()   { PASS=$((PASS + 1)); printf '  \033[1;32mok\033[0m   %s\n' "$1"; }
bad()  { FAIL=$((FAIL + 1)); printf '  \033[1;31mFAIL\033[0m %s\n' "$1"; }
check(){ # check "<label>" <actual> <expected>
  if [ "$2" = "$3" ]; then ok "$1 ($2)"; else bad "$1 (got '$2', want '$3')"; fi
}

ROOT=$(cd "$(dirname "$0")" && pwd)
WORK="${TMPDIR:-/tmp}/vpn-switch-ownership-test.$$"
mkdir -p "$WORK"
trap 'rm -rf "$WORK"' EXIT INT TERM

# --- Extract the functions under test from source into this shell -------------
# Both are plain POSIX functions; extracting their definitions avoids running
# vpn-switch's top-level dispatch.
eval "$(sed -n '/^session_peer_matches_interface() {/,/^}/p' "$ROOT/vpn-switch.sh")"
eval "$(sed -n '/^_session_refresh0() {/,/^}/p' "$ROOT/include/session.sh")"

if ! command -v session_peer_matches_interface >/dev/null 2>&1; then
  echo "ERROR: could not extract session_peer_matches_interface from vpn-switch.sh" >&2
  exit 1
fi
if ! command -v _session_refresh0 >/dev/null 2>&1; then
  echo "ERROR: could not extract _session_refresh0 from include/session.sh" >&2
  exit 1
fi

# --- Platform-ish variables the functions reference ---------------------------
LOG_FILE=/dev/null
MODIFY_LINK_FORCE='ln -sfn'
MODIFY_LINK_REMOVE='rm -f'
EXAMINE_LINK_TARGET='readlink'
# EXAMINE_VPN_WIREGUARD_INTERFACE / EXAMINE_NETWORK_INTERFACE_EXISTS are set per
# test to a stub so we control the "live" interface state deterministically.

PEER_A='peerKEYaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa='
PEER_B='peerKEYbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb='

# stub_wgshow <pubkey-or-empty> : make EXAMINE_VPN_WIREGUARD_INTERFACE report it
stub_wgshow() {
  local key="$1"
  local stub="$WORK/wgshow.sh"
  if [ -n "$key" ]; then
    printf '#!/bin/sh\nprintf "peer: %%s\\n" "%s"\n' "$key" > "$stub"
  else
    printf '#!/bin/sh\nexit 0\n' > "$stub"   # interface up but no peers readable
  fi
  chmod 0755 "$stub"
  EXAMINE_VPN_WIREGUARD_INTERFACE="$stub"
}

# make_session <pid> <iface> <protocol> <pubkey> [started]
make_session() {
  local pid="$1" iface="$2" proto="$3" key="$4" started="${5:-2026-01-01 00:00:00}"
  local d="$BASE/.session/$pid"
  mkdir -p "$d"
  printf '%s\n' "$proto" > "$d/protocol"
  printf '%s\n' "$iface" > "$d/interface"
  printf '%s\n' "$started" > "$d/started"
  if [ -n "$key" ]; then
    printf 'PrivateKey = x\nPublicKey = %s\n' "$key" > "$d/$iface.conf"
  fi
}

fresh_base() { BASE="$WORK/db.$1"; mkdir -p "$BASE/.session" "$BASE/session"; VPN_SWITCH_BASE="$BASE"; }
owner_of()   { readlink "$BASE/session/latest-$1" 2>/dev/null | sed 's|.*/||'; }

echo "=== session_peer_matches_interface ==="

# Matching peer -> 0 (active)
fresh_base m1; make_session 100 wg0 wireguard "$PEER_A"
stub_wgshow "$PEER_A"
session_peer_matches_interface "$BASE/.session/100" wg0; check "matching peer returns 0" "$?" "0"

# Mismatching peer -> 1 (stopped / drift)
fresh_base m2; make_session 100 wg0 wireguard "$PEER_A"
stub_wgshow "$PEER_B"
session_peer_matches_interface "$BASE/.session/100" wg0; check "mismatching peer returns 1" "$?" "1"

# Unreadable live peers -> 0 (no judgement, conservative)
fresh_base m3; make_session 100 wg0 wireguard "$PEER_A"
stub_wgshow ""
session_peer_matches_interface "$BASE/.session/100" wg0; check "unreadable peers returns 0" "$?" "0"

# Non-WireGuard protocol -> 0 (skipped)
fresh_base m4; make_session 100 tun0 openvpn ""
stub_wgshow "$PEER_B"
session_peer_matches_interface "$BASE/.session/100" tun0; check "openvpn session skipped (0)" "$?" "0"

echo "=== _session_refresh0 ==="
# _session_refresh0 is a terminal function: it EMITS shell commands (the re-point
# / remove / echo lines) for an interpreter to run. run_refresh captures that
# output (for message assertions) and pipes it to sh to apply the effect - exactly
# how the dispatcher executes it in production.
run_refresh() { REFRESH_OUT=$(_session_refresh0 2>/dev/null); printf '%s\n' "$REFRESH_OUT" | sh >/dev/null 2>&1; }

# session refresh uses interface-existence in the down-cleanup branch.
EXAMINE_NETWORK_INTERFACE_EXISTS='true'   # interface "exists" by default

# Drift repaired: latest-wg0 points at a mismatching session; refresh re-points
# it to the session whose config matches the loaded peer.
fresh_base r1
make_session 200 wg0 wireguard "$PEER_A" "2026-04-18 08:00:00"   # matches loaded
make_session 201 wg0 wireguard "$PEER_B" "2026-04-18 09:00:00"   # does not match
ln -sfn "../.session/201" "$BASE/session/latest-wg0"             # drifted
stub_wgshow "$PEER_A"
run_refresh
check "refresh re-points to matching session" "$(owner_of wg0)" "200"

# Among several identical-config sessions, prefer the most-recently started.
fresh_base r2
make_session 300 wg0 wireguard "$PEER_A" "2026-04-18 08:00:00"
make_session 301 wg0 wireguard "$PEER_A" "2026-04-18 10:00:00"   # newest match
make_session 302 wg0 wireguard "$PEER_A" "2026-04-18 09:00:00"
ln -sfn "../.session/302" "$BASE/session/latest-wg0"
stub_wgshow "$PEER_A"
run_refresh
check "refresh picks most-recent matching session" "$(owner_of wg0)" "301"

# Idempotent: when ownership already correct, nothing changes.
fresh_base r3
make_session 400 wg0 wireguard "$PEER_A"
ln -sfn "../.session/400" "$BASE/session/latest-wg0"
stub_wgshow "$PEER_A"
run_refresh
check "idempotent: owner unchanged" "$(owner_of wg0)" "400"
printf '%s\n' "$REFRESH_OUT" | grep -q "already correct" && ok "idempotent: reports 'already correct'" \
  || bad "idempotent: missing 'already correct' message"

# No matching session: loaded config is unknown/external -> leave link as-is.
fresh_base r4
make_session 500 wg0 wireguard "$PEER_A"
ln -sfn "../.session/500" "$BASE/session/latest-wg0"
stub_wgshow "$PEER_B"   # loaded peer matches no session
run_refresh
check "unknown loaded config: ownership left as-is" "$(owner_of wg0)" "500"

# Interface down (no peers + interface absent) -> remove stale ownership.
fresh_base r5
make_session 600 wg0 wireguard "$PEER_A"
ln -sfn "../.session/600" "$BASE/session/latest-wg0"
stub_wgshow ""
EXAMINE_NETWORK_INTERFACE_EXISTS='false'
run_refresh
if [ -L "$BASE/session/latest-wg0" ]; then bad "down interface: stale link not removed"; else ok "down interface: stale ownership removed"; fi
EXAMINE_NETWORK_INTERFACE_EXISTS='true'

echo ""
echo "========================================"
echo "Test Summary"
echo "========================================"
# Summary lines in the format the shared runner (scripts/run-all-tests.sh) parses.
echo "Test Functions:     2"
printf 'Total Assertions:   %s\n' "$((PASS + FAIL))"
printf 'Passed Assertions:  %s\n' "$PASS"
printf 'Failed Assertions:  %s\n' "$FAIL"
echo "========================================"
[ "$FAIL" -eq 0 ]
