#!/bin/sh
#
# === AUTO-GENERATED METADATA (make metadata) ===
# Generated: 2026-09-15 20:13:08
# Terminal functions (single underscore): output shell commands
# Combinator functions (double underscore): output single vpn-switch command
# Batch-combinator functions (triple underscore): output multiple vpn-switch commands
TERMINAL_FUNCTIONS="_error1 _error2 _error3 _fail2 _log1 _log2 _log3  _lift1 _database_init0 _environment_init1 _environment_cache1 _lift3 _setenv2 _getenv1 _unsetenv1 _cat1 _batch2 _printenv0 _env_sync0 _version_sync0 _version0 _link2 _remove1 _status0 _help0 _help1 _help2 _complete0 _complete1 _complete2 _complete3 _complete4 _complete5 _complete6 _helpenv0 _helpenv2 _database_enumerate0 _system_inspect0 _logs_inspect0 _phases_inspect0 _summary_inspect0 _prologue_inspect0 _openvpn_patch2 _openvpn_configure1 _openvpn_connect1 _openvpn_disconnect1 _openvpn_patch1 _openvpn_enumerate0 _openvpn_import1 _openvpn_list0 _openvpn_list1 _openvpn_add1 _openvpn_add3 _openvpn_link2 _openvpn_remove1 _openvpn_remove2 _openvpn_validate0 _openvpn_info1 _phases_copy0 _session_list0 _session_show1 _session_remove1 _session_connect1 _session_save0 _session_save1 _session_clean0 _session_refresh0 _session_validate0 _session_enumerate0 _session_describe0 _session_create1 _interface_destroy1 _session_populate3 _logs_validate0 _logs_clean0 _phases_validate0 _database_validate0 _binaries_validate0 _network_validate0 _permissions_validate0 _environment_validate0 _install_validate0 _version_validate0 _sudo_validate0 _wireguard_patch2 _wireguard_configure1 _wireguard_connect1 _wireguard_disconnect1 _wireguard_enumerate0 _wireguard_import1 _wireguard_list0 _wireguard_list1 _wireguard_add1 _wireguard_add3 _wireguard_link2 _wireguard_remove1 _wireguard_remove2 _wireguard_validate0 _wireguard_patch1 _wireguard_info1"
COMBINATOR_FUNCTIONS="__bootstrap1 __environment_cache0 __phases_lift1 __init0 __batch1 __restore1 __import1 __helpenv1 __setintp2 __getintp1 __helpintp1 __helpintp2 __openvpn_start0 __openvpn_start1 __openvpn_stop1 __openvpn_add2 __openvpn_help0 __session_disconnect1 __session_stop1 __session_show0 __session_start0 __session_start1 __session_help0 __session_exists1 __session_conflicts2 __interface_check1 __stop1 __start1 __start0 __wireguard_start0 __wireguard_start1 __wireguard_stop1 __wireguard_add2 __wireguard_help0"
BATCH_COMBINATOR_FUNCTIONS="___bootstrap2 ___init1 ___dumpenv1 ___dump0 ___batch0 ___sync0 ___list0 ___environment_inspect0 ___inspect0 ___openvpn_create1 ___openvpn_stop0 ___openvpn_inspect0 ___openvpn_clean0 ___openvpn_dump0 ___phases_sync1 ___phases_sync0 ___session_stop0 ___session_switch1 ___session_switch2 ___session_dump0 ___session_inspect0 ___session_prepare3 ___stop0 ___validate0 ___wireguard_create1 ___wireguard_inspect0 ___wireguard_stop0 ___wireguard_clean0 ___wireguard_clean1 ___wireguard_dump0"
ANCHOR_FUNCTIONS="_error1 _error2 _error3 _fail2 _log1 _log2 _log3  _lift1 _database_init0 _environment_init1 _environment_cache1 _lift3 _setenv2 _getenv1 _unsetenv1 _cat1 _batch2 _printenv0 _env_sync0 _version_sync0 _version0 _link2 _remove1 _status0 _help0 _help1 _help2 _complete0 _complete1 _complete2 _complete3 _complete4 _complete5 _complete6 _helpenv0 _helpenv2 _database_enumerate0 _system_inspect0 _logs_inspect0 _phases_inspect0 _summary_inspect0 _prologue_inspect0 _openvpn_patch2 _openvpn_configure1 _openvpn_connect1 _openvpn_disconnect1 _openvpn_patch1 _openvpn_enumerate0 _openvpn_import1 _openvpn_list0 _openvpn_list1 _openvpn_add1 _openvpn_add3 _openvpn_link2 _openvpn_remove1 _openvpn_remove2 _openvpn_validate0 _openvpn_info1 _phases_copy0 _session_list0 _session_show1 _session_remove1 _session_connect1 _session_save0 _session_save1 _session_clean0 _session_refresh0 _session_validate0 _session_enumerate0 _session_describe0 _session_create1 _interface_destroy1 _session_populate3 _logs_validate0 _logs_clean0 _phases_validate0 _database_validate0 _binaries_validate0 _network_validate0 _permissions_validate0 _environment_validate0 _install_validate0 _version_validate0 _sudo_validate0 _wireguard_patch2 _wireguard_configure1 _wireguard_connect1 _wireguard_disconnect1 _wireguard_enumerate0 _wireguard_import1 _wireguard_list0 _wireguard_list1 _wireguard_add1 _wireguard_add3 _wireguard_link2 _wireguard_remove1 _wireguard_remove2 _wireguard_validate0 _wireguard_patch1 _wireguard_info1   __bootstrap1 __environment_cache0 __phases_lift1 __init0 __batch1 __restore1 __import1 __helpenv1 __setintp2 __getintp1 __helpintp1 __helpintp2 __openvpn_start0 __openvpn_start1 __openvpn_stop1 __openvpn_add2 __openvpn_help0 __session_disconnect1 __session_stop1 __session_show0 __session_start0 __session_start1 __session_help0 __session_exists1 __session_conflicts2 __interface_check1 __stop1 __start1 __start0 __wireguard_start0 __wireguard_start1 __wireguard_stop1 __wireguard_add2 __wireguard_help0   ___bootstrap2 ___init1 ___dumpenv1 ___dump0 ___batch0 ___sync0 ___list0 ___environment_inspect0 ___inspect0 ___openvpn_create1 ___openvpn_stop0 ___openvpn_inspect0 ___openvpn_clean0 ___openvpn_dump0 ___phases_sync1 ___phases_sync0 ___session_stop0 ___session_switch1 ___session_switch2 ___session_dump0 ___session_inspect0 ___session_prepare3 ___stop0 ___validate0 ___wireguard_create1 ___wireguard_inspect0 ___wireguard_stop0 ___wireguard_clean0 ___wireguard_clean1 ___wireguard_dump0"
# Function-to-module mapping (format: "func:module.sh func:module.sh ...")
# Used by process_arguments() for deterministic module loading
FUNCTION_MODULES="__bootstrap1:database.sh ___bootstrap2:database.sh _lift1:database.sh _database_init0:database.sh _environment_init1:database.sh __environment_cache0:database.sh _environment_cache1:database.sh _lift3:database.sh __phases_lift1:database.sh ___init1:database.sh __init0:database.sh _setenv2:database.sh _getenv1:database.sh _unsetenv1:database.sh ___dumpenv1:database.sh ___dump0:database.sh _cat1:database.sh ___batch0:database.sh __batch1:database.sh _batch2:database.sh __restore1:database.sh _printenv0:database.sh ___sync0:database.sh _env_sync0:database.sh _version_sync0:database.sh _version0:database.sh __import1:database.sh ___list0:database.sh _link2:database.sh _remove1:database.sh _status0:help.sh _help0:help.sh _help1:help.sh _help2:help.sh _complete0:help.sh _complete1:help.sh _complete2:help.sh _complete3:help.sh _complete4:help.sh _complete5:help.sh _complete6:help.sh _helpenv0:helpenv.sh __helpenv1:helpenv.sh _helpenv2:helpenv.sh __setintp2:helpenv.sh __getintp1:helpenv.sh __helpintp1:helpenv.sh __helpintp2:helpenv.sh _database_enumerate0:inspect.sh ___environment_inspect0:inspect.sh _system_inspect0:inspect.sh _logs_inspect0:inspect.sh _phases_inspect0:inspect.sh _summary_inspect0:inspect.sh _prologue_inspect0:inspect.sh ___inspect0:inspect.sh __openvpn_start0:openvpn.sh __openvpn_start1:openvpn.sh ___openvpn_create1:openvpn.sh _openvpn_patch2:openvpn.sh _openvpn_configure1:openvpn.sh _openvpn_connect1:openvpn.sh ___openvpn_stop0:openvpn.sh __openvpn_stop1:openvpn.sh _openvpn_disconnect1:openvpn.sh _openvpn_patch1:openvpn.sh ___openvpn_inspect0:openvpn.sh _openvpn_enumerate0:openvpn.sh _openvpn_import1:openvpn.sh _openvpn_list0:openvpn.sh _openvpn_list1:openvpn.sh _openvpn_add1:openvpn.sh __openvpn_add2:openvpn.sh _openvpn_add3:openvpn.sh _openvpn_link2:openvpn.sh _openvpn_remove1:openvpn.sh _openvpn_remove2:openvpn.sh _openvpn_validate0:openvpn.sh ___openvpn_clean0:openvpn.sh _openvpn_info1:openvpn.sh ___openvpn_dump0:openvpn.sh __openvpn_help0:openvpn.sh _phases_copy0:phase.sh ___phases_sync1:phase.sh ___phases_sync0:phase.sh __session_disconnect1:session.sh ___session_stop0:session.sh __session_stop1:session.sh _session_list0:session.sh __session_show0:session.sh _session_show1:session.sh _session_remove1:session.sh __session_start0:session.sh __session_start1:session.sh ___session_switch1:session.sh ___session_switch2:session.sh _session_connect1:session.sh _session_save0:session.sh _session_save1:session.sh _session_clean0:session.sh _session_refresh0:session.sh _session_validate0:session.sh ___session_dump0:session.sh __session_help0:session.sh ___session_inspect0:session.sh _session_enumerate0:session.sh _session_describe0:session.sh _session_create1:session.sh __session_exists1:session.sh __session_conflicts2:session.sh _interface_destroy1:session.sh __interface_check1:session.sh ___session_prepare3:session.sh _session_populate3:session.sh ___stop0:session.sh __stop1:session.sh __start1:session.sh __start0:session.sh _logs_validate0:validate.sh _logs_clean0:validate.sh _phases_validate0:validate.sh _database_validate0:validate.sh _binaries_validate0:validate.sh _network_validate0:validate.sh _permissions_validate0:validate.sh _environment_validate0:validate.sh _install_validate0:validate.sh _version_validate0:validate.sh _sudo_validate0:validate.sh ___validate0:validate.sh __wireguard_start0:wireguard.sh __wireguard_start1:wireguard.sh ___wireguard_create1:wireguard.sh _wireguard_patch2:wireguard.sh _wireguard_configure1:wireguard.sh _wireguard_connect1:wireguard.sh _wireguard_disconnect1:wireguard.sh ___wireguard_inspect0:wireguard.sh _wireguard_enumerate0:wireguard.sh ___wireguard_stop0:wireguard.sh __wireguard_stop1:wireguard.sh _wireguard_import1:wireguard.sh _wireguard_list0:wireguard.sh _wireguard_list1:wireguard.sh _wireguard_add1:wireguard.sh __wireguard_add2:wireguard.sh _wireguard_add3:wireguard.sh _wireguard_link2:wireguard.sh _wireguard_remove1:wireguard.sh _wireguard_remove2:wireguard.sh _wireguard_validate0:wireguard.sh ___wireguard_clean0:wireguard.sh ___wireguard_clean1:wireguard.sh _wireguard_patch1:wireguard.sh _wireguard_info1:wireguard.sh ___wireguard_dump0:wireguard.sh __wireguard_help0:wireguard.sh"
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
COMMANDS_WITHOUT_DATABASE="help bootstrap init log error fail complete"

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
session:0750:noexec:operational
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

#-----------------------------------------------------------------------------
# The engine, then every module. VPN_SWITCH_INCLUDES is data (the template
# names the modules); the engine is never lazy-loaded, the modules are
# preloaded so a helper of one module serves the anchors of another.
#-----------------------------------------------------------------------------
. "$VPN_SWITCH_LIBDIR/include/engine.sh"
: "${VPN_SWITCH_INCLUDES:=database.sh session.sh phase.sh validate.sh inspect.sh wireguard.sh openvpn.sh help.sh helpenv.sh}"
for _m in $VPN_SWITCH_INCLUDES; do
  . "$VPN_SWITCH_LIBDIR/include/$_m"
done
unset _m

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
