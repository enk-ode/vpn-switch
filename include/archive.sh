#!/bin/sh
#
# SPDX-License-Identifier: BSD-2-Clause
#
# Copyright (c) 2026 Dr. Johannes Brügmann
# vpn-switch archive - the export/import pair, ported from elebake: a dump
# and a bundle that travel apart, bound by a seal and signed with one
# OpenPGP key; on arrival the signer is pinned, the seal checked, the
# bundle's MANIFEST verified, a receipt filed and the serial raised before
# the replay. A dump alone names its base elements against
# "$VPN_SWITCH_ARCHIVE_BASE"; the bundle carries them.
#
# Entry points: export <dump> <bundle>, import <dump> <bundle>, restore
# <dump> [<base>], version. Every detail (the serial, the pinned key, the
# signer, the signer's floor, this database's serial) is read ONCE at the
# entry of a command and handed down as an argument; the batches at the
# end compare and act on their arguments.

#@help ___collect0
# @command collect
# @summary The complete list of files an archive must carry: the openpgp records, the receipts, the WireGuard and OpenVPN configurations (sessions are recreated by the dump from them)
# @group   database
# @internal
# @env     VPN_SWITCH_ARCHIVE_BASE  the prefix collection lines are written against
# @see     export
#@end
___collect0() {
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" openpgp collect"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" provenance collect"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" wireguard collect"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" openvpn collect"
}

#@help _wireguard_collect0
# @command wireguard collect
# @summary Text terminal: the WireGuard configurations (wireguard/*.conf) by their real path, written against "$VPN_SWITCH_ARCHIVE_BASE"; the categories and links are recreated by the dump
# @group   wireguard
# @internal
# @env     VPN_SWITCH_ARCHIVE_BASE  the prefix the emitted paths are written against
#@end
_wireguard_collect0() {
        printf '# wireguard\n'
        find "$VPN_SWITCH_BASE/wireguard" -maxdepth 1 -type f -name '*.conf' 2>/dev/null | sort | sed "s|^$VPN_SWITCH_BASE/|\"\$VPN_SWITCH_ARCHIVE_BASE\"/|"
}

#@help _openvpn_collect0
# @command openvpn collect
# @summary Text terminal: the OpenVPN configurations (openvpn/*.ovpn) by their real path, written against "$VPN_SWITCH_ARCHIVE_BASE"; the groups and links are recreated by the dump
# @group   openvpn
# @internal
# @env     VPN_SWITCH_ARCHIVE_BASE  the prefix the emitted paths are written against
#@end
_openvpn_collect0() {
        printf '# openvpn\n'
        find "$VPN_SWITCH_BASE/openvpn" -maxdepth 1 -type f -name '*.ovpn' 2>/dev/null | sort | sed "s|^$VPN_SWITCH_BASE/|\"\$VPN_SWITCH_ARCHIVE_BASE\"/|"
}

#@help __export3
# @command export <strategy> <dump> <bundle>
# @summary Write the two artifacts that travel apart, bound and signed: the DUMP to a path of your choosing (commit it), the BUNDLE to its store. The strategy is the first word: redacted (no credentials, for sending) | full (own machines, disaster recovery) | minimized (rescue: the configurations and the key, no receipts). Every strategy describes the database completely and governs the payload only
# @group   database
# @completion strategy none
# @completion dump files
# @completion bundle files
# @param   strategy  redacted | full | minimized
# @param   dump      where the dump goes (a path of your choosing, absolute)
# @param   bundle    where the bundle goes (absolute)
# @env     VPN_SWITCH_ARCHIVE_ATTEST_KEY  the openpgp record that signs the bundle's MANIFEST and the dump
# @example vpn-switch export full ~/backup/vpn-switch.sh ~/backup/vpn-switch.tar.gz
# @example vpn-switch export redacted ~/git/config/vpn-switch.sh ~/backup/vpn-switch-redacted.tar.gz
# @see     import
# @see     dump
# @see     filter
#@end
__export3() {
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'export: unknown strategy $1 (redacted | full | minimized)'"
}

#@help __export2
# @internal arity-2 fallback of 'export': the strategy is required -- an error line naming the three
#@end
__export2() {
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'export: the strategy comes first: export redacted|full|minimized <dump> <bundle>'"
}

#@help __export_redacted2
# @command export redacted <dump> <bundle>
# @summary Export the complete description and the payload without credentials (the configurations stay): rewrite to 'export pair redacted ...'
# @group   database
# @internal
# @see     export
#@end
__export_redacted2() {
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" export pair redacted '$1' '$2'"
}

#@help __export_full2
# @command export full <dump> <bundle>
# @summary Export the complete description and the complete payload: rewrite to 'export pair full ...'
# @group   database
# @internal
# @see     export
#@end
__export_full2() {
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" export pair full '$1' '$2'"
}

#@help __export_minimized2
# @command export minimized <dump> <bundle>
# @summary Export the complete description with the rescue payload (the configurations and the key, no receipts): rewrite to 'export pair minimized ...'
# @group   database
# @internal
# @see     export
#@end
__export_minimized2() {
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" export pair minimized '$1' '$2'"
}

#@help __export_pair3
# @internal 'export pair <strategy> <dump> <bundle>': the export serial read here, then 'export pair <strategy> <dump> <bundle> <serial>'
#@end
__export_pair3() {
        local cur=""
        cur=$(head -n1 "$VPN_SWITCH_BASE/export/serial" 2>/dev/null)
        case "$cur" in ''|*[!0-9]*) cur=0 ;; esac
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" export pair '$1' '$2' '$3' '$cur'"
}

#@help ___export_pair4
# @internal 'export pair <strategy> <dump> <bundle> <serial>': the one export -- write the dump (its header carries the next serial), collect the files, filter the collection by the strategy, attest its MANIFEST, bundle it, seal the pair (the seal hashes the bundle), attest the dump, and advance the serial LAST -- a failed export (a pinentry that could not open) leaves the number to the next attempt; one signature covers the pair
# @env     VPN_SWITCH_ARCHIVE_ATTEST_KEY  the openpgp record that signs
#@end
___export_pair4() {
        local work="$VPN_SWITCH_BASE/export" key="${VPN_SWITCH_ARCHIVE_ATTEST_KEY:-}"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" archive key pinned"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" dump '$4' > '$2'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" collect > '$work/collection.raw'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" filter '$1' '$work/collection.raw' '$work/collection'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" manifest attest '$work/collection' '$key'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" bundle '$work/collection' '$3'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" seal '$2' '$3'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" attest '$2' '$key'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" provenance serial '$4'"
}

#@help _dump_header1
# @internal 'dump header <serial>': the header of a dump -- the generator ('vpn-switch <format> <commit>'), the format as '# Version:' (restore reads it), the date, the lineage serial as <serial>+1 (the number the next 'export' advances to) and the base
# @env     VPN_SWITCH_FORMAT  the dump format major version
#@end
_dump_header1() {
        local commit=""
        commit=$(git -C "$VPN_SWITCH_LIBDIR" rev-parse --short HEAD 2>/dev/null)
        printf '# vpn-switch database dump\n# Generator: vpn-switch %s %s\n# Version: %s\n' "$VPN_SWITCH_FORMAT" "${commit:-unknown}" "$VPN_SWITCH_FORMAT"
        printf '# Generated: %s\n# Serial: %s\n# Profile: %s\n# Base: %s\n\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$(($1 + 1))" "$(ls "$VPN_SWITCH_BASE/.env/default" 2>/dev/null | sed -n 's/^VPN_SWITCH_PROFILE_//p' | head -n1 | tr '[:upper:]' '[:lower:]')" "$VPN_SWITCH_BASE"
}

#@help __dump_readable1
# @command dump readable <dump>
# @summary The dump file is there and readable: a comment line, else an error line
# @group   database
# @internal
# @see     restore
#@end
__dump_readable1() {
        if test -r "$1"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" comment 'dump $1 readable'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'restore: dump file not found or not readable: $1'"
        fi
}
#@help __archive_key_pinned0
# @command archive key pinned
# @summary VPN_SWITCH_ARCHIVE_ATTEST_KEY names an openpgp record that is there with its keyid: a comment line, else an error line -- the signer both artifacts of a pair carry (export) and the receiver expects (import, restore)
# @group   database
# @internal
# @see     restore
# @see     export
# @see     import
#@end
__archive_key_pinned0() {
        if test -n "${VPN_SWITCH_ARCHIVE_ATTEST_KEY:-}" && test -f "$VPN_SWITCH_BASE/openpgp/${VPN_SWITCH_ARCHIVE_ATTEST_KEY:-}/keyid"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" comment 'attest key ${VPN_SWITCH_ARCHIVE_ATTEST_KEY:-} pinned'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'VPN_SWITCH_ARCHIVE_ATTEST_KEY not set or its openpgp record incomplete (openpgp add <name> <fingerprint>; setenv VPN_SWITCH_ARCHIVE_ATTEST_KEY <name>)'"
        fi
}
#@help __restore1
# @command restore <dump> [<base>]
# @completion dump files
# @completion base files
# @summary Replay a dump into the current database -- only a dump signed by the PINNED attest key, at or above the lineage's serial; <base> binds where its base elements come from (default: this database). The dump's format (its '# Version:' header) selects the restore that speaks it: 'restore v<format> <dump> <base>', which reads the serial, the pinned key, the signer and the signer's floor once and hands them down -- into a database that does not yet hold the records (an identical import is refused as 'already exists', the rest replays)
# @group   database
# @env     VPN_SWITCH_ARCHIVE_ATTEST_KEY  the openpgp record naming the signer the dump must carry
# @example vpn-switch restore backup.sh
# @see     dump
# @see     import
# @see     attest
# @see     version
# @env     VPN_SWITCH_ARCHIVE_BASE  bound for the replay: the dump's base elements are taken from there
# @env     VPN_SWITCH_BATCH_KEEP_GOING  0 = stop at the first failing line, 1 = replay everything
# @param   dump  dump file produced by 'dump' and signed by 'attest' (the signature is <dump>.asc)
# @param   base  an old database (migration) or an extracted bundle; absent = the elements are already here
#@end
__restore1() {
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" restore '$1' '$VPN_SWITCH_BASE'"
}
#@help __restore2
# @internal arity-2 sibling of 'restore' (restore <dump> <base>): The dump's format decides (lifting): read '# Version:' from the header and rewrite to 'restore v<format> <dump> <base>'; a dump without the header is 'v?'
#@end
__restore2() {
        local format=""
        format=$(sed -n "s/^# Version: //p" "$1" 2>/dev/null | head -n1)
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" restore 'v${format:-?}' '$1' '$2'"
}
#@help __restore_v12
# @internal 'restore v1 <dump> <base>': the dump's serial, read here from its header -> 'restore v1 <dump> <base> <serial>', else an error line (not readable, or no numeric serial)
#@end
__restore_v12() {
        local serial=""
        serial=$(sed -n 's/^# Serial: //p' "$1" 2>/dev/null | head -n1)
        if ! test -r "$1"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'restore: dump file not found or not readable: $1'"
        elif printf '%s\n' "$serial" | grep -qx '[0-9][0-9]*'; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" restore v1 '$1' '$2' '$serial'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'restore: dump carries no numeric # Serial: header: $1'"
        fi
}
#@help __restore_v13
# @internal 'restore v1 <dump> <base> <serial>': the pinned attest key, an openpgp record with a keyid -> 'restore v1 ... <key>', else an error line
# @env     VPN_SWITCH_ARCHIVE_ATTEST_KEY  the openpgp record naming the pinned signer
#@end
__restore_v13() {
        local key="${VPN_SWITCH_ARCHIVE_ATTEST_KEY:-}" keyid=""
        keyid=$(head -n1 "$VPN_SWITCH_BASE/openpgp/${key:-.}/keyid" 2>/dev/null | sed 's/^0[xX]//' | tr 'a-f' 'A-F')
        case "$keyid" in
                ????????????????*) case "$keyid" in *[!0-9A-F]*) keyid="" ;; esac ;;
                *) keyid="" ;;
        esac
        if test -n "$key" && test -n "$keyid"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" restore v1 '$1' '$2' '$3' '$key'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'VPN_SWITCH_ARCHIVE_ATTEST_KEY not set or its openpgp record incomplete (a keyid of 16+ hex digits; openpgp add <name> <fingerprint>; setenv VPN_SWITCH_ARCHIVE_ATTEST_KEY <name>)'"
        fi
}
#@help __restore_v14
# @internal 'restore v1 <dump> <base> <serial> <key>': the signer of <dump>.asc, gpg's status lines read here, once -> 'restore v1 ... <fpr>' when it is the pinned key, else an error line with the one reason (unsigned, bad, expired, revoked, a different key)
#@end
__restore_v14() {
        local keyid="" gh="" status="" fpr="" pfpr="" why=""
        keyid=$(head -n1 "$VPN_SWITCH_BASE/openpgp/$4/keyid" 2>/dev/null | sed 's/^0[xX]//' | tr 'a-f' 'A-F')
        gh=$(head -n1 "$VPN_SWITCH_BASE/openpgp/$4/gnupghome" 2>/dev/null)
        if ! test -f "$1.asc"; then
                why="unsigned: no $1.asc"
        elif test -n "$gh"; then
                status=$(GNUPGHOME="$gh" gpg --batch --status-fd 1 --verify "$1.asc" "$1" 2>>"${LOG_FILE:-/dev/null}")
        else
                status=$(gpg --batch --status-fd 1 --verify "$1.asc" "$1" 2>>"${LOG_FILE:-/dev/null}")
        fi
        printf '%s\n' "$status" >>"${LOG_FILE:-/dev/null}"
        fpr=$(printf '%s\n' "$status" | awk '/^\[GNUPG:\] VALIDSIG /{print $3; exit}')
        pfpr=$(printf '%s\n' "$status" | awk '/^\[GNUPG:\] VALIDSIG /{print $NF; exit}')
        test -n "$why" || case "$status" in
                *"[GNUPG:] NO_PUBKEY"*) why="signer public key not in the keyring${gh:+ $gh}" ;;
                *"[GNUPG:] BADSIG"*)    why="BAD SIGNATURE -- file or signature altered" ;;
                *"[GNUPG:] REVKEYSIG"*) why="signed by a REVOKED key" ;;
                *"[GNUPG:] EXPKEYSIG"*) why="signed by an EXPIRED key" ;;
                *"[GNUPG:] EXPSIG"*)    why="signature itself has expired" ;;
                *"[GNUPG:] GOODSIG"*)   case "$fpr|$pfpr|" in *"$keyid|"*) ;; *) why="signed by a DIFFERENT key: $fpr (expected ...$keyid)" ;; esac ;;
                *) why="no good signature (see the log for gpg status)" ;;
        esac
        if test -z "$why"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" restore v1 '$1' '$2' '$3' '$4' '$fpr'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error $(sq "restore: $why") '(file $1, expected signer: openpgp record $4)'"
        fi
}
#@help __restore_v15
# @internal 'restore v1 <dump> <base> <serial> <key> <fpr>': the signer's highest receipt in this database, read from the records -> 'restore v1 ... <floor>' (0 without receipts)
#@end
__restore_v15() {
        local r="" s="" floor=0
        for r in "$VPN_SWITCH_BASE"/provenance/*/; do
                test "$(head -n1 "$r/signer" 2>/dev/null)" = "$5" || continue
                s=$(head -n1 "$r/serial" 2>/dev/null)
                case "$s" in ''|*[!0-9]*) continue ;; esac
                test "$s" -le "$floor" || floor=$s
        done
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" restore v1 '$1' '$2' '$3' '$4' '$5' '$floor'"
}
#@help ___restore_v16
# @internal 'restore v1 <dump> <base> <serial> <key> <fpr> <floor>': Restore a format-1 dump, every detail read once on the way here (the serial, the pinned key, the signer, the signer's floor), pruned against the bundle's collection, replayed fail-fast: the serial is not below the floor (no downgrade), the base exists -- then the replay (a batch under keep-going, so a re-run survives a config that is already there)
#@end
___restore_v16() {
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" restore serial admissible '$3' '$6' '$5'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" restore base exists '$2'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" restore prune '$1' '$2'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" restore replay '$2/replay.sh' '$2'"
}
#@help _restore_prune2
# @command restore prune <dump> <base>
# @summary Act terminal (owner): <base>/replay.sh written from the dump -- every line naming a base element the bundle's collection (<base>/export/collection) marks as dropped becomes a '# dropped (<reason>)' comment (a redacted pair: the configurations travel as description only), the rest as it is; no collection in the bundle, nothing pruned
# @group   database
# @internal
# @env     VPN_SWITCH_TEMPLATE_DIR  where awk/prune.awk lives
# @see     restore
# @see     filter
#@end
_restore_prune2() {
        local l="" links=""
        for l in "$2"/*/*; do	# the names links give (stage/<name> -> .staging/<id>): the collection names the real path, the dump the name
                test -L "$l" || continue
                links="$links${links:+;}${l#"$2"/}=$(readlink "$l" | sed 's|^\.\./||')"
        done
        emit_note "restore: $1 -> $2/replay.sh (the lines naming what the bundle dropped commented out)"
        printf '%s\n' "awk -v collection='$2/export/collection' -v links='$links' -f '$VPN_SWITCH_TEMPLATE_DIR/awk/prune.awk' '$1' > '$2/replay.sh' || exit 1"
        printf '%s\n' "$MODIFY_FILE_PERMS 0600 '$2/replay.sh'"
}
#@help __restore3
# @internal arity-3 sibling of 'restore' (restore <format> <dump> <base>): The total fallback behind the formats (dispatch binds the longer name): a dump format this vpn-switch does not speak is an error line naming both formats
#@end
__restore3() {
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'restore: dump format ${1#v} not admissible (this vpn-switch speaks v$VPN_SWITCH_FORMAT; re-export with it)'"
}
#@help __restore_serial_admissible3
# @internal 'restore serial admissible <serial> <floor> <fpr>': The dump's serial is not below the signer's highest receipt in this database, both handed down: a comment line, else an error line -- a DOWNGRADE is refused
#@end
__restore_serial_admissible3() {
        if test "$1" -ge "$2" 2>/dev/null; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" comment 'dump serial $1 at or above the receipt floor $2'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'restore: DOWNGRADE refused: dump serial $1 is below the highest receipt $2 of signer $3'"
        fi
}
#@help __restore_base_exists1
# @command restore base exists <base>
# @summary The base directory the replay takes its elements from is there: a comment line, else an error line
# @group   database
# @internal
# @see     restore
#@end
__restore_base_exists1() {
        if test -d "$1"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" comment 'base $1 exists'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'restore: base directory not found: $1'"
        fi
}
#@help __restore_replay2
# @command restore replay <dump> <base>
# @summary The one line that replays the dump -- 'batch <dump>' with VPN_SWITCH_ARCHIVE_BASE bound to <base> and fail-fast set in front of it (the child skips the startup re-exec, so the batch expands the dump's "$VPN_SWITCH_ARCHIVE_BASE/..." against that directory; a restore survives failing lines and replays everything else). Both settings stand in the line, readable; the pin only maps the script word
# @group   database
# @internal
# @env     VPN_SWITCH_INTERPRETER_restore_replay  execs the line with the script word mapped; cat = dry-run
# @env     VPN_SWITCH_BATCH_KEEP_GOING  set to 0 in the emitted line: the replay stops at the first failing line -- a dump half applied must not end as a success
# @env     VPN_SWITCH_ARCHIVE_BASE  bound to <base> in the emitted line: where the dump's base elements are
# @see     restore
# @see     batch
#@end
__restore_replay2() {
        printf '%s\n' "env VPN_SWITCH_BATCH_KEEP_GOING=0 VPN_SWITCH_ARCHIVE_BASE='$2' \"\$VPN_SWITCH_CONTEXT_SCRIPT\" batch '$1'"
}
#@help __filter2
# @command filter <collection> <filtered>
# @summary Apply the default strategy to a collection (delegates: default -> redacted)
# @group   database
# @see     filter redacted
#@end
__filter2() {
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" filter default '$1' '$2'"
}
#@help __filter_default2
# @internal the user's notion of a default, as one visible line
#@end
__filter_default2() {
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" filter redacted '$1' '$2'"
}
#@help __filter3
# @internal arity-3 fallback of 'filter': an unknown strategy is an error line
#@end
__filter3() {
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'filter: unknown strategy $1 (redacted | full | minimized)'"
}
#@help __filter_redacted2
# @command filter redacted <collection> <filtered>
# @summary Drop what is a secret: the VPN configurations themselves (wireguard/*.conf, openvpn/*.ovpn carry keys and credentials) -- and always the operational directories. The description still travels complete (categories, links, sessions, keys, receipts); what a bug report or a second machine's skeleton needs, without the credentials. The collection is readable: rewrite to 'filter write redacted ...', else an error line
# @group   database
# @example vpn-switch filter redacted export/collection export/filtered
# @see     filter write
#@end
__filter_redacted2() {
        if test -r "$1"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" filter write redacted '$1' '$2'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'filter redacted: no such collection $1'"
        fi
}
#@help __filter_full2
# @command filter full <collection> <filtered>
# @summary Keep everything except the operational directories: the configurations with their keys travel. For one's own machines (a rescue medium, a second host), never for sending to strangers. The collection is readable: rewrite to 'filter write full ...', else an error line
# @group   database
# @see     filter write
#@end
__filter_full2() {
        if test -r "$1"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" filter write full '$1' '$2'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'filter full: no such collection $1'"
        fi
}
#@help __filter_minimized2
# @command filter minimized <collection> <filtered>
# @summary Keep what connecting needs only: the configurations (wireguard/, openvpn/) and the attest key; no receipts. What a rescue system needs to come online, nothing of the lineage. The collection is readable: rewrite to 'filter write minimized ...', else an error line
# @group   database
# @example vpn-switch filter minimized export/collection export/filtered
# @see     filter write
#@end
__filter_minimized2() {
        if test -r "$1"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" filter write minimized '$1' '$2'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'filter minimized: no such collection $1'"
        fi
}

#@help _filter_write3
# @command filter write <strategy> <collection> <filtered>
# @summary Act terminal: the script that writes the filtered collection -- every line of the collection kept, or turned into an auditable '# dropped (<reason>)' comment, as template/filter/<strategy>.drop and .keep say (matched by template/awk/filter.awk); the file is 0600
# @group   database
# @internal
# @env     VPN_SWITCH_TEMPLATE_DIR  where filter/<strategy>.drop, filter/<strategy>.keep and awk/filter.awk live
# @see     filter full
#@end
_filter_write3() {
        printf '%s\n' "cat > '$3' <<'VSCOLLECTION'"
        awk -v strategy="$1" -v drop="$VPN_SWITCH_TEMPLATE_DIR/filter/$1.drop" -v keep="$VPN_SWITCH_TEMPLATE_DIR/filter/$1.keep" -f "$VPN_SWITCH_TEMPLATE_DIR/awk/filter.awk" "$2" 2>/dev/null
        printf '%s\n' "VSCOLLECTION"
        printf '%s\n' "$MODIFY_FILE_PERMS 0600 '$3'"
        emit_note "filtered ($1): $3"
}
#@help ___bundle2
# @command bundle <collection> <archive>
# @completion collection files
# @completion archive files
# @summary Pack the collected files with VPN_SWITCH_ARCHIVER: the collection is readable, the archiver set, the archive path absolute, the manifest pair (MANIFEST + MANIFEST.asc) lies beside the collection -- an archive that carries no tamper detection is not an artifact this tool produces -- and the collection lives inside the database (the pair is packed by its database-relative path); then 'bundle pack'
# @group   database
# @env     VPN_SWITCH_ARCHIVER  the packing template; $a is the archive, $b the base directory
# @env     VPN_SWITCH_ARCHIVE_BASE  the prefix collection lines are written against
# @example vpn-switch bundle export/filtered ~/.vpn-switch/bundle/a1b2c3d.tar.gz
# @see     extract
# @see     manifest attest
# @see     bundle pack
#@end
___bundle2() {
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" collection readable '$1'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" archiver set"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" bundle archive absolute '$2'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" bundle manifest beside '$1'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" bundle collection inside '$1'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" bundle pack '$1' '$2'"
}
#@help __collection_readable1
# @command collection readable <collection>
# @summary The collection file is there and readable: a comment line, else an error line
# @group   database
# @internal
# @see     bundle
#@end
__collection_readable1() {
        if test -r "$1"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" comment 'collection $1 readable'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'no such collection $1'"
        fi
}
#@help __archiver_set0
# @command archiver set
# @summary VPN_SWITCH_ARCHIVER is set: a comment line, else an error line (environment init <profile>)
# @group   database
# @internal
# @env     VPN_SWITCH_ARCHIVER  the packing template
# @see     bundle
#@end
__archiver_set0() {
        if test -n "${VPN_SWITCH_ARCHIVER:-}"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" comment 'archiver set'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'bundle: VPN_SWITCH_ARCHIVER not set (environment init <profile>)'"
        fi
}
#@help __bundle_archive_absolute1
# @command bundle archive absolute <archive>
# @summary The archive path is absolute: a comment line, else an error line
# @group   database
# @internal
# @see     bundle
#@end
__bundle_archive_absolute1() {
        if test "${1#/}" != "$1"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" comment 'archive path $1 absolute'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'bundle: archive must be an absolute path: $1'"
        fi
}
#@help __bundle_manifest_beside1
# @command bundle manifest beside <collection>
# @summary MANIFEST and MANIFEST.asc lie beside the collection (where 'manifest attest' puts them; the manifest cannot list itself, exactly as boot/manifest excludes itself and its signature): a comment line, else an error line
# @group   database
# @internal
# @see     bundle
# @see     manifest attest
#@end
__bundle_manifest_beside1() {
        if test -f "$(dirname "$1")/MANIFEST" && test -f "$(dirname "$1")/MANIFEST.asc"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" comment 'manifest pair beside $1'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'bundle: no MANIFEST + MANIFEST.asc beside the collection ($(dirname "$1"))' '(manifest attest <collection> <key> first -- an archive without tamper detection is not produced)'"
        fi
}
#@help __bundle_collection_inside1
# @command bundle collection inside <collection>
# @summary The collection's directory lies inside the database, so the manifest pair has a database-relative path to be packed by: a comment line, else an error line
# @group   database
# @internal
# @see     bundle
#@end
__bundle_collection_inside1() {
        if test "${1#"$VPN_SWITCH_BASE"/}" != "$1"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" comment 'collection $1 inside the database'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'bundle: the collection must live inside the database ($VPN_SWITCH_BASE), not at $(dirname "$1")' '(the manifest pair is packed by its database-relative path)'"
        fi
}
#@help _bundle_pack2
# @command bundle pack <collection> <archive>
# @summary Act terminal: the packing script -- the archive's directory, $a and $b for the VPN_SWITCH_ARCHIVER template, the template in a group (a pipeline's heredoc would attach to its LAST command) fed the database-relative file list of the collection plus MANIFEST and MANIFEST.asc beside it; the archive is 0600
# @group   database
# @internal
# @env     VPN_SWITCH_ARCHIVER  the packing template; $a is the archive, $b the base directory
# @see     bundle
# @env     VPN_SWITCH_ARCHIVE_BASE  the prefix collection lines are written against
#@end
_bundle_pack2() {
        local line="" rel="" mrel="" n=0
        mrel=${1#"$VPN_SWITCH_BASE"/}
        mrel=$(dirname "$mrel")/
        printf '%s\n' "$MODIFY_DIR_CREATE '$(dirname "$2")'"
        printf "a='%s'\n" "$2"
        printf "b='%s'\n" "$VPN_SWITCH_BASE"
        printf '%s\n' "{ $VPN_SWITCH_ARCHIVER ; } <<'VSBUNDLE'"
        grep -v '^#' "$1" 2>/dev/null | grep . | sed 's|^"\$VPN_SWITCH_ARCHIVE_BASE"/||'
        printf '%s\n' "${mrel#./}MANIFEST"
        printf '%s\n' "${mrel#./}MANIFEST.asc"
        printf '%s\n' "${mrel#./}$(basename "$1")"	# the collection itself: what the bundle carries and what it dropped, read by restore prune
        printf '%s\n' "VSBUNDLE"
        printf '%s\n' "$MODIFY_FILE_PERMS 0600 '$2'"
        n=$(grep -v '^#' "$1" 2>/dev/null | grep -c .)
        emit_note "bundled $((n + 3)) entries (MANIFEST, MANIFEST.asc and the collection included) -> $2"
}
#@help ___seal2
# @command seal <dump> <bundle>
# @completion dump files
# @completion bundle files
# @summary Append the bundle's sha256 and size to the dump as its seal line ('# Bundle: sha256=... bytes=...'): both files readable, the dump not yet sealed (a dump names ONE bundle) and not yet attested (sealing after signing would invalidate the signature); then 'seal write'. Attest the dump AFTER sealing so one signature covers both
# @group   database
# @example vpn-switch seal ~/git/config/dump.sh ~/.vpn-switch/bundle/a1b2c3d.tar.gz
# @see     seal verify
# @see     export
# @see     seal write
#@end
___seal2() {
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" dump readable '$1'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" bundle readable '$2'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" seal absent '$1'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" attest absent '$1'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" seal write '$1' '$2'"
}
#@help __bundle_readable1
# @command bundle readable <bundle>
# @summary The bundle (an archive file) is there and readable: a comment line, else an error line
# @group   database
# @internal
# @see     seal
# @see     extract
#@end
__bundle_readable1() {
        if test -r "$1"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" comment 'bundle $1 readable'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'no such bundle $1'"
        fi
}
#@help __seal_absent1
# @command seal absent <dump>
# @summary The dump carries no seal line yet: a comment line, else an error line (a dump names ONE bundle; export again for a new pair)
# @group   database
# @internal
# @see     seal
#@end
__seal_absent1() {
        if ! grep -qs '^# Bundle: sha256=' "$1"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" comment 'dump $1 not yet sealed'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'seal: $1 is already sealed (a dump names ONE bundle; export again for a new pair)'"
        fi
}
#@help __attest_absent1
# @command attest absent <dump>
# @summary No detached signature <dump>.asc exists yet: a comment line, else an error line
# @group   database
# @internal
# @see     seal
#@end
__attest_absent1() {
        if test ! -f "$1.asc"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" comment 'dump $1 not yet attested'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'seal: $1 is already attested -- sealing after signing would invalidate the signature'"
        fi
}
#@help _seal_write2
# @command seal write <dump> <bundle>
# @summary Act terminal: the one line that appends the seal ('# Bundle: sha256=<sha256 of the bundle> bytes=<size>') to the dump, then the dump's mode 0600 -- the pair's files are the owner's alone, like the bundle; the hash is computed here, at generation
# @group   database
# @internal
# @see     seal
#@end
_seal_write2() {
        local line=""
        line="# Bundle: sha256=$($EXAMINE_FILE_SHA256 "$2" 2>/dev/null) bytes=$(wc -c 2>/dev/null < "$2" | tr -d ' ')"
        emit_note "seal: $1 names $(basename "$2") (${line#\# Bundle: })"
        printf '%s\n' "printf '%s\\n' '$line' >> '$1'"
        printf '%s\n' "$MODIFY_FILE_PERMS 0600 '$1'"
}
#@help ___seal_verify2
# @command seal verify <dump> <bundle>
# @completion dump files
# @completion bundle files
# @summary Check that the dump's seal line names THIS bundle (sha256 and size): both files readable, the dump sealed, the seal matching -- a mismatch fails the command before anything is extracted
# @group   database
# @example vpn-switch seal verify dump.sh ~/.vpn-switch/bundle/a1b2c3d.tar.gz
# @see     seal
# @see     import
#@end
___seal_verify2() {
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" dump readable '$1'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" bundle readable '$2'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" seal present '$1'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" seal matches '$1' '$2'"
}
#@help __seal_present1
# @command seal present <dump>
# @summary The dump carries a seal line: a comment line, else an error line (it was not exported with a bundle -- a dump and a bundle are bound by content, not by name)
# @group   database
# @internal
# @see     seal verify
#@end
__seal_present1() {
        if grep -qs '^# Bundle: sha256=' "$1"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" comment 'dump $1 sealed'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'seal verify: $1 carries no seal line -- it was not exported with a bundle' '(a dump and a bundle are bound by content, not by name)'"
        fi
}
#@help __seal_matches2
# @command seal matches <dump> <bundle>
# @summary The dump's seal line equals this bundle's sha256 and size: a log line, else an error line (MISMATCHED PAIR)
# @group   database
# @internal
# @see     seal verify
#@end
__seal_matches2() {
        local want="" have=""
        want=$(grep '^# Bundle: sha256=' "$1" 2>/dev/null | head -n1)
        have="# Bundle: sha256=$($EXAMINE_FILE_SHA256 "$2" 2>/dev/null) bytes=$(wc -c 2>/dev/null < "$2" | tr -d ' ')"
        if test "$want" = "$have"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" log 'seal verify: $(basename "$2") is the bundle $1 names (${have#\# Bundle: })'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'seal verify: MISMATCHED PAIR -- $1 does not name this bundle' '(dump says   ${want#\# Bundle: })' '(bundle is   ${have#\# Bundle: })'"
        fi
}
#@help __incoming_clear1
# @command incoming clear <directory>
# @completion directory files
# @summary Empty one scratch directory under $VPN_SWITCH_ROOT/incoming/ -- import's own unpacking area, cleared before each extract so a re-import never trips over the last one. The path lies below incoming/ and carries no '..': rewrite to 'incoming remove', else an error line (only import's own scratch is cleared here, never a database)
# @group   database
# @see     extract
# @see     import
#@end
__incoming_clear1() {
        if test "${1#"$VPN_SWITCH_ROOT"/incoming/}" != "$1" && test "${1%%..*}" = "$1"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" incoming remove '$1'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'incoming clear: not below $VPN_SWITCH_ROOT/incoming (or carrying ..): $1' '(only the scratch of import is cleared here, never a database)'"
        fi
}
#@help _incoming_remove1
# @command incoming remove <directory>
# @summary Act terminal: rm -rf of the scratch directory
# @group   database
# @internal
# @see     incoming clear
#@end
_incoming_remove1() {
        emit_note "incoming clear: $1"
        printf '%s\n' "rm -rf '$1'"
}
#@help ___extract2
# @command extract <archive> <destination>
# @completion archive files
# @completion destination files
# @summary Unpack an archive into a scratch directory with VPN_SWITCH_EXTRACTOR: the archive readable, the extractor set, the destination absolute and empty (or not yet there); then 'extract unpack'
# @group   database
# @env     VPN_SWITCH_EXTRACTOR  the unpacking template; $a is the archive, $d the destination
# @example vpn-switch extract ~/.vpn-switch/bundle/a1b2c3d.tar.gz /tmp/incoming
# @see     bundle
# @see     import
#@end
___extract2() {
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" bundle readable '$1'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" extractor set"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" extract destination absolute '$2'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" extract destination empty '$2'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" extract unpack '$1' '$2'"
}
#@help __extractor_set0
# @command extractor set
# @summary VPN_SWITCH_EXTRACTOR is set: a comment line, else an error line (environment init <profile>)
# @group   database
# @internal
# @env     VPN_SWITCH_EXTRACTOR  the unpacking template
# @see     extract
#@end
__extractor_set0() {
        if test -n "${VPN_SWITCH_EXTRACTOR:-}"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" comment 'extractor set'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'extract: VPN_SWITCH_EXTRACTOR not set (environment init <profile>)'"
        fi
}
#@help __extract_destination_absolute1
# @command extract destination absolute <destination>
# @summary The destination path is absolute: a comment line, else an error line
# @group   database
# @internal
# @see     extract
#@end
__extract_destination_absolute1() {
        if test "${1#/}" != "$1"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" comment 'destination $1 absolute'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'extract: destination must be an absolute path: $1'"
        fi
}
#@help __extract_destination_empty1
# @command extract destination empty <destination>
# @summary The destination is empty or not there yet: a comment line, else an error line (choose an empty or new directory)
# @group   database
# @internal
# @see     extract
#@end
__extract_destination_empty1() {
        if test -z "$(ls -A "$1" 2>/dev/null)"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" comment 'destination $1 empty'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'extract: destination not empty: $1 (choose an empty or new directory)'"
        fi
}
#@help _extract_unpack2
# @command extract unpack <archive> <destination>
# @summary Act terminal: the unpacking script -- the destination directory, $a and $d for the VPN_SWITCH_EXTRACTOR template, the template
# @group   database
# @internal
# @env     VPN_SWITCH_EXTRACTOR  the unpacking template; $a is the archive, $d the destination
# @see     extract
#@end
_extract_unpack2() {
        printf '%s\n' "$MODIFY_DIR_CREATE '$2'"
        printf "a='%s'\n" "$1"
        printf "d='%s'\n" "$2"
        printf '%s\n' "$VPN_SWITCH_EXTRACTOR"
        emit_note "extracted $1 -> $2"
}
#@help __import2
# @command import <dump> <bundle>
# @completion dump files
# @completion bundle files
# @summary Replay an exported pair into the current database, checked end to end BEFORE anything lands, cheapest first, every detail read ONCE on the way in and handed down: the dump's serial, the pinned signer, the dump's signature (gpg once), the signer's floor, this database's serial; then 'import <dump> <bundle> <serial> <key> <fpr> <floor> <cur>' -- the seal (this bundle is the one the dump names), the bundle unpacked into import's own scratch under incoming/, its MANIFEST (pinned signer, every hash), the receipt filed BEFORE the replay (the replay runs keep-going, so a redacted pair's withheld elements cost no receipt), the replay. ONLY into an EMPTY database (a fresh bootstrap with the attest key pinned): on a database that already holds the configs the replay reports them as existing and goes on
# @group   database
# @param   dump    the dump of the pair (its signature is <dump>.asc)
# @param   bundle  the bundle the dump's seal names
# @env     VPN_SWITCH_ARCHIVE_ATTEST_KEY  the openpgp record naming the signer both artifacts must carry
# @example vpn-switch import ~/git/config/dump.sh ~/.vpn-switch/bundle/a1b2c3d.tar.gz
# @see     export
# @see     restore
# @see     provenance add
#@end
__import2() {
        local serial=""
        serial=$(sed -n 's/^# Serial: //p' "$1" 2>/dev/null | head -n1)
        if ! test -d "$VPN_SWITCH_BASE/.env"; then	# no database: the base directory itself appears with the first command (.tmp, .log are scratch)
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" import bootstrap '$1' '$2'"
        elif ! test -r "$1"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'import: dump file not found or not readable: $1'"
        elif printf '%s\n' "$serial" | grep -qx '[0-9][0-9]*'; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" import '$1' '$2' '$serial'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'import: dump carries no numeric # Serial: header: $1'"
        fi
}
#@help __import_bootstrap2
# @command import bootstrap <dump> <bundle>
# @completion dump files
# @completion bundle files
# @summary Import into a database that is not there (no .env layer under VPN_SWITCH_BASE): the dump is readable and signed, names its profile ('# Profile:' in its header) and carries the openpgp record of its signer ('openpgp add <name> <keyid> [<gnupghome>]'); the signature is verified against the keyring that record names -- an absolute gnupghome that exists here, else YOUR default keyring (a gnupghome inside the database travels in the bundle and serves after the import, not before); then 'import bootstrap <dump> <bundle> <profile> <record> <fingerprint> [<gnupghome>]'. The trust is the keyring's: the first signer a fresh database meets is one whose public key you hold
# @group   database
# @example vpn-switch import bootstrap ~/.elebake/db/.resource/vpn-switch/dump.sh ~/.elebake/db/.resource/vpn-switch/bundle.tar.gz
# @see     import
# @see     bootstrap
#@end
__import_bootstrap2() {
        local pat='^"\$VPN_SWITCH_CONTEXT_SCRIPT" openpgp add ' profile="" tmp="" line="" name="" keyid="" gh="" status="" fpr="" pfpr="" rec="" rgh="" why="" seen=0
        profile=$(sed -n 's/^# Profile: //p' "$1" 2>/dev/null | head -n1)
        tmp="${TMPDIR:-/tmp}/import-bootstrap.$$"
        grep "$pat" "$1" > "$tmp" 2>/dev/null
        if test -r "$1" && test -f "$1.asc"; then
                while IFS= read -r line; do
                        seen=1
                        line=${line#*openpgp add }
                        name=$(printf '%s' "$line" | sed -n "s/^'\([^']*\)' .*/\1/p")
                        keyid=$(printf '%s' "$line" | sed -n "s/^'[^']*' '\([^']*\)'.*/\1/p" | sed 's/^0[xX]//' | tr 'a-f' 'A-F')
                        gh=$(printf '%s' "$line" | sed -n "s/^'[^']*' '[^']*' ['\"]\([^'\"]*\)['\"].*/\1/p")
                        case "$gh" in '$'*) gh="" ;; esac	# a keyring rebased into the database: it arrives with the bundle
                        test -z "$gh" || test -d "$gh" || continue
                        if test -n "$gh"; then
                                status=$(GNUPGHOME="$gh" gpg --batch --status-fd 1 --verify "$1.asc" "$1" 2>>"${LOG_FILE:-/dev/null}")
                        else
                                status=$(gpg --batch --status-fd 1 --verify "$1.asc" "$1" 2>>"${LOG_FILE:-/dev/null}")
                        fi
                        printf '%s\n' "$status" >>"${LOG_FILE:-/dev/null}"
                        fpr=$(printf '%s\n' "$status" | awk '/^\[GNUPG:\] VALIDSIG /{print $3; exit}')
                        pfpr=$(printf '%s\n' "$status" | awk '/^\[GNUPG:\] VALIDSIG /{print $NF; exit}')
                        case "$status" in
                                *"[GNUPG:] BADSIG"*)    why="BAD SIGNATURE -- file or signature altered" ;;
                                *"[GNUPG:] NO_PUBKEY"*) why="signer public key not in the keyring${gh:+ $gh}" ;;
                        esac
                        test -n "$fpr" || continue
                        case "$fpr|$pfpr|" in *"$keyid|"*) rec=$name; rgh=$gh; break ;; esac
                done < "$tmp"
        fi
        rm -f "$tmp"
        if ! test -r "$1"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'import: dump file not found or not readable: $1'"
        elif ! test -f "$1.asc"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'import bootstrap: unsigned: no $1.asc (no database yet, so the signature is the only trust)'"
        elif test -z "$profile"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'import bootstrap: the dump names no profile (# Profile: in its header) -- bootstrap yourself, then import'"
        elif test "$seen" = 0; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'import bootstrap: the dump carries no openpgp record of its signer (openpgp add <name> <keyid>) -- bootstrap yourself, pin the key, then import'"
        elif test -z "$rec"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error $(sq "import bootstrap: $1.asc does not verify against the keyring any of its openpgp records names${why:+ ($why)} -- gpg --import the signer, or bootstrap yourself, pin the key, then import")"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" import bootstrap '$1' '$2' '$profile' '$rec' '$fpr'${rgh:+ '$rgh'}"
        fi
}

#@help ___import_bootstrap5
# @internal 'import bootstrap <dump> <bundle> <profile> <record> <fingerprint>': the database bootstrapped (at VPN_SWITCH_BASE) with the profile, the terminal interpreter pinned to sh (an import is asked for: its acts run; the dump's epilogue sets the source's pins after), the signer pinned under the record name, VPN_SWITCH_ARCHIVE_ATTEST_KEY set, then 'import <dump> <bundle>' -- every line a FRESH invocation (env -u: the loaded environment dropped; bootstrap takes main's own path as if typed, the lines after it read the environment of the database just made -- a batch's children would inherit the shipped baseline, terminal cat), the batch under sh -e (VPN_SWITCH_INTERPRETER_import_bootstrap: no database, no batch ring, fail-fast)
#@end
___import_bootstrap5() {
        printf '%s\n' "env -u VPN_SWITCH_CONTEXT_BOOTSTRAPPED -u VPN_SWITCH_CACHE_ENV_ARGS \"\$VPN_SWITCH_CONTEXT_SCRIPT\" bootstrap '$VPN_SWITCH_BASE' '$3'"
        printf '%s\n' "env -u VPN_SWITCH_CONTEXT_BOOTSTRAPPED -u VPN_SWITCH_CACHE_ENV_ARGS \"\$VPN_SWITCH_CONTEXT_SCRIPT\" setenv VPN_SWITCH_TERMINAL_INTERPRETER sh"
        printf '%s\n' "env -u VPN_SWITCH_CONTEXT_BOOTSTRAPPED -u VPN_SWITCH_CACHE_ENV_ARGS \"\$VPN_SWITCH_CONTEXT_SCRIPT\" openpgp add '$4' '$5'"
        printf '%s\n' "env -u VPN_SWITCH_CONTEXT_BOOTSTRAPPED -u VPN_SWITCH_CACHE_ENV_ARGS \"\$VPN_SWITCH_CONTEXT_SCRIPT\" setenv VPN_SWITCH_ARCHIVE_ATTEST_KEY '$4'"
        printf '%s\n' "env -u VPN_SWITCH_CONTEXT_BOOTSTRAPPED -u VPN_SWITCH_CACHE_ENV_ARGS \"\$VPN_SWITCH_CONTEXT_SCRIPT\" import '$1' '$2'"
}
#@help ___import_bootstrap6
# @internal 'import bootstrap <dump> <bundle> <profile> <record> <fingerprint> <gnupghome>': as the 5-argument form, the record pinned with its gnupghome (the keyring the signature verified against)
#@end
___import_bootstrap6() {
        printf '%s\n' "env -u VPN_SWITCH_CONTEXT_BOOTSTRAPPED -u VPN_SWITCH_CACHE_ENV_ARGS \"\$VPN_SWITCH_CONTEXT_SCRIPT\" bootstrap '$VPN_SWITCH_BASE' '$3'"
        printf '%s\n' "env -u VPN_SWITCH_CONTEXT_BOOTSTRAPPED -u VPN_SWITCH_CACHE_ENV_ARGS \"\$VPN_SWITCH_CONTEXT_SCRIPT\" setenv VPN_SWITCH_TERMINAL_INTERPRETER sh"
        printf '%s\n' "env -u VPN_SWITCH_CONTEXT_BOOTSTRAPPED -u VPN_SWITCH_CACHE_ENV_ARGS \"\$VPN_SWITCH_CONTEXT_SCRIPT\" openpgp add '$4' '$5' '$6'"
        printf '%s\n' "env -u VPN_SWITCH_CONTEXT_BOOTSTRAPPED -u VPN_SWITCH_CACHE_ENV_ARGS \"\$VPN_SWITCH_CONTEXT_SCRIPT\" setenv VPN_SWITCH_ARCHIVE_ATTEST_KEY '$4'"
        printf '%s\n' "env -u VPN_SWITCH_CONTEXT_BOOTSTRAPPED -u VPN_SWITCH_CACHE_ENV_ARGS \"\$VPN_SWITCH_CONTEXT_SCRIPT\" import '$1' '$2'"
}

#@help __import3
# @internal 'import <dump> <bundle> <serial>': the pinned attest key -> 'import ... <key>', else an error line
# @env     VPN_SWITCH_ARCHIVE_ATTEST_KEY  the openpgp record naming the pinned signer
#@end
__import3() {
        local key="${VPN_SWITCH_ARCHIVE_ATTEST_KEY:-}" keyid=""
        keyid=$(head -n1 "$VPN_SWITCH_BASE/openpgp/${key:-.}/keyid" 2>/dev/null | sed 's/^0[xX]//' | tr 'a-f' 'A-F')
        case "$keyid" in
                ????????????????*) case "$keyid" in *[!0-9A-F]*) keyid="" ;; esac ;;
                *) keyid="" ;;
        esac
        if test -n "$key" && test -n "$keyid"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" import '$1' '$2' '$3' '$key'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'VPN_SWITCH_ARCHIVE_ATTEST_KEY not set or its openpgp record incomplete (a keyid of 16+ hex digits; openpgp add <name> <fingerprint>; setenv VPN_SWITCH_ARCHIVE_ATTEST_KEY <name>)'"
        fi
}
#@help __import4
# @internal 'import <dump> <bundle> <serial> <key>': the signer of <dump>.asc, gpg once -> 'import ... <fpr>', else an error line with the reason
#@end
__import4() {
        local keyid="" gh="" status="" fpr="" pfpr="" why=""
        keyid=$(head -n1 "$VPN_SWITCH_BASE/openpgp/$4/keyid" 2>/dev/null | sed 's/^0[xX]//' | tr 'a-f' 'A-F')
        gh=$(head -n1 "$VPN_SWITCH_BASE/openpgp/$4/gnupghome" 2>/dev/null)
        if ! test -f "$1.asc"; then
                why="unsigned: no $1.asc"
        elif test -n "$gh"; then
                status=$(GNUPGHOME="$gh" gpg --batch --status-fd 1 --verify "$1.asc" "$1" 2>>"${LOG_FILE:-/dev/null}")
        else
                status=$(gpg --batch --status-fd 1 --verify "$1.asc" "$1" 2>>"${LOG_FILE:-/dev/null}")
        fi
        printf '%s\n' "$status" >>"${LOG_FILE:-/dev/null}"
        fpr=$(printf '%s\n' "$status" | awk '/^\[GNUPG:\] VALIDSIG /{print $3; exit}')
        pfpr=$(printf '%s\n' "$status" | awk '/^\[GNUPG:\] VALIDSIG /{print $NF; exit}')
        test -n "$why" || case "$status" in
                *"[GNUPG:] NO_PUBKEY"*) why="signer public key not in the keyring${gh:+ $gh}" ;;
                *"[GNUPG:] BADSIG"*)    why="BAD SIGNATURE -- file or signature altered" ;;
                *"[GNUPG:] REVKEYSIG"*) why="signed by a REVOKED key" ;;
                *"[GNUPG:] EXPKEYSIG"*) why="signed by an EXPIRED key" ;;
                *"[GNUPG:] EXPSIG"*)    why="signature itself has expired" ;;
                *"[GNUPG:] GOODSIG"*)   case "$fpr|$pfpr|" in *"$keyid|"*) ;; *) why="signed by a DIFFERENT key: $fpr (expected ...$keyid)" ;; esac ;;
                *) why="no good signature (see the log for gpg status)" ;;
        esac
        if test -z "$why"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" import '$1' '$2' '$3' '$4' '$fpr'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error $(sq "import: $why") '(file $1, expected signer: openpgp record $4)'"
        fi
}
#@help __import5
# @internal 'import <dump> <bundle> <serial> <key> <fpr>': the signer's highest receipt here -> 'import ... <floor>'
#@end
__import5() {
        local r="" s="" floor=0
        for r in "$VPN_SWITCH_BASE"/provenance/*/; do
                test "$(head -n1 "$r/signer" 2>/dev/null)" = "$5" || continue
                s=$(head -n1 "$r/serial" 2>/dev/null)
                case "$s" in ''|*[!0-9]*) continue ;; esac
                test "$s" -le "$floor" || floor=$s
        done
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" import '$1' '$2' '$3' '$4' '$5' '$floor'"
}
#@help __import6
# @internal 'import <dump> <bundle> <serial> <key> <fpr> <floor>': this database's export serial -> 'import ... <cur>'
#@end
__import6() {
        local cur=""
        cur=$(head -n1 "$VPN_SWITCH_BASE/export/serial" 2>/dev/null)
        case "$cur" in ''|*[!0-9]*) cur=0 ;; esac
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" import '$1' '$2' '$3' '$4' '$5' '$6' '$cur'"
}
#@help ___import7
# @internal the import with every detail read: seal verify, incoming clear, extract, manifest verify, provenance add, restore v1
#@end
___import7() {
        local inc="$VPN_SWITCH_ROOT/incoming/$(basename "$2" | sed 's/\.[a-z.]*$//')"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" seal verify '$1' '$2'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" incoming clear '$inc'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" extract '$2' '$inc'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" manifest verify '$inc/export/MANIFEST' '$inc' '$4'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" provenance add '$1' '$2' '$3' '$4' '$5' '$6' '$7'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" restore v1 '$1' '$inc' '$3' '$4' '$5' '$6'"
}
