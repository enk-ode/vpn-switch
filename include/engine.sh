

# q <value> -- Q is the single-quoted value: every ' as '\''. Pure shell;
# the first case is the fast path (a value without an apostrophe is
# wrapped directly -- the loop's ${s#*\'} is quadratic on long values
# without one, the VPN_SWITCH_PROFILE_* lists). sq prints Q.
q() {
  local s="$1" rest
  case "$s" in *\'*) ;; *) Q="'$s'"; return 0 ;; esac
  Q=""
  while :; do
    rest=${s#*\'}
    if [ "$rest" = "$s" ]; then Q="$Q$s"; break; fi
    Q="$Q${s%%\'*}'\\''"
    s=$rest
  done
  Q="'$Q'"
}


# sq <text> — <text> as ONE single-quoted shell word (a quote inside becomes
# '\''), for values that travel inside an emitted line: labels, descriptions,
# error reasons that may contain quotes or parentheses
sq() {
  local Q
  q "$1"
  printf '%s' "$Q"
}
#!/bin/sh
#
# engine.sh -- the combinator engine of vpn-switch, out of vpn-switch.sh
# (15.09.2026, step 1 of docs/DESIGN_ENGINE_LIBRARY.md): dispatch
# (to_function_call, outside-in), process_arguments / run_env / the exit
# arithmetic, interpreter resolution, the environment cascade, the batch
# ring, the trace and log layer, the error and log terminals, main. Sourced
# first by vpn-switch.sh, before every module; never lazy-loaded. Moved
# verbatim -- the suites are the net; the reconciliation with elvboot's
# engine (step 2) follows behind them.
#
trace_log() {
  if [ -z "${VPN_SWITCH_TRACE_FILE:-}" ]; then
    return 0
  fi

  local marker="${1:-|}"
  local caller="${2:-unknown}"
  shift 2 2>>"$LOG_FILE" || return 0  # Shift safely, return if not enough args
  local message="$*"

  # Get current depth (default to 0)
  local depth="${VPN_SWITCH_TRACE_DEPTH:-0}"

  # Build depth prefix ("> " repeated depth times)
  local depth_prefix=""
  local i=0
  while [ "$i" -lt "$depth" ]; do
    depth_prefix="${depth_prefix}>  "
    i=$((i + 1))
  done

  # Format and write log entry
  # Format: <depth_prefix><marker> <caller>: <message>
  echo "${depth_prefix}${marker} ${caller}: ${message}" >> "$VPN_SWITCH_TRACE_FILE"
  return 0
}

# safety_first_message - Output safety-first mode explanation
#
# Outputs standard message explaining that commands are being displayed
# rather than executed (VPN_SWITCH_TERMINAL_INTERPRETER=cat behavior).
#
# Usage: Call from functions that output shell commands
#
safety_first_message() {
  cat <<'EOF'
# First time seeing commands instead of execution?
# This is safety-first mode (VPN_SWITCH_TERMINAL_INTERPRETER=cat).
# For auto-execution setup: vpn-switch help environment
EOF
}

#-----------------------------------------------------------------------------
# Environment Isolation - run_env()
#-----------------------------------------------------------------------------

# should_skip_env_value - Check if environment variable value should be skipped
#
# Args: $1 - value to check
# Returns: 0 if should skip, 1 if should use
#
# Skips empty lines, whitespace-only lines, and comment lines (starting with #).
# This allows disabling variables without deleting files, while keeping the
# resolution strategy simple: comments DON'T block defaults (less surprising).
#
should_skip_env_value() {
  local value="$1"

  # Empty line - skip
  case "$value" in
    '') return 0 ;;
  esac

  # Whitespace-only line - skip
  case "$value" in
    *[![:space:]]*) ;;  # Has non-whitespace - continue checking
    *) return 0 ;;      # Only whitespace - skip
  esac

  # Comment line (with optional leading whitespace) - skip
  local trimmed=$(echo "$value" | sed 's/^[[:space:]]*//')
  case "$trimmed" in
    \#*) return 0 ;;    # Comment - skip
  esac

  return 1  # Use this value
}

# build_env_args - Build environment variable arguments for env command
#
# Searches for environment files in priority order (envdir-style):
#   1. ${VPN_SWITCH_ENV_DIR}/local/VARNAME    (machine-specific overrides, highest priority)
#   2. ${VPN_SWITCH_ENV_DIR}/default/VARNAME  (default configuration, fallback)
#
# Each variable is a separate file containing the value (first line only).
# Local overrides take precedence over defaults.
#
# RESOLUTION STRATEGY (less surprising for new users):
#   - Empty lines / whitespace-only / comments in local/ → DON'T block defaults
#   - Only actual values in local/ will override defaults
#   - This means: comments/empty files are truly "transparent" to resolution
#
# PERFORMANCE: Results are cached in VPN_SWITCH_CACHE_ENV_ARGS for reuse within
# the same process tree (passed through env - boundary).
#
# Output: Space-separated VAR='value' pairs (single-quoted for safety with eval)
#
build_env_args_full() {
  # Full environment scan (excludes cache file to avoid recursion)
  # Called by build_env_args() when cache is not available
  # Called by "environment cache on" to generate cache content

  # Return in-memory cached value if available (passed through env -)
  if [ -n "${VPN_SWITCH_CACHE_ENV_ARGS:-}" ]; then
    echo "$VPN_SWITCH_CACHE_ENV_ARGS"
    return 0
  fi

  local env_base="$VPN_SWITCH_ENV_DIR"
  local env_args=""
  local seen_vars=""

  # First pass: Load local overrides (highest priority)
  if [ -d "$env_base/local" ]; then
    for varfile in "$env_base/local"/*; do
      [ ! -f "$varfile" ] && continue

      local varname=$(basename "$varfile")

      # CRITICAL: Skip cache file to avoid recursion
      if [ "$varname" = "VPN_SWITCH_CACHE_ENV_ARGS" ]; then
        continue
      fi

      local value=$(head -n1 "$varfile")

      # Use helper to check if should skip
      if should_skip_env_value "$value"; then
        # DON'T mark as seen - allow default to load (less surprising)
        continue
      fi

      # Mark as seen ONLY when we actually use the value
      seen_vars="$seen_vars $varname "

      # Escape single quotes for shell eval: ' becomes '\''
      local escaped_value=$(printf '%s\n' "$value" | sed "s/'/'\\\\''/g")
      env_args="$env_args $varname='$escaped_value'"
    done
  fi

  # Second pass: Load defaults (only if not already set by local)
  if [ -d "$env_base/default" ]; then
    for varfile in "$env_base/default"/*; do
      [ ! -f "$varfile" ] && continue

      local varname=$(basename "$varfile")

      # Skip VPN_SWITCH_BASE - it's passed explicitly in run_env()
      if [ "$varname" = "VPN_SWITCH_BASE" ]; then
        display_warning "VPN_SWITCH_BASE found in .env files but will be ignored (must be set via environment)" >&2
        continue
      fi

      # Skip if already loaded from local
      case "$seen_vars" in
        *" $varname "*) continue ;;
      esac

      local value=$(head -n1 "$varfile")

      # Use helper to check if should skip
      if should_skip_env_value "$value"; then
        continue
      fi

      # Escape single quotes for shell eval: ' becomes '\''
      local escaped_value=$(printf '%s\n' "$value" | sed "s/'/'\\\\''/g")
      env_args="$env_args $varname='$escaped_value'"
    done
  fi

  echo "$env_args"
}

build_env_args() {
  # Smart router: Check disk cache first, fall back to full scan
  # Cache optimization: Reads 1 file instead of 41+ files
  # Enable with: vpn-switch environment cache on

  local cache_file="$VPN_SWITCH_BASE/.env/local/VPN_SWITCH_CACHE_ENV_ARGS"

  # If disk cache exists, use it (fast path)
  if [ -f "$cache_file" ]; then
    cat "$cache_file"
    return 0
  fi

  # No cache - do full scan
  build_env_args_full
}

# run_env - Execute command in isolated environment
#
# Args: $@ - command and arguments to execute
#       Special: "--" as first arg switches to external command mode
#
# Uses 'env -' to create clean environment, then adds only variables
# from .env configuration. No environment pollution - each execution
# gets a fresh, isolated environment.
#
# Two modes:
#   Internal mode: run_env dispatch "$@"
#     → Calls back into vpn-switch.sh with "dispatch" command
#   External mode: run_env -- sh
#     → Executes arbitrary command (sh) with same isolated environment
#
run_env() {
  # Execute external command (interpreter) in isolated environment
  # Usage: run_env -- <interpreter> [args...]
  # Example: run_env -- sh -c "wg-quick up wg0"
  #
  # This function is used ONLY for executing interpreters with proper environment isolation.
  # Internal commands no longer need run_env since environment is loaded at top level.

  # Validate usage
  if [ "$1" != "--" ]; then
    display error "run_env requires '--' marker for external commands"
    display plain "Usage: run_env -- <command> [args...]"
    return 1
  fi
  shift

  # Build or reuse cached environment variable arguments (performance optimization)
  local env_args
  if [ -n "${VPN_SWITCH_CACHE_ENV_ARGS:-}" ]; then
    env_args="$VPN_SWITCH_CACHE_ENV_ARGS"
  else
    env_args=$(build_env_args)
    # Cache for child processes by passing through env - boundary
    VPN_SWITCH_CACHE_ENV_ARGS="$env_args"
  fi

  local script_path="$VPN_SWITCH_CONTEXT_SCRIPT"

  # Build passthrough variables (context, cache, trace) - simple list for easy extension
  local passthrough=""

  # Add bootstrap marker to context (indicates environment loaded from .env files)
  passthrough="$passthrough VPN_SWITCH_CONTEXT_BOOTSTRAPPED=1"

  # Add cache (performance - reuse env_args in child processes)
  if [ -n "${VPN_SWITCH_CACHE_ENV_ARGS:-}" ]; then
    passthrough="$passthrough VPN_SWITCH_CACHE_ENV_ARGS=\"\$VPN_SWITCH_CACHE_ENV_ARGS\""
  fi

  # Add trace file (debugging context)
  if [ -n "${VPN_SWITCH_TRACE_FILE:-}" ]; then
    passthrough="$passthrough VPN_SWITCH_TRACE_FILE=\"\$VPN_SWITCH_TRACE_FILE\""
  fi

  # Add log file (debugging infrastructure - stderr redirection)
  if [ -n "${LOG_FILE:-}" ]; then
    passthrough="$passthrough LOG_FILE=\"\$LOG_FILE\""
  fi

  # Add trace depth (subprocess nesting level)
  if [ -n "${VPN_SWITCH_TRACE_DEPTH:-}" ]; then
    passthrough="$passthrough VPN_SWITCH_TRACE_DEPTH=\"\$VPN_SWITCH_TRACE_DEPTH\""
  fi

  # Add exit code bits (exit code accumulation through call tree)
  # Always pass through since it's initialized at startup
  passthrough="$passthrough VPN_SWITCH_CONTEXT_EXIT_BITS=\"\$VPN_SWITCH_CONTEXT_EXIT_BITS\""

  # Add command (interpreter context)
  if [ -n "${VPN_SWITCH_CONTEXT_COMMAND:-}" ]; then
    passthrough="$passthrough VPN_SWITCH_CONTEXT_COMMAND=\"\$VPN_SWITCH_CONTEXT_COMMAND\""
  fi

  # Add resolved function call (dispatch context)
  if [ -n "${VPN_SWITCH_CONTEXT_CALL:-}" ]; then
    passthrough="$passthrough VPN_SWITCH_CONTEXT_CALL=\"\$VPN_SWITCH_CONTEXT_CALL\""
  fi

  # Add context variables for phase scripts (Phase 1 & Feature 3)
  if [ -n "${VPN_SWITCH_CONTEXT_CONNECT:-}" ]; then
    passthrough="$passthrough VPN_SWITCH_CONTEXT_CONNECT=\"\$VPN_SWITCH_CONTEXT_CONNECT\""
  fi

  if [ -n "${VPN_SWITCH_CONTEXT_DISCONNECT:-}" ]; then
    passthrough="$passthrough VPN_SWITCH_CONTEXT_DISCONNECT=\"\$VPN_SWITCH_CONTEXT_DISCONNECT\""
  fi

  if [ -n "${VPN_SWITCH_CONTEXT_INSPECT:-}" ]; then
    passthrough="$passthrough VPN_SWITCH_CONTEXT_INSPECT=\"\$VPN_SWITCH_CONTEXT_INSPECT\""
  fi

  # Add display mode (inspect context override for plain-text diagnostics)
  if [ -n "${VPN_SWITCH_DISPLAY_ANSI:-}" ]; then
    passthrough="$passthrough VPN_SWITCH_DISPLAY_ANSI=\"\$VPN_SWITCH_DISPLAY_ANSI\""
  fi

  # Get current depth for logging (default to 0)
  local current_depth="${VPN_SWITCH_TRACE_DEPTH:-0}"
  # Calculate next depth for subprocess
  local next_depth=$((current_depth + 1))

  # Execute external command in isolated environment
  trace_log ">" "run_env" "External command: $*"
  # Update passthrough to include incremented depth for subprocess
  local subprocess_passthrough="$passthrough VPN_SWITCH_TRACE_DEPTH=$next_depth"

  # Build optional runtime variables (from parent environment, not .env files)
  local runtime_vars=""
  if [ -n "${VPN_SWITCH_BATCH_KEEP_GOING:-}" ]; then
    runtime_vars="$runtime_vars VPN_SWITCH_BATCH_KEEP_GOING=\"$VPN_SWITCH_BATCH_KEEP_GOING\""
  fi

  # PATH for the isolated command environment. The "$PATH" below is only a
  # fallback: if PATH is set in .env it appears later in $env_args and wins
  # (env applies the last assignment of a duplicate var). VPN_SWITCH_PATH is
  # NOT consulted here - it is baked only into the generated connect/disconnect
  # scripts.
  eval "env - PATH=\"$PATH\" $env_args $subprocess_passthrough $runtime_vars VPN_SWITCH_CONTEXT_SCRIPT=\"\$script_path\" VPN_SWITCH_BASE=\"\$VPN_SWITCH_BASE\" \"\$@\""
  local exit_code=$?
  trace_log "<" "run_env" "External command completed (exit: $exit_code)"

  # CRITICAL: Ensure set +e before returning (subprocess may have returned batch code >= 128)
  set +e
  return $exit_code
}

#-----------------------------------------------------------------------------
# Core Infrastructure - Dispatch Mechanism
#-----------------------------------------------------------------------------

# to_function_call - Pure resolution function (no execution)
#
# Args: $1 - function list (space-separated function names)
#       $2+ - command arguments to resolve
# Output: Single line with resolved function name and remaining arguments
# Return: 0 if resolved, 1 if no match found
#
# This is a pure transformer function that separates resolution from execution.
# Unlike dispatch(), it does NOT execute the function - it just outputs what
# would be called. This enables:
# - Testing resolution in isolation
# - Computing resolution once, using result twice (dispatch + interpreter)
# - Easier debugging (can see what will be called before calling it)
#
# Progressive filtering optimization:
# - STEP 1: Filter function list FIRST to narrow search space dramatically
# - STEP 2: Search for exact matches in the filtered set (much faster)
# - STEP 3: Further filter before recursion to progressively narrow the set
# This improves performance for deep command hierarchies by reducing pattern matching overhead.
#
# Example:
#   to_function_call "$ANCHOR_FUNCTIONS" wireguard start privacy
#   → outputs: "__wireguard_start1 privacy"
#
to_function_call() {
  # First argument is the function list (mandatory)
  local functions="${1:-}"
  shift

  local curr="${1:-}"
  local next="${2:-}"

  # If no function list or no current argument, return usage
  if [ -z "$functions" ] || [ -z "$curr" ]; then
    echo "usage"
    return 0
  fi

  # Shift past curr to get remaining args
  shift

  # Save argument count for accurate arity (after shifting curr)
  # This is the total count of arguments that will be passed to the function
  # Includes $next (if present) plus all remaining args in "$@"
  local arity=$#

  # Now shift $next so "$@" contains only the remaining args
  if [ -n "$next" ]; then
    shift
  fi

  # === STEP 1: Filter FIRST to narrow search space (performance optimization) ===
  # Only keep functions that match current prefix
  # This dramatically reduces search space for subsequent operations
  local filtered=""
  for line in $functions; do
    case "$line" in
      ${curr}|_${curr}|__${curr}|___${curr}|_${curr}_*|__${curr}_*|___${curr}_*|_${curr}[0-9]*|__${curr}[0-9]*|___${curr}[0-9]*)
        filtered="$filtered $line"
        ;;
    esac
  done

  # === STEP 2: Search in filtered set for exact matches ===
  # Arity was calculated above (total argument count after shifting curr)

  # Try: exact match, with underscore prefix(es), with underscore + arity
  # Support terminal (_), combinator (__), and set-combinator (___) functions
  # Search ONLY in filtered set (much faster than full list)
  for line in $filtered; do
    if [ "$curr" = "$line" ] || \
       [ "_${curr}" = "$line" ] || \
       [ "__${curr}" = "$line" ] || \
       [ "___${curr}" = "$line" ] || \
       [ "_${curr}${arity}" = "$line" ] || \
       [ "__${curr}${arity}" = "$line" ] || \
       [ "___${curr}${arity}" = "$line" ]; then
      # Found exact match - output function call with quoted arguments
      # Use printf with %q to properly quote each argument for eval safety
      printf "%s" "$line"
      if [ -n "$next" ]; then
        printf " %s" "$(printf '%s\n' "$next" | sed "s/'/'\\\\''/g; s/^/'/; s/$/'/")"
      fi
      for arg in "$@"; do
        printf " %s" "$(printf '%s\n' "$arg" | sed "s/'/'\\\\''/g; s/^/'/; s/$/'/")"
      done
      printf '\n'
      return 0
    fi
  done

  # === STEP 3: No match found - try concatenating with next arg ===
  if [ -n "$next" ]; then
    # Further filter for recursive call (only keep functions with concatenated prefix)
    # This narrows the already-filtered set even more for the next iteration
    local filtered_recursive=""
    for line in $filtered; do
      case "$line" in
        _${curr}_*|__${curr}_*|___${curr}_*)
          filtered_recursive="$filtered_recursive $line"
          ;;
      esac
    done

    # Only recurse if there are matching functions (avoid infinite loop)
    if [ -n "$filtered_recursive" ]; then
      # Recursive call: pass filtered list as first parameter
      # This implements progressive filtering optimization
      # Use "$@" to preserve argument quoting through recursion
      to_function_call "$filtered_recursive" "${curr}_${next}" "$@"
      return $?
    else
      # No matching functions found - return usage
      echo "usage"
      return 0
    fi
  else
    # No more args to concatenate - return usage
    echo "usage"
    return 0
  fi
}

# _env_resolve_file <var_name> [location]
# Resolve the file backing an environment variable, honouring the same
# local -> default -> template cascade as getenv. With an explicit <location>
# (local|default|template), restrict the lookup to that single layer.
#
# Output on success: two lines — the layer word, then the absolute path.
# Returns 1 if not found (in the requested location, or anywhere).
#
# Lives in the always-loaded core so both _getenv1 (database.sh) and the env-var
# help commands (helpenv.sh) share it regardless of which module is lazy-loaded.
# Not a dispatch function (no trailing-digit arity), so metadata ignores it.
_env_resolve_file() {
  local var_name="$1"
  local location="${2:-}"
  local base="$VPN_SWITCH_BASE"
  local local_file="$base/.env/local/$var_name"
  local default_file="$base/.env/default/$var_name"
  local template_file="$VPN_SWITCH_TEMPLATE_DIR/environment/$var_name"

  case "$location" in
    local)    [ -f "$local_file" ]    && { printf 'local\n%s\n' "$local_file"; return 0; }; return 1 ;;
    default)  [ -f "$default_file" ]  && { printf 'default\n%s\n' "$default_file"; return 0; }; return 1 ;;
    template) [ -f "$template_file" ] && { printf 'template\n%s\n' "$template_file"; return 0; }; return 1 ;;
    "")
      if   [ -f "$local_file" ];    then printf 'local\n%s\n' "$local_file"
      elif [ -f "$default_file" ];  then printf 'default\n%s\n' "$default_file"
      elif [ -f "$template_file" ]; then printf 'template\n%s\n' "$template_file"
      else return 1
      fi
      ;;
    *) return 1 ;;
  esac
}

# dispatch - Resolve command-line arguments to function names and execute
#
# Algorithm:
#   1. Try to match first argument against function list
#   2. If match: call function with remaining args
#   3. If no match: concatenate first two args with underscore, recurse
#   4. If exhausted args: call usage()
#
# Input:  Function list on stdin (one per line)
#         Command-line arguments as parameters
# Output: Function output to stdout
#
dispatch() {
  # Read resolved function call from environment (set by main)
  # This avoids stdin consumption, allowing batch-combinators to capture stdin
  local function_call="$VPN_SWITCH_CONTEXT_CALL"

  # Defensive: Check for empty function call
  if [ -z "$function_call" ]; then
    trace_log "!" "dispatch" "Called with empty VPN_SWITCH_CONTEXT_CALL"
    return 1
  fi

  # Parse function name (first word) and remaining arguments
  local function_name="${function_call%% *}"
  local args="${function_call#* }"

  # If no space found, args would equal function_call (no arguments case)
  if [ "$args" = "$function_call" ]; then
    args=""
  fi

  # Defensive: Check for empty function name
  if [ -z "$function_name" ]; then
    trace_log "!" "dispatch" "Empty function name (function_call='$function_call')"
    return 1
  fi

  # CRITICAL: Disable set -e before calling function
  # This prevents shell exit if the function returns non-zero (including batch codes >= 128)
  set +e

  # Execute the function with its arguments (using eval to preserve quoting)
  if [ -z "$args" ]; then
    $function_name
  else
    eval "$function_name $args"
  fi
  local func_exit=$?

  # CRITICAL: Ensure set +e before returning (nested functions may have re-enabled set -e)
  # This allows returning non-zero exit codes (including batch codes >= 128) without shell exit
  set +e
  return $func_exit
}

#-----------------------------------------------------------------------------
# Core Infrastructure - Interpreter System
#-----------------------------------------------------------------------------

# lookup_interpreter - Determine interpreter for resolved function call
#
# Input: Resolved function call from stdin (output of to_function_call)
# Output: Interpreter command
#
# Resolution strategy:
#   1. Try per-function override: VPN_SWITCH_INTERPRETER_<function_name_mangled>
#   2. Use default based on underscore count:
#      - Double underscore (__): VPN_SWITCH_COMBINATOR_INTERPRETER
#      - Single underscore (_):  VPN_SWITCH_TERMINAL_INTERPRETER
#   3. Fallback: "sh" (if naming convention not followed)
#
# Examples:
#   echo "_wireguard_connect1 12345" | lookup_interpreter
#     → tries: VPN_SWITCH_INTERPRETER_wireguard_connect (not found)
#     → uses: VPN_SWITCH_TERMINAL_INTERPRETER (default: "sh")
#
#   echo "__wireguard_start1 privacy" | lookup_interpreter
#     → tries: VPN_SWITCH_INTERPRETER_wireguard_start (not found)
#     → uses: VPN_SWITCH_COMBINATOR_INTERPRETER (default: "xargs ...")
#
# Phase 3.1.2: Intrinsic classification via naming convention
#
lookup_interpreter() {
  # Read resolved function call from stdin
  local function_call
  read -r function_call

  # Extract function name (first word)
  local function_name="${function_call%% *}"

  # Try arity-specific override first (most specific)
  # Example: VPN_SWITCH_INTERPRETER_wireguard_stop0
  local mangled_with_arity=$(echo "$function_name" | sed 's/^_*//')
  local interp_var_arity="VPN_SWITCH_INTERPRETER_${mangled_with_arity}"
  local override_arity=$(eval echo "\${${interp_var_arity}:-}")

  if [ -n "$override_arity" ]; then
    echo "$override_arity"
    return 0
  fi

  # Try arity-agnostic override (less specific)
  # Example: VPN_SWITCH_INTERPRETER_wireguard_stop
  local mangled=$(echo "$function_name" | sed 's/^_*//; s/[0-9]$//')
  local interp_var="VPN_SWITCH_INTERPRETER_${mangled}"
  local override=$(eval echo "\${${interp_var}:-}")

  if [ -n "$override" ]; then
    echo "$override"
    return 0
  fi

  # Use defaults based on underscore count (intrinsic classification)
  case "$function_name" in
    ___*)
      # Triple underscore = batch-combinator function (outputs multiple commands)
      echo "$VPN_SWITCH_BATCH_COMBINATOR_INTERPRETER"
      ;;
    __*)
      # Double underscore = combinator function (outputs single command)
      echo "$VPN_SWITCH_COMBINATOR_INTERPRETER"
      ;;
    _*)
      # Single underscore = terminal function (outputs shell commands)
      echo "$VPN_SWITCH_TERMINAL_INTERPRETER"
      ;;
    *)
      # No underscore prefix (shouldn't happen with proper naming)
      error "Function name without underscore prefix: $function_name (check function naming convention)"
      ;;
  esac
}


#-----------------------------------------------------------------------------
# Helper Functions - Display Abstraction
#-----------------------------------------------------------------------------

# ANSI color codes (only used when VPN_SWITCH_DISPLAY_ANSI=1)
# These are defined as constants but only applied conditionally
COLOR_RESET='\033[0m'
COLOR_RED='\033[1;31m'      # Errors
COLOR_YELLOW='\033[1;33m'   # Warnings
COLOR_GREEN='\033[1;32m'    # Success
COLOR_BLUE='\033[1;34m'     # Info/headings
COLOR_CYAN='\033[1;36m'     # Commands/examples
COLOR_GRAY='\033[2m'        # Debug/log

# display - Unified output function with optional color support
#
# Args: $1 - message level (error|warning|success|info|log|plain)
#       $2+ - message text
#
# Honors VPN_SWITCH_DISPLAY_ANSI environment variable:
#   0 or unset = plain text output
#   1 = colored output using ANSI escape sequences
#
# Output always goes to stderr for consistency with error messages
#
display() {
  local level="${1:-plain}"
  shift
  local message="$*"
  local color=""
  local prefix=""

  # Determine color and prefix based on level
  case "$level" in
    error)
      color="$COLOR_RED"
      prefix="Error: "
      ;;
    warning)
      color="$COLOR_YELLOW"
      prefix="Warning: "
      ;;
    success)
      color="$COLOR_GREEN"
      prefix=""
      ;;
    info)
      color="$COLOR_BLUE"
      prefix=""
      ;;
    log)
      color="$COLOR_GRAY"
      prefix=""
      ;;
    plain|*)
      color=""
      prefix=""
      ;;
  esac

  # Output with or without color
  # Note: %b interprets backslash escapes in color codes (\033 -> ESC)
  if [ "${VPN_SWITCH_DISPLAY_ANSI:-0}" = "1" ] && [ -n "$color" ]; then
    printf '%b%s%s%b\n' "$color" "$prefix" "$message" "$COLOR_RESET" >&2
  else
    printf "%s%s\n" "$prefix" "$message" >&2
  fi
}

# Semantic wrapper functions for common use cases
display_error()   { display error "$@"; }

display_warning() { display warning "$@"; }

display_success() { display success "$@"; }

display_info()    { display info "$@"; }

display_log()     { display log "$@"; }

# error - Print error message and exit
#
# Kept for backward compatibility, now uses display()
#
error() {
  display_error "$*"
  exit 1
}

# generate_error - Output error shell commands for any number of lines
#
# Usage: generate_error "line1" ["line2" ["line3" ...]]
#
# This helper function outputs shell commands that display an error message
# and exit with code 1. ANSI color check happens at generation time.
#
# Used by:
# - _error1/2/3 terminal functions (called via vpn-switch error command)
# - Terminal functions that need inline error handling
#
# Output format:
#   First line: "Error: message" (with color if ANSI enabled)
#   Additional lines: "  message" (indented, no "Error:" prefix)
#   Final: exit 1
#
generate_error() {
  local first=true

  if [ "${VPN_SWITCH_DISPLAY_ANSI:-0}" != "0" ]; then
    # Color version
    for line in "$@"; do
      if $first; then
        printf '%s\n' "printf \"# \\033[1;31mError:\\033[0m %s\\n\" \"$line\" >&2"
        first=false
      else
        printf '%s\n' "printf \"#   %s\\n\" \"$line\" >&2"
      fi
    done
  else
    # Plain version
    for line in "$@"; do
      if $first; then
        printf '%s\n' "printf \"# Error: %s\\n\" \"$line\" >&2"
        first=false
      else
        printf '%s\n' "printf \"#   %s\\n\" \"$line\" >&2"
      fi
    done
  fi

  printf '%s\n' "exit 1"
}

# log - Print informational message
#
# Kept for backward compatibility, now uses display()
#
log() {
  display_log "$*"
}

# follow_symlinks_safe - Follow symbolic links with loop detection
#
# Follows a chain of symbolic links up to a maximum depth (POSIX SYMLOOP_MAX).
# Detects symlink loops and excessively deep chains.
#
# Args: $1 - directory path
#       $2 - name (may be symlink)
# Output: resolved name (basename)
# Returns: 0 on success, 1 on symlink loop or too many levels
#
follow_symlinks_safe() {
  local dir="$1"
  local name="$2"

  local symlink_depth=0
  local max_symlinks=40  # POSIX SYMLOOP_MAX

  while [ -L "$dir/$name" ]; do
    symlink_depth=$((symlink_depth + 1))
    if [ "$symlink_depth" -gt "$max_symlinks" ]; then
      return 1  # Symlink loop or too deep
    fi

    name=$(readlink "$dir/$name")
    # If relative path, resolve it
    case "$name" in
      /*) ;;  # absolute path
      *) name="$dir/$name" ;;  # relative path
    esac
  done

  # Return basename only
  basename -- "$name"
  return 0
}

# has_newline_in_path - Check if a path contains newlines
#
# Args: $1 - path to check
# Returns: 0 if path contains newlines (unsafe), 1 if safe
#
# Security check to prevent path injection attacks via embedded newlines.
# Used by both wireguard and openvpn modules during config patching.
#
has_newline_in_path() {
  local path="$1"
  # wc -l counts newlines - if > 0, the path contains embedded newlines
  [ "$(printf '%s' "$path" | wc -l)" -gt 0 ]
}

# check_batch_success - recursively check if batch execution succeeded
# Args: $1 - exit code to check
# Returns: 0 if successful, 1 if any failure found
# Note: No cleanup - batch files retained for diagnostics (round-robin overwrites old files)
check_batch_success() {
	local exit_code="$1"

	# Exit 0: Success
	if [ "$exit_code" -eq 0 ]; then
		return 0
	fi

	# Exit 1-127: Real failure
	if [ "$exit_code" -lt 128 ]; then
		return 1
	fi

	# Exit 128-255: Batch completion - recursively check children
	local batch_id=$(( (exit_code - 128) & 0x3F ))
	local batch_file="$VPN_SWITCH_BASE/.tmp/batch-exits/$batch_id"

	if [ ! -f "$batch_file" ]; then
		# Batch file missing
		return 1
	fi

	# Check each child recursively
	# Note: || [ -n "$child_exit" ] prevents set -e from triggering on EOF
	while IFS='|' read -r child_exit child_func child_ref || [ -n "$child_exit" ]; do
		if ! check_batch_success "$child_exit"; then
			return 1
		fi
	done < "$batch_file"

	# All children succeeded
	return 0
}

# produce_with_exit - wrapper around dispatch that produces XOR output
# Either outputs dispatch results (success) OR fail command (failure)
# This enables exit code propagation through the pipeline
# Usage: produce_with_exit exit_file stdout_file stderr_file
produce_with_exit() {
	local exit_file="$1"
	local stdout_file="$2"
	# $3 (stderr_file) unused - stderr flows naturally

	trace_log "|" "produce_with_exit" "ENTRY: VPN_SWITCH_CONTEXT_CALL='$VPN_SWITCH_CONTEXT_CALL'"

	set +e  # Temporarily disable errexit to capture exit code
	# Close stdin to prevent reading from inherited pipes (nested pipeline issue)
	# Stderr flows naturally (not captured) to allow LOG_FILE redirections to work
	dispatch </dev/null > "$stdout_file"
	local dispatch_exit=$?
	trace_log "|" "produce_with_exit" "dispatch returned: $dispatch_exit before set -e"
	set -e  # Re-enable errexit

	trace_log "|" "produce_with_exit" "dispatch returned: $dispatch_exit after set -e"

	# Store exit code in file
	echo "$dispatch_exit" > "$exit_file"

	trace_log "|" "produce_with_exit" "Wrote exit code to file: $exit_file"

	# Use recursive helper to check if execution succeeded
	if ! check_batch_success "$dispatch_exit"; then
		# Failure path: show captured output, report on stderr.
		# The failure already propagates out-of-band via the producer exit
		# channel (combine_exit_codes), so no error script is injected into
		# the pipe — an injected script would be executed by sh interpreters
		# but rendered as garbage by data interpreters (cat, cut -b3-).
		cat "$stdout_file"
		printf "# Error: %s\n" "Command failed with exit $dispatch_exit" >&2
		return "$dispatch_exit"
	else
		# Success path: output dispatch results
		cat "$stdout_file"
		return $dispatch_exit
	fi
}

# extract_line1 - extracts first line to check for fail command
# Passes through all output to interpreter
# NOTE: Currently just passes through all output unchanged
# Reserved for future enhancement to detect fail commands
extract_line1() {
	IFS= read -r first_line
	echo "$first_line"
	cat
}

# to_trace_file - Filter that traces what passes through and appends to trace file
# Usage: cmd | to_trace_file '=' 'context' 'message'
to_trace_file() {
	local prefix="$1"
	local context="$2"
	local message="$3"

	if [ -n "${VPN_SWITCH_TRACE_FILE:-}" ]; then
		# Capture stdin to temp file first
		local temp_data=$(mktemp "$VPN_SWITCH_BASE/.tmp/trace-data.XXXXXX")
		cat > "$temp_data"

		# Write marker to trace file
		trace_log "$prefix" "$context" "$message"

		# Write captured data to trace file (appears after marker)
		cat "$temp_data" >> "$VPN_SWITCH_TRACE_FILE"

		# Output captured data to stdout (continue pipeline)
		cat "$temp_data"
		$MODIFY_FILE_REMOVE "$temp_data"
	else
		# No tracing - just pass through
		cat
	fi
}

# consume_with_exit - Run interpreter on stdin, output to stdout
# Stores exit code in file
# Usage: cmd | consume_with_exit exit_file interpreter
consume_with_exit() {
	local exit_file="$1"
	local interpreter="$2"

	# Defensive: If exit_file not provided, just pass through
	if [ -z "$exit_file" ]; then
		cat
		return 1
	fi

	# Create temp file for interpreter stdout
	local stdout_file=$(mktemp "$VPN_SWITCH_BASE/.tmp/consumer-out.XXXXXX")

	# Run interpreter and capture exit code
	# CRITICAL: set +e prevents shell exit on non-zero, allowing exit code capture
	set +e
	eval "run_env -- $interpreter" > "$stdout_file"
	local exit_code=$?
	set -e

	# Store exit code for caller
	echo "$exit_code" > "$exit_file"

	# Output interpreter results to stdout
	cat "$stdout_file"
	$MODIFY_FILE_REMOVE "$stdout_file"

	return $exit_code
}

#-----------------------------------------------------------------------------
# Batch Infrastructure - Exit Code Tracking
#-----------------------------------------------------------------------------

# get_batch_id - Allocate batch ID using round-robin (circular buffer)
#
# Returns a batch ID (0-63) for batch combinator execution.
# Implements simple round-robin allocation - old batch files are overwritten.
#
# Round-robin behavior:
#   - Maintains pointer to next available slot (0-63)
#   - Wraps around: (pointer + 1) % 64
#   - No cleanup needed - files naturally age out
#   - Retains last ~64 batch executions for diagnostics
#
# Returns: batch_id (0-63) on stdout
# Never fails: always returns a valid batch_id
#
# Side effects:
#   - Increments global pointer in .tmp/batch-counter (modulo 64)
#   - Uses .tmp/batch-exits/ directory (created by init)
#
get_batch_id() {
	local counter_file="$VPN_SWITCH_BASE/.tmp/batch-counter"
	local batch_dir="$VPN_SWITCH_BASE/.tmp/batch-exits"
	local batch_id=0

	# Read current position (or start at 0)
	if [ -f "$counter_file" ]; then
		batch_id=$(cat "$counter_file" 2>>"$LOG_FILE")
		# Sanitize: ensure it's in valid range
		batch_id=$(( batch_id % 64 ))
	fi

	# Calculate next position (circular)
	local next_id=$(( (batch_id + 1) % 64 ))
	echo "$next_id" > "$counter_file" 2>>"$LOG_FILE"

	# Return current position (caller will overwrite this batch file)
	echo "$batch_id"
}

# store_batch_exits - Store batch exit codes with optional batch references
#
# Stores space-separated exit codes to batch file for later decoding.
# Supports batch reference format for nested batches: "exit:batch_ref"
#
# Args:
#   $1 - batch_id (0-63)
#   $2+ - exit codes (format: "exit" or "exit:batch_ref")
#
# Side effects:
#   - Creates/appends to .tmp/batch-exits/$batch_id
#
store_batch_exits() {
	local batch_id="$1"
	shift
	local batch_file="$VPN_SWITCH_BASE/.tmp/batch-exits/$batch_id"

	# Create batch file with space-separated exit codes
	echo "$@" > "$batch_file" 2>>"$LOG_FILE"
}

# free_batch_id - Clean up batch exit file
#
# Removes batch file after results have been decoded.
#
# Args:
#   $1 - batch_id (0-63)
#
# Side effects:
#   - Deletes .tmp/batch-exits/$batch_id
#
free_batch_id() {
	local batch_id="$1"
	local batch_file="$VPN_SWITCH_BASE/.tmp/batch-exits/$batch_id"

	$MODIFY_FILE_REMOVE "$batch_file" 2>>"$LOG_FILE"
}

# combine_exit_codes - Combine producer and consumer exit codes
#
# Constructs hierarchical EXIT_BITS structure and returns combined exit code.
# Understands batch completion codes and handles them appropriately.
#
# Args:
#   $1 - init_bits: inherited exit bits from parent (simplified notation)
#   $2 - producer_exit: raw producer exit code (0-255)
#   $3 - consumer_exit: raw consumer exit code (0-255)
#
# Returns: Combined exit code (0-255)
#
# Side effects:
#   - Updates VPN_SWITCH_CONTEXT_EXIT_BITS
#   - May read batch files if exit codes >= 128
#
combine_exit_codes() {
	local init_bits="$1"
	local producer_exit="$2"
	local consumer_exit="$3"

	# Trace entry point with all parameters
	trace_log "|" "combine_exit_codes" "ENTRY: init_bits='$init_bits' producer_exit='$producer_exit' consumer_exit='$consumer_exit'"

	# Defensive: Check if exit codes are valid numbers
	if [ -z "$producer_exit" ] || ! [ "$producer_exit" -eq "$producer_exit" ] 2>/dev/null; then
		trace_log "!" "combine_exit_codes" "Invalid producer_exit='$producer_exit' - FAILING"
		echo "# ERROR: Invalid producer_exit='$producer_exit' in combine_exit_codes" >&2
		return 1
	fi
	if [ -z "$consumer_exit" ] || ! [ "$consumer_exit" -eq "$consumer_exit" ] 2>/dev/null; then
		trace_log "!" "combine_exit_codes" "Invalid consumer_exit='$consumer_exit' - FAILING"
		echo "# ERROR: Invalid consumer_exit='$consumer_exit' in combine_exit_codes" >&2
		return 1
	fi

	# Check if producer is batch completion code
	if [ "$producer_exit" -ge 128 ]; then
		# Producer returned batch code - propagate it up
		# Extract batch_id and read batch file
		local batch_id=$(( (producer_exit - 128) & 0x3F ))
		local batch_file="$VPN_SWITCH_BASE/.tmp/batch-exits/$batch_id"

		if [ ! -f "$batch_file" ]; then
			echo "# ERROR: Batch file not found: $batch_file" >&2
			return 1
		fi

		# Build space-separated list of child results
		local children=""
		# Note: || [ -n "$exit_code" ] prevents set -e from triggering on EOF
		while IFS='|' read -r exit_code function_args batch_ref || [ -n "$exit_code" ]; do
			# Skip empty lines
			[ -z "$exit_code" ] && continue

			if [ -z "$children" ]; then
				children="$exit_code"
			else
				children="$children $exit_code"
			fi
		done < "$batch_file"

		# Construct hierarchical structure: "batch_children . consumer"
		# Consumer normalized to bit
		local c_bit=0
		if [ "$consumer_exit" -ne 0 ]; then
			c_bit=1
		fi
		VPN_SWITCH_CONTEXT_EXIT_BITS="$children . $c_bit"
		export VPN_SWITCH_CONTEXT_EXIT_BITS

		# Propagate batch completion code
		return "$producer_exit"
	fi

	# Check if consumer is batch completion code
	if [ "$consumer_exit" -ge 128 ]; then
		# Consumer returned batch code
		# Extract batch_id from batch exit code
		local batch_id=$(( (consumer_exit - 128) & 0x3F ))

		# Read batch file and construct child results
		local batch_file="$VPN_SWITCH_BASE/.tmp/batch-exits/$batch_id"

		if [ ! -f "$batch_file" ]; then
			echo "# ERROR: Batch file not found: $batch_file" >&2
			return 1
		fi

		# Build space-separated list of child results
		local children=""
		# Note: || [ -n "$exit_code" ] prevents set -e from triggering on EOF
		while IFS='|' read -r exit_code function_args batch_ref || [ -n "$exit_code" ]; do
			# Skip empty lines
			[ -z "$exit_code" ] && continue

			# Each line is a child result (already encoded as single exit code)
			if [ -z "$children" ]; then
				children="$exit_code"
			else
				children="$children $exit_code"
			fi
		done < "$batch_file"

		# Normalize producer to bit
		local p_bit=0
		if [ "$producer_exit" -ne 0 ]; then
			p_bit=1
		fi

		# Construct hierarchical structure: "p . child1 child2 child3"
		# Store in EXIT_BITS for debugging/analysis
		VPN_SWITCH_CONTEXT_EXIT_BITS="$p_bit . $children"
		export VPN_SWITCH_CONTEXT_EXIT_BITS

		# Propagate batch completion code
		return "$consumer_exit"
	fi

	# Both producer and consumer are regular exit codes (0-127)
	# Normalize to bits and encode
	local p_bit=0
	if [ "$producer_exit" -ne 0 ]; then
		p_bit=1
	fi

	local c_bit=0
	if [ "$consumer_exit" -ne 0 ]; then
		c_bit=1
	fi

	# Build pair structure: "p.c"
	VPN_SWITCH_CONTEXT_EXIT_BITS="$p_bit.$c_bit"
	export VPN_SWITCH_CONTEXT_EXIT_BITS

	# Encode into bit pattern
	# Current level encoding: (p << 1) | c
	local encoded=$(( (p_bit << 1) | c_bit ))

	# Return encoded exit code
	return "$encoded"
}

process_arguments() {
  # Resolve function call first (needed for module loading and execution)
  local resolved_call=$(to_function_call "$ANCHOR_FUNCTIONS" "$@")
  export VPN_SWITCH_CONTEXT_CALL="$resolved_call"

  # Dynamic module loading: deterministic function-to-module lookup
  # Extract function name (first word before space or entire string if no space)
  local func_name="${resolved_call%% *}"

  # Look up module in FUNCTION_MODULES mapping (format: "func:module.sh func:module.sh ...")
  # This is a build-time generated mapping - see scripts/generate-metadata.sh
  for mapping in $FUNCTION_MODULES; do
    case "$mapping" in
      "$func_name":*)
        # Extract module name after colon
        local module_name="${mapping#*:}"
        local module_file="$VPN_SWITCH_LIBDIR/include/$module_name"

        # Load module if it exists
        if [ -f "$module_file" ]; then
          . "$module_file"
        fi
        break
        ;;
    esac
  done

  # Setup automatic logging and tracing (if retention configured)
  # Note: func_name already extracted above for module loading

  # Check retention settings (default: LOG=1 day, TRACE=1 day)
  local log_retention=${VPN_SWITCH_RETENTION_DAYS_LOG:-1}
  local trace_retention=${VPN_SWITCH_RETENTION_DAYS_TRACE:-1}

  # Generate timestamp components
  local log_date=$(date +%Y-%m-%d)
  local log_time=$(date +%H%M%S)
  local log_timestamp="${log_time}.$$"  # Include PID to prevent collisions

  # Determine log base directory (bootstrap uses target database, others use current)
  local log_base="$VPN_SWITCH_BASE"
  if [ "$func_name" = "__bootstrap2" ]; then
    # Bootstrap: extract basedir from first argument
    log_base="$1"
  fi

  # Create log directory for today (if logging/tracing enabled)
  if [ "$log_retention" -gt 0 ] || [ "$trace_retention" -gt 0 ]; then
    local log_dir="$log_base/.log/$log_date"
    $MODIFY_DIR_CREATE "$log_dir" 2>>"$LOG_FILE" || true
    # Set proper permissions on .log directory (extract from VPN_SWITCH_INIT_DIR_CONFIG)
    local log_mode=$(echo "$VPN_SWITCH_INIT_DIR_CONFIG" | grep '^\.log:' | cut -d: -f2)
    if [ -n "$log_mode" ]; then
      $MODIFY_FILE_PERMS "$log_mode" "$log_base/.log" 2>>"$LOG_FILE" || true
    fi
  fi

  # Ensure .tmp directory exists (required for exit code propagation)
  # This is needed before any mktemp calls in the pipeline execution below
  # Note: init also creates .tmp, but dispatch needs it first (chicken-and-egg problem)
  # Mode 0750: allows group access for sudo scenarios (operational directory)
  if [ ! -d "$VPN_SWITCH_BASE/.tmp" ]; then
    $MODIFY_DIR_CREATE "$VPN_SWITCH_BASE/.tmp" 2>>"$LOG_FILE" || true
    $MODIFY_FILE_PERMS 0750 "$VPN_SWITCH_BASE/.tmp" 2>>"$LOG_FILE" || true
  fi

  # Setup LOG_FILE (if not already set and retention > 0)
  # Treat /dev/null as "not set" since it's the default value
  if { [ -z "${LOG_FILE:-}" ] || [ "$LOG_FILE" = "/dev/null" ]; } && [ "$log_retention" -gt 0 ]; then
    # Only use real log file if directory exists and is writable (graceful degradation)
    if [ -d "$log_base/.log/$log_date" ] && [ -w "$log_base/.log/$log_date" ]; then
      export LOG_FILE="$log_base/.log/$log_date/${log_timestamp}_${func_name}.log"
    else
      export LOG_FILE="/dev/null"
    fi
  elif [ "$log_retention" -eq 0 ]; then
    # Retention disabled - redirect to /dev/null
    export LOG_FILE="/dev/null"
  fi

  # Setup TRACE_FILE automatically based on retention setting
  # If user hasn't explicitly set VPN_SWITCH_TRACE_FILE, create it in database's .log/ directory
  if [ -z "${VPN_SWITCH_TRACE_FILE:-}" ] && [ "$trace_retention" -gt 0 ]; then
    # Only use real trace file if directory exists and is writable (graceful degradation)
    if [ -d "$log_base/.log/$log_date" ] && [ -w "$log_base/.log/$log_date" ]; then
      export VPN_SWITCH_TRACE_FILE="$log_base/.log/$log_date/${log_timestamp}_${func_name}.trace"
    else
      unset VPN_SWITCH_TRACE_FILE
    fi
  elif [ "$trace_retention" -eq 0 ]; then
    # Trace disabled - unset the variable
    unset VPN_SWITCH_TRACE_FILE
  fi

  # Execute pipeline with optional tracing
  # If VPN_SWITCH_TRACE_FILE is set, capture intermediate output via tee
  if [ -n "${VPN_SWITCH_TRACE_FILE:-}" ]; then
    # Validate trace file path to prevent creating files with bare PIDs
    # Path must contain a slash (absolute or relative) or start with a dot
    case "$VPN_SWITCH_TRACE_FILE" in
      */*|.*)
        # Valid path - contains directory component
        ;;
      *)
        # Invalid: bare filename without directory (could be corrupted to PID)
        echo "# ERROR: Invalid trace file path (must be absolute or relative with directory): $VPN_SWITCH_TRACE_FILE" >&2
        echo "#        Disabling tracing for safety." >&2
        VPN_SWITCH_TRACE_FILE=""
        ;;
    esac
  fi

  # Read inherited EXIT_BITS from environment (default: 0 for top level)
  local init_bits="${VPN_SWITCH_CONTEXT_EXIT_BITS:-0}"

  # If VPN_SWITCH_TRACE_FILE is still set after validation, capture intermediate output via tee
  if [ -n "${VPN_SWITCH_TRACE_FILE:-}" ]; then
    trace_log "|" "process_arguments" "provided arguments '$*' resolve to function call: '$resolved_call'"
    trace_log "|" "process_arguments" "inherited EXIT_BITS: $init_bits"

    # Determine interpreter based on resolved function (intrinsic classification)
    local interpreter=$(echo "$resolved_call" | lookup_interpreter)
    trace_log "|" "process_arguments" "Interpreter resolved: $interpreter"


    # Store trace file locally and export for subshells in pipeline
    local trace_file="$VPN_SWITCH_TRACE_FILE"
    export VPN_SWITCH_TRACE_FILE

    # Create temp files for exit codes
    local temp_producer_exit=$(mktemp "$VPN_SWITCH_BASE/.tmp/producer-exit.XXXXXX")
    local temp_producer_out=$(mktemp "$VPN_SWITCH_BASE/.tmp/producer-out.XXXXXX")
    local temp_producer_err=$(mktemp "$VPN_SWITCH_BASE/.tmp/producer-err.XXXXXX")
    local temp_consumer_exit=$(mktemp "$VPN_SWITCH_BASE/.tmp/consumer-exit.XXXXXX")

    # Debug temp files to trace data flow
    local temp_after_produce=$(mktemp "$VPN_SWITCH_BASE/.tmp/debug-after-produce.XXXXXX")
    local temp_after_trace1=$(mktemp "$VPN_SWITCH_BASE/.tmp/debug-after-trace1.XXXXXX")
    local temp_after_consume=$(mktemp "$VPN_SWITCH_BASE/.tmp/debug-after-consume.XXXXXX")

    # Run pipeline: produce_with_exit | to_trace_file | consume_with_exit | to_trace_file
    produce_with_exit "$temp_producer_exit" "$temp_producer_out" "$temp_producer_err" \
      | tee "$temp_after_produce" \
      | to_trace_file '=' 'process_arguments' '--- input to interpreter ---' \
      | tee "$temp_after_trace1" \
      | consume_with_exit "$temp_consumer_exit" "$interpreter" \
      | tee "$temp_after_consume" \
      | to_trace_file '>' 'process_arguments' '--- output from interpreter ---'

    # Read exit codes from temp files; trace only the error paths and the
    # final values (logged below as "producer/consumer exit code: ...")
    if [ ! -f "$temp_producer_exit" ]; then
      trace_log "!" "process_arguments" "Producer exit file missing!"
    elif [ ! -s "$temp_producer_exit" ]; then
      trace_log "!" "process_arguments" "Producer exit file exists but is empty!"
    fi
    local producer_exit=$(cat "$temp_producer_exit" 2>/dev/null || echo "ERROR_PRODUCER")

    if [ ! -f "$temp_consumer_exit" ]; then
      trace_log "!" "process_arguments" "Consumer exit file missing!"
    elif [ ! -s "$temp_consumer_exit" ]; then
      trace_log "!" "process_arguments" "Consumer exit file exists but is empty!"
    fi
    local consumer_exit=$(cat "$temp_consumer_exit" 2>/dev/null || echo "ERROR_CONSUMER")

    # Clean up temp files
    $MODIFY_FILE_REMOVE "$temp_producer_exit" "$temp_producer_out" "$temp_producer_err" "$temp_consumer_exit" \
          "$temp_after_produce" "$temp_after_trace1" "$temp_after_consume"

    trace_log "|" "process_arguments" "producer exit code: $producer_exit"
    trace_log "|" "process_arguments" "consumer exit code: $consumer_exit"

    # Combine exit codes and construct hierarchical structure
    # Let combine_exit_codes understand what exit codes mean and handle them
    # CRITICAL: Disable set -e to allow capturing exit codes >127
    local combined_exit
    set +e
    combine_exit_codes "$init_bits" "$producer_exit" "$consumer_exit"
    combined_exit=$?
    set -e

    trace_log "|" "process_arguments" "combined exit code: $combined_exit"
    trace_log "|" "process_arguments" "final EXIT_BITS: ${VPN_SWITCH_CONTEXT_EXIT_BITS}"
    trace_log "=" "process_arguments" "=========================================="

    set +e
    return $combined_exit
  else
    # No tracing: direct execution (faster, cleaner output)
    local interpreter=$(echo "$resolved_call" | lookup_interpreter)

    # Create temp files for exit codes
    local temp_producer_exit=$(mktemp "$VPN_SWITCH_BASE/.tmp/producer-exit.XXXXXX")
    local temp_producer_out=$(mktemp "$VPN_SWITCH_BASE/.tmp/producer-out.XXXXXX")
    local temp_producer_err=$(mktemp "$VPN_SWITCH_BASE/.tmp/producer-err.XXXXXX")
    local temp_consumer_exit=$(mktemp "$VPN_SWITCH_BASE/.tmp/consumer-exit.XXXXXX")

    # Run pipeline: produce_with_exit | consume_with_exit (no tracing)
    produce_with_exit "$temp_producer_exit" "$temp_producer_out" "$temp_producer_err" \
      | consume_with_exit "$temp_consumer_exit" "$interpreter"

    local producer_exit=$(cat "$temp_producer_exit" 2>/dev/null || echo "ERROR_PRODUCER")
    local consumer_exit=$(cat "$temp_consumer_exit" 2>/dev/null || echo "ERROR_CONSUMER")

    $MODIFY_FILE_REMOVE "$temp_producer_exit" "$temp_producer_out" "$temp_producer_err" "$temp_consumer_exit"

    # Combine exit codes and construct hierarchical structure
    # Let combine_exit_codes understand what exit codes mean and handle them
    # CRITICAL: Disable set -e to allow capturing exit codes >127
    local combined_exit
    set +e
    combine_exit_codes "$init_bits" "$producer_exit" "$consumer_exit"
    combined_exit=$?
    set -e
    set +e
    return $combined_exit
  fi
}

#-----------------------------------------------------------------------------
# Phase 3.2 Commands - Protocol-Agnostic Start
#-----------------------------------------------------------------------------

# _error1 - Output error with 1 message line
#
# Usage: vpn-switch error "message"
#
# This is a terminal function that outputs shell commands to display
# an error message and exit with code 1. The error message is formatted
# with color support (if ANSI enabled) and sent to stderr.
#
# Used by:
# - COMBINATOR functions via: echo "\"$VPN_SWITCH_CONTEXT_SCRIPT\" error \"message\""
# - Direct invocation for testing/debugging
#
#@help _error1
# @internal emit a formatted error message (diagnostics helper)
#@end
_error1() {
  generate_error "$1"
}

# _error2 - Output error with 2 message lines
#
# Usage: vpn-switch error "message line 1" "message line 2"
#
# Same as _error1 but formats multi-line errors with proper indentation:
#   Error: line 1
#     line 2
#
#@help _error2
# @internal emit a formatted error with detail (diagnostics helper)
#@end
_error2() {
  generate_error "$1" "$2"
}

# _error3 - Output error with 3 message lines
#
# Usage: vpn-switch error "line 1" "line 2" "line 3"
#
# Same as _error1/_error2 but supports up to 3 lines:
#   Error: line 1
#     line 2
#     line 3
#
#@help _error3
# @internal emit a formatted error with detail and hint (diagnostics helper)
#@end
_error3() {
  generate_error "$1" "$2" "$3"
}

# _fail2 - Propagate failure with preserved exit code
#
# Usage: vpn-switch fail <exit_code> "message"
#
# Used by exit code propagation infrastructure to preserve exact exit codes
# from failed commands (e.g., 127 for command not found, 126 for permission denied).
#
# Unlike error (which always exits with 1), fail preserves the original exit code.
# This helps distinguish:
# - VPN-switch errors (use error → exit 1)
# - External command failures (use fail → preserve code)
#
# Args:
#   $1 - Exit code to propagate (e.g., 127, 126, 2)
#   $2 - Error message
#
#@help _fail2
# @internal emit an error and signal failure (diagnostics helper)
#@end
_fail2() {
  local exit_code="$1"
  local message="$2"

  # Output error message to stderr
  if [ "${VPN_SWITCH_DISPLAY_ANSI:-0}" != "0" ]; then
    echo "printf \"# \\033[1;31mError:\\033[0m %s\\n\" \"$message\" >&2"
  else
    echo "printf \"# Error: %s\\n\" \"$message\" >&2"
  fi

  # Exit with preserved code
  echo "exit $exit_code"
}

# _log1 - Output informational message (non-error)
#
# Usage: vpn-switch log "message"
#
# Outputs an informational message to stdout (not stderr).
# Used for success cases that need user feedback (e.g., "No sessions to stop").
# Always returns 0 (success).
#
#@help _log1
# @internal emit a log message (diagnostics helper)
#@end
_log1() {
  echo "printf \"# %s\\n\" \"$1\""
}

# _log2 - Output informational message with 2 lines
#
# Usage: vpn-switch log "message line 1" "message line 2"
#
# Same as _log1 but supports 2 lines:
#   line 1
#   line 2
#
#@help _log2
# @internal emit a log message with detail (diagnostics helper)
#@end
_log2() {
  echo "printf \"# %s\\n\" \"$1\""
  echo "printf \"# %s\\n\" \"$2\""
}

# _log3 - Output informational message with 3 lines
#
# Usage: vpn-switch log "line 1" "line 2" "line 3"
#
# Same as _log1/_log2 but supports up to 3 lines:
#   line 1
#   line 2
#   line 3
#
#@help _log3
# @internal emit a log message with detail and hint (diagnostics helper)
#@end
_log3() {
  echo "printf \"# %s\\n\" \"$1\""
  echo "printf \"# %s\\n\" \"$2\""
  echo "printf \"# %s\\n\" \"$3\""
}

#-----------------------------------------------------------------------------
# Phase 1 Commands - Status
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# Usage / Help
#-----------------------------------------------------------------------------

usage() {
  # Helper to output colored or plain text based on VPN_SWITCH_DISPLAY_ANSI
  local c_reset="" c_heading="" c_cmd="" c_gray=""

  if [ "${VPN_SWITCH_DISPLAY_ANSI:-0}" = "1" ]; then
    c_reset="$COLOR_RESET"
    c_heading="$COLOR_BLUE"
    c_cmd="$COLOR_CYAN"
    c_gray="$COLOR_GRAY"
  fi

  printf '%b\n' "$(cat <<EOF
${c_heading}vpn-switch v2.0${c_reset} - Manage VPN connections

${c_heading}Usage:${c_reset}
  ${c_cmd}vpn-switch wireguard start <category>${c_reset}   Start VPN with category
  ${c_cmd}vpn-switch stop${c_reset}                         Stop all VPN connections
  ${c_cmd}vpn-switch status${c_reset}                       Show VPN status
  ${c_cmd}vpn-switch help${c_reset}                         Show this help

${c_heading}Session Management:${c_reset}
  ${c_cmd}vpn-switch session list${c_reset}                 List active sessions
  ${c_cmd}vpn-switch session show [PID]${c_reset}           Show session connect script
  ${c_cmd}vpn-switch session start [name|PID]${c_reset}     Resume saved session
  ${c_cmd}vpn-switch session stop [name|PID]${c_reset}      Stop active session
  ${c_cmd}vpn-switch session save [name]${c_reset}          Save current session
  ${c_cmd}vpn-switch session remove <PID>${c_reset}         Remove stale session
  ${c_cmd}vpn-switch session clean${c_reset}                Clean stale symlinks

  ${c_gray}Note: Sessions are stored in .session/ (metadata) and session/ (named links)${c_reset}

${c_heading}Config Management:${c_reset}
  ${c_cmd}vpn-switch wireguard list [category]${c_reset}    List configs and categories
  ${c_cmd}vpn-switch wireguard add <category> [config]${c_reset}  Add config to category
  ${c_cmd}vpn-switch wireguard link <alias> <target>${c_reset}    Create symlink
  ${c_cmd}vpn-switch wireguard remove <name>${c_reset}      Remove config or link
  ${c_cmd}vpn-switch wireguard import <file>${c_reset}      Import config file
  ${c_cmd}vpn-switch wireguard info <category>${c_reset}    Show category information
  ${c_cmd}vpn-switch wireguard patch <config>${c_reset}     Show patched config
  ${c_cmd}vpn-switch wireguard validate${c_reset}           Validate configurations
  ${c_cmd}vpn-switch wireguard clean${c_reset}              Generate cleanup commands

${c_heading}Database Management:${c_reset}
  ${c_cmd}vpn-switch bootstrap <basedir> <profile>${c_reset} Bootstrap new database
  ${c_cmd}vpn-switch dump [> file]${c_reset}                Dump database to stdout/file
  ${c_cmd}vpn-switch restore <file>${c_reset}               Restore from dump file
  ${c_cmd}vpn-switch batch <file>${c_reset}                 Execute commands from file

  ${c_gray}Note: Dump creates portable backups, restore requires original config files${c_reset}

${c_heading}Environment Management:${c_reset}
  ${c_cmd}vpn-switch setenv <var> <value>${c_reset}        Set environment variable
  ${c_cmd}vpn-switch getenv <var>${c_reset}                Get environment variable value
  ${c_cmd}vpn-switch unsetenv <var>${c_reset}              Unset environment variable

  ${c_gray}Note: Changes are written to .env/local/ and take effect next command${c_reset}

${c_heading}Examples:${c_reset}
  ${c_cmd}vpn-switch wireguard start privacy${c_reset}      ${c_gray}# Start VPN from privacy category${c_reset}
  ${c_cmd}vpn-switch session save work${c_reset}            ${c_gray}# Save current session as 'work'${c_reset}
  ${c_cmd}vpn-switch session start work${c_reset}           ${c_gray}# Resume 'work' session${c_reset}
  ${c_cmd}vpn-switch dump > backup.sh${c_reset}             ${c_gray}# Backup database to file${c_reset}
  ${c_cmd}vpn-switch restore backup.sh${c_reset}            ${c_gray}# Restore database from file${c_reset}
  ${c_cmd}vpn-switch setenv VPN_SWITCH_DISPLAY_ANSI 1${c_reset}  ${c_gray}# Enable colored output${c_reset}
  ${c_cmd}vpn-switch getenv VPN_SWITCH_BASE${c_reset}       ${c_gray}# Show base directory${c_reset}
  ${c_cmd}vpn-switch wireguard validate${c_reset}           ${c_gray}# Check for broken links${c_reset}
  ${c_cmd}vpn-switch stop${c_reset}                         ${c_gray}# Stop VPN${c_reset}

${c_heading}Environment:${c_reset}
  ${c_cmd}VPN_SWITCH_BASE${c_reset}          Base directory (must exist, default: /usr/local/etc/vpn-switch)
  ${c_cmd}VPN_SWITCH_DISPLAY_ANSI${c_reset}  Colored output (0=off, 1=on)

  ${c_gray}Note: Commands displayed instead of executed? This is the safety-first design.${c_reset}
        ${c_gray}See '${c_cmd}vpn-switch help environment${c_reset}${c_gray}' for details on auto-execution mode.${c_reset}

${c_heading}For detailed help:${c_reset}
  ${c_cmd}vpn-switch help environment${c_reset}     Environment system and safety-first design
  ${c_cmd}vpn-switch help profile${c_reset}         Profile system and installation
  ${c_cmd}vpn-switch wireguard help${c_reset}       Show WireGuard command help
  ${c_cmd}vpn-switch session help${c_reset}         Show session management help
  See README.md for complete documentation

${c_heading}Your call:${c_reset}
  ${c_cmd}env VPN_SWITCH_BASE=\$VPN_SWITCH_BASE \$CMDLINE_ARGUMENTS${c_reset}

EOF
)" >&2 # workaround for my IDE "
  return 0
}

#-----------------------------------------------------------------------------
# Environment Sanity Check
#-----------------------------------------------------------------------------

# Check for required environment variables and directory existence
environment_sanity_check() {
  local errors=""
  local warnings=""

  # Check VPN_SWITCH_BASE is set
  if [ -z "${VPN_SWITCH_BASE:-}" ]; then
    warnings="${warnings}WARNING: VPN_SWITCH_BASE is not set\n"
  elif [ ! -d "${VPN_SWITCH_BASE}" ]; then
    errors="${errors}ERROR: VPN_SWITCH_BASE directory does not exist: ${VPN_SWITCH_BASE}\n"
  fi

  # Check all interpreter variables are set (required for proper operation)
  if [ -z "${VPN_SWITCH_COMBINATOR_INTERPRETER:-}" ]; then
    errors="${errors}ERROR: VPN_SWITCH_COMBINATOR_INTERPRETER is not set\n"
  fi

  if [ -z "${VPN_SWITCH_TERMINAL_INTERPRETER:-}" ]; then
    errors="${errors}ERROR: VPN_SWITCH_TERMINAL_INTERPRETER is not set\n"
  fi

  if [ -z "${VPN_SWITCH_BATCH_COMBINATOR_INTERPRETER:-}" ]; then
    errors="${errors}ERROR: VPN_SWITCH_BATCH_COMBINATOR_INTERPRETER is not set\n"
  fi

  # Print warnings if any
  if [ -n "${warnings}" ]; then
    printf "%b" "${warnings}" >&2
  fi

  # Print errors and exit if any
  if [ -n "${errors}" ]; then
    printf "%b" "${errors}" >&2
    exit 1
  fi
}

# shellcheck disable=SC2034  # CMDLINE_ARGUMENTS preserved for usage() to display original command
CMDLINE_ARGUMENTS="$@"

#-----------------------------------------------------------------------------
# Top-Level Bootstrap - Load Environment Once
#-----------------------------------------------------------------------------

# ensure_interpreter_var - Ensure interpreter variable exists in env_args
#
# Args: $1 - Variable name (e.g., "VPN_SWITCH_TERMINAL_INTERPRETER")
#
# Reads default value from template directory (first line of template file).
# This ensures bootstrap defaults stay in sync with documented template values.
#
# Modifies: env_args (global variable)
#
ensure_interpreter_var() {
  local var_name="$1"

  # Skip if variable already present in env_args
  if echo "$env_args" | grep -q "$var_name"; then
    return 0
  fi

  # Use VPN_SWITCH_TEMPLATE_DIR (already set as bootstrap variable)
  # Read default value from template (first line)
  local template_file="$VPN_SWITCH_TEMPLATE_DIR/environment/$var_name"
  local default_value

  if [ -f "$template_file" ]; then
    default_value=$(head -n 1 "$template_file")
  else
    # Fallback if template doesn't exist (should never happen in normal operation)
    echo "# Warning: Template not found: $template_file" >&2
    case "$var_name" in
      VPN_SWITCH_TERMINAL_INTERPRETER)
        default_value="cat"
        ;;
      VPN_SWITCH_COMBINATOR_INTERPRETER)
        default_value='xargs sh -c '"'"'eval exec "$0" "$@"'"'"' --'
        ;;
      VPN_SWITCH_BATCH_COMBINATOR_INTERPRETER)
        # Note: $MODIFY_FILE_PERMS expands now; other $ vars are escaped for later execution
        default_value="sh -c 'tmp=\$(mktemp \"\$VPN_SWITCH_BASE/.tmp/batch.XXXXXX\"); $MODIFY_FILE_PERMS 0600 \"\$tmp\"; cat > \"\$tmp\"; \"\$VPN_SWITCH_CONTEXT_SCRIPT\" batch \"\$tmp\" true'"
        ;;
      *)
        echo "# Error: Unknown interpreter variable: $var_name" >&2
        return 1
        ;;
    esac
  fi

  # Escape single quotes in value for safe inclusion in env_args
  # Replace each ' with '\'' (close quote, escaped quote, open quote)
  local escaped_value
  escaped_value=$(printf '%s' "$default_value" | sed "s/'/'\\\\''/g")

  env_args="$env_args $var_name='$escaped_value'"
}

#-----------------------------------------------------------------------------
# Main Entry Point
#-----------------------------------------------------------------------------

main() {
  # Normal user flow starts here
  # (Environment already bootstrapped at top level before main() was called)

  # Capture original command for interpreter context
  VPN_SWITCH_CONTEXT_COMMAND="$*"

  # Trace: Initial command invocation
  trace_log "=" "main" "=========================================="
  trace_log "|" "main" "Session started: $(date '+%Y-%m-%d %H:%M:%S')"
  trace_log "|" "main" "Command: vpn-switch.sh $*"

  #---------------------------------------------------------------------------
  # Part 1: Special commands that run BEFORE environment checks
  #---------------------------------------------------------------------------
  #
  # Some commands need to run before VPN_SWITCH_BASE existence checks:
  # - bootstrap: Creates the database, so BASE doesn't need to exist yet
  #
  # These commands handle their own environment setup and exit early.
  #
  if [ "${1:-}" = "bootstrap" ]; then
    # Bootstrap command: Configure environment before dispatch
    # Bootstrap runs BEFORE database exists, so we must provide complete
    # environment via CACHE_ENV_ARGS (no .env files available yet)

    # Resolve function call first (needed for module loading)
    local resolved_call=$(to_function_call "$ANCHOR_FUNCTIONS" "$@")
    export VPN_SWITCH_CONTEXT_CALL="$resolved_call"

    # Dynamic module loading: deterministic function-to-module lookup
    # Bootstrap bypasses process_arguments(), so we must load module manually
    local func_name="${resolved_call%% *}"
    for mapping in $FUNCTION_MODULES; do
      case "$mapping" in
        "$func_name":*)
          local module_name="${mapping#*:}"
          local module_file="$VPN_SWITCH_LIBDIR/include/$module_name"
          if [ -f "$module_file" ]; then
            . "$module_file"
          fi
          break
          ;;
      esac
    done

    # IMPORTANT: Set VPN_SWITCH_BASE to an existing directory for bootstrap
    # The nested init call needs BASE to exist, so we use /tmp as a safe default
    # The actual target directory is passed by _bootstrap1 as an argument to init
    VPN_SWITCH_BASE="${TMPDIR:-/tmp}"

    # Export complete environment for bootstrap execution
    # Override bootstrap and init interpreters (init is called by bootstrap)
    # Provide PATH for file operations (no sbin directories needed)
    export VPN_SWITCH_CACHE_ENV_ARGS="PATH='/bin:/usr/bin:/usr/local/bin' VPN_SWITCH_INTERPRETER_bootstrap='sh' VPN_SWITCH_INTERPRETER_init='sh'"

    # Evaluate CACHE_ENV_ARGS to make variables available for lookup_interpreter
    eval "export $VPN_SWITCH_CACHE_ENV_ARGS"

    # Dispatch function (generates commands, reads from CONTEXT_CALL)
    local function_output=$(dispatch)

    # Lookup interpreter (can now see CACHE_ENV_ARGS with interpreter override)
    local interpreter=$(echo "$resolved_call" | lookup_interpreter)

    # Execute the captured output
    echo "$function_output" | run_env -- $interpreter

    return 0  # Bootstrap complete, exit early
  fi

  #---------------------------------------------------------------------------
  # Part 2: Environment checks (required for all normal commands)
  #---------------------------------------------------------------------------

  # Emit warning if VPN_SWITCH_BASE was not explicitly set
  if [ -z "$VPN_SWITCH_BASE_EXPLICIT" ]; then
    echo "# Warning: VPN_SWITCH_BASE not set, using default: $VPN_SWITCH_BASE" >&2
    echo "#          Set VPN_SWITCH_BASE=/path/to/vpn to suppress this warning." >&2
  fi

  # Allow certain commands without database (defined in COMMANDS_WITHOUT_DATABASE)
  # These commands can run before database initialization (e.g., help, bootstrap)
  for cmd in $COMMANDS_WITHOUT_DATABASE; do
    for arg in "$@"; do
      if [ "$arg" = "$cmd" ]; then
        # Help command needs VPN_SWITCH_BASE set to an existing directory
        # because process_arguments() uses .tmp for exit code propagation
        # Other commands (bootstrap, init) handle their own VPN_SWITCH_BASE
        if [ "$cmd" = "help" ]; then
          VPN_SWITCH_BASE="${TMPDIR:-/tmp}"
        fi
        # complete works with or without a database: with one, placeholders
        # complete to real configs/sessions; without, only the command words.
        # Keyed on the first word: the words being completed may themselves
        # be 'help' or 'bootstrap' and must not trigger their special cases.
        if [ "${1:-}" = "complete" ] && [ ! -d "$VPN_SWITCH_BASE" ]; then
          VPN_SWITCH_BASE="${TMPDIR:-/tmp}"
        fi

        # Ensure interpreter variables have defaults (no .env files available)
        # Start with CACHE_ENV_ARGS if set (e.g., from bootstrap's init call)
        env_args="${VPN_SWITCH_CACHE_ENV_ARGS:-}"
        ensure_interpreter_var "VPN_SWITCH_TERMINAL_INTERPRETER"
        ensure_interpreter_var "VPN_SWITCH_COMBINATOR_INTERPRETER"
        ensure_interpreter_var "VPN_SWITCH_BATCH_COMBINATOR_INTERPRETER"
        # complete emits words for the shell, never commands: its cat pin must
        # hold even on a database that predates the template (no env sync yet)
        # and even when the user flipped the terminal interpreter to sh.
        if [ "${1:-}" = "complete" ]; then
          ensure_interpreter_var "VPN_SWITCH_INTERPRETER_complete"
        fi
        eval "export $env_args"

        local exit_code
        process_arguments "$@"
        exit_code=$?
        # Use check_batch_success to handle batch completion codes
        if check_batch_success "$exit_code"; then
          return 0
        else
          return 1
        fi
      fi
    done
  done

  # Ensure VPN_SWITCH_BASE exists (required for all other commands)
  if [ ! -d "$VPN_SWITCH_BASE" ]; then
    error "VPN base directory not found: $VPN_SWITCH_BASE"
  fi

  #---------------------------------------------------------------------------
  # Part 3: Normal command execution via process_arguments()
  #---------------------------------------------------------------------------
  #
  # Delegate to process_arguments() which handles:
  # 1. Command-line arg resolution via to_function_call()
  # 2. Interpreter lookup via lookup_interpreter() (intrinsic classification)
  # 3. Execution via dispatch | run_env -- $interpreter
  # 4. Optional tracing (if VPN_SWITCH_TRACE_FILE is set)
  #
  # This ensures consistent execution logic for both:
  # - Top-level commands (via main)
  # - Batch commands (via _batch2)
  #
  # Tracing flows continuously through nested calls, including batch execution.
  #
  local exit_code
  process_arguments "$@"
  exit_code=$?

  # Convert batch completion codes to simple success/failure for user
  # Use check_batch_success() to recursively determine if execution succeeded
  if check_batch_success "$exit_code"; then
    return 0
  else
    return 1
  fi
}

# Run main if executed directly
