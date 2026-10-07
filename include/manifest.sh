#!/bin/sh
#
# SPDX-License-Identifier: BSD-2-Clause
#
# Copyright (c) 2026 Dr. Johannes Brügmann
# vpn-switch manifest - the archive's own tamper detection, built from the collection
# of files the bundle carries.
#
# An archive that carries no manifest is a claim without evidence: the receiver
# can tell that the tarball unpacked, not that it unpacked what the sender
# packed. So a bundle carries the same pair /boot carries -- MANIFEST plus a
# detached OpenPGP signature MANIFEST.asc -- produced by the same recipe as
# stage manifest / stage attest: LC_ALL=C-sorted 'path key=value' lines,
# hashed at generation time, signed with attest. Two line kinds, because a
# database tree holds more than regular files:
#
#   wireguard/ch-zrh-01.conf       sha256=3fa7...
#   openvpn/work/office            symlink=../us-server.ovpn
#
# The manifest never lists itself or its signature.

#@help ___manifest2
# @command manifest <collection> <manifest>
# @completion collection files
# @completion manifest files
# @summary Hash every entry of a collection into a manifest, (LC_ALL=C-sorted 'path sha256=hash', symlinks as 'path symlink=target'): the collection is readable, the manifest is named MANIFEST (import looks for it by name, next to the collection), every entry is hashable; then 'manifest write' -- everything hashed at generation, the emission is one concrete heredoc write
# @group   database
# @param   collection  a collection file, as written by 'filter'
# @param   manifest    where to write it; the signature goes next to it as <manifest>.asc
# @env     VPN_SWITCH_ARCHIVE_BASE  the prefix collection lines are written against
# @example vpn-switch manifest export/collection export/MANIFEST
# @see     manifest attest
# @see     manifest verify
# @see     bundle
#@end
___manifest2() {
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" collection readable '$1'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" manifest named '$2'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" manifest entries hashable '$1'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" manifest write '$1' '$2'"
}

#@help __manifest_named1
# @command manifest named <manifest>
# @summary The manifest path ends in /MANIFEST: a comment line, else an error line
# @group   database
# @internal
# @see     manifest
#@end
__manifest_named1() {
        if test "${1##*/}" = MANIFEST; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" comment 'manifest $1 named'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'manifest: the manifest must be named MANIFEST: $1' '(import looks for it by name, next to the collection)'"
        fi
}

#@help __manifest_entries_hashable1
# @command manifest entries hashable <collection>
# @summary Every entry of the collection is a file or symlink under the database with no whitespace in its path, and there is at least one: a comment line, else an error line naming the first that is not (an unreadable entry ends the command instead of shortening the manifest)
# @group   database
# @internal
# @see     manifest
# @env     VPN_SWITCH_ARCHIVE_BASE  the literal every collection entry starts with (expanded where the bundle is built)
#@end
__manifest_entries_hashable1() {
        local line="" rel="" bad=""
        bad=$(grep -v '^#' "$1" 2>/dev/null | grep . | while IFS= read -r line; do
                rel=${line#\"\$VPN_SWITCH_ARCHIVE_BASE\"/}
                case "$rel" in (*" "*|*"	"*) printf 'whitespace in path: %s\n' "$rel"; break ;; esac
                test -L "$VPN_SWITCH_BASE/$rel" || test -f "$VPN_SWITCH_BASE/$rel" || { printf 'neither file nor symlink: %s\n' "$rel"; break; }
        done | head -n1)
        if test -z "$bad" && test "$(grep -v "^#" "$1" 2>/dev/null | grep -c .)" -gt 0; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" comment 'every entry of $1 hashable'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error $(sq "manifest: ${bad:-collection $1 lists nothing to hash}") '(collect and bundle must see the same database)'"
        fi
}

#@help _manifest_write2
# @command manifest write <collection> <manifest>
# @summary Act terminal: the heredoc that writes <manifest>.new with one line per collection entry (hashed now), then mv into place (0644) and the count line
# @group   database
# @internal
# @see     manifest
# @env     VPN_SWITCH_ARCHIVE_BASE  the prefix collection lines are written against
#@end
_manifest_write2() {
        local line="" rel="" n=0
        n=$(grep -v '^#' "$1" 2>/dev/null | grep -c .)
        emit_note "vpn-switch manifest '$2' ($n entries, hashed at generation time)"
        printf '%s\n' "cat > '$2.new' <<'VSEOF'"
        grep -v '^#' "$1" 2>/dev/null | grep . | while IFS= read -r line; do
                rel=${line#\"\$VPN_SWITCH_ARCHIVE_BASE\"/}
                if test -L "$VPN_SWITCH_BASE/$rel"; then
                        printf '%s symlink=%s\n' "$rel" "$(readlink "$VPN_SWITCH_BASE/$rel")"
                else
                        printf '%s sha256=%s\n' "$rel" "$($EXAMINE_FILE_SHA256 "$VPN_SWITCH_BASE/$rel" 2>/dev/null)"
                fi
        done
        printf '%s\n' "VSEOF"
        printf '%s\n' "mv -f '$2.new' '$2' && $MODIFY_FILE_PERMS 0644 '$2'"
        printf '%s\n' "printf '# MANIFEST written: %s entries\\n' '$n' >&2"
}

#@help ___manifest_attest2
# @command manifest attest <collection> <key>
# @completion collection files
# @completion key none
# @summary Write the manifest for a collection and sign it, side by side with the collection: manifest + attest
# @group   database
# @param   collection  the filtered collection the bundle will pack
# @param   key         the openpgp record that signs (VPN_SWITCH_ARCHIVE_ATTEST_KEY in export)
# @example vpn-switch manifest attest export/collection attest-v1
# @see     manifest
# @see     attest
# @see     export
#@end
___manifest_attest2() {
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" manifest '$1' '$(dirname "$1")/MANIFEST'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" attest '$(dirname "$1")/MANIFEST' '$2'"
}

#@help ___manifest_verify3
# @command manifest verify <manifest> <base> <key>
# @completion manifest files
# @completion base files
# @completion key none
# @summary Verify a manifest, both judgments at generation time: the signature (attest verify: signed by the PINNED key, key neither expired nor revoked) and the tree (manifest match: every listed entry present and identical) -- a finding fails the batch before restore replays anything. The key is the RECEIVER's openpgp record naming the signer it expects
# @group   database
# @param   manifest  the MANIFEST to check
# @param   base      the directory its paths are relative to (an extraction directory)
# @param   key       the openpgp record naming the signer you expect
# @example vpn-switch manifest verify ~/.vpn-switch/incoming/a1b2c3d/export/MANIFEST ~/.vpn-switch/incoming/a1b2c3d attest-v1
# @see     attest verify
# @see     import
#@end
___manifest_verify3() {
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" attest verify '$1' '$3'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" manifest match '$1' '$2'"
}

#@help ___manifest_match2
# @command manifest match <manifest> <base>
# @completion manifest files
# @completion base files
# @summary Does the tree under <base> match the manifest? The manifest is readable and lists entries, the base exists; then 'manifest tree matches' -- every listed file hashes identically, every listed symlink points where recorded (MISSING, CHANGED, RETARGETED fail). Files present but unlisted are not findings: the base is an extraction directory
# @group   database
# @param   manifest  the MANIFEST to check
# @param   base      the directory its paths are relative to
# @see     manifest verify
#@end
___manifest_match2() {
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" manifest readable '$1'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" manifest base exists '$2'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" manifest tree matches '$1' '$2'"
}

#@help __manifest_readable1
# @command manifest readable <manifest>
# @summary The manifest is readable and lists at least one entry: a comment line, else an error line
# @group   database
# @internal
#@end
__manifest_readable1() {
        local n=""
        n=$(grep -cE "^[^ ]+ (sha256|symlink)=" "$1" 2>/dev/null)
        if test "${n:-0}" -gt 0; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" comment 'manifest $1 lists entries'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'manifest match: no such manifest, or it lists no entries: $1'"
        fi
}

#@help __manifest_base_exists1
# @command manifest base exists <base>
# @summary The base directory exists: a comment line, else an error line
# @group   database
# @internal
#@end
__manifest_base_exists1() {
        if test -d "$1"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" comment 'base $1 exists'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'manifest match: no such directory $1'"
        fi
}

#@help __manifest_tree_matches2
# @command manifest tree matches <manifest> <base>
# @summary No finding against the manifest (the tree under <base> read here, entry by entry): a log line with the entry count, else an error line carrying the findings (MISSING SYMLINK, RETARGETED, MISSING, CHANGED); files present but unlisted are not findings, the base is an extraction directory
# @group   database
# @internal
#@end
__manifest_tree_matches2() {
        local rel="" val="" findings=""
        findings=$(while read -r rel val; do
                case "$val" in
                (symlink=*)
                        test -L "$2/$rel" || printf 'MISSING SYMLINK %s\n' "$rel"
                        test ! -L "$2/$rel" || test "$(readlink "$2/$rel")" = "${val#symlink=}" || printf 'RETARGETED %s\n' "$rel"
                        ;;
                (sha256=*)
                        test -f "$2/$rel" || printf 'MISSING %s\n' "$rel"
                        test ! -f "$2/$rel" || test "$($EXAMINE_FILE_SHA256 "$2/$rel" 2>/dev/null)" = "${val#sha256=}" || printf 'CHANGED %s\n' "$rel"
                        ;;
                esac
        done 2>/dev/null < "$1")
        if test -z "$findings"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" log 'manifest match: $(grep -cE "^[^ ]+ (sha256|symlink)=" "$1" 2>/dev/null) entries, tree matches'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'manifest match: $1 does not describe $2 (the TREE differs from what the sender listed)' $(sq "$(printf '%s' "$findings" | tr '\n' ';')")"
        fi
}
