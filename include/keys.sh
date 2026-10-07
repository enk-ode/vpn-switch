#!/bin/sh
#
# SPDX-License-Identifier: BSD-2-Clause
#
# Copyright (c) 2026 Dr. Johannes Brügmann
# vpn-switch keys - what a key backend (openpgp) needs: the
# record name rule, the import of an extra file into a record, the file
# list of a record for an archive. The backend rewrites to these lines
# with its own name first ('key import pem ...'); the records differ
# only in their schema files, which travel as the backend's add replay.
#
# ARCHITECTURE: every check is a combinator line (a comment line, else an
# error line) in front of one act terminal; the record holds public
# material and references only.

#@help __key_name_valid1
# @command key name valid <name>
# @summary The key record name is a record name ([A-Za-z0-9_.-], not . or ..): a comment line, else an error line
# @group   keys
# @internal
# @see     openpgp add
#@end
__key_name_valid1() {
        if key_name_ok "$1"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" comment 'key name $1 valid'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'invalid key name $1 ([A-Za-z0-9_.-])'"
        fi
}

#@help ___key_import3
# @command key import <backend> <name> <absfile>
# @completion backend none
# @completion name files
# @completion absfile files
# @summary Copy ONE extra file into a key record: the record exists, the source is an absolute existing file or symlink; then 'key import copy'
# @group   keys
# @internal
# @see     openpgp import
#@end
___key_import3() {
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" key record exists '$1' '$2'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" base element exists '$3'"
        printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" key import copy '$1' '$2' '$3'"
}

#@help __base_element_exists1
# @command base element exists <absfile>
# @summary The base element is an absolute path to an existing file or symlink in the OTHER database: a comment line, else an error line
# @group   keys
# @internal
# @see     key import
# @see     provenance import
#@end
__base_element_exists1() {
        if test "${1#/}" != "$1" && { test -L "$1" || test -f "$1"; }; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" comment 'base element $1 exists'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'no such file: $1'"
        fi
}

#@help _key_import_copy3
# @command key import copy <backend> <name> <absfile>
# @summary Act terminal: rm -f and cp -Pp of the file into the record (idempotent; a link stays a link)
# @group   keys
# @internal
# @see     key import
#@end
_key_import_copy3() {
        printf '%s\n' "rm -f '$VPN_SWITCH_BASE/$1/$2/${3##*/}' && cp -Pp '$3' '$VPN_SWITCH_BASE/$1/$2/' || { printf '# Error: %s import failed\\n' '$1' >&2; exit 1; }"
}

#@help _key_collect_files2
# @command key collect files <backend> <name>
# @summary Text terminal: the files of one key record by their real path, written against "$VPN_SWITCH_ARCHIVE_BASE"
# @group   keys
# @internal
# @see     openpgp collect
#@end
_key_collect_files2() {
        printf '# %s %s\n' "$1" "$2"
        find "$VPN_SWITCH_BASE/$1/$2" \( -type f -o -type l \) 2>/dev/null | sort | sed "s|^$VPN_SWITCH_BASE/|\"\$VPN_SWITCH_ARCHIVE_BASE\"/|"
}


#@help __key_record_exists2
# @command key record exists <backend> <name>
# @summary The key record <backend>/<name> is registered: a comment line, else an error line
# @group   keys
# @internal
#@end
__key_record_exists2() {
        if test -e "$VPN_SWITCH_BASE/$1/$2"; then
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" comment 'key $1/$2 registered'"
        else
                printf '%s\n' "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error 'unknown key $1/$2 (register it with: $1 add)'"
        fi
}
