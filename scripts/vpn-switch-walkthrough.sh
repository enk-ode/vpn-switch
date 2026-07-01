#!/bin/sh
# vpn-switch-walkthrough.sh - Walk through command resolution chains
# === AUTO-GENERATED METADATA (make metadata) ===
# Generated: 2026-06-27 08:32:13
# Terminal functions (single underscore): output shell commands
# Combinator functions (double underscore): output single vpn-switch command
# Batch-combinator functions (triple underscore): output multiple vpn-switch commands
TERMINAL_FUNCTIONS="_session_create1 _interface_destroy1 _session_populate3 _phases_copy0 _env_sync0 _version_sync0 _version0 _link2 _remove1 _error1 _error2 _error3 _fail2 _log1 _log2 _log3  _lift1 _database_init0 _environment_init1 _environment_cache1 _lift3 _setenv2 _getenv1 _unsetenv1 _cat1 _batch2 _printenv0 _status0 _help0 _help1 _help2 _helpenv0 _helpenv2 _database_enumerate0 _system_inspect0 _logs_inspect0 _phases_inspect0 _summary_inspect0 _prologue_inspect0 _openvpn_patch2 _openvpn_configure1 _openvpn_connect1 _openvpn_disconnect1 _openvpn_patch1 _openvpn_enumerate0 _openvpn_import1 _openvpn_list0 _openvpn_list1 _openvpn_add1 _openvpn_add3 _openvpn_link2 _openvpn_remove1 _openvpn_remove2 _openvpn_validate0 _openvpn_info1 _session_list0 _session_show1 _session_remove1 _session_connect1 _session_save0 _session_save1 _session_clean0 _session_refresh0 _session_validate0 _session_enumerate0 _session_describe0 _logs_validate0 _logs_clean0 _phases_validate0 _database_validate0 _binaries_validate0 _network_validate0 _permissions_validate0 _environment_validate0 _install_validate0 _version_validate0 _sudo_validate0 _wireguard_patch2 _wireguard_configure1 _wireguard_connect1 _wireguard_disconnect1 _wireguard_enumerate0 _wireguard_import1 _wireguard_list0 _wireguard_list1 _wireguard_add1 _wireguard_add3 _wireguard_link2 _wireguard_remove1 _wireguard_remove2 _wireguard_validate0 _wireguard_patch1 _wireguard_info1"
COMBINATOR_FUNCTIONS="__session_exists1 __session_conflicts2 __interface_check1 __stop1 __import1 __start1 __start0  __bootstrap1 __environment_cache0 __phases_lift1 __init0 __batch1 __restore1 __helpenv1 __setintp2 __getintp1 __helpintp1 __helpintp2 __openvpn_start0 __openvpn_start1 __openvpn_stop1 __openvpn_add2 __openvpn_help0 __session_disconnect1 __session_stop1 __session_show0 __session_start0 __session_start1 __session_help0 __wireguard_start0 __wireguard_start1 __wireguard_stop1 __wireguard_add2 __wireguard_help0"
BATCH_COMBINATOR_FUNCTIONS="___session_prepare3 ___stop0 ___phases_sync1 ___phases_sync0 ___sync0 ___list0  ___bootstrap2 ___init1 ___dumpenv1 ___dump0 ___batch0 ___environment_inspect0 ___inspect0 ___openvpn_create1 ___openvpn_stop0 ___openvpn_inspect0 ___openvpn_clean0 ___openvpn_dump0 ___session_stop0 ___session_dump0 ___session_inspect0 ___validate0 ___wireguard_create1 ___wireguard_inspect0 ___wireguard_stop0 ___wireguard_clean0 ___wireguard_clean1 ___wireguard_dump0"
ANCHOR_FUNCTIONS="_session_create1 _interface_destroy1 _session_populate3 _phases_copy0 _env_sync0 _version_sync0 _version0 _link2 _remove1 _error1 _error2 _error3 _fail2 _log1 _log2 _log3  _lift1 _database_init0 _environment_init1 _environment_cache1 _lift3 _setenv2 _getenv1 _unsetenv1 _cat1 _batch2 _printenv0 _status0 _help0 _help1 _help2 _helpenv0 _helpenv2 _database_enumerate0 _system_inspect0 _logs_inspect0 _phases_inspect0 _summary_inspect0 _prologue_inspect0 _openvpn_patch2 _openvpn_configure1 _openvpn_connect1 _openvpn_disconnect1 _openvpn_patch1 _openvpn_enumerate0 _openvpn_import1 _openvpn_list0 _openvpn_list1 _openvpn_add1 _openvpn_add3 _openvpn_link2 _openvpn_remove1 _openvpn_remove2 _openvpn_validate0 _openvpn_info1 _session_list0 _session_show1 _session_remove1 _session_connect1 _session_save0 _session_save1 _session_clean0 _session_refresh0 _session_validate0 _session_enumerate0 _session_describe0 _logs_validate0 _logs_clean0 _phases_validate0 _database_validate0 _binaries_validate0 _network_validate0 _permissions_validate0 _environment_validate0 _install_validate0 _version_validate0 _sudo_validate0 _wireguard_patch2 _wireguard_configure1 _wireguard_connect1 _wireguard_disconnect1 _wireguard_enumerate0 _wireguard_import1 _wireguard_list0 _wireguard_list1 _wireguard_add1 _wireguard_add3 _wireguard_link2 _wireguard_remove1 _wireguard_remove2 _wireguard_validate0 _wireguard_patch1 _wireguard_info1 __session_exists1 __session_conflicts2 __interface_check1 __stop1 __import1 __start1 __start0  __bootstrap1 __environment_cache0 __phases_lift1 __init0 __batch1 __restore1 __helpenv1 __setintp2 __getintp1 __helpintp1 __helpintp2 __openvpn_start0 __openvpn_start1 __openvpn_stop1 __openvpn_add2 __openvpn_help0 __session_disconnect1 __session_stop1 __session_show0 __session_start0 __session_start1 __session_help0 __wireguard_start0 __wireguard_start1 __wireguard_stop1 __wireguard_add2 __wireguard_help0 ___session_prepare3 ___stop0 ___phases_sync1 ___phases_sync0 ___sync0 ___list0  ___bootstrap2 ___init1 ___dumpenv1 ___dump0 ___batch0 ___environment_inspect0 ___inspect0 ___openvpn_create1 ___openvpn_stop0 ___openvpn_inspect0 ___openvpn_clean0 ___openvpn_dump0 ___session_stop0 ___session_dump0 ___session_inspect0 ___validate0 ___wireguard_create1 ___wireguard_inspect0 ___wireguard_stop0 ___wireguard_clean0 ___wireguard_clean1 ___wireguard_dump0"
# Function-to-module mapping (format: "func:module.sh func:module.sh ...")
# Used by process_arguments() for deterministic module loading
FUNCTION_MODULES="__bootstrap1:database.sh ___bootstrap2:database.sh _lift1:database.sh _database_init0:database.sh _environment_init1:database.sh __environment_cache0:database.sh _environment_cache1:database.sh _lift3:database.sh __phases_lift1:database.sh ___init1:database.sh __init0:database.sh _setenv2:database.sh _getenv1:database.sh _unsetenv1:database.sh ___dumpenv1:database.sh ___dump0:database.sh _cat1:database.sh ___batch0:database.sh __batch1:database.sh _batch2:database.sh __restore1:database.sh _printenv0:database.sh _status0:help.sh _help0:help.sh _help1:help.sh _help2:help.sh _helpenv0:helpenv.sh __helpenv1:helpenv.sh _helpenv2:helpenv.sh __setintp2:helpenv.sh __getintp1:helpenv.sh __helpintp1:helpenv.sh __helpintp2:helpenv.sh _database_enumerate0:inspect.sh ___environment_inspect0:inspect.sh _system_inspect0:inspect.sh _logs_inspect0:inspect.sh _phases_inspect0:inspect.sh _summary_inspect0:inspect.sh _prologue_inspect0:inspect.sh ___inspect0:inspect.sh __openvpn_start0:openvpn.sh __openvpn_start1:openvpn.sh ___openvpn_create1:openvpn.sh _openvpn_patch2:openvpn.sh _openvpn_configure1:openvpn.sh _openvpn_connect1:openvpn.sh ___openvpn_stop0:openvpn.sh __openvpn_stop1:openvpn.sh _openvpn_disconnect1:openvpn.sh _openvpn_patch1:openvpn.sh ___openvpn_inspect0:openvpn.sh _openvpn_enumerate0:openvpn.sh _openvpn_import1:openvpn.sh _openvpn_list0:openvpn.sh _openvpn_list1:openvpn.sh _openvpn_add1:openvpn.sh __openvpn_add2:openvpn.sh _openvpn_add3:openvpn.sh _openvpn_link2:openvpn.sh _openvpn_remove1:openvpn.sh _openvpn_remove2:openvpn.sh _openvpn_validate0:openvpn.sh ___openvpn_clean0:openvpn.sh _openvpn_info1:openvpn.sh ___openvpn_dump0:openvpn.sh __openvpn_help0:openvpn.sh __session_disconnect1:session.sh ___session_stop0:session.sh __session_stop1:session.sh _session_list0:session.sh __session_show0:session.sh _session_show1:session.sh _session_remove1:session.sh __session_start0:session.sh __session_start1:session.sh _session_connect1:session.sh _session_save0:session.sh _session_save1:session.sh _session_clean0:session.sh _session_refresh0:session.sh _session_validate0:session.sh ___session_dump0:session.sh __session_help0:session.sh ___session_inspect0:session.sh _session_enumerate0:session.sh _session_describe0:session.sh _logs_validate0:validate.sh _logs_clean0:validate.sh _phases_validate0:validate.sh _database_validate0:validate.sh _binaries_validate0:validate.sh _network_validate0:validate.sh _permissions_validate0:validate.sh _environment_validate0:validate.sh _install_validate0:validate.sh _version_validate0:validate.sh _sudo_validate0:validate.sh ___validate0:validate.sh __wireguard_start0:wireguard.sh __wireguard_start1:wireguard.sh ___wireguard_create1:wireguard.sh _wireguard_patch2:wireguard.sh _wireguard_configure1:wireguard.sh _wireguard_connect1:wireguard.sh _wireguard_disconnect1:wireguard.sh ___wireguard_inspect0:wireguard.sh _wireguard_enumerate0:wireguard.sh ___wireguard_stop0:wireguard.sh __wireguard_stop1:wireguard.sh _wireguard_import1:wireguard.sh _wireguard_list0:wireguard.sh _wireguard_list1:wireguard.sh _wireguard_add1:wireguard.sh __wireguard_add2:wireguard.sh _wireguard_add3:wireguard.sh _wireguard_link2:wireguard.sh _wireguard_remove1:wireguard.sh _wireguard_remove2:wireguard.sh _wireguard_validate0:wireguard.sh ___wireguard_clean0:wireguard.sh ___wireguard_clean1:wireguard.sh _wireguard_patch1:wireguard.sh _wireguard_info1:wireguard.sh ___wireguard_dump0:wireguard.sh __wireguard_help0:wireguard.sh"
# === END AUTO-GENERATED ===
#
# This script demonstrates how vpn-switch commands resolve step-by-step
# from generic commands (like "start") down to terminal functions that
# output actual shell commands.
#
# Usage:
#   ./vpn-switch-walkthrough.sh [options] <command> [args...]
#
# Options:
#   --database <path>    VPN_SWITCH_BASE directory to use
#   --format <type>      Output format: tree, markdown (default: tree)
#   --depth <n>          Maximum depth to traverse (default: unlimited)
#   --help, -h           Show this help message
#
# Examples:
#   ./vpn-switch-walkthrough.sh --database ~/.local/vpn start
#   ./vpn-switch-walkthrough.sh --format markdown wireguard start wg0.conf
#   ./vpn-switch-walkthrough.sh --depth 2 stop

set -e


#-----------------------------------------------------------------------------
# Configuration
#-----------------------------------------------------------------------------

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
VPN_SWITCH_SCRIPT="${SCRIPT_DIR}/vpn-switch.sh"

# Default options
DATABASE=""
FORMAT="tree"
MAX_DEPTH=""
COMMAND_ARGS=""

#-----------------------------------------------------------------------------
# Helper Functions
#-----------------------------------------------------------------------------

usage() {
  cat <<EOF
Usage: $0 [options] <command> [args...]

Walk through vpn-switch command resolution chains, showing how commands
resolve step-by-step from combinators to terminal functions.

Options:
  --database <path>    VPN_SWITCH_BASE directory to use (required)
  --format <type>      Output format: tree, markdown (default: tree)
  --depth <n>          Maximum depth to traverse (default: unlimited)
  --help, -h           Show this help message

Examples:
  $0 --database ~/.local/vpn start
  $0 --format markdown wireguard start wg0.conf
  $0 --depth 2 stop

Output:
  - tree:     Visual tree showing command resolution hierarchy
  - markdown: Detailed step-by-step documentation format

EOF
  exit 0
}

# is_terminal_function - Check if function is a terminal function
is_terminal_function() {
  local func="$1"
  echo "$TERMINAL_FUNCTIONS" | grep -qw "$func"
}

# is_combinator - Check if function is a combinator (double underscore)
is_combinator() {
  local func="$1"
  echo "$COMBINATOR_FUNCTIONS" | grep -qw "$func"
}

# is_batch_combinator - Check if function is a batch combinator (triple underscore)
is_batch_combinator() {
  local func="$1"
  echo "$BATCH_COMBINATOR_FUNCTIONS" | grep -qw "$func"
}

# resolve_command_to_function - Resolve command to function name using vpn-switch's logic
# This creates environment overrides for all interpreters set to cat, then
# executes vpn-switch to see what function gets called
resolve_command_to_function() {
  local cmd="$*"

  # Build environment with all combinator/batch interpreters set to cat
  # This prevents execution and shows us the resolution
  local env_overrides=""

  # Set combinator interpreters to cat
  for func in $COMBINATOR_FUNCTIONS; do
    local arity=$(extract_arity "$func")
    env_overrides="$env_overrides VPN_SWITCH_INTERPRETER_${func}=cat"
  done

  # Set batch combinator interpreters to cat
  for func in $BATCH_COMBINATOR_FUNCTIONS; do
    local arity=$(extract_arity "$func")
    env_overrides="$env_overrides VPN_SWITCH_INTERPRETER_${func}=cat"
  done

  # Execute and capture output
  local output=$(eval env VPN_SWITCH_BASE=\"\$DATABASE\" $env_overrides \"\$VPN_SWITCH_SCRIPT\" $cmd 2>&1)
  local status=$?

  # Output format: "status|function|output"
  # We parse the output to extract the function that was called
  # For now, return the raw output
  echo "$output"
}

# extract_arity - Get function arity from name
extract_arity() {
  local func="$1"
  # Function names end with a digit (the arity)
  echo "$func" | sed 's/.*\([0-9]\)$/\1/'
}

# is_vpn_switch_command - Check if line is a vpn-switch command
is_vpn_switch_command() {
  local line="$1"
  echo "$line" | grep -q '^"\$VPN_SWITCH_CONTEXT_SCRIPT"'
}

# extract_command_from_output - Extract command arguments from output
extract_command_from_output() {
  local line="$1"
  # Remove "$VPN_SWITCH_CONTEXT_SCRIPT" prefix (keep quotes in arguments)
  echo "$line" | sed 's/^"\$VPN_SWITCH_CONTEXT_SCRIPT" //'
}

#-----------------------------------------------------------------------------
# Tree Walking
#-----------------------------------------------------------------------------

# resolve_function - Resolve command arguments to function name
# Args: command arguments (e.g., "stop" or "wireguard stop")
# Output: function name (e.g., "___stop0" or "__wireguard_stop0")
# Returns: 0 if found, 1 if not found
resolve_function() {
  local args="$*"
  local arg_count=$#

  # Build function name base (concatenate with underscores)
  local base=$(echo "$args" | tr ' ' '_')

  # Try different arity values (arity 0 first, then increasing)
  # Arity is the number of arguments the function accepts, not the number of words in command
  # For command "stop" (1 word), try arity 0, 1, 2, ...
  # For command "wireguard stop" (2 words), try arity 0, 1, 2, ...
  local arity=0
  while [ $arity -le $((arg_count + 2)) ]; do
    local func_base="${base}${arity}"

    # Try different underscore prefixes (batch first, then combinator, then terminal)
    # This matches the resolution priority in vpn-switch.sh dispatch
    for func_name in "___${func_base}" "__${func_base}" "_${func_base}"; do
      # Check if this function exists in ANCHOR_FUNCTIONS
      if echo " $ANCHOR_FUNCTIONS " | grep -q " $func_name "; then
        echo "$func_name"
        return 0
      fi
    done

    arity=$((arity + 1))
  done

  return 1
}

# walk_command - Recursively walk command resolution
walk_command() {
  local depth="$1"
  shift
  local cmd="$*"

  # Check depth limit
  if [ -n "$MAX_DEPTH" ] && [ "$depth" -ge "$MAX_DEPTH" ]; then
    output_depth_limit "$depth" "$cmd"
    return 0
  fi

  # Resolve command to function name
  local func_name=$(resolve_function $cmd)

  if [ -z "$func_name" ]; then
    # Could not resolve - treat as terminal and stop recursion
    # This handles commands with complex quoting like log "message with spaces"
    echo "  $(printf '%*s' $((depth * 2)) '' | tr ' ' ' ')└─ TERMINAL (unresolved): $cmd"
    return 0
  fi

  # Check if this is a terminal function (single underscore) - no need to recurse
  case "$func_name" in
    _*)
      # Terminal function - don't recurse, just show it
      case "$func_name" in
        __*|___*) ;; # Not terminal, continue
        *)
          echo "  $(printf '%*s' $((depth * 2)) '' | tr ' ' ' ')└─ TERMINAL: $func_name ($cmd)"
          return 0
          ;;
      esac
      ;;
  esac

  # Strip underscores for interpreter variable naming
  local mangled=$(echo "$func_name" | sed 's/^_*//')

  # Set ONLY this specific function's interpreter to 'cat'
  env VPN_SWITCH_BASE="$DATABASE" "$VPN_SWITCH_SCRIPT" setenv "VPN_SWITCH_INTERPRETER_${mangled}" cat >/dev/null 2>&1

  # Execute and capture output
  local output=$(env VPN_SWITCH_BASE="$DATABASE" "$VPN_SWITCH_SCRIPT" $cmd 2>&1)
  local exit_status=$?

  # Immediately unset this interpreter (cleanup)
  env VPN_SWITCH_BASE="$DATABASE" "$VPN_SWITCH_SCRIPT" unsetenv "VPN_SWITCH_INTERPRETER_${mangled}" >/dev/null 2>&1

  # Analyze the output to determine what type of function this was
  # Count lines with VPN_SWITCH commands (excluding comments)
  local command_count=$(echo "$output" | grep -c '^"\$VPN_SWITCH_CONTEXT_SCRIPT"' || echo 0)

  if [ "$command_count" -gt 1 ]; then
    # This is a batch combinator - it output multiple vpn-switch commands
    output_batch_combinator_node "$depth" "$cmd" "$exit_status" "$output"

    # Recurse on each command (use temp file to preserve quotes)
    echo "$output" | while IFS= read -r line; do
      # Skip comments and empty lines
      case "$line" in
        \#*|"") continue ;;
        '"$VPN_SWITCH_CONTEXT_SCRIPT"'*)
          local next_cmd=$(extract_command_from_output "$line")
          # Write to temp file and source it to preserve quoting
          local tmp=$(mktemp)
          echo "walk_command $((depth + 1)) $next_cmd" > "$tmp"
          . "$tmp"
          rm -f "$tmp"
          ;;
      esac
    done

  elif [ "$command_count" -eq 1 ]; then
    # This is a combinator - it output a single vpn-switch command
    output_combinator_node "$depth" "$cmd" "$exit_status" "$output"

    # Recurse on the next command (use temp file to preserve quotes)
    local next_cmd=$(extract_command_from_output "$output")
    local tmp=$(mktemp)
    echo "walk_command $((depth + 1)) $next_cmd" > "$tmp"
    . "$tmp"
    rm -f "$tmp"

  else
    # This is a terminal function - it output actual shell commands
    output_terminal_node "$depth" "$cmd" "$exit_status" "$output"
  fi
}

#-----------------------------------------------------------------------------
# Output Formatting
#-----------------------------------------------------------------------------

# Tree format output functions
output_combinator_node() {
  local depth="$1" cmd="$2" status="$3" output="$4"
  local indent=$(printf '%*s' $((depth * 2)) '' | tr ' ' ' ')
  echo "${indent}├─ COMBINATOR: $cmd"
  echo "${indent}│  Exit: $status"
  echo "${indent}│  Next: $output"
}

output_batch_combinator_node() {
  local depth="$1" cmd="$2" status="$3" output="$4"
  local indent=$(printf '%*s' $((depth * 2)) '' | tr ' ' ' ')

  # Count commands (lines starting with "$VPN_SWITCH_CONTEXT_SCRIPT")
  local count=$(echo "$output" | grep -c '^"\$VPN_SWITCH_CONTEXT_SCRIPT"' || echo 0)

  echo "${indent}├─ BATCH COMBINATOR: $cmd"
  echo "${indent}│  Exit: $status"
  echo "${indent}│  Commands generated: $count"
}

output_terminal_node() {
  local depth="$1" cmd="$2" status="$3" output="$4"
  local indent=$(printf '%*s' $((depth * 2)) '' | tr ' ' ' ')

  # Count lines of output
  local line_count=$(echo "$output" | wc -l | tr -d ' ')

  echo "${indent}└─ TERMINAL: $cmd"
  echo "${indent}   Exit: $status"
  echo "${indent}   Output lines: $line_count"
}

output_depth_limit() {
  local depth="$1" cmd="$2"
  local indent=$(printf '%*s' $((depth * 2)) '' | tr ' ' ' ')
  echo "${indent}... (depth limit reached: $cmd)"
}

#-----------------------------------------------------------------------------
# Markdown Format Functions
#-----------------------------------------------------------------------------

# These functions execute commands with interpreters set to use markdown-formatter.sh
# The tee approach captures both formatted markdown (stdout) and raw output (file)

markdown_walk_command() {
  local depth="$1"
  shift
  local cmd="$*"

  # Check depth limit
  if [ -n "$MAX_DEPTH" ] && [ "$depth" -ge "$MAX_DEPTH" ]; then
    echo "*(Maximum depth reached)*"
    return 0
  fi

  # Resolve command to function name
  local func_name=$(resolve_function $cmd)

  if [ -z "$func_name" ]; then
    # Could not resolve - treat as terminal
    return 0
  fi

  # Check if this is a terminal function - show output but don't recurse
  local is_terminal=0
  case "$func_name" in
    _*)
      case "$func_name" in
        __*|___*) ;; # Not terminal, continue
        *)
          is_terminal=1  # Terminal function - execute and show, but don't recurse
          ;;
      esac
      ;;
  esac

  # Strip underscores for interpreter variable naming
  local mangled=$(echo "$func_name" | sed 's/^_*//')

  # Create temp file for tee (raw output for recursion)
  local raw_file=$(mktemp)

  # Determine formatter based on function type
  local heading_level=$((depth + 2))  # Start at ## for top level
  [ "$heading_level" -gt 6 ] && heading_level=6
  local heading=$(printf '#%.0s' $(seq 1 $heading_level))

  if is_batch_combinator "$func_name"; then
    # Batch combinator: use section formatter
    local interpreter="tee $raw_file | $SCRIPT_DIR/markdown-formatter.sh section depth=$heading_level title='Command: $cmd'"
  elif is_combinator "$func_name"; then
    # Combinator: use codeblock formatter
    local interpreter="tee $raw_file | $SCRIPT_DIR/markdown-formatter.sh codeblock lang=bash caption='$cmd ($func_name)'"
  else
    # Terminal function: use codeblock formatter
    local interpreter="tee $raw_file | $SCRIPT_DIR/markdown-formatter.sh codeblock lang=bash caption='Output: $cmd'"
  fi

  # Set interpreter with tee+formatter
  env VPN_SWITCH_BASE="$DATABASE" "$VPN_SWITCH_SCRIPT" setenv "VPN_SWITCH_INTERPRETER_${mangled}" "$interpreter" >/dev/null 2>&1

  # Execute command - formatted markdown flows to stdout, raw to file
  env VPN_SWITCH_BASE="$DATABASE" "$VPN_SWITCH_SCRIPT" $cmd 2>&1

  # Unset interpreter
  env VPN_SWITCH_BASE="$DATABASE" "$VPN_SWITCH_SCRIPT" unsetenv "VPN_SWITCH_INTERPRETER_${mangled}" >/dev/null 2>&1

  # Terminal functions: stop here (don't recurse)
  if [ "$is_terminal" -eq 1 ]; then
    rm -f "$raw_file"
    return 0
  fi

  # Read raw file for recursion (combinators and batch combinators only)
  local command_count=$(grep -c '^"\$VPN_SWITCH_CONTEXT_SCRIPT"' "$raw_file" 2>/dev/null || echo 0)

  if [ "$command_count" -gt 0 ]; then
    # Recurse on child commands (read file directly to avoid subshell)
    while IFS= read -r line; do
      case "$line" in
        '"$VPN_SWITCH_CONTEXT_SCRIPT"'*)
          local next_cmd=$(extract_command_from_output "$line")
          local tmp=$(mktemp)
          echo "markdown_walk_command $((depth + 1)) $next_cmd" > "$tmp"
          . "$tmp"
          rm -f "$tmp"
          ;;
      esac
    done < "$raw_file"
  fi

  # Cleanup
  rm -f "$raw_file"
}

#-----------------------------------------------------------------------------
# Main
#-----------------------------------------------------------------------------

# Parse arguments
while [ $# -gt 0 ]; do
  case "$1" in
    --database)
      DATABASE="$2"
      shift 2
      ;;
    --format)
      FORMAT="$2"
      shift 2
      ;;
    --depth)
      MAX_DEPTH="$2"
      shift 2
      ;;
    --help|-h)
      usage
      ;;
    *)
      # Remaining arguments are the command
      COMMAND_ARGS="$*"
      break
      ;;
  esac
done

# Validate arguments
if [ -z "$DATABASE" ]; then
  echo "Error: --database is required" >&2
  echo "Use --help for usage information" >&2
  exit 1
fi

if [ -z "$COMMAND_ARGS" ]; then
  echo "Error: No command specified" >&2
  echo "Use --help for usage information" >&2
  exit 1
fi

if [ ! -f "$VPN_SWITCH_SCRIPT" ]; then
  echo "Error: vpn-switch.sh not found at: $VPN_SWITCH_SCRIPT" >&2
  exit 1
fi

# Check metadata is populated
if [ -z "$TERMINAL_FUNCTIONS" ]; then
  echo "Error: Metadata not populated. Run: scripts/generate-metadata.sh --target vpn-switch-walkthrough.sh" >&2
  exit 1
fi

# Start walking
if [ "$FORMAT" = "markdown" ]; then
  # Markdown format: output clean markdown document
  echo "# vpn-switch Command Walkthrough"
  echo ""
  echo "**Command:** \`$COMMAND_ARGS\`"
  echo ""
  echo "**Database:** $DATABASE"
  echo ""

  markdown_walk_command 0 $COMMAND_ARGS

else
  # Tree format: output with headers
  echo "========================================="
  echo "vpn-switch Command Walkthrough"
  echo "========================================="
  echo "Database: $DATABASE"
  echo "Command: $COMMAND_ARGS"
  echo "Format: $FORMAT"
  echo ""

  walk_command 0 $COMMAND_ARGS

  echo ""
  echo "========================================="
  echo "Walkthrough complete"
  echo "========================================="
fi
