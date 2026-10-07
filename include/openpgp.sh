#!/bin/sh
#
# SPDX-License-Identifier: BSD-2-Clause
#
# Copyright (c) 2026 Dr. Johannes Brügmann
# vpn-switch openpgp - OpenPGP (GnuPG) attest-key registry (ported from elebake).
#
# The key backend. Used to ATTEST a dump and a bundle's MANIFEST
# (detached GPG signature). openpgp/<name>/ holds only the key reference
# (keyid, and the gnupghome for a keyring living elsewhere -- secboot.sh keeps
# the manifest key in /root/secureboot/manifest/.gnupg; every consumer derives
# a GNUPGHOME= prefix from it).
#
# ARCHITECTURE: every check is a combinator line (a comment line, else an
# error line) in front of one act terminal; the record holds public
# material and references only.

#@help ___openpgp_add2
# @internal arity-2 sibling of 'openpgp add' (openpgp add <name> <keyid>): Register a GnuPG attest key of the default keyring: the name is a record name, the keyid is hex; then 'openpgp record'
#@end
___openpgp_add2() {
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" key name valid '$1'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" openpgp keyid valid '$2'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" openpgp record '$1' '$2'"
}

#@help ___openpgp_add3
# @command openpgp add <name> <keyid> [<gnupghome>]
# @completion name files
# @completion keyid none
# @completion gnupghome files
# @summary Register a GnuPG attest key; gnupghome for a keyring living elsewhere: the name is a record name, the keyid is hex; then 'openpgp record'
# @group   keys
# @param   name       record name (VPN_SWITCH_ARCHIVE_ATTEST_KEY names it)
# @param   keyid      long key id (16 hex digits) or fingerprint
# @param   gnupghome  GnuPG home holding the key (e.g. /root/secureboot/manifest/.gnupg)
# @example vpn-switch openpgp add attest-v1 0123456789ABCDEF /root/secureboot/manifest/.gnupg
# @see     openpgp prerequisites
#@end
___openpgp_add3() {
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" key name valid '$1'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" openpgp keyid valid '$2'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" openpgp record '$1' '$2' '$3'"
}

#@help __openpgp_keyid_valid1
# @command openpgp keyid valid <keyid>
# @summary The key id is 8, 16 or 40 hex digits (short id, long id, fingerprint): a comment line, else an error line
# @group   keys
# @internal
# @see     openpgp add
#@end
__openpgp_keyid_valid1() {
        if keyid_ok "$1"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" comment 'keyid $1 valid'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'openpgp add: keyid must be hex (16 digits, or the 40-digit fingerprint): $1'"
        fi
}

#@help _openpgp_record2
# @internal arity-2 sibling of 'openpgp record' (openpgp record <name> <keyid>): Act terminal: write openpgp/<name>/keyid (0700/0600) and say so
#@end
_openpgp_record2() {
        printf '%s\n' "$MODIFY_DIR_CREATE '$VPN_SWITCH_BASE/openpgp/$1'"
        printf '%s\n' "$MODIFY_FILE_PERMS 0700 '$VPN_SWITCH_BASE/openpgp/$1'"
        printf '%s\n' "echo '$2' > '$VPN_SWITCH_BASE/openpgp/$1/keyid'"
        printf '%s\n' "$MODIFY_FILE_PERMS 0600 '$VPN_SWITCH_BASE/openpgp/$1/keyid'"
        printf '%s\n' "printf '# Registered openpgp key %s\\n' '$1' >&2"
}

#@help _openpgp_record3
# @command openpgp record <name> <keyid> <gnupghome>
# @summary Act terminal: write openpgp/<name>/keyid and gnupghome (0700/0600) and say so
# @group   keys
# @internal
# @see     openpgp add
#@end
_openpgp_record3() {
        printf '%s\n' "$MODIFY_DIR_CREATE '$VPN_SWITCH_BASE/openpgp/$1'"
        printf '%s\n' "$MODIFY_FILE_PERMS 0700 '$VPN_SWITCH_BASE/openpgp/$1'"
        printf '%s\n' "echo '$2' > '$VPN_SWITCH_BASE/openpgp/$1/keyid'"
        printf '%s\n' "echo '$3' > '$VPN_SWITCH_BASE/openpgp/$1/gnupghome'"
        printf '%s\n' "$MODIFY_FILE_PERMS 0600 '$VPN_SWITCH_BASE/openpgp/$1/keyid' '$VPN_SWITCH_BASE/openpgp/$1/gnupghome'"
        printf '%s\n' "printf '# Registered openpgp key %s (gnupghome %s)\\n' '$1' '$3' >&2"
}

#@help _openpgp_prerequisites0
# @command openpgp prerequisites
# @summary Act terminal: the runtime check of the GnuPG attest toolchain. No card requirement here: gpg is card-agnostic (a keyring stub routes to the card transparently), and a pure-keyring key needs no card at all
# @group   diagnostics
#@end
_openpgp_prerequisites0() {
        emit_note "openpgp prerequisites (detached GPG signature)"
        printf '%s\n' "command -v gpg >/dev/null 2>&1 || { printf '# Error: gpg not installed (pkg install gnupg)\\n' >&2; exit 1; }"
        printf '%s\n' "printf '# prerequisites ok: openpgp\\n' >&2"
}

#@help ___openpgp_dump0
# @command openpgp dump
# @summary Emit the openpgp portion of a database dump: one 'openpgp add' replay line per registered key, in the arity of the record (cat-pinned: dump TEXT, replayed by 'restore'), plus one 'openpgp import' per extra file; none is a comment line
# @group   keys
# @see     dump
#@end
___openpgp_dump0() {
        local rec="" n=0
        for rec in "$VPN_SWITCH_BASE"/openpgp/*/; do
                test -d "$rec" || continue
                n=$((n + 1))
                if test -f "$rec/gnupghome"; then
                        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" openpgp add '$(basename "$rec")' '$(head -n1 "$rec/keyid" 2>/dev/null)' $(rebase_db_path "$(head -n1 "$rec/gnupghome")")"
                else
                        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" openpgp add '$(basename "$rec")' '$(head -n1 "$rec/keyid" 2>/dev/null)'"
                fi
                backend_dump_extra_lines openpgp "$(basename "$rec")" keyid gnupghome
        done
        test "${n:-0}" -gt 0 || printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" comment 'no openpgp keys to dump'"
}

#@help __openpgp_import2
# @command openpgp import <name> <absfile>
# @completion name files
# @completion absfile files
# @summary Copy ONE extra file into the key record -- dump/restore base element (the schema files travel as the 'openpgp add' replay): rewrite to 'key import openpgp <name> <absfile>'
# @group   keys
# @param   absfile  absolute source path in the OTHER database
# @see     key import
#@end
__openpgp_import2() {
        if true; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" key import openpgp '$1' '$2'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" key import openpgp '$1' '$2'"
        fi
}

#@help ___openpgp_collect0
# @command openpgp collect
# @summary List the files of the openpgp key records that belong into an archive -- public material only; private key material stays a path promise into the world: one 'openpgp collect <key>' per record, none is a comment line
# @group   keys
# @see     collect
#@end
___openpgp_collect0() {
        local r="" n=0
        for r in "$VPN_SWITCH_BASE"/openpgp/*/; do
                test -d "$r" || continue
                n=$((n + 1))
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" openpgp collect '$(basename "$r")'"
        done
        test "${n:-0}" -gt 0 || printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" comment 'no openpgp keys to collect'"
}

#@help __openpgp_collect1
# @internal arity-1 sibling of 'openpgp collect' (openpgp collect <key>): The key record exists: rewrite to 'key collect files openpgp <key>', else an error line
#@end
__openpgp_collect1() {
        if test -d "$VPN_SWITCH_BASE/openpgp/$1"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" key collect files openpgp '$1'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'openpgp collect: no such key $1'"
        fi
}

