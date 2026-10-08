#!/bin/sh
#
# SPDX-License-Identifier: BSD-2-Clause
#
# Copyright (c) 2026 Dr. Johannes Brügmann
#
# vpn-switch-import-db-patch.sh -- a patch script of 'elebake stage rescue
# patch': the vpn-switch database of a user, built into a rescue root from
# an export pair, by the vpn-switch of the image itself.
# It lives under template/rescue/ of the tool and travels with it: in the
# image it is /usr/local/lib/vpn-switch/template/rescue/vpn-switch-import-db-patch.sh --
# the path 'stage rescue patch add' records.
#
# The contract of every patch script: sh <script> <user> <resources>, run as
# root INSIDE the rescue root (elebake puts a one-shot jail on the mounted
# root; no network) -- $1 the user the patch is for, $2 the resource
# directory the owner filled, hung into the root read-only; a non-zero exit
# fails the batch. Here the resources are the pair 'vpn-switch export'
# wrote, dump.sh (with dump.sh.asc beside it) and bundle.tar.gz, and
# signer.asc, the public key of the signer (gpg --export --armor <keyid>).
#
# What it does: the user's ~/.vpn-switch of the image removed (a previous build
# leaves none behind), then as the user with a login shell (su -l: HOME, PATH and the
# default base ~/.vpn-switch/db of the image), the public key imported into
# the user's keyring of the image (what the signature is checked against;
# the rescue keeps it), then 'vpn-switch import <dump> <bundle>' -- import
# makes the database when there is none (bootstrap with the profile the
# dump names, the signer pinned under the record name the dump carries) and
# replays the dump. The import's stdout (the dump displays the session
# scripts it builds) is kept for the failure case only; its notes and
# errors go to stderr as always.
set -u
user=${1:-}; res=${2:-}
me=$(basename "$0")
test -n "$user" && test -n "$res" || { printf '%s: usage: sh %s <user> <resources>\n' "$me" "$me" >&2; exit 2; }
home=$(getent passwd "$user" 2>/dev/null | cut -d: -f6)
test -n "$home" || { printf '%s: no such user in the image: %s (stage rescue user mirror first)\n' "$me" "$user" >&2; exit 1; }
test -d "$home" || { printf '%s: the image carries no home for %s: %s\n' "$me" "$user" "$home" >&2; exit 1; }
test -r "$res/dump.sh" && test -r "$res/dump.sh.asc" && test -r "$res/bundle.tar.gz" \
        || { printf '%s: the resources are not the pair: %s/dump.sh, dump.sh.asc, bundle.tar.gz (vpn-switch export <strategy> ... first)\n' "$me" "$res" >&2; exit 1; }
test -r "$res/signer.asc" || { printf '%s: no %s/signer.asc -- the public key of the signer (gpg --export --armor <keyid> > signer.asc)\n' "$me" "$res" >&2; exit 1; }
test -x /usr/local/bin/vpn-switch || { printf '%s: no /usr/local/bin/vpn-switch in the image (the vpn-switch package installed?)\n' "$me" >&2; exit 1; }
rm -rf "$home/.vpn-switch"	# the database of the image IS the dump: never a union with a previous build
printf '%s: vpn-switch import as %s (home %s)\n' "$me" "$user" "$home" >&2
out=$(mktemp) || exit 1
su -l "$user" -c "gpg --batch --quiet --import '$res/signer.asc' && vpn-switch import '$res/dump.sh' '$res/bundle.tar.gz'" > "$out"; rc=$?
su -l "$user" -c "gpgconf --kill all" 2>/dev/null
test "$rc" = 0 || cat "$out" >&2
rm -f "$out"
exit $rc
