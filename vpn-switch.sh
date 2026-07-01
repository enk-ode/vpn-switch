#!/bin/sh
#
# === AUTO-GENERATED METADATA (make metadata) ===
# Generated: 2026-06-28 12:26:37
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
# vpn-switch - Manage and initiate VPN connections
# Version 2.0 - Combinator-based architecture
#
# POSIX shell compliant (tested on FreeBSD sh)
#

set -e  # Exit on error
set -u  # Exit on undefined variable

# Default LOG_FILE (will be overridden by process_arguments if retention > 0)
: "${LOG_FILE:=/dev/null}"

# Commands that can run without an initialized database
# These commands don't require VPN_SWITCH_BASE to exist
# Used by main() to bypass database existence check
COMMANDS_WITHOUT_DATABASE="help bootstrap init log error fail"

#-----------------------------------------------------------------------------
# Environment Configuration
#-----------------------------------------------------------------------------

# Script path (for sourcing in isolated environments)
# Only set if not already defined (allows run_env to pass it explicitly)
: "${VPN_SWITCH_CONTEXT_SCRIPT:=$(readlink -f "$0" 2>>"$LOG_FILE" || realpath "$0" 2>>"$LOG_FILE" || echo "$0")}"

# Exit code bits (for exit code propagation through call tree)
# Initialize to 0 (no errors yet) if not already set
: "${VPN_SWITCH_CONTEXT_EXIT_BITS:=0}"

# Check if VPN_SWITCH_BASE is explicitly set (before applying default)
VPN_SWITCH_BASE_EXPLICIT="${VPN_SWITCH_BASE:-}"

# Base directory for VPN configurations.
# Defaults to per-user database $HOME/.vpn-switch/db so that users get a
# sensible location without needing to set the env var. The previous
# system-wide /usr/local/etc/vpn-switch default required root ownership
# and made multi-user usage awkward.
: "${VPN_SWITCH_BASE:=$HOME/.vpn-switch/db}"

# Environment directory
: "${VPN_SWITCH_ENV_DIR:=${VPN_SWITCH_BASE}/.env}"

# Library directory: contains program files (include/, template/)
# Default: relative to script location (for development/repository use)
# Installation: /usr/local/lib/vpn-switch/ or similar
: "${VPN_SWITCH_LIBDIR:=$(dirname "$VPN_SWITCH_CONTEXT_SCRIPT")}"

# Template directory: environment/, phase/, platform/
# Derived from LIBDIR (can be overridden for testing)
: "${VPN_SWITCH_TEMPLATE_DIR:=$VPN_SWITCH_LIBDIR/template}"

# Directory configuration for database initialization and validation
# Format: path:mode:exec_flag:content_policy (newline separated)
#   - path: relative to $VPN_SWITCH_BASE
#   - mode: octal permissions (0700, 0755)
#   - exec_flag: "exec" (scripts must execute) or "noexec" (safe for noexec mount)
#   - content_policy: "exclusive" (must be empty) or "operational" (allows existing content)
#
# Directories marked "exec" require script execution capability (tested during init).
# Directories marked "exclusive" must be empty on first init (security requirement).
# Directories marked "operational" allow existing content (idempotent re-init).
# Pre-existing directories must match mode and exec requirements.
# Managed directories (.env, .include) use operational for idempotent bootstrap/init.
#
VPN_SWITCH_INIT_DIR_CONFIG=".session:0700:exec:operational
.tmp:0750:noexec:operational
.tmp/batch-exits:0750:noexec:operational
.log:0750:noexec:operational
.env:0700:noexec:operational
.env/default:0700:noexec:operational
.env/local:0700:noexec:operational
.include:0700:exec:operational
.include/phase:0700:exec:operational
session:0700:noexec:operational
wireguard:0700:noexec:operational
openvpn:0700:noexec:operational"

#-----------------------------------------------------------------------------
# Platform Configuration
#-----------------------------------------------------------------------------

# Load platform-specific command definitions
# Platform file defines CMD_* variables (e.g., CMD_STAT_PERMS, CMD_NETIF)
# These variables expand at generation time to produce platform-specific commands
#
# Platform selection:
#   1. User can set VPN_SWITCH_PLATFORM to specific platform (e.g., "freebsd", "linux")
#   2. Otherwise, uses 'default' symlink in template/platform/
#   3. Admin sets 'default' symlink to point to correct platform for the system
#
# Example: On Debian/Linux: template/platform/default -> linux.sh
#          On FreeBSD:      template/platform/default -> freebsd.sh
#
: "${VPN_SWITCH_PLATFORM:=default}"

# Determine platform file path
if [ "$VPN_SWITCH_PLATFORM" = "default" ]; then
  # Use 'default' symlink (no .sh extension)
  PLATFORM_FILE="$VPN_SWITCH_TEMPLATE_DIR/platform/default"
else
  # User-specified platform (with .sh extension)
  PLATFORM_FILE="$VPN_SWITCH_TEMPLATE_DIR/platform/$VPN_SWITCH_PLATFORM.sh"
fi

if [ -f "$PLATFORM_FILE" ]; then
  . "$PLATFORM_FILE"
elif [ "$VPN_SWITCH_PLATFORM" = "default" ]; then
  # Default platform file missing - this is a critical error
  echo "ERROR: Default platform symlink not found: $PLATFORM_FILE" >&2
  echo "This indicates a broken installation. Please reinstall vpn-switch." >&2
  exit 1
else
  # User-specified platform not found - show available platforms
  echo "ERROR: Platform file not found: $PLATFORM_FILE" >&2
  echo "Available platforms:" >&2
  ls -1 "$VPN_SWITCH_TEMPLATE_DIR/platform/"*.sh 2>/dev/null | \
    sed 's|.*/||; s|\.sh$||' >&2 || echo "  (none found - check installation)" >&2
  exit 1
fi

#-----------------------------------------------------------------------------
# Debugging - Trace Support
#-----------------------------------------------------------------------------

# trace_log - Log message with depth visualization to trace file
#
# Args: $1 - marker (>, <, |, =)
#       $2 - caller (function name or context)
#       $3+ - message to log
#
# Markers:
#   >  - Before interpreter call (subprocess entry)
#   <  - After interpreter call (subprocess exit)
#   |  - Informational message
#   =  - Separator line
#
# Depth visualization:
#   Uses VPN_SWITCH_TRACE_DEPTH to indent output with "> " prefix
#   Example: ">  >  | func: message" (depth 2)
#
# Only logs if VPN_SWITCH_TRACE_FILE is set.
# Always returns success to avoid breaking pipelines.
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

# random_select - Randomly select one item from list
#
# Input: items on stdin (one per line)
# Output: one randomly selected item
#
random_select() {
  local items=$(cat)
  local count=$(echo "$items" | wc -l | tr -d ' ')

  if [ "$count" -eq 0 ]; then
    return 1
  fi

  # Use /dev/urandom for random selection. od's decimal output is padded, and
  # the padding char differs by OS: OpenBSD zero-pads ("00826"), which $(())
  # would read as invalid octal (8/9 are not octal digits) and abort. Normalise
  # to a bare decimal via awk ($1+0) before the modulo so it is shell-agnostic.
  local rand
  rand=$(od -An -N2 -tu2 < /dev/urandom | awk '{print $1+0; exit}')
  local selected=$(( rand % count + 1 ))
  echo "$items" | sed -n "${selected}p"
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

# resolve_default_or_random - Resolve using default symlink or random selection
#
# Args: $1 - directory path
#       $2 - pattern to select from (e.g., "*.conf" or "*")
# Output: selected item name (basename)
#
resolve_default_or_random() {
  local dir="$1"
  local pattern="${2:-*}"

  # Check for default symlink
  if [ -L "$dir/default" ]; then
    local target=$(readlink "$dir/default")
    basename -- "$target"
    return 0
  fi

  # Random selection - list items matching pattern, exclude directories and reserved keywords
  local items=$(cd "$dir" && ls -1 $pattern 2>>"$LOG_FILE" | while read -r item; do
    [ ! -d "$item" ] && [ "$item" != "default" ] && [ "$item" != "latest" ] && echo "$item"
  done)

  # Return empty if no items found (let caller decide if that's an error)
  if [ -z "$items" ]; then
    echo ""
    return 0
  fi

  echo "$items" | random_select
}

#-----------------------------------------------------------------------------
# Session Management
#-----------------------------------------------------------------------------

# check_and_create_session - Validate and prepare session directory creation
#
# Args: $1 - interface name (e.g., wg0, tun0)
# Output: Commands to create session directory and handle conflicts
#
# IMPORTANT: This function is a BATCH COMBINATOR helper - it outputs commands
# to stdout and should ONLY be called from batch combinator functions (___).
# It must NOT be called from terminal functions or executed directly.
#
# The function outputs vpn-switch commands for:
# - Session conflict detection and resolution
# - Orphaned interface cleanup warnings
# - Session directory creation with proper permissions
#
# Phase 2.1.1: Updated to include interface metadata and proper file permissions
#
check_and_create_session() {
  local interface="$1"
  local session_dir="$VPN_SWITCH_BASE/.session/$$"

  # Check if session already exists (collision detection)
  # This prevents multiple VPN starts in the same process from overwriting each other
  if [ -d "$session_dir" ]; then
    echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error \"Session $$ already exists\" \"Cannot create multiple sessions in the same process\""
    return 1
  fi

  # Validation - check for existing sessions on this interface
  local session_base="$VPN_SWITCH_BASE/.session"
  if [ -d "$session_base" ]; then
    for session_dir_iter in "$session_base"/*/; do
      [ ! -d "$session_dir_iter" ] && continue

      # Read interface name from session
      local session_interface_file="$session_dir_iter/interface"
      local session_interface=""

      if [ ! -f "$session_interface_file" ]; then
        # Old session format without interface file - check protocol instead
        local session_protocol="$(cat "$session_dir_iter/protocol" 2>>"$LOG_FILE" || echo "unknown")"

        # Legacy: infer interface from protocol using dynamic variable lookup
        local interface_var="VPN_SWITCH_INTERFACE_${session_protocol}"
        eval "session_interface=\"\$$interface_var\""
        [ -z "$session_interface" ] && continue
      else
        session_interface="$(cat "$session_interface_file")"
      fi

      # Check if interfaces match
      if [ "$session_interface" = "$interface" ]; then
        local session_pid=$(basename "$session_dir_iter")

        # Skip current session (we may have just created it)
        if [ "$session_pid" = "$$" ]; then
          continue
        fi

        # Check if the session is actually alive (uses is_session_alive with ownership check)
        # Note: is_session_alive is defined in include/session.sh and checks:
        # 1. Ownership via session/latest-$interface symlink
        # 2. Interface existence
        # 3. Process existence (fallback)
        # This prevents false positives from PID recycling
        if is_session_alive "$session_dir_iter"; then
          local original_config=$(cat "$session_dir_iter/original" 2>>"$LOG_FILE" || echo "unknown")
          local config_name=$(basename "$original_config")
          echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error \"VPN already running on interface $interface\" \"PID: $session_pid, config: $config_name\" \"Stop it first: vpn-switch stop\""
          return 1
        fi
      fi
    done
  fi

  # Check for running VPN processes (database-aware, protocol-agnostic)
  # We warn about conflicts but allow creation because:
  # 1. Session creation happens at generation time (may not execute)
  # 2. Different databases should be isolated
  # 3. Same-database conflicts are caught by check #2 (session tracking)
  for protocol_dir in "$VPN_SWITCH_BASE"/*; do
    [ ! -d "$protocol_dir" ] && continue
    [ -L "$protocol_dir" ] && continue  # Skip symlinks

    local protocol=$(basename "$protocol_dir")
    is_pseudo_protocol "$protocol" && continue

    # Get binary path from environment variable (VPN_SWITCH_BINARY_<protocol>)
    local binary_var="VPN_SWITCH_BINARY_${protocol}"
    eval "local binary_path=\"\$$binary_var\""
    [ -z "$binary_path" ] && continue

    # Extract just the binary name for pgrep matching
    local binary_name=$(basename "$binary_path")

    if pgrep -f "${binary_name}.*${interface}" >/dev/null 2>&1; then
      local matching_pids=$(pgrep -f "${binary_name}.*${interface}")
      for pid in $matching_pids; do
        local cmdline=$(ps -p "$pid" -o args= 2>/dev/null || continue)

        if echo "$cmdline" | grep -q "$VPN_SWITCH_BASE"; then
          # Same database - orphaned process (check #2 should have caught tracked sessions)
          echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" log \"Warning: Found orphaned $binary_name process for $interface (PID: $pid)\" \"Proceeding - interface cleanup will handle if needed\""
        else
          # Different database - warn about potential conflict
          echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" log \"Warning: Interface $interface may be in use by another database (PID: $pid)\" \"Session created. Connect will fail if interface exists.\""
        fi
      done
    fi
  done

  # Fallback: Check for orphaned interfaces (platform-agnostic)
  if $EXAMINE_NETWORK_INTERFACES "$interface" >/dev/null 2>&1; then
    echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" log \"Warning: Found orphaned interface $interface (no active process). Auto-destroying...\""
    echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" interface destroy \"$interface\""
    echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" log \"Orphaned interface $interface destroyed\""
  fi

  # Output command to create minimal session directory (only PID file)
  # Uses existing _session_create1 terminal function for actual execution
  echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" session create \"$$\""

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

# get_session_process_pid - Get the actual VPN process PID for a session
#
# Args: $1 - session directory path
# Output: PID to stdout
#
# Returns the PID of the actual VPN process (wg-quick, openvpn, etc.)
# Falls back to session directory name if VPN process PID not yet captured.
#
# This abstracts the difference between:
#   - Session directory name (vpn-switch.sh PID - short-lived)
#   - Actual VPN process PID (wg-quick/openvpn - long-lived)
#
get_session_process_pid() {
  local session_dir="$1"

  # Try to read VPN process PID from metadata
  # This file is created during connection (protocol-agnostic: vpn.pid)
  local vpn_pid=$(cat "$session_dir/vpn.pid" 2>>"$LOG_FILE")

  if [ -n "$vpn_pid" ]; then
    echo "$vpn_pid"
  else
    # Fall back to session directory name (pre-connection state)
    basename "$session_dir"
  fi
}

# session_peer_matches_interface - Verify a session's stored peer set matches
# the peers actually loaded on the live interface.
#
# Args: $1 - Session directory path
#       $2 - Interface name (e.g. "wg0")
# Returns: 0 if the session's config matches the loaded interface OR the check
#          cannot be performed safely; 1 only on positive evidence of mismatch.
#
# Rationale: is_session_alive() trusts the session/latest-$interface ownership
# symlink to decide which session owns a live interface. If the interface is
# later reconfigured with a different peer (or the symlink drifts), the symlink
# can point at a session whose config is no longer loaded - so `session list`
# would report a stale session as active. This cross-check catches that drift.
#
# Conservative by design: this helper may only DEMOTE active->stopped, and only
# when it can positively read BOTH peer sets and they differ. Any uncertainty
# (non-WireGuard protocol, unreadable dump - e.g. requires root or wg missing,
# empty config) returns 0, so the existing no-root and OpenVPN behaviour is
# never regressed.
session_peer_matches_interface() {
  local session_dir="$1"
  local interface="$2"

  # Only WireGuard exposes a peer identity on the interface; skip others.
  local protocol=""
  if [ -f "$session_dir/protocol" ]; then
    protocol=$(cat "$session_dir/protocol" 2>>"$LOG_FILE")
  fi
  [ "$protocol" = "wireguard" ] || return 0

  # Peers loaded on the live interface (read-only; works without root on
  # supported platforms). Empty/unreadable -> no judgement.
  local loaded=""
  loaded=$($EXAMINE_VPN_WIREGUARD_INTERFACE "$interface" 2>>"$LOG_FILE" \
    | grep '^peer:' \
    | sed 's/^peer:[[:space:]]*//' \
    | sort)
  [ -n "$loaded" ] || return 0

  # Peers declared by this session's stored config. Empty/unreadable -> no
  # judgement.
  local conf="$session_dir/$interface.conf"
  [ -f "$conf" ] || return 0
  local stored=""
  stored=$(grep -i '^[[:space:]]*PublicKey' "$conf" 2>>"$LOG_FILE" \
    | sed 's/^[[:space:]]*[Pp]ublic[Kk]ey[[:space:]]*=[[:space:]]*//' \
    | sort)
  [ -n "$stored" ] || return 0

  # Positive comparison: match -> 0, mismatch -> 1 (drift detected).
  [ "$loaded" = "$stored" ]
}

# is_session_alive - Check if a session's VPN process is running
#
# Args: $1 - Session directory path
# Returns: 0 if process is alive, 1 if dead
#
# Checks session liveness using multiple strategies:
# 1. Ownership check via session/latest-$interface symlink
# 2. Interface existence check
# 3. Peer cross-check (WireGuard): config loaded on the interface must match
# 4. Process existence check (may require sudo for cross-user)
#
# This function must be in vpn-switch.sh (not just session.sh) because
# it's called by batch combinators (___wireguard_stop0, etc.) which run
# before modules are loaded.
#
is_session_alive() {
  local session_dir="$1"

  # Sessions without vpn.pid are treated as stopped/stale
  # This includes:
  # - Legacy sessions (created before vpn.pid migration)
  # - Pending sessions (created but never connected)
  # - Broken sessions (vpn.pid deleted/lost)
  if [ ! -f "$session_dir/vpn.pid" ]; then
    return 1  # Mark as stopped
  fi

  # Read interface name
  local interface=""
  if [ -f "$session_dir/interface" ]; then
    interface=$(cat "$session_dir/interface" 2>>"$LOG_FILE")
  fi

  # Primary check: Ownership + interface existence (works without root privileges)
  # Uses latest-$interface symlink to determine which session owns the interface
  # This prevents multiple sessions from claiming the same interface
  if [ -n "$interface" ]; then
    local session_proto_dir="$VPN_SWITCH_BASE/session"
    local ownership_link="$session_proto_dir/latest-$interface"

    # Check if ownership symlink exists and points to this session
    if [ -L "$ownership_link" ]; then
      local owner_session=$(readlink "$ownership_link" 2>>"$LOG_FILE" || echo "")
      local owner_pid=$(basename "$owner_session" 2>>"$LOG_FILE" || echo "")
      local this_pid=$(basename "$session_dir")

      # This session owns the interface - check if interface actually exists
      if [ "$owner_pid" = "$this_pid" ]; then
        if $EXAMINE_NETWORK_INTERFACE_EXISTS "$interface" >/dev/null 2>&1; then
          # Interface exists and we own it per the ownership symlink. Cross-check
          # that the peer actually loaded on the interface matches this session's
          # config; a mismatch means the interface was reconfigured by another
          # session and this one is effectively stopped (see
          # session_peer_matches_interface).
          if session_peer_matches_interface "$session_dir" "$interface"; then
            return 0  # We own the interface, it exists, and our config is loaded
          fi
          return 1    # We own the symlink but a different config is loaded → stopped
        else
          return 1  # We own it but interface is down
        fi
      else
        # Ownership symlink exists but points to different session
        # This session does NOT own the interface → stopped
        return 1
      fi
    fi

    # No ownership symlink exists
    # For old sessions (pre-ownership-tracking): check if interface exists
    # If interface doesn't exist, we need process check to distinguish:
    # - PID recycling (process dead) → stopped
    # - Test session or pending (process alive) → active
    if ! $EXAMINE_NETWORK_INTERFACE_EXISTS "$interface" >/dev/null 2>&1; then
      # Interface doesn't exist - use process check as final arbiter
      local pid=$(cat "$session_dir/vpn.pid" 2>>"$LOG_FILE")
      if $EXAMINE_PROCESS_EXISTS "$pid" 2>>"$LOG_FILE"; then
        return 0  # Process alive despite no interface (test/pending session)
      else
        return 1  # No interface + dead process → PID recycling, definitely stopped
      fi
    fi
  fi

  # Fallback check: Process exists (only reached for old sessions with existing interface)
  # Platform variable EXAMINE_PROCESS_EXISTS can be configured with sudo prefix
  # This is a last resort for sessions created before ownership tracking
  local pid=$(cat "$session_dir/vpn.pid" 2>>"$LOG_FILE")
  if $EXAMINE_PROCESS_EXISTS "$pid" 2>>"$LOG_FILE"; then
    return 0  # Process running (old session, interface exists, process alive)
  fi

  # All checks failed
  return 1  # Session is stopped
}

# find_session_by_interface - Find session directory by interface name
#
# Args: $1 - interface name (e.g., "wg0")
# Output: Session PID if found, empty string otherwise
# Returns: 0 if found, 1 if not found
#
find_session_by_interface() {
  local target_interface="$1"
  local session_base="$VPN_SWITCH_BASE/.session"

  [ ! -d "$session_base" ] && return 1

  for session_dir in "$session_base"/*/; do
    [ ! -d "$session_dir" ] && continue

    local session_interface="$(cat "$session_dir/interface" 2>>"$LOG_FILE")"

    # Legacy sessions: infer interface from protocol
    if [ -z "$session_interface" ]; then
      local session_protocol="$(cat "$session_dir/protocol" 2>>"$LOG_FILE")"
      case "$session_protocol" in
        wireguard) session_interface="$VPN_SWITCH_INTERFACE_wireguard" ;;
        openvpn) session_interface="$VPN_SWITCH_INTERFACE_openvpn" ;;
        *) continue ;;
      esac
    fi

    if [ "$session_interface" = "$target_interface" ]; then
      basename "$session_dir"
      return 0
    fi
  done

  return 1
}

# _session_create1 - Create session directory with minimal structure
#
# Args: $1 - session PID
# Output: Shell commands to create session directory
#
# Terminal function - outputs shell commands for execution
#
#@help _session_create1
# @internal create a session metadata directory (start chain step)
#@end
_session_create1() {
  local session_pid="$1"
  local session_dir="$VPN_SWITCH_BASE/.session/$session_pid"

  cat <<EOF
$MODIFY_DIR_CREATE "$session_dir"
$MODIFY_FILE_PERMS 0750 "$session_dir"
echo "$session_pid" > "$session_dir/pid"
$MODIFY_FILE_PERMS 0640 "$session_dir/pid"
EOF
}

# __session_exists1 - Check for session directory collision
#
# Args: $1 - session PID
# Output: error command if collision exists, log command otherwise
#
# Combinator - outputs exactly 1 vpn-switch command
#
#@help __session_exists1
# @internal guard: refuse a duplicate session for the current process
#@end
__session_exists1() {
  local session_pid="$1"
  local session_dir="$VPN_SWITCH_BASE/.session/$session_pid"

  if [ -d "$session_dir" ]; then
    echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error \"Session $session_pid already exists\" \"Cannot create multiple sessions in the same process\""
  else
    echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" log \"Session directory available for $session_pid\""
  fi
}

# __session_conflicts2 - Check for interface conflict with existing sessions
#
# Args: $1 - session PID
#       $2 - interface name
# Output: error command if conflict exists, log command otherwise
#
# Combinator - outputs exactly 1 vpn-switch command
#
#@help __session_conflicts2
# @internal guard: detect interface conflicts before connect
#@end
__session_conflicts2() {
  local session_pid="$1"
  local interface="$2"
  local session_base="$VPN_SWITCH_BASE/.session"

  # No sessions directory - no conflicts
  if [ ! -d "$session_base" ]; then
    echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" log \"No sessions directory - no interface conflicts\""
    return
  fi

  for session_dir in "$session_base"/*/; do
    [ ! -d "$session_dir" ] && continue

    # Interface file is required - skip sessions without it
    [ ! -f "$session_dir/interface" ] && continue

    local session_interface
    session_interface=$(cat "$session_dir/interface")

    # Different interface - no conflict
    [ "$session_interface" != "$interface" ] && continue

    # Same interface - check if it's another session
    local other_pid
    other_pid=$(basename "$session_dir")

    # Skip self
    [ "$other_pid" = "$session_pid" ] && continue

    # Check if VPN process is running
    [ ! -f "$session_dir/vpn.pid" ] && continue

    local vpn_pid
    vpn_pid=$(cat "$session_dir/vpn.pid")

    # Use platform variable for process check
    if $EXAMINE_PROCESS_EXISTS "$vpn_pid" 2>/dev/null; then
      local original_config
      original_config=$(cat "$session_dir/original" 2>/dev/null || echo "unknown")
      local config_name
      config_name=$(basename "$original_config")

      echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error \"VPN already running on interface $interface\" \"PID: $other_pid, config: $config_name\" \"Stop it first: vpn-switch stop\""
      return
    fi
  done

  # No conflicts found
  echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" log \"No interface conflicts found for $interface\""
}

# __interface_check1 - Check if network interface exists (orphan check)
#
# Args: $1 - interface name
# Output: error command if interface exists, log command otherwise
#
# Terminal function - outputs shell commands to destroy an interface
#
#@help _interface_destroy1
# @internal destroy an orphaned interface (cleanup chain step)
#@end
_interface_destroy1() {
  local interface="$1"
  # Use printf format template for platform independence (FreeBSD vs Linux)
  printf '%s 2>>"$LOG_FILE" || true\n' "$(printf "$MODIFY_INTERFACE_DESTROY_FMT" "$interface")"
}

# Combinator - outputs exactly 1 vpn-switch command
#
#@help __interface_check1
# @internal guard: check interface availability before connect
#@end
__interface_check1() {
  local interface="$1"

  if $EXAMINE_NETWORK_INTERFACES "$interface" >/dev/null 2>&1; then
    local destroy_cmd=$(printf "$MODIFY_INTERFACE_DESTROY_FMT" "$interface")
    echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error \"Orphaned interface $interface exists\" \"Please destroy it manually: $destroy_cmd\""
  else
    echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" log \"Interface $interface is available\""
  fi
}

# ___session_prepare3 - Prepare session with validation
#
# Args: $1 - session PID
#       $2 - protocol name
#       $3 - interface name
# Output: vpn-switch commands for session create and populate
#
# Batch combinator - performs validation at generation time, outputs commands
# Protocol-agnostic: caller provides interface directly
#
#@help ___session_prepare3
# @internal prepare a session (exists/conflicts/check/create/populate chain)
#@end
___session_prepare3() {
  local session_pid="$1"
  local protocol="$2"
  local interface="$3"

  # All checks passed - output commands
  cat <<EOF
"\$VPN_SWITCH_CONTEXT_SCRIPT" session exists "$session_pid"
"\$VPN_SWITCH_CONTEXT_SCRIPT" session conflicts "$session_pid" "$interface"
"\$VPN_SWITCH_CONTEXT_SCRIPT" interface check "$interface"
"\$VPN_SWITCH_CONTEXT_SCRIPT" session create "$session_pid"
"\$VPN_SWITCH_CONTEXT_SCRIPT" session populate "$session_pid" "$protocol" "$interface"
EOF
}

# _session_populate3 - Populate session directory with metadata
#
# Args: $1 - session PID
#       $2 - protocol (wireguard or openvpn)
#       $3 - interface name
# Output: Shell commands to populate session metadata
#
# Terminal function - outputs shell commands for execution
# Protocol-agnostic: caller provides interface directly
#
# NOTE: Stale session cleanup is performed by 'session clean' command
# which should be run periodically to clean up dead sessions and orphaned interfaces.
#
#@help _session_populate3
# @internal write session metadata (protocol, interface, original)
#@end
_session_populate3() {
  local pid="$1"
  local protocol="$2"
  local interface="$3"
  local session_dir="$VPN_SWITCH_BASE/.session/$pid"

  cat <<EOF
echo "$protocol" > "$session_dir/protocol"
echo "$interface" > "$session_dir/interface"
$EXAMINE_DATE_NOW > "$session_dir/started"
$MODIFY_FILE_PERMS 0640 "$session_dir/protocol" "$session_dir/interface" "$session_dir/started"
EOF
}

#-----------------------------------------------------------------------------
# Configuration File Patching
#-----------------------------------------------------------------------------

# is_pseudo_protocol - Check if directory name is a pseudo-protocol
#
# Args: $1 - protocol/directory name
# Returns: 0 if pseudo-protocol (should skip), 1 if real protocol
#
# Pseudo-protocols are special directories that are NOT VPN protocols.
# Detection rules:
#   1. Hidden directories (.*) are always pseudo-protocols
#   2. Directories in VPN_SWITCH_PSEUDO_PROTOCOL variable (space-separated list)
#
# Default VPN_SWITCH_PSEUDO_PROTOCOL: "session environment"
# Override in tests to simulate "no protocols found" scenarios
#
is_pseudo_protocol() {
  local proto="$1"

  # Hidden directories are always pseudo-protocols
  case "$proto" in
    .*) return 0 ;;
  esac

  # Check against configured pseudo-protocol list
  local pseudo
  for pseudo in $VPN_SWITCH_PSEUDO_PROTOCOL; do
    [ "$proto" = "$pseudo" ] && return 0
  done

  return 1
}

#-----------------------------------------------------------------------------
# Stop/Disconnect Commands (Combinator Pattern)
#-----------------------------------------------------------------------------

# __stop0 - Stop all VPN sessions (filesystem discovery)
#
# Output: Combinator commands (one per protocol)
#
# Uses filesystem discovery: VPN_SWITCH_BASE subdirectories = protocols.
# Special handling: "session" pseudo-protocol runs first (stale cleanup).
#
#@help ___stop0
# @command stop
# @summary Stop every active VPN session (idempotent)
# @group   connection
# @returns disconnect commands for all active sessions
# @example vpn-switch stop
# @see     start
#@end
___stop0() {
  # First: Stop all protocol interfaces (VPN teardown)
  local base_dir="$VPN_SWITCH_BASE"
  [ ! -d "$base_dir" ] && return 0

  for protocol_dir in "$base_dir"/*/; do
    [ ! -d "$protocol_dir" ] && continue

    local protocol=$(basename "$protocol_dir")

    # Skip pseudo-protocols (consistent with other batch combinators)
    is_pseudo_protocol "$protocol" && continue

    # Check if protocol has a stop function (prevent usage() spam)
    # Look for __<protocol>_stop0 or __<protocol>_stop1 in ANCHOR_FUNCTIONS list
    # (Functions may be in modules, not in main script, so check the complete list)
    if ! echo "$ANCHOR_FUNCTIONS" | grep -q "__${protocol}_stop"; then
      echo "# Skipping protocol '$protocol' (no stop function implemented)"
      continue
    fi

    # Output stop command for each discovered protocol
    # Script path uses literal variable reference for portability
    echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" $protocol stop"
  done

  # Note: Session cleanup is now explicit - users should run 'vpn-switch session clean'
  # to remove unreferenced sessions after stopping VPNs
}

# __stop1 - Stop specific VPN session by interface name
#
# Args: $1 - interface name (e.g., "wg0", "tun0")
# Output: Combinator command for protocol-specific stop
#
# Resolves interface → protocol, outputs "<protocol> stop <interface>"
#
#@help __stop1
# @internal arity-1 sibling of 'stop' (stop a specific interface)
#@end
__stop1() {
  local interface="$1"

  # Find session for this interface
  local session_pid=$(find_session_by_interface "$interface")

  if [ -z "$session_pid" ]; then
    echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error \"No active VPN session found for interface: $interface\""
    return
  fi

  local session_dir="$VPN_SWITCH_BASE/.session/$session_pid"
  local session_protocol=$(cat "$session_dir/protocol" 2>>"$LOG_FILE")

  if [ -z "$session_protocol" ]; then
    echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error \"Could not determine protocol for interface: $interface\""
    return
  fi

  # Output protocol-specific stop command
  # Script path uses literal variable reference for portability
  echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" $session_protocol stop $interface"
}

#-----------------------------------------------------------------------------
# System Validation (Phase 4.1 - Feature 3)
#-----------------------------------------------------------------------------

# check_undefined_variables - Check for undefined variables in phase scripts
#
# Output: Shell commands to scan phase scripts for undefined variables
#
check_undefined_variables() {
  cat <<'EOF'
# Extract ALL variables from the actual runtime environment (not just exports in script)
# This includes variables from .env/default and .env/local
std_vars=$(printenv | grep '^VPN_SWITCH_' | sed 's/=.*//' | tr '\n' ' ')
# Add standard shell variables
std_vars="$std_vars PATH HOME USER PWD SHELL TERM"
# Add connection context variables (set in phase prologues)
std_vars="$std_vars ISOLATED VPN_CONFIG_FILE VPN_ORIGINAL_CONFIG_RELATIVE VPN_SESSION_DIR VPN_SESSION_PID"
std_vars="$std_vars VPN_INTERFACE VPN_DNS_SERVER VPN_REMOTE_IPS VPN_PHASES_CONNECT VPN_PHASES_DISCONNECT VPN_PHASES_INSPECT"
std_vars="$std_vars VPN_SWITCH_CONTEXT_CONNECT"

for phase_file in "$VPN_SWITCH_BASE"/.include/phase/*/*/*.sh; do
  [ ! -f "$phase_file" ] && continue
  # ERE: BRE '\?' (optional) is a GNU/FreeBSD extension OpenBSD grep rejects,
  # so the BRE form matched nothing there and phase-var checks silently passed.
  vars=$(grep -oE '\$[{]?VPN_SWITCH_[A-Za-z0-9_]*[}]?' "$phase_file" 2>/dev/null | sed 's/[${}]//g' | sort -u)

  for var in $vars; do
    echo "$std_vars" | grep -qw "$var" && continue
    relative_path=$(echo "$phase_file" | sed "s|$VPN_SWITCH_BASE/.include/phase/||")
    echo "# [WARNING] Undefined \$$var in $relative_path"
    issues=$((issues + 1))
  done
done
EOF
}

# check_interface_collision - Helper to check for interface name collisions
#
# Args: $1 - first variable name, $2 - second variable name
# Output: Shell commands to check if two interface variables have same value
#
check_interface_collision() {
  var1_name="$1"
  var2_name="$2"

  cat <<EOF
eval "iface1=\${${var1_name}:-}"
eval "iface2=\${${var2_name}:-}"
[ -n "\$iface1" ] && [ -n "\$iface2" ] && [ "\$iface1" = "\$iface2" ] && \\
  echo "# [ERROR] Interface collision: ${var1_name} == ${var2_name} (\$iface1)" && \\
  issues=\$((issues + 1))
EOF
}

#-----------------------------------------------------------------------------
# Database Initialization (Phase 2.3.1)
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# Phase Template Lifting Engine
#-----------------------------------------------------------------------------

# parse_phase_spec - Parse phase specification with syntax: phase[:variant][@profile]
#
# Syntax:
#   phase              - Just phase name (e.g., "firewall")
#   phase:variant      - Phase with backend variant (e.g., "firewall:pf")
#   phase@profile      - Phase with specific profile (e.g., "firewall@base")
#   phase:variant@profile - All three (e.g., "firewall:pf@base")
#
# Args:
#   $1 - spec: Phase specification string
#
# Output: Three lines to stdout:
#   Line 1: phase_name
#   Line 2: variant (or empty if not specified)
#   Line 3: profile (or empty if not specified)
#
# Internal helper function (no underscore = not an anchor function)
#
parse_phase_spec() {
  local spec="$1"
  local phase_name=""
  local variant=""
  local profile=""

  # Split on @ first (profile separator)
  case "$spec" in
    *@*)
      # Extract profile (everything after @)
      profile="${spec##*@}"
      # Remove profile part to get phase[:variant]
      spec="${spec%@*}"
      ;;
  esac

  # Split on : (variant separator)
  case "$spec" in
    *:*)
      # Extract variant (everything after :)
      variant="${spec##*:}"
      # Extract phase (everything before :)
      phase_name="${spec%:*}"
      ;;
    *)
      # No variant specified
      phase_name="$spec"
      ;;
  esac

  # Output components (one per line for easy reading)
  echo "$phase_name"
  echo "$variant"
  echo "$profile"
}

# resolve_phase_script - Resolve phase script from spec (with backend support)
#
# Resolves a phase specification to an actual script path. Supports both:
#   1. Backend resolution (when :variant or @profile specified)
#   2. Protocol-specific scripts (backward compatibility)
#
# Args:
#   $1 - phase_spec: Phase specification (e.g., "firewall:pf@base" or "firewall")
#   $2 - protocol: Protocol name (wireguard, openvpn)
#   $3 - direction: connect or disconnect
#   $4 - base_dir: Database base directory
#
# Output: Path to phase script (stdout)
# Returns: 0 if found, 1 if not found
#
# Internal helper function (no underscore = not an anchor function)
#
resolve_phase_script() {
  local phase_spec="$1"
  local protocol="$2"
  local direction="$3"
  local base_dir="$4"

  # Parse the phase specification
  local parsed=$(parse_phase_spec "$phase_spec")
  local phase_name=$(echo "$parsed" | sed -n '1p')
  local variant=$(echo "$parsed" | sed -n '2p')
  local profile=$(echo "$parsed" | sed -n '3p')

  # If variant or profile specified, use backend resolution
  if [ -n "$variant" ] || [ -n "$profile" ]; then
    # Backend resolution: look in .include/phase/<profile>/<phase>/<variant>.sh
    local profile_dir="${profile:-default}"
    local backend="${variant:-standard}"
    local backend_script="$base_dir/.include/phase/$profile_dir/$phase_name/${backend}.sh"

    if [ -f "$backend_script" ]; then
      echo "$backend_script"
      return 0
    fi

    # Backend not found
    return 1
  fi

  # No variant/profile - use protocol-specific script (backward compatible)
  local protocol_script="$base_dir/.include/phase/$protocol/$direction/${phase_name}.sh"
  if [ -f "$protocol_script" ]; then
    echo "$protocol_script"
    return 0
  fi

  # Not found
  return 1
}

# resolve_phase_backend - Resolve phase backend template using profile-first structure
#
# Resolution order:
#   1. template/phase/<profile>/<phase>/<backend>.sh (explicit profile)
#   2. template/phase/default/<phase>/<backend>.sh (default profile symlink)
#   3. Use "standard" backend if backend not specified
#
# Args:
#   $1 - phase_name: Phase name (firewall, dns, vpn, etc.)
#   $2 - backend_name: Backend name (pf, ipfw, resolvconf, etc.) or empty for default
#   $3 - profile_name: Profile name (base, advanced, etc.) or empty for default
#
# Output: Path to backend template file (stdout)
# Returns: 0 if found, 1 if not found
#
# Internal helper function (no underscore = not an anchor function)
#
resolve_phase_backend() {
  local phase_name="$1"
  local backend_name="${2:-standard}"
  local profile_name="${3:-}"

  # Determine profile to use
  local profile_dir
  if [ -n "$profile_name" ]; then
    profile_dir="$VPN_SWITCH_TEMPLATE_DIR/phase/$profile_name"
  else
    # Use default symlink
    profile_dir="$VPN_SWITCH_TEMPLATE_DIR/phase/default"
  fi

  # Build candidate path
  local candidate="$profile_dir/$phase_name/${backend_name}.sh"

  # Check if template exists
  if [ -f "$candidate" ]; then
    echo "$candidate"
    return 0
  fi

  # Not found
  return 1
}

# lift_phase_simple - Transform plain shell template to terminal function
#
# Converts simple phase templates (plain shell commands) into proper terminal
# function format with automatic escaping and phase structure wrapping.
#
# Args:
#   $1 - input_file: Path to simple template (plain shell)
#   $2 - phase_name: Phase name (firewall, dns, vpn, etc.)
#   $3 - output_file: Path for generated terminal function
#
# Input format (simple template):
#   #!/bin/sh
#   # Comments describing commands
#   command1 $context_var
#   command2 $context_var
#
# Output format (terminal function):
#   Full case structure with verify/prepare/execute/inspect
#
# Escaping rules:
#   - Context variables ($dns_server, $interface, etc.) → unescaped
#   - Runtime variables ($?, $1-$9, $@, $*, $$) → escaped
#
# Internal helper function (no underscore = not an anchor function)
#
lift_phase_simple() {
  local input_file="$1"
  local phase_name="$2"
  local output_file="$3"

  # Validate arguments
  if [ -z "$input_file" ] || [ -z "$phase_name" ] || [ -z "$output_file" ]; then
    generate_error "lift_phase_simple requires 3 arguments" "Usage: lift_phase_simple <input_file> <phase_name> <output_file>"
    return 0
  fi

  # Security: Require absolute paths to prevent writing outside database
  case "$output_file" in
    /*) ;; # Absolute path - OK
    *)
      generate_error "lift_phase_simple requires absolute output path" "Got relative path: $output_file"
      return 0
      ;;
  esac

  case "$input_file" in
    /*) ;; # Absolute path - OK
    *)
      generate_error "lift_phase_simple requires absolute input path" "Got relative path: $input_file"
      return 0
      ;;
  esac

  if [ ! -f "$input_file" ]; then
    generate_error "Input file not found: $input_file"
    return 0
  fi

  # Read entire input file, preserve structure
  # Skip shebang (line 1), keep everything else including comments
  # Comments serve as documentation in the generated phase script
  local commands=$(tail -n +2 "$input_file")

  # Generate lifted terminal function
  cat > "$output_file" <<'LIFT_OUTER'
#!/bin/sh
# Auto-generated phase template (lifted from simple format)

# Unpack context variables (for generation-time expansion)
eval "$VPN_SWITCH_CONTEXT_CONNECT"

case "$1" in
    verify)
        cat <<'EOF'
# Verify function for __PHASE__ phase
verify___PHASE__() {
    local step="$1"
    local exit_code="$2"

    case "$step" in
        prepare)
            if [ "$exit_code" -ne 0 ]; then
                echo "# ERROR: __PHASE__ prepare failed" >&2
                exit 1
            fi
            echo "# ✓ __PHASE__ prerequisites met" >&2
            ;;
        execute)
            if [ "$exit_code" -ne 0 ]; then
                echo "# ERROR: __PHASE__ configuration failed" >&2
                exit 1
            fi
            echo "# ✓ __PHASE__ configured successfully" >&2
            ;;
    esac
}
EOF
        ;;

    prepare)
        cat <<'EOF'
echo "# ==> Phase: __PHASE__ (prepare)" >&2
verify___PHASE__ prepare 0
EOF
        ;;

    execute)
        cat <<EOF
echo "# ==> Phase: __PHASE__ (execute)" >&2

__COMMANDS__
EOF
        ;;

    inspect)
        cat <<EOF
echo "### __PHASE__ Phase"
echo "Context: dns_server=\$dns_server interface=\$interface"
EOF
        ;;

    *)
        echo "# Usage: \$0 {verify|prepare|execute|inspect}" >&2
        exit 1
        ;;
esac
LIFT_OUTER

  # Perform substitutions
  # 1. Replace __PHASE__ with actual phase name
  sed -i '' "s/__PHASE__/$phase_name/g" "$output_file" 2>/dev/null || \
    sed -i "s/__PHASE__/$phase_name/g" "$output_file"

  # 2. Process commands with escaping
  # For simple templates, just escape runtime variables and add single verify at end
  # Preserve heredocs and multi-line constructs as-is
  # Double escape runtime variables so they survive both: echo to file + heredoc expansion
  # Escape runtime shell variables so they survive heredoc expansion
  # Use [$] character class instead of \$ for portability (GNU sed treats \? as 0-or-1 quantifier)
  local escaped=$(echo "$commands" | sed 's/[$]?/\\\\$?/g; s/[$][$]/\\\\$\\\\$/g; s/[$]@/\\\\$@/g; s/[$][*]/\\\\$*/g; s/[$]\([0-9]\)/\\\\$\1/g')

  local lifted="${escaped}
verify_${phase_name} execute \\\$?"

  # 3. Replace __COMMANDS__ marker with lifted commands
  # Write commands to temp file and use sed to insert them
  # Use printf to preserve backslashes (echo interprets them)
  printf '%s\n' "$lifted" > "${output_file}.commands"

  # Use sed to replace __COMMANDS__ with file contents
  # This preserves multi-line content and special characters
  sed -e '/__COMMANDS__/ {' -e "r ${output_file}.commands" -e 'd' -e '}' "$output_file" > "${output_file}.tmp"
  $MODIFY_FILE_MOVE "${output_file}.tmp" "$output_file"
  $MODIFY_FILE_REMOVE "${output_file}.commands"

  display success "✓ Lifted: $input_file → $output_file"
  return 0
}

#-----------------------------------------------------------------------------
# Pure Filter: Template Lifting (stdin → stdout)
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# Database Initialization Components
#-----------------------------------------------------------------------------

# _phases_copy0 - Copy phase templates without lifting
#
# Output: Shell commands to copy phase templates
#
# Copies all phase templates from template/phase/ to .include/phase/
# without any transformation. This is the first step before lifting.
#
#@help _phases_copy0
# @internal copy phase templates into the database (sync helper)
#@end
_phases_copy0() {
  local base="$VPN_SWITCH_BASE"

  cat <<EOF
# Copy phase templates
# Force overwrite (-Rf) for idempotent bootstrap: keeps phase scripts current
if [ -d "$VPN_SWITCH_TEMPLATE_DIR/phase" ]; then
  $MODIFY_DIR_COPY "$VPN_SWITCH_TEMPLATE_DIR/phase/"* "$base/.include/phase/"
  $MODIFY_FILE_PERMS_RECURSIVE 0700 "$base/.include/phase"
  echo "# Copied phase templates to: $base/.include/phase/" >&2
else
  echo "# Error: Phase template directory not found: $VPN_SWITCH_TEMPLATE_DIR/phase" >&2
  echo "# This directory is required for database initialization." >&2
  echo "# Please ensure vpn-switch.sh is in the correct location relative to template/" >&2
  exit 1
fi
EOF
}

# ___phases_sync1 - Sync all backends for one phase (batch combinator)
#
# Arguments: phase name (firewall, dns, etc.)
# Output: List of "phases lift" commands, one per backend
#
# Discovers all backends for the given phase and outputs a command to
# lift each one. This is a batch combinator that delegates to _phases_lift1.
#
#@help ___phases_sync1
# @internal arity-1 sibling of 'phases sync' (single phase)
#@end
___phases_sync1() {
  local phase_name="$1"

  if [ -z "$phase_name" ]; then
    echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error \"phases sync requires phase name argument\""
    return 1
  fi

  # Resolve profile name from template/phase/default symlink
  local profile_name="base"
  if [ -L "$VPN_SWITCH_TEMPLATE_DIR/phase/default" ]; then
    profile_name=$(basename "$(readlink "$VPN_SWITCH_TEMPLATE_DIR/phase/default")")
  fi

  local phase_dir="$VPN_SWITCH_TEMPLATE_DIR/phase/$profile_name/$phase_name"

  # Validation at generation time
  if [ ! -d "$phase_dir" ]; then
    echo "# Warning: Phase directory not found: $phase_name (skipping)"
    return 0
  fi

  # Discover all backends for this phase (generation time)
  local found_backend=0
  for backend_file in "$phase_dir"/*.sh; do
    [ -f "$backend_file" ] || continue

    local backend_name=$(basename "$backend_file" .sh)

    # Skip documentation templates
    [ "$backend_name" = "user-template" ] && continue

    # Output delegation command (one per backend)
    echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" phases lift \"$phase_name:$backend_name\""
    found_backend=1
  done

  if [ "$found_backend" -eq 0 ]; then
    # Output warning as comment (defensive: harmless if piped to sh)
    echo "# Warning: No backends found for phase: $phase_name"
  fi
}

# ___phases_sync0 - Sync all phase templates (batch combinator)
#
# Output: List of commands to copy and lift all phase templates
#
# Top-level batch combinator for phase synchronization. First copies all
# templates, then discovers all phases and lifts their backends.
#
#@help ___phases_sync0
# @command phases sync [<phase>]
# @summary Refresh phase scripts (firewall, vpn, dns) from source templates
# @group   database
# @param   phase  restrict the refresh to a single phase
# @returns shell commands (refresh phase scripts)
# @example vpn-switch phases sync
# @see     sync
#@end
___phases_sync0() {
  local base="$VPN_SWITCH_BASE"

  # Step 1: Copy all phase templates
  echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" phases copy"

  # Step 2: Discover all phases and lift their backends
  # Resolve profile name from template/phase/default symlink
  local profile_name="base"
  if [ -L "$VPN_SWITCH_TEMPLATE_DIR/phase/default" ]; then
    profile_name=$(basename "$(readlink "$VPN_SWITCH_TEMPLATE_DIR/phase/default")")
  fi

  local template_profile_dir="$VPN_SWITCH_TEMPLATE_DIR/phase/$profile_name"

  if [ ! -d "$template_profile_dir" ]; then
    echo "echo \"# Error: Template profile directory not found: $template_profile_dir\" >&2"
    echo "exit 1"
    return 1
  fi

  # Discover phases at generation time
  for phase_dir in "$template_profile_dir"/*/; do
    [ -d "$phase_dir" ] || continue

    local phase_name=$(basename "$phase_dir")

    # Output delegation command for this phase
    echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" phases sync \"$phase_name\""
  done
}

#-----------------------------------------------------------------------------
# Database Sync (refresh DB against source templates)
#-----------------------------------------------------------------------------

# ___sync0 - Top-level sync orchestrator (batch combinator)
#
# Output: three vpn-switch subcommands to refresh the DB from source.
#
# Usage: vpn-switch sync
#
# Refreshes the user's database (.env/default/, .include/phase/, .version)
# against the system-wide source templates. Idempotent: safe to run after
# every source upgrade. Per-user customisations in .env/local/ are not
# touched.
#
#@help ___sync0
# @command sync
# @summary Refresh the database from installed source templates
# @group   connection
# @returns shell commands (phases sync + env sync + version sync)
# @example vpn-switch sync
# @see     version
#@end
___sync0() {
  echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" phases sync"
  echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" env sync"
  echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" version sync"
}

# _env_sync0 - Refresh .env/default/ from environment templates (terminal)
#
# Output: shell commands to copy template/environment/* into the
# database's .env/default/. Existing .env/local/ overrides are not
# affected — only the bootstrap defaults are refreshed.
#
# Usage: vpn-switch env sync
#
#@help _env_sync0
# @command env sync
# @summary Refresh environment defaults in .env/default/ from source templates
# @group   database
# @returns shell commands (refresh .env/default)
# @example vpn-switch env sync
# @see     sync
#@end
_env_sync0() {
  local base="$VPN_SWITCH_BASE"

  cat <<EOF
# Sync environment defaults from templates.
# Directory perms 0700 (owner traverse), per-file 0600 (owner r/w).
# We don't use chmod -R 0600 because that would strip the directory's
# traverse bit during the recursive walk and lock us out.
if [ -d "$VPN_SWITCH_TEMPLATE_DIR/environment" ]; then
  $MODIFY_DIR_CREATE "$base/.env/default"
  $MODIFY_FILE_PERMS 0700 "$base/.env/default"
  $MODIFY_FILE_COPY_FORCE "$VPN_SWITCH_TEMPLATE_DIR/environment/"* "$base/.env/default/"
  for f in "$base/.env/default"/*; do
    [ -f "\$f" ] && $MODIFY_FILE_PERMS 0600 "\$f"
  done
  echo "# Synced env defaults from: $VPN_SWITCH_TEMPLATE_DIR/environment/"
  # Invalidate a live env cache: build_env_args reads the cache file verbatim
  # and never re-scans, so freshly synced defaults stay invisible until the
  # cache is dropped. Same convention as _environment_init1 / _setenv2.
  if [ -f "$base/.env/local/VPN_SWITCH_CACHE_ENV_ARGS" ]; then
    $MODIFY_FILE_REMOVE "$base/.env/local/VPN_SWITCH_CACHE_ENV_ARGS"
    echo "# Cache invalidated (rebuild with: environment cache on)"
  fi
else
  echo "# Error: Environment template directory not found: $VPN_SWITCH_TEMPLATE_DIR/environment" >&2
  exit 1
fi
EOF
}

# _version_sync0 - Write .version with current source version (terminal)
#
# Output: shell commands to copy template/VERSION into the database
# root as .version. Used to track which source-tree commit the DB
# was last synced against.
#
# Usage: vpn-switch version sync
#
#@help _version_sync0
# @command version sync
# @summary Stamp the database's .version with the source's current SHA
# @group   database
# @returns shell commands (write the version marker)
# @example vpn-switch version sync
# @see     sync
#@end
_version_sync0() {
  local base="$VPN_SWITCH_BASE"

  cat <<EOF
# Sync DB version marker
if [ -f "$VPN_SWITCH_TEMPLATE_DIR/VERSION" ]; then
  $MODIFY_FILE_COPY_FORCE "$VPN_SWITCH_TEMPLATE_DIR/VERSION" "$base/.version"
  $MODIFY_FILE_PERMS 0600 "$base/.version"
  echo "# DB synced to source version: \$(cat "$base/.version")"
else
  echo "# Warning: source VERSION file not found at $VPN_SWITCH_TEMPLATE_DIR/VERSION" >&2
  echo "# Skipping .version update — run 'gmake metadata' in the source tree to regenerate" >&2
fi
EOF
}

# _version0 - Report version state of the DB (terminal, info-style)
#
# All filesystem inspection happens here at generation time. The output
# is the final display text; the default 'cat' interpreter passes it
# through unchanged (same pattern as _help0 / _printenv0).
#
# Format (stable, machine-parseable for tests/tooling):
#   db: <sha-from-.version | "unstamped">
#   source: <sha-from-template/VERSION | "missing">
#
# Usage: vpn-switch version
#
#@help _version0
# @command version
# @summary Report the database and source SHAs (drift means run 'sync')
# @group   connection
# @returns two lines: db SHA and source SHA
# @example vpn-switch version
# @see     sync
#@end
_version0() {
  local db_version source_version

  if [ -f "$VPN_SWITCH_BASE/.version" ]; then
    db_version=$(cat "$VPN_SWITCH_BASE/.version")
  else
    db_version="unstamped"
  fi

  if [ -f "$VPN_SWITCH_TEMPLATE_DIR/VERSION" ]; then
    source_version=$(cat "$VPN_SWITCH_TEMPLATE_DIR/VERSION")
  else
    source_version="missing"
  fi

  printf 'db: %s\n' "$db_version"
  printf 'source: %s\n' "$source_version"
}

#-----------------------------------------------------------------------------
# Protocol-Agnostic Commands
#-----------------------------------------------------------------------------

# _import1 - Protocol-agnostic import (wrapper)
#
# Args: $1 - Path to config file
# Output: Delegates to protocol-specific import
#
# Detects protocol from file extension and delegates to protocol-specific function
#
#@help __import1
# @internal protocol-agnostic router for 'import'
#@end
__import1() {
  local source_path="$1"
  local filename=$(basename "$source_path")

  # Extract extension
  local ext=""
  case "$filename" in
    *.*) ext="${filename##*.}" ;;
  esac

  if [ -z "$ext" ]; then
    echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error \"import: file has no extension: $filename\""
    return
  fi

  # Resolve protocol from extension link (Phase 3.4.1)
  if [ -L "$VPN_SWITCH_BASE/$ext" ]; then
    local link_target
    link_target=$(readlink "$VPN_SWITCH_BASE/$ext" 2>>"$LOG_FILE")
    if [ $? -ne 0 ]; then
      echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error \"import: failed to resolve extension link: $ext\""
      return
    fi

    local protocol
    protocol=$(basename "$link_target")

    # Validate protocol directory exists
    if [ ! -d "$VPN_SWITCH_BASE/$protocol" ]; then
      echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error \"import: extension link '$ext' points to non-existent protocol '$protocol'\""
      return
    fi

    # Delegate to protocol-specific import
    echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" $protocol import \"$source_path\""
  else
    echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error \"import: unknown extension '$ext' \\(no extension link found\\)\" \"Create link: cd \$VPN_SWITCH_BASE && ln -sf <protocol> $ext\""
    return
  fi
}

# ___list0 - List all protocols (protocol-agnostic, Phase 3.4.1)
#
# Output: Delegates to protocol-specific list commands
#
# Batch-combinator function: Outputs multiple vpn-switch commands for batch execution
# Discovers all protocols dynamically and delegates to their list functions
#
#@help ___list0
# @internal protocol-agnostic router for 'list'
#@end
___list0() {
  # Discover protocols and delegate to each
  for dir in "$VPN_SWITCH_BASE"/*; do
    # Skip symlinks (extension links like conf→wireguard/)
    [ -L "$dir" ] && continue
    [ -d "$dir" ] || continue
    proto=$(basename "$dir")

    # Skip pseudo-protocols
    is_pseudo_protocol "$proto" && continue

    # Delegate to protocol-specific list
    echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" $proto list"
  done
}

# _link2 - Create protocol-level symlink in base directory
#
# Args: $1 - Alias name
#       $2 - Protocol name
# Output: Shell commands to create symlink
#
# Creates a symlink in base directory pointing to protocol directory.
# Used for: vpn-switch link default wireguard
#
#@help _link2
# @internal protocol-agnostic router for 'link'
#@end
_link2() {
  local alias="$1"
  local protocol="$2"
  local base_dir="$VPN_SWITCH_BASE"
  local alias_path="$base_dir/$alias"
  local protocol_path="$base_dir/$protocol"

  # Validate protocol directory exists
  if [ ! -d "$protocol_path" ]; then
    generate_error "Protocol directory not found: $protocol"
    return 0
  fi

  # Check if alias already exists (file, link, or directory)
  if [ -e "$alias_path" ] || [ -L "$alias_path" ]; then
    generate_error "Alias already exists: $alias"
    return 0
  fi

  # Output commands to create symlink (relative path)
  cat <<EOF
# Create protocol-level link: $alias -> $protocol
$MODIFY_LINK_CREATE "./$protocol" "$alias_path"
echo "# Created protocol link: $alias -> $protocol" >&2
EOF
}

# _remove1 - Remove protocol-level link from base directory
#
# Args: $1 - Alias name
# Output: Shell commands to remove link
#
# Removes a symlink from base directory (created by _link2).
# Used for: vpn-switch remove default
#
#@help _remove1
# @internal protocol-agnostic router for 'remove'
#@end
_remove1() {
  local alias="$1"
  local base_dir="$VPN_SWITCH_BASE"
  local alias_path="$base_dir/$alias"

  # Validate alias exists
  if [ ! -e "$alias_path" ] && [ ! -L "$alias_path" ]; then
    generate_error "Link not found: $alias"
    return 0
  fi

  # Validate it's a symlink (not a file or directory)
  if [ ! -L "$alias_path" ]; then
    generate_error "Not a symlink: $alias" "Use appropriate command for files or directories"
    return 0
  fi

  # Output commands to remove symlink
  cat <<EOF
# Remove protocol-level link: $alias
$MODIFY_LINK_REMOVE "$alias_path"
echo "Removed protocol link: $alias"
EOF
}

#-----------------------------------------------------------------------------
# Config Management Commands - Validate and Clean
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# OpenVPN Config Management Commands
#-----------------------------------------------------------------------------

# process_arguments - Core command execution logic with optional tracing
#
# Processes command-line arguments through the combinator system:
# 1. Resolves args to function call via to_function_call()
# 2. Looks up correct interpreter via lookup_interpreter()
# 3. Executes via dispatch | run_env -- $interpreter
#
# This is the core execution path used by both:
# - main() for top-level commands
# - _batch2() for batch-file commands
#
# The key difference from hardcoding an interpreter:
# - Each command gets its CORRECT interpreter (terminal, combinator, or batch_combinator)
# - lookup_interpreter() uses intrinsic classification (underscore count)
# - Ensures proper execution semantics for all command types
#
# Tracing support:
# - If VPN_SWITCH_TRACE_FILE is set, enables detailed execution tracing
# - Tracing flows continuously through nested calls (including batch execution)
# - Validates trace file path to prevent accidental corruption
#
# Args: $@ - command-line arguments (e.g., "wireguard start privacy")
# Returns: Exit code from executed command
#
# Example:
#   process_arguments wireguard start privacy
#   → Resolves to __wireguard_start1
#   → Looks up combinator interpreter
#   → Executes via dispatch with optional tracing
#

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
		# Failure path: output captured results directly and fail
		# Bypass interpreter - show output to user and call _fail2 directly
		cat "$stdout_file"
		_fail2 "$dispatch_exit" "Command failed with exit $dispatch_exit"
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

# __start1 - Protocol-agnostic start with auto-detection (Phase 3.4.1)
#
# Args: $1 - config name (can be in any protocol directory)
# Output: Resolved protocol start command (single vpn-switch command)
#
# Resolution strategy (three-tier):
# 1. Extension link fast path: If name has extension and extension link exists,
#    resolve protocol via link (O(1) - fast)
# 2. Filesystem search: Scan all protocol directories for matching config
#    (O(n) protocols - slower but flexible)
# 3. Error handling: Clear messages for not found or ambiguous matches
#
# Benefits:
# - No hardcoded protocol names
# - User can add new protocols (e.g., ikev2/) without modifying this function
# - Extension links provide fast path for common case
# - Fallback search handles configs without extensions
#
#@help __start1
# @command start [<config>]
# @summary Connect using a config; with no argument, resume the default session or pick at random
# @group   connection
# @param   config  config/category/group/alias to start; omit to use the 'default' session, otherwise a random protocol and config
# @returns connect commands (delegates to the resolved protocol)
# @example vpn-switch start privacy
# @example vpn-switch start
# @see     stop
# @see     session save
# @see     wireguard start
#@end
__start1() {
  local name="$1"

  if [ -z "$name" ]; then
    echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error \"start: config name required\""
    return
  fi

  # Extract extension if present
  local ext=""
  case "$name" in
    *.*) ext="${name##*.}" ;;
  esac

  # Fast path: Extension link exists
  if [ -n "$ext" ] && [ -L "$VPN_SWITCH_BASE/$ext" ]; then
    local link_target
    link_target=$(readlink "$VPN_SWITCH_BASE/$ext" 2>>"$LOG_FILE")
    if [ $? -ne 0 ]; then
      echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error \"start: failed to resolve extension link: $ext\""
      return
    fi

    local protocol
    protocol=$(basename "$link_target")

    # Validate protocol directory exists
    if [ ! -d "$VPN_SWITCH_BASE/$protocol" ]; then
      echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error \"start: extension link '$ext' points to non-existent protocol '$protocol'\""
      return
    fi

    # Delegate to protocol-specific start
    echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" $protocol start $name"
    return
  fi

  # Fallback: Search all protocol directories
  local matches=""
  local proto
  for protocol_dir in "$VPN_SWITCH_BASE"/*; do
    # Skip symlinks (extension links like conf→wireguard/)
    [ -L "$protocol_dir" ] && continue
    [ -d "$protocol_dir" ] || continue
    proto=$(basename "$protocol_dir")

    # Skip pseudo-protocols
    is_pseudo_protocol "$proto" && continue

    # Look for config (exact match, with extension, or as category)
    for candidate in "$protocol_dir/$name" "$protocol_dir/$name".*; do
      # Check if file, symlink, or directory (category)
      if [ -f "$candidate" ] || [ -L "$candidate" ] || [ -d "$candidate" ]; then
        config_basename=$(basename "$candidate")

        # Add to matches
        if [ -z "$matches" ]; then
          matches="$proto:$config_basename"
        else
          matches="$matches $proto:$config_basename"
        fi
        break  # Only count first match per protocol
      fi
    done
  done

  # Handle results
  case "$matches" in
    "")
      # No matches found - build list of protocols searched
      local proto_list=""
      for protocol_dir in "$VPN_SWITCH_BASE"/*; do
        [ -L "$protocol_dir" ] && continue
        [ -d "$protocol_dir" ] || continue
        proto=$(basename "$protocol_dir")
        is_pseudo_protocol "$proto" && continue
        if [ -z "$proto_list" ]; then
          proto_list="$proto/$name"
        else
          proto_list="$proto_list, $proto/$name"
        fi
      done
      echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error \"start: config not found: $name\" \"Searched in: $proto_list\""
      return
      ;;
    *" "*)
      # Multiple matches - build list and suggest first match
      local match_list=""
      for match in $matches; do
        if [ -z "$match_list" ]; then
          match_list="${match%%:*}/${match#*:}"
        else
          match_list="$match_list, ${match%%:*}/${match#*:}"
        fi
      done
      # Get first match for suggestion
      local first_match="${matches%% *}"
      local first_proto="${first_match%%:*}"
      local first_config="${first_match#*:}"
      echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error \"Multiple configs match: $name\" \"Found: $match_list\" \"Use: vpn-switch $first_proto start $first_config\""
      return
      ;;
    *)
      # Single match - use it
      proto="${matches%%:*}"
      config="${matches#*:}"
      echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" $proto start $config"
      ;;
  esac
}

# __start0 - Protocol-agnostic start using default or random (Phase 3.4.1)
#
# No args - tries default session, then random protocol selection
# Output: Resolved protocol start command or session start command
#
# Resolution strategy:
# 1. Try session/default link (if exists, resume that session)
# 2. Otherwise: discover protocols and pick random config from random protocol
# 3. Skip pseudo-protocols during discovery
#
# Benefits:
# - No hardcoded protocol names
# - User can add new protocols and they'll be included in random selection
# - Seamless integration with session management (default session takes priority)
#
#@help __start0
# @internal arity-0 sibling of 'start' (use the default config)
#@end
__start0() {
  # Try default session first
  if [ -L "$VPN_SWITCH_BASE/session/default" ]; then
    echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" session start"
    return
  fi

  # No default session - discover protocols and pick randomly
  local protocols=""
  local proto
  for dir in "$VPN_SWITCH_BASE"/*; do
    # Skip symlinks (extension links like conf→wireguard/)
    [ -L "$dir" ] && continue
    [ -d "$dir" ] || continue
    proto=$(basename "$dir")

    # Skip pseudo-protocols
    is_pseudo_protocol "$proto" && continue

    # Check if protocol has any configs
    if ls "$dir"/*.* >/dev/null 2>&1 || \
       ls "$dir"/*/ >/dev/null 2>&1; then
      protocols="$protocols $proto"
    fi
  done

  # No protocols found
  if [ -z "$protocols" ]; then
    echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" error \"start: no VPN protocols found\" \"Run 'vpn-switch import' to add configs\""
    return 0
  fi

  # Pick random protocol
  local proto_count
  proto_count=$(printf "%s" "$protocols" | wc -w | tr -d ' ')
  local proto_index
  proto_index=$(($(date +%s) % proto_count + 1))
  local selected_proto
  selected_proto=$(printf "%s" "$protocols" | awk "{print \$$proto_index}")

  # Delegate to protocol-specific start with no args (picks random config)
  echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" $selected_proto start"
}

#-----------------------------------------------------------------------------
# Error Commands - Terminal Functions
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

        # Ensure interpreter variables have defaults (no .env files available)
        # Start with CACHE_ENV_ARGS if set (e.g., from bootstrap's init call)
        env_args="${VPN_SWITCH_CACHE_ENV_ARGS:-}"
        ensure_interpreter_var "VPN_SWITCH_TERMINAL_INTERPRETER"
        ensure_interpreter_var "VPN_SWITCH_COMBINATOR_INTERPRETER"
        ensure_interpreter_var "VPN_SWITCH_BATCH_COMBINATOR_INTERPRETER"
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
if [ "${0##*/}" = "vpn-switch.sh" ] || [ "${0##*/}" = "vpn-switch" ]; then
  # Bootstrap: Load environment from .env files exactly once
  # This happens at the top level, before main() is called
  if [ -z "${VPN_SWITCH_CONTEXT_BOOTSTRAPPED:-}" ]; then
    # Not bootstrapped yet - load environment and re-exec

    # Build environment arguments from .env files
    env_args=$(build_env_args)

    # Check if critical interpreter variables are missing from env_args
    # This happens during 'init' command before .env files exist
    # Provide defaults from template directory to allow basic operation
    ensure_interpreter_var "VPN_SWITCH_TERMINAL_INTERPRETER"
    ensure_interpreter_var "VPN_SWITCH_COMBINATOR_INTERPRETER"
    ensure_interpreter_var "VPN_SWITCH_BATCH_COMBINATOR_INTERPRETER"

    # Build passthrough variables (context, cache, trace)
    passthrough=""
    passthrough="$passthrough VPN_SWITCH_CONTEXT_BOOTSTRAPPED=1"

    # Cache env args for performance (avoid rebuilding in subprocesses)
    if [ -z "${VPN_SWITCH_CACHE_ENV_ARGS:-}" ]; then
      VPN_SWITCH_CACHE_ENV_ARGS="$env_args"
    fi
    passthrough="$passthrough VPN_SWITCH_CACHE_ENV_ARGS=\"\$VPN_SWITCH_CACHE_ENV_ARGS\""

    # Pass trace file if set (make relative paths relative to BASE/.trace/)
    if [ -n "${VPN_SWITCH_TRACE_FILE:-}" ]; then
      # If trace file is relative (doesn't start with /), make it relative to BASE/.trace/
      case "$VPN_SWITCH_TRACE_FILE" in
        /*)
          # Absolute path - use as-is
          passthrough="$passthrough VPN_SWITCH_TRACE_FILE=\"\$VPN_SWITCH_TRACE_FILE\""
          ;;
        *)
          # Relative path - make it relative to BASE/.trace/
          VPN_SWITCH_TRACE_FILE="${VPN_SWITCH_BASE}/.trace/${VPN_SWITCH_TRACE_FILE}"
          passthrough="$passthrough VPN_SWITCH_TRACE_FILE=\"\$VPN_SWITCH_TRACE_FILE\""
          ;;
      esac
    fi

    # Pass trace depth if set
    if [ -n "${VPN_SWITCH_TRACE_DEPTH:-}" ]; then
      passthrough="$passthrough VPN_SWITCH_TRACE_DEPTH=\"\$VPN_SWITCH_TRACE_DEPTH\""
    fi

    # Pass batch keep-going mode if set (runtime parameter)
    if [ -n "${VPN_SWITCH_BATCH_KEEP_GOING:-}" ]; then
      passthrough="$passthrough VPN_SWITCH_BATCH_KEEP_GOING=\"$VPN_SWITCH_BATCH_KEEP_GOING\""
    fi

    # Re-exec with loaded environment
    # IMPORTANT: VPN_SWITCH_BASE must come AFTER $env_args to override .env value
    eval "exec env - $env_args $passthrough VPN_SWITCH_CONTEXT_SCRIPT=\"\$VPN_SWITCH_CONTEXT_SCRIPT\" VPN_SWITCH_BASE=\"\$VPN_SWITCH_BASE\" \"\$VPN_SWITCH_CONTEXT_SCRIPT\" \"\$@\""
  fi

  # If we reach here, we're bootstrapped and environment is loaded
  main "$@"
fi
