#!/bin/sh
# helpenv.sh - Documentation access for environment variables + interpreter sugar
#
# Surfaces the documentation that lives in template/environment/<VAR> (and the
# DB-activated copies under .env/{local,default}). Each such file holds the
# effective value on line 1 and hand-written docs on lines 2+. getenv shows only
# line 1; helpenv shows the value PLUS the documentation, honouring the same
# local -> default -> template cascade (via the shared _env_resolve_file in
# database.sh, so the two can never drift).
#
# Commands:
#   helpenv                       list documented variables
#   helpenv <name>                show value + docs (effective location)
#   helpenv <name> <location>     show from a specific layer (local|default|template)
#
#   <name> resolves by cascade: literal -> VPN_SWITCH_<name> -> VPN_SWITCH_INTERPRETER_<name>
#
# Interpreter sugar. The <fn> token is resolved by _intp_var: the three class
# defaults (terminal | combinator | batch[_combinator], any case) map to
# VPN_SWITCH_<CLASS>_INTERPRETER; anything else is a per-function override named
# VPN_SWITCH_INTERPRETER_<fn> (the <fn> carries its arity digit, e.g. helpenv0).
#   setintp  <fn> <value>         = setenv  <resolved> <value>
#   getintp  <fn>                 = getenv  <resolved>
#   helpintp <fn> [location]      = helpenv <resolved> [location]

#@help _helpenv0
# @command helpenv [<name> [location]]
# @summary Show env-var documentation (value + docs); with no argument, list all
# @group configuration
# @param name      variable name (full, or short for VPN_SWITCH_ / VPN_SWITCH_INTERPRETER_)
# @param location  optional layer to inspect: local | default | template
# @example vpn-switch helpenv
# @example vpn-switch helpenv VPN_SWITCH_EXT_IF
# @example vpn-switch helpenv wireguard_start template
# @see getenv
# @see helpintp
#@end
_helpenv0() {
  local base="$VPN_SWITCH_BASE"
  # Terminal: emit final text directly (default terminal interpreter is 'cat').
  echo "Documented environment variables — show one with: helpenv <name>"
  echo ""
  {
    ls "$VPN_SWITCH_TEMPLATE_DIR/environment" 2>/dev/null
    [ -d "$base/.env/default" ] && ls "$base/.env/default" 2>/dev/null
    [ -d "$base/.env/local" ]   && ls "$base/.env/local" 2>/dev/null
  } | sort -u | sed 's/^/  /'
}

#@help __helpenv1
# @internal arity-1 of 'helpenv' (name cascade + resolve effective layer, delegate)
#@end
__helpenv1() {
  local arg="$1" var="" cand layer
  # Name cascade: literal -> VPN_SWITCH_<arg> -> VPN_SWITCH_INTERPRETER_<arg>
  for cand in "$arg" "VPN_SWITCH_$arg" "VPN_SWITCH_INTERPRETER_$arg"; do
    if _env_resolve_file "$cand" >/dev/null 2>&1; then var="$cand"; break; fi
  done
  if [ -z "$var" ]; then
    echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error \"No documented environment variable: $arg\""
    return 0
  fi
  # Resolve the effective layer and delegate to the 2-arg terminal renderer.
  layer=$(_env_resolve_file "$var" | sed -n 1p)
  echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" helpenv $var $layer"
}

#@help _helpenv2
# @internal arity-2 of 'helpenv' (render docs from a forced layer)
#@end
_helpenv2() {
  local var="$1" location="${2:-}"
  local resolved layer path label

  # Terminal: emit final text directly (default terminal interpreter is 'cat').
  if ! resolved=$(_env_resolve_file "$var" "$location"); then
    if [ -n "$location" ]; then
      echo "# $var: no value in location: $location"
    else
      echo "# Variable $var not found"
    fi
    return 0
  fi
  layer=$(printf '%s\n' "$resolved" | sed -n 1p)
  path=$(printf '%s\n' "$resolved" | sed -n 2p)
  case "$layer" in
    local)    label=".env/local/$var (override)" ;;
    default)  label=".env/default/$var (default)" ;;
    template) label="template/environment/$var (template)" ;;
  esac

  echo "# Source: $label"
  echo "$var = $(head -n 1 "$path")"
  echo ""
  # Documentation: lines 2+, stop at '# @internal', render @tags as labelled
  # sections and everything else as prose (leading '# ' stripped).
  tail -n +2 "$path" | awk '
    /^#[ \t]*@internal/ { exit }
    {
      line=$0
      sub(/^#[ \t]?/,"",line)
      if (sub(/^@summary[ \t]+/,"",line))  { print "Summary:  " line; next }
      if (sub(/^@default[ \t]+/,"",line))  { print "Default:  " line; next }
      if (sub(/^@values[ \t]+/,"",line))   { print "Values:   " line; next }
      if (sub(/^@example[ \t]+/,"",line))  { print "Example:  " line; next }
      if (sub(/^@see[ \t]+/,"",line))      { print "See also: " line; next }
      if (line ~ /^@/)                     { next }
      print line
    }'
}

# _intp_var - resolve an interpreter token to its full env-var name.
# Class defaults (terminal | combinator | batch | batch_combinator, any case)
# map to VPN_SWITCH_<CLASS>_INTERPRETER; everything else is a per-function
# override named VPN_SWITCH_INTERPRETER_<fn>. Plain helper (no trailing arity
# digit, no @help) so it is not classified as a dispatchable command.
_intp_var() {
  case "$(printf '%s' "$1" | tr 'A-Z' 'a-z')" in
    terminal)               echo "VPN_SWITCH_TERMINAL_INTERPRETER" ;;
    combinator)             echo "VPN_SWITCH_COMBINATOR_INTERPRETER" ;;
    batch|batch_combinator) echo "VPN_SWITCH_BATCH_COMBINATOR_INTERPRETER" ;;
    *)                      echo "VPN_SWITCH_INTERPRETER_$1" ;;
  esac
}

#@help __setintp2
# @command setintp <fn> <value>
# @summary Set an interpreter (shortcut for setenv of the resolved interpreter var)
# @group configuration
# @param fn     class default (terminal|combinator|batch) or function name (e.g. wireguard_start0)
# @param value  interpreter command
# @example vpn-switch setintp terminal 'cut -b3- | sh'
# @example vpn-switch setintp wireguard_start0 'sudo sh'
# @see getintp
# @see setenv
#@end
__setintp2() {
  local fn="$1" val="$2" q
  q=$(printf '%s\n' "$val" | sed "s/'/'\\\\''/g; s/^/'/; s/\$/'/")
  echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" setenv $(_intp_var "$fn") $q"
}

#@help __getintp1
# @command getintp <fn>
# @summary Show an interpreter (shortcut for getenv of the resolved interpreter var)
# @group configuration
# @param fn  class default (terminal|combinator|batch) or function name (e.g. wireguard_start0)
# @example vpn-switch getintp terminal
# @example vpn-switch getintp wireguard_start0
# @see setintp
#@end
__getintp1() {
  echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" getenv $(_intp_var "$1")"
}

#@help __helpintp1
# @command helpintp <fn> [location]
# @summary Show docs for an interpreter variable (class default or per-function)
# @group configuration
# @param fn        class default (terminal|combinator|batch) or function name (e.g. wireguard_start0)
# @param location  optional layer to inspect: local | default | template
# @example vpn-switch helpintp terminal
# @example vpn-switch helpintp helpenv0 template
# @see helpenv
# @see setintp
#@end
__helpintp1() {
  echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" helpenv $(_intp_var "$1")"
}

#@help __helpintp2
# @internal arity-2 of 'helpintp' (forced layer)
#@end
__helpintp2() {
  echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" helpenv $(_intp_var "$1") $2"
}
