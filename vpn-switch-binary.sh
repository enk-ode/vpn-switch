#!/bin/sh
#
# SPDX-License-Identifier: BSD-2-Clause
#
# Copyright (c) 2026 Dr. Johannes Brügmann
#
# vpn-switch-binary.sh -- vpn-switch in ONE process. The runner of elvboot's
# elebake-binary.sh, mechanically: the same three modes, the same override,
# the names of this engine (VPN_SWITCH_*, vpn-switch.sh, main).
#
#   sh vpn-switch-binary.sh  <database> <command> [args...]   run the command
#   sh vpn-switch-binary.sh  <database> batch <file>          run a batch or dump
#   sh vpn-switch-compile.sh <database> <command> [args...]   write the script instead
#   sh vpn-switch-walkthrough.sh <database> <command> [args...]   show the tree, act on nothing
#
# The binary is vpn-switch.sh sourced: every anchor, the engine's main, its
# batch runner _batch2, the batch ring and the exit arithmetic are
# functions of this process (vpn-switch.sh's own main does not run -- $0 is
# not vpn-switch.sh). Three things differ from a run of vpn-switch.sh:
#
#   1. "$VPN_SWITCH_CONTEXT_SCRIPT" is the word main. A line an anchor
#      emits, eval'd in this process, calls the engine's main: the same
#      checks, the same process_arguments, the same 0 or 1 the child
#      process would have exited with.
#   2. env is a function: a line 'env NAME=value ... "$VPN_SWITCH_CONTEXT_SCRIPT" ...'
#      becomes a prefix assignment to the call; env with an option is the
#      program (run_env's env -).
#   3. process_arguments is overridden: resolve, dispatch into a file, hand
#      the emission on by pin -- cat prints; a batch combinator's lines go
#      through main batch, a combinator's one line through eval, both in
#      this process; a terminal pinned to sh runs in a subshell; any other
#      pin gets the file on stdin through run_env. Then combine_exit_codes,
#      the engine's, with the same arguments.
#
# Where this engine differs from elvboot's, the override says so in one
# line each: the resolution is to_function_call (printed, a capture), the
# pin is lookup_interpreter (a pipe), combine_exit_codes takes three
# arguments, there is no command alias.
#
# Three modes, chosen by the name this file is called by:
#   vpn-switch-binary.sh      -- INTERPRET: acts run at once, in a subshell.
#   vpn-switch-compile.sh     -- COMPILE: a terminal pinned to sh is written
#                                as a fragment; a check becomes 'main <words>
#                                || exit 1'; a redirecting batch line is
#                                written as it is.
#   vpn-switch-walkthrough.sh -- WALK: the tree as text, every act under its
#                                '# -- <anchor> <words>' line, checks
#                                answered now, nothing written.
#
# The environment: the cache file when the database has one (vpn-switch
# environment cache on), else one scan of .env at the start.

# ---------------------------------------------------------------- the binary
if [ -n "${ELV_SOURCED:-}" ]; then
        VPN_SWITCH_LIBDIR=$ELV_LIBDIR
        ELV_MODE=run
else
        VPN_SWITCH_LIBDIR=$(cd "$(dirname "$0")" && pwd)
        case "${0##*/}" in
        vpn-switch-compile.sh)     ELV_MODE=compile ;;
        vpn-switch-walkthrough.sh) ELV_MODE=walk ;;
        *)                         ELV_MODE=run ;;
        esac
        VPN_SWITCH_BASE=${1:?database}; shift
fi
VPN_SWITCH_CONTEXT_SCRIPT=main
VPN_SWITCH_CONTEXT_EXIT_BITS=${VPN_SWITCH_CONTEXT_EXIT_BITS:-0}
export VPN_SWITCH_LIBDIR VPN_SWITCH_BASE VPN_SWITCH_CONTEXT_SCRIPT VPN_SWITCH_CONTEXT_EXIT_BITS
. "$VPN_SWITCH_LIBDIR/vpn-switch.sh"      # metadata, engine, every module
eval "export $(build_env_args)"           # the cache file, else one scan
set +e                                    # vpn-switch.sh sets -e; here the exit codes are values
ELV_DEPTH=0
trap 'rm -f "$VPN_SWITCH_BASE"/.tmp/elv.$$.*' EXIT

env() {
        local pre="" cmd="" w
        case "${1:-}" in -*) command env "$@"; return ;; esac
        while [ $# -gt 0 ]; do
                case "$1" in
                [A-Za-z_]*=*)
                        case "${1%%=*}" in *[!A-Za-z0-9_]*) break ;; esac
                        q "${1#*=}"; pre="$pre ${1%%=*}=$Q"; shift ;;
                *)      break ;;
                esac
        done
        for w in "$@"; do q "$w"; cmd="$cmd $Q"; done
        eval "${pre# }$cmd"
}

# env_reload -- after an act that wrote the environment: the later calls of
# this process see it (a child process would have read it at its start).
env_reload() {
        eval "export $(build_env_args)"
}

only_comments() {
        local line
        while IFS= read -r line || [ -n "$line" ]; do
                case "$line" in ""|\#*) ;; *) return 1 ;; esac
        done < "$1"
        return 0
}

elv_batch() {
        local line
        if [ "$ELV_MODE" = run ]; then
                main batch "$1" true
                return
        fi
        while IFS= read -r line || [ -n "$line" ]; do
                case "$line" in
                ''|'#'*|*' > '*|*' >> '*) printf '%s\n' "$line" ;;
                *) eval "$line" ;;
                esac
        done < "$1"
}

elv_line() {
        local line file="$1" own="" w
        shift
        read -r line < "$file"
        case "$ELV_MODE:$line" in
        compile:'"$VPN_SWITCH_CONTEXT_SCRIPT" comment '*|compile:'"$VPN_SWITCH_CONTEXT_SCRIPT" error '*)
                for w in "$@"; do q "$w"; own="$own $Q"; done
                if [ "${VPN_SWITCH_BATCH_KEEP_GOING:-0}" = 1 ]; then
                        printf 'main%s || printf %s >&2\n' "$own" "'# failed: %s\\n' '$*'"
                else
                        printf 'main%s || exit 1\n' "$own"
                fi ;;
        *)      eval "$line" ;;
        esac
}

elv_act() {
        local file="$1" name="$2"
        shift 2
        if only_comments "$file"; then
                [ "$ELV_MODE" = run ] || cat "$file"
        elif [ "$ELV_MODE" = run ]; then
                ( . "$file" )
        elif [ "$ELV_MODE" = walk ]; then
                printf '# -- %s %s\n' "$name" "$*"
                cat "$file"
        else
                printf '# -- %s %s\n(\n' "$name" "$*"
                cat "$file"
                if [ "${VPN_SWITCH_BATCH_KEEP_GOING:-0}" = 1 ]; then
                        q "$*"; printf ') || printf %s >&2\n' "'# failed: %s\\n' $Q"
                else
                        printf ') || exit 1\n'
                fi
        fi
}

# process_arguments <word>... -- the engine's, without its pipeline.
process_arguments() {
        local bits="${VPN_SWITCH_CONTEXT_EXIT_BITS:-0}" call name pe ce=0 PIN
        local file="$VPN_SWITCH_BASE/.tmp/elv.$$.$ELV_DEPTH"
        call=$(to_function_call "$ANCHOR_FUNCTIONS" "$@"); name=${call%% *}
        export VPN_SWITCH_CONTEXT_CALL="$call"
        ELV_DEPTH=$((ELV_DEPTH + 1))
        dispatch < /dev/null > "$file"; pe=$?
        PIN=$(printf '%s\n' "$call" | lookup_interpreter)
        case "$PIN:$name" in
        cat:*)  cat "$file" ;;
        *:___*) elv_batch "$file"; ce=$? ;;
        *:__*)  elv_line "$file" "$@"; ce=$? ;;
        sh:*)   elv_act "$file" "$name" "$@"; ce=$? ;;
        *)      if [ "$ELV_MODE" = walk ]; then
                        printf '# -- %s %s (pin: %s)\n' "$name" "$*" "$PIN"
                        cat "$file"
                else
                        eval "run_env -- $PIN" < "$file"; ce=$?
                fi ;;
        esac
        ELV_DEPTH=$((ELV_DEPTH - 1))
        case "$name" in
        _setenv2|_unsetenv1|_environment_cache1|_env_sync0|_environment_init1) [ "$ELV_MODE" = run ] && env_reload ;;
        esac
        VPN_SWITCH_CONTEXT_CALL=$call
        combine_exit_codes "$bits" "$pe" "$ce"
}

# ------------------------------------------------------------------ main
[ -z "${ELV_SOURCED:-}" ] || return 0 2>/dev/null || exit 0
if [ "$ELV_MODE" = compile ]; then
        printf '#!/bin/sh\n# compiled by vpn-switch-compile.sh from: %s\n# database %s, %s\n' "$*" "$VPN_SWITCH_BASE" "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
        printf 'VPN_SWITCH_BASE=%s; export VPN_SWITCH_BASE\n' "$(sq "$VPN_SWITCH_BASE")"
        printf 'ELV_SOURCED=1; ELV_LIBDIR=%s; . %s          # main: the checks below ask the database when they run\n' "$(sq "$VPN_SWITCH_LIBDIR")" "$(sq "$VPN_SWITCH_LIBDIR/vpn-switch-binary.sh")"
        printf 'VPN_SWITCH_BATCH_KEEP_GOING=%s\n' "${VPN_SWITCH_BATCH_KEEP_GOING:-0}"
fi
main "$@"
