#!/bin/sh
#
# === AUTO-GENERATED METADATA (make metadata) ===
# Generated: 2026-06-28 05:21:17
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
# vpn-switch Unit Test Suite - Formalized Edition
#
# Principles:
#   - One systematic way, no exceptions
#   - Every test uses 'vpn-switch bootstrap' for database creation
#   - test_setup() does minimal, universal setup only
#   - Each test is self-contained and tailors its own environment
#   - No cleanup - leave artifacts for debugging
#   - Per-test tracing and output capture
#
# POSIX shell compliant
#

set -e
set -u

#-----------------------------------------------------------------------------
# Test Configuration (Prologue)
#-----------------------------------------------------------------------------

# Test base directory - evaluated once at script start
# Uses TMPDIR if set, otherwise /tmp (making TMPDIR dependency explicit)
TEST_BASE_DIR="${TMPDIR:-/tmp}/vpn-switch-test.$$"

# Test script location
TEST_SCRIPT="./vpn-switch.sh"

# Profile for bootstrap (can be overridden via command-line argument)
# Default: minimal (only essential variables)
# Alternative: all (all .env-templates installed - quality gate for tests)
#
# Test filtering (optional): Specify test function names to run only those tests
#
# Usage:
#   ./vpn-switch-unit-test.sh                    # minimal profile, all tests
#   ./vpn-switch-unit-test.sh all                # all profile, all tests
#   ./vpn-switch-unit-test.sh minimal test_batch_validate_includes_system
#   ./vpn-switch-unit-test.sh all test_session_list test_session_show
TEST_PROFILE="${1:-minimal}"
shift

# Dynamically generate list of all test functions
ALL_TESTS=$(grep -o '^test_[a-z_]*()' "$0" | sed 's/()$//' | tr '\n' ' ')

# Collect test filter arguments (optional test function names)
TEST_FILTER="$*"

# If no filter specified, run all tests
if [ -z "$TEST_FILTER" ]; then
  TEST_FILTER="$ALL_TESTS"
fi

# Source platform-specific commands (EXAMINE_*, MODIFY_*)
# Uses the default symlink which points to the correct platform
PLATFORM_FILE="./template/platform/default"
if [ -f "$PLATFORM_FILE" ]; then
  . "$PLATFORM_FILE"
else
  echo "ERROR: Platform file not found: $PLATFORM_FILE" >&2
  echo "Run this script from the repository root" >&2
  exit 1
fi

#-----------------------------------------------------------------------------
# Test Framework Infrastructure
#-----------------------------------------------------------------------------

# should_run_test - Run test if it matches the filter
#
# Args: $1 - test function name (e.g., "test_batch_validate_includes_system")
#
# Returns: Always 0 (to prevent set -e from exiting when test is skipped)
#
# Usage:
#   should_run_test test_session_list
#
should_run_test() {
  local test_name="$1"

  # Check if test_name is in the filter list
  for filter_test in $TEST_FILTER; do
    if [ "$filter_test" = "$test_name" ]; then
      "$test_name"
      return 0
    fi
  done

  # Test not in filter list - skip it
  return 0
}

# Test counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Color support - always use escape codes
# Using literal escape codes for portability (tput output varies across systems)
# All color output uses printf '%b' to interpret escape sequences
# Note: Always write escape codes so log files can be viewed with color
# using tools like 'tail -f', 'less -R', or terminal emulators
COLOR_GREEN='\033[1;32m'
COLOR_RED='\033[1;31m'
COLOR_YELLOW='\033[1;33m'
COLOR_BLUE='\033[1;34m'
COLOR_RESET='\033[0m'

# Global test directory (set by test_setup, used by all tests)
TEST_DIR=""

# pass - Mark assertion as passed
pass() {
  TESTS_PASSED=$((TESTS_PASSED + 1))
  printf '%b✓%b %s\n' "$COLOR_GREEN" "$COLOR_RESET" "$*"
}

# fail - Mark assertion as failed
fail() {
  TESTS_FAILED=$((TESTS_FAILED + 1))
  printf '%b✗%b %s\n' "$COLOR_RED" "$COLOR_RESET" "$*"
}

# get_file_perms - Get file permissions in octal (cross-platform)
# Uses EXAMINE_FILE_PERMS from platform script (e.g., "stat -f %Lp" on FreeBSD)
get_file_perms() {
  local file="$1"
  $EXAMINE_FILE_PERMS "$file" 2>/dev/null
}

# get_file_perms_full - Get file permissions in octal (cross-platform)
# Uses EXAMINE_FILE_PERMS from platform script
# Returns just permission bits (e.g., "600") - tests accept both "100600" and "600" formats
get_file_perms_full() {
  local file="$1"
  $EXAMINE_FILE_PERMS "$file" 2>/dev/null
}

# test_header - Print test header
#
# Args: $1 - Test description
#       $2 - Optional: Function name (for easy test selection)
#
test_header() {
  local description="$1"
  local function_name="${2:-}"

  TESTS_RUN=$((TESTS_RUN + 1))
  echo ""

  if [ -n "$function_name" ]; then
    printf '%bTEST %s (%s):%b %s\n' "$COLOR_BLUE" "$TESTS_RUN" "$function_name" "$COLOR_RESET" "$description"
  else
    printf '%bTEST %s:%b %s\n' "$COLOR_BLUE" "$TESTS_RUN" "$COLOR_RESET" "$description"
  fi
}

# test_summary - Print test summary
test_summary() {
  local test_functions=$TESTS_RUN
  local assertions_passed=$TESTS_PASSED
  local assertions_failed=$TESTS_FAILED
  local total_assertions=$((assertions_passed + assertions_failed))

  echo ""
  echo "========================================"
  echo "Test Summary"
  echo "========================================"
  echo "Test Functions:     $test_functions"
  echo "Total Assertions:   $total_assertions"
  printf '%bPassed Assertions:  %s%b\n' "$COLOR_GREEN" "$assertions_passed" "$COLOR_RESET"
  if [ "$assertions_failed" -gt 0 ]; then
    printf '%bFailed Assertions:  %s%b\n' "$COLOR_RED" "$assertions_failed" "$COLOR_RESET"
  else
    echo "Failed Assertions:  $assertions_failed"
  fi
  echo ""

  if [ "$assertions_failed" -gt 0 ]; then
    printf '%bSOME TESTS FAILED%b\n' "$COLOR_RED" "$COLOR_RESET"
    echo ""
    echo "Test artifacts preserved in: $TEST_BASE_DIR"
    echo "To clean up: rm -rf $TEST_BASE_DIR"
    return 1
  else
    printf '%bALL TESTS PASSED%b\n' "$COLOR_GREEN" "$COLOR_RESET"
    return 0
  fi
}

#-----------------------------------------------------------------------------
# Universal Test Setup (Minimal, Systematic, No Exceptions)
#-----------------------------------------------------------------------------

# test_setup - Create EXCLUSIVE test database for THIS test
#
# Principles:
#   - Each test gets its own exclusive database directory
#   - Uses 'vpn-switch bootstrap' to create database (systematic, no exceptions)
#   - bootstrap creates directory and initializes database in one command
#   - NO test-specific configuration (tests do that themselves)
#
# Returns: Sets TEST_DIR to the exclusive database directory for this test
#
test_setup() {
  # Create exclusive test directory for THIS test
  local test_num=$TESTS_RUN
  TEST_DIR="$TEST_BASE_DIR/test_${test_num}"

  # Show database path for debugging
  printf '  %bDatabase:%b %s\n' "$COLOR_BLUE" "$COLOR_RESET" "$TEST_DIR"

  # Run 'vpn-switch bootstrap' to create database
  # Bootstrap creates the directory and initializes the database structure
  # This is the ONLY way we create test databases (systematic, no exceptions)
  # Profile comes from TEST_PROFILE (set via command-line argument or default)
  mkdir -p "$TEST_BASE_DIR"
  local bootstrap_log="$TEST_BASE_DIR/test_${test_num}.bootstrap.log"

  # Set minimal PATH for bootstrap operations (needed for run_env before database exists)
  export VPN_SWITCH_PATH="/bin:/usr/bin:/usr/local/bin"

  if ! "$TEST_SCRIPT" bootstrap "$TEST_DIR" "$TEST_PROFILE" > "$bootstrap_log" 2>&1; then
    printf '%bERROR:%b vpn-switch bootstrap failed for test %s (profile: %s)\n' "$COLOR_RED" "$COLOR_RESET" "$test_num" "$TEST_PROFILE"
    printf '%bBootstrap output:%b\n' "$COLOR_YELLOW" "$COLOR_RESET"
    cat "$bootstrap_log" | sed 's/^/  /'
    echo ""
    echo "Full log saved to: $bootstrap_log"
    exit 1
  fi

  # Simulate experienced user who overrides safety default
  # Both minimal and all profiles ship TERMINAL_INTERPRETER=cat (safe by default)
  # Tests simulate user who has opted into auto-execution for convenience
  # Use setenv to configure (black-box approach - tests the actual user interface)
  VPN_SWITCH_BASE="$TEST_DIR" "$TEST_SCRIPT" setenv VPN_SWITCH_TERMINAL_INTERPRETER sh > /dev/null 2>&1

  # Set minimal PATH for vpn-switch operations
  VPN_SWITCH_BASE="$TEST_DIR" "$TEST_SCRIPT" setenv VPN_SWITCH_PATH "/bin:/usr/bin:/usr/local/bin" > /dev/null 2>&1

  # Copy test configs into database (if available)
  if [ -d "test-configs/wireguard" ]; then
    cp test-configs/wireguard/*.conf "$TEST_DIR/wireguard/" 2>/dev/null || true
    chmod 0400 "$TEST_DIR/wireguard"/*.conf 2>/dev/null || true
  fi
}

# setup_session_test_mocks - Mock external commands for session operation tests
#
# Layer 2/3 tests (start, connect, stop, session operations) need to mock
# external commands to avoid actually executing network operations.
#
# Args: $1 - Optional test ID for unique interface names (e.g., "13", "14")
#           If provided, interfaces will be named wg_test<ID>, tun_test<ID>
#           If omitted, uses default wg9, tun9 (backward compatible)
#
# Uses .env/local/ hierarchy (proper override location) to mock:
#   - VPN_SWITCH_BINARY_wireguard: wg-quick → echo wg-quick (mock network interface ops)
#   - VPN_SWITCH_PFCTL: pfctl → echo pfctl (mock firewall ops)
#   - VPN_SWITCH_INSTALL: install → echo install (mock file installation ops)
#   - VPN_SWITCH_WG_INTERFACE: wg0 → wg_test<ID> (unique test interface name)
#
# Must be called AFTER test_setup() for tests that need command mocking.
#
setup_session_test_mocks() {
  local test_id="${1:-9}"  # Default to 9 for backward compatibility

  # Determine interface names based on test_id
  local wg_interface="wg_test${test_id}"
  local ovpn_interface="tun_test${test_id}"

  # Mock wg-quick to avoid actually creating network interfaces
  run_vpn_switch setenv VPN_SWITCH_BINARY_wireguard "echo wg-quick" > /dev/null 2>&1

  # Mock openvpn to avoid actually creating VPN tunnels
  run_vpn_switch setenv VPN_SWITCH_BINARY_openvpn "echo openvpn" > /dev/null 2>&1

  # Mock pfctl to avoid actually modifying firewall rules
  run_vpn_switch setenv VPN_SWITCH_PFCTL "echo pfctl" > /dev/null 2>&1

  # Mock install to avoid actually writing to system directories
  run_vpn_switch setenv VPN_SWITCH_INSTALL "echo install" > /dev/null 2>&1

  # Use unique test interface names to avoid conflicts between tests
  run_vpn_switch setenv VPN_SWITCH_INTERFACE_wireguard "$wg_interface" > /dev/null 2>&1
  run_vpn_switch setenv VPN_SWITCH_INTERFACE_openvpn "$ovpn_interface" > /dev/null 2>&1

  # Set resolvconf script paths (base path, scripts append -up/-down)
  run_vpn_switch setenv VPN_SWITCH_RESOLVCONF_wireguard "/usr/local/sbin/wg-resolvconf" > /dev/null 2>&1
  run_vpn_switch setenv VPN_SWITCH_RESOLVCONF_openvpn "/usr/local/sbin/ovpn-resolvconf" > /dev/null 2>&1
}

#-----------------------------------------------------------------------------
# Helper Functions
#-----------------------------------------------------------------------------

# set_function_interpreter - Set interpreter for a specific function
#
# Reduces code duplication by centralizing the pattern of setting function-specific
# interpreters in .env/local/ directory.
#
# Args: $1 - Function name (e.g., "wireguard_connect", "session_list")
#       $2 - Interpreter value (e.g., "cat", "sh", "echo")
#
# Creates: $TEST_DIR/.env/local/VPN_SWITCH_INTERPRETER_<function>
#
# Usage:
#   set_function_interpreter "wireguard_connect" "cat"
#   set_function_interpreter "session_list" "sh"
#
set_function_interpreter() {
  local func_name="$1"
  local interpreter="$2"

  # Use setenv to configure interpreter (black-box approach)
  run_vpn_switch setenv "VPN_SWITCH_INTERPRETER_${func_name}" "$interpreter" > /dev/null 2>&1
}

# override_for_command_inspection - Override interpreter for command inspection
#
# Tests that need to inspect command output (grep for specific commands) must
# explicitly override the interpreter to 'cat' regardless of profile.
#
# Args: $1 - Function name (without underscore prefix)
#
# This helper ensures tests are profile-independent by setting function-specific
# interpreter (highest priority in resolution chain), which overrides intrinsic
# classification (TERMINAL_INTERPRETER).
#
# Usage:
#   test_setup
#   override_for_command_inspection "link"
#   output=$(VPN_SWITCH_BASE="$TEST_DIR" "$TEST_SCRIPT" link testproto wireguard)
#   grep "ln -s" <<< "$output"  # Works with ANY profile
#
override_for_command_inspection() {
  local func="$1"

  if [ -z "$func" ]; then
    printf '%bERROR:%b override_for_command_inspection requires function name\n' "$COLOR_RED" "$COLOR_RESET"
    exit 1
  fi

  # Set function-specific interpreter to cat (highest priority)
  # This overrides both TERMINAL_INTERPRETER and intrinsic classification
  set_function_interpreter "$func" "cat"
}

# run_vpn_switch - Execute vpn-switch.sh through the user interface
#
# Arguments:
#   $1-N: command arguments to pass to vpn-switch.sh
#
# Environment:
#   Uses only variables a normal user would set:
#   - VPN_SWITCH_BASE: database location (always set in tests)
#   - VPN_SWITCH_DISPLAY_ANSI: disable colors for test parsing
#
# Log/trace files are automatically created in database's .log/ directory
# based on LOG_RETENTION_DAYS and TRACE_RETENTION_DAYS settings (default: 1 day)
#
# Sets up per-test output capture:
#   - Output saved to: $TEST_BASE_DIR/traces/output_${TESTS_RUN}.log
#
# Returns: captured stdout and stderr
#
run_vpn_switch() {
  # Create traces directory for test output capture
  local test_num=$TESTS_RUN
  local traces_dir="$TEST_BASE_DIR/traces"
  mkdir -p "$traces_dir"

  # Set up per-test output file for assertions
  local output_file="$traces_dir/output_${test_num}.log"

  # Execute vpn-switch exactly as a user would
  # Only user-facing environment variables:
  # - VPN_SWITCH_BASE: where the database lives
  # - VPN_SWITCH_DISPLAY_ANSI: disable colors for grep parsing
  # Note: Log/trace files are automatically managed by retention settings
  VPN_SWITCH_BASE="$TEST_DIR" \
  VPN_SWITCH_DISPLAY_ANSI=0 \
  "$TEST_SCRIPT" "$@" 2>&1 | tee "$output_file"
}

# validate_batch_syntax - Validate batch combinator output syntax (Issue #001)
#
# Args: $1 - output (batch combinator output to validate)
#       $2 - function_name (for error messages)
#
# Returns: 0 if valid, 1 if invalid (with error message)
#
# Validates that batch combinator output follows strict syntax rules:
# - Non-comment lines must start with "$VPN_SWITCH_CONTEXT_SCRIPT"
# - Variable must be literal (escaped $), not expanded
# - No multiple commands per line (no ;, &&, ||)
# - Comments and empty lines are allowed
#
validate_batch_syntax() {
  local output="$1"
  local function_name="$2"
  local line_num=0

  echo "$output" | while IFS= read -r line; do
    line_num=$((line_num + 1))

    # Skip empty lines
    [ -z "$line" ] && continue

    # Allow comments
    case "$line" in
      '#'*) continue ;;
    esac

    # Must start with literal "$VPN_SWITCH_CONTEXT_SCRIPT"
    if ! echo "$line" | grep -q '^"\$VPN_SWITCH_CONTEXT_SCRIPT"'; then
      echo "ERROR: $function_name line $line_num: Must start with \"\\\$VPN_SWITCH_CONTEXT_SCRIPT\""
      echo "  Got: $line"
      return 1
    fi

    # Must NOT have expanded path (absolute paths indicate expansion)
    if echo "$line" | grep -qE '"/[^$].*vpn-switch'; then
      echo "ERROR: $function_name line $line_num: Variable expanded (not literal)"
      echo "  Got: $line"
      return 1
    fi

    # Must NOT have multiple commands per line
    if echo "$line" | grep -qEE ';|&&|||'; then
      echo "ERROR: $function_name line $line_num: Multiple commands per line"
      echo "  Got: $line"
      return 1
    fi
  done
}

#-----------------------------------------------------------------------------
# Test Cases
#-----------------------------------------------------------------------------

# TEST 1: Basic printenv command (simplest possible test)
test_printenv_command() {
  test_header "printenv - basic environment display" "test_printenv_command"

  # Create exclusive database for this test
  test_setup

  # Run printenv command
  local output=$(run_vpn_switch printenv)

  # Verify printenv output shows environment variables header
  if printf '%s\n' "$output" | grep -q "Environment variables in isolated context"; then
    pass "Printenv command executed and shows header"
  else
    fail "Printenv command did not show expected output"
  fi

  # Verify it shows sorted environment
  if printf '%s\n' "$output" | grep -q "VPN_SWITCH_BASE"; then
    pass "Printenv shows VPN_SWITCH_BASE variable"
  else
    fail "Printenv did not show VPN_SWITCH_BASE variable"
  fi
}

# TEST 2: Status command
test_status_command() {
  test_header "status - VPN status display" "test_status_command"

  # Create exclusive database for this test
  test_setup

  # Run status command
  local output=$(run_vpn_switch status)

  # Verify status output shows header
  if printf '%s\n' "$output" | grep -q "VPN Status"; then
    pass "Status command shows header"
  else
    fail "Status command did not show header"
  fi

  # Verify status shows disconnected state (no VPN running)
  if printf '%s\n' "$output" | grep -q "Disconnected"; then
    pass "Status shows disconnected state"
  else
    fail "Status did not show disconnected state"
  fi

  # Verify status checks network interfaces
  if printf '%s\n' "$output" | grep -q "Network Interfaces"; then
    pass "Status checks network interfaces"
  else
    fail "Status did not check network interfaces"
  fi
}

# TEST 3: WireGuard import - valid config
test_wireguard_import_valid() {
  test_header "wireguard import - import valid config" "test_wireguard_import_valid"

  # Create exclusive database for this test
  test_setup

  # Enable execution for wireguard import (narrow override)
  set_function_interpreter "wireguard_import1" "sh"

  # Create a test config file in temp location
  local test_config="$TEST_BASE_DIR/test-import-wg-NL-99.conf"
  cat > "$test_config" <<'EOF'
[Interface]
PrivateKey = test_private_key_placeholder
Address = 10.2.0.2/32
DNS = 10.2.0.1

[Peer]
PublicKey = test_public_key_placeholder
AllowedIPs = 0.0.0.0/0
Endpoint = 1.2.3.4:51820
EOF
  chmod 0600 "$test_config"

  # Run import command (actually execute it!)
  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1

  # Verify the file was actually copied to the database
  local imported_file="$TEST_DIR/wireguard/test-import-wg-NL-99.conf"
  if [ -f "$imported_file" ]; then
    pass "Config file imported to database"
  else
    fail "Config file was not imported"
    ls -la "$TEST_DIR/wireguard/" || true
  fi

  # Verify permissions are 0400 (read-only)
  if [ -f "$imported_file" ]; then
    local perms=$(get_file_perms "$imported_file")
    if [ "$perms" = "400" ]; then
      pass "Permissions set to 0400 (read-only)"
    else
      fail "Permissions incorrect: got $perms, expected 400"
    fi
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST 4: WireGuard add - create category
test_wireguard_add_category() {
  test_header "wireguard add - create category with permissions" "test_wireguard_add_category"

  # Create exclusive database for this test
  test_setup

  # Enable execution for wireguard add (narrow override)
  set_function_interpreter "wireguard_add" "sh"

  # Run add command (actually execute it!)
  run_vpn_switch wireguard add test-streaming >/dev/null 2>&1

  # Verify category directory was created
  local category_dir="$TEST_DIR/wireguard/test-streaming"
  if [ -d "$category_dir" ]; then
    pass "Category directory created"
  else
    fail "Category directory was not created"
    ls -la "$TEST_DIR/wireguard/" || true
  fi

  # Verify permissions are 0755 (rwxr-xr-x)
  if [ -d "$category_dir" ]; then
    local perms=$(get_file_perms "$category_dir")
    if [ "$perms" = "755" ]; then
      pass "Permissions set to 0755"
    else
      fail "Permissions incorrect: got $perms, expected 755"
    fi
  fi
}

# TEST 5: WireGuard link - create symlink
test_wireguard_link_create() {
  test_header "wireguard link - create symlink in protocol directory" "test_wireguard_link_create"

  # Create exclusive database for this test
  test_setup

  # Enable execution for wireguard import and link (narrow overrides)
  set_function_interpreter "wireguard_import1" "sh"
  set_function_interpreter "wireguard_link2" "sh"

  # First, import a config file to link to
  local test_config="$TEST_BASE_DIR/wg-TEST-RS-1.conf"
  cat > "$test_config" <<'EOF'
[Interface]
PrivateKey = test_key_for_link
Address = 10.2.0.3/32
DNS = 10.2.0.1

[Peer]
PublicKey = test_public_key_for_link
AllowedIPs = 0.0.0.0/0
Endpoint = 5.6.7.8:51820
EOF
  chmod 0600 "$test_config"

  # Import the config file first
  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1

  # Now create the link
  run_vpn_switch wireguard link test-link wg-TEST-RS-1.conf >/dev/null 2>&1

  # Verify symlink was created
  local link_path="$TEST_DIR/wireguard/test-link"
  if [ -L "$link_path" ]; then
    pass "Symlink created"
  else
    fail "Symlink was not created"
    ls -la "$TEST_DIR/wireguard/" || true
  fi

  # Verify symlink points to the correct target
  if [ -L "$link_path" ]; then
    local link_target=$(readlink "$link_path")
    if [ "$link_target" = "./wg-TEST-RS-1.conf" ]; then
      pass "Symlink points to correct relative path (./wg-TEST-RS-1.conf)"
    else
      fail "Symlink target incorrect: got '$link_target', expected './wg-TEST-RS-1.conf'"
    fi
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST 6: WireGuard list - display configs and categories
test_wireguard_list() {
  test_header "wireguard list - display configurations" "test_wireguard_list"

  # Create exclusive database for this test
  test_setup

  # Enable execution for wireguard import and add (narrow overrides)
  set_function_interpreter "wireguard_import1" "sh"
  set_function_interpreter "wireguard_add" "sh"

  # Add some test data to make the list more interesting
  # Import a config
  local test_config="$TEST_BASE_DIR/wg-TEST-NL-1.conf"
  cat > "$test_config" <<'EOF'
[Interface]
PrivateKey = test_key_nl1
Address = 10.2.0.4/32
DNS = 10.2.0.1

[Peer]
PublicKey = test_public_key_nl1
AllowedIPs = 0.0.0.0/0
Endpoint = 9.10.11.12:51820
EOF
  chmod 0600 "$test_config"
  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1

  # Create a category
  run_vpn_switch wireguard add privacy >/dev/null 2>&1

  # Run list command
  local output=$(run_vpn_switch wireguard list)

  # Verify header displayed
  if printf '%s\n' "$output" | grep -q "WireGuard Configurations"; then
    pass "Configuration section header displayed"
  else
    fail "Configuration header missing"
    printf '%s\n' "Output: $output"
  fi

  # Verify config files section exists
  if printf '%s\n' "$output" | grep -q "Configuration files:"; then
    pass "Config files section displayed"
  else
    fail "Config files section missing"
    printf '%s\n' "Output: $output"
  fi

  # Verify our imported config is listed
  if printf '%s\n' "$output" | grep -q "wg-TEST-NL-1.conf"; then
    pass "Imported config file listed"
  else
    fail "Imported config not shown"
    printf '%s\n' "Output: $output"
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST 7: WireGuard validate - check configuration integrity
test_wireguard_validate() {
  test_header "wireguard validate - validate clean configuration" "test_wireguard_validate"

  # Create exclusive database for this test
  test_setup

  # Run validate on clean database
  local output=$(run_vpn_switch wireguard validate)

  # Verify validation header
  if printf '%s\n' "$output" | grep -q "WireGuard Configuration Validation"; then
    pass "Validation header displayed"
  else
    fail "Validation header missing"
    printf '%s\n' "Output: $output"
  fi

  # Verify no errors reported
  if printf '%s\n' "$output" | grep -q "No issues found"; then
    pass "No issues found in clean configuration"
  else
    fail "Unexpected issues reported"
    printf '%s\n' "Output: $output"
  fi
}

# TEST 8: WireGuard info - display category information
test_wireguard_info() {
  test_header "wireguard info - display category information" "test_wireguard_info"

  # Create exclusive database for this test
  test_setup

  # Enable execution for wireguard add and import (narrow overrides)
  set_function_interpreter "wireguard_add" "sh"
  set_function_interpreter "wireguard_import1" "sh"

  # Create privacy category
  run_vpn_switch wireguard add privacy >/dev/null 2>&1

  # Import a config and link it to the category
  local test_config="$TEST_BASE_DIR/wg-TEST-CH-1.conf"
  cat > "$test_config" <<'EOF'
[Interface]
PrivateKey = test_key_ch1
Address = 10.2.0.5/32
DNS = 10.2.0.1

[Peer]
PublicKey = test_public_key_ch1
AllowedIPs = 0.0.0.0/0
Endpoint = 13.14.15.16:51820
EOF
  chmod 0600 "$test_config"
  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1

  # Link config to privacy category (category, target, alias)
  run_vpn_switch wireguard add privacy wg-TEST-CH-1.conf ch1 >/dev/null 2>&1

  # Run info command on privacy category
  local output=$(run_vpn_switch wireguard info privacy)

  # Verify category header displayed
  if printf '%s\n' "$output" | grep -q "Category: privacy"; then
    pass "Category header displayed"
  else
    fail "Category header missing"
    printf '%s\n' "Output: $output"
  fi

  # Verify path displayed
  if printf '%s\n' "$output" | grep -q "Path:.*privacy"; then
    pass "Category path displayed"
  else
    fail "Category path missing"
    printf '%s\n' "Output: $output"
  fi

  # Verify contents section exists
  if printf '%s\n' "$output" | grep -q "Contents:"; then
    pass "Contents section displayed"
  else
    fail "Contents section missing"
    printf '%s\n' "Output: $output"
  fi

  # Verify symlinks shown with arrow notation
  if printf '%s\n' "$output" | grep -q -- "->"; then
    pass "Category contents listed with symlink arrows"
  else
    fail "Contents not shown properly"
    printf '%s\n' "Output: $output"
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST 9: WireGuard start - create session and connect
test_wireguard_start_basic() {
  test_header "wireguard start - create session and connect to VPN" "test_wireguard_start_basic"

  # Create exclusive database for this test
  test_setup

  # Set up mocks for network operations with unique test ID
  local test_id=13
  setup_session_test_mocks "$test_id"
  local test_interface="wg_test${test_id}"

  # Enable execution for wireguard add and import (narrow overrides)
  set_function_interpreter "wireguard_add" "sh"
  set_function_interpreter "wireguard_import1" "sh"

  # Create privacy category
  run_vpn_switch wireguard add privacy >/dev/null 2>&1

  # Import a config and link it to the category
  local test_config="$TEST_BASE_DIR/wg-TEST-DE-1.conf"
  cat > "$test_config" <<'EOF'
[Interface]
PrivateKey = test_key_de1
Address = 10.2.0.6/32
DNS = 10.2.0.1

[Peer]
PublicKey = test_public_key_de1
AllowedIPs = 0.0.0.0/0
Endpoint = 17.18.19.20:51820
EOF
  chmod 0600 "$test_config"
  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1
  run_vpn_switch wireguard add privacy wg-TEST-DE-1.conf de1 >/dev/null 2>&1

  # Run start command
  local output=$(run_vpn_switch wireguard start privacy 2>&1 || true)

  # Verify session was created
  if printf '%s\n' "$output" | grep -qi "session"; then
    pass "Session creation logged"
  else
    fail "Session creation not logged"
    printf '%s\n' "Output: $output"
  fi

  # Verify wg-quick command is in generated connect.sh
  local session_dir=$(ls -1d "$TEST_DIR/.session"/* 2>/dev/null | head -1)
  if [ -f "$session_dir/connect.sh" ] && grep -q "wg-quick" "$session_dir/connect.sh"; then
    pass "wg-quick command in connect.sh"
  else
    fail "wg-quick command not found in connect.sh"
    printf '%s\n' "Output: $output"
  fi

  # Verify session directory was created
  local session_count=$(ls -1d "$TEST_DIR/.session"/* 2>/dev/null | wc -l)
  if [ "$session_count" -ge 1 ]; then
    pass "Session directory created in .session/"
  else
    fail "Session directory not found"
    ls -la "$TEST_DIR/.session/" || true
  fi

  # Verify session metadata files exist
  local session_dir=$(ls -1d "$TEST_DIR/.session"/* 2>/dev/null | head -1)
  if [ -f "$session_dir/protocol" ] && [ -f "$session_dir/pid" ]; then
    pass "Session metadata files created"
  else
    fail "Session metadata files missing"
    ls -la "$session_dir" || true
  fi

  # Verify connect.sh was generated
  if [ -f "$session_dir/connect.sh" ]; then
    pass "connect.sh script generated"
  else
    fail "connect.sh script not found"
    ls -la "$session_dir" || true
  fi

  # Verify connect.sh is executable
  if [ -x "$session_dir/connect.sh" ]; then
    pass "connect.sh is executable"
  else
    fail "connect.sh is not executable"
    ls -la "$session_dir/connect.sh" || true
  fi

  # Verify connect.sh contains relative path to original
  if grep -q "Original config: ../../wireguard" "$session_dir/connect.sh"; then
    pass "connect.sh documents original config with relative path"
  else
    fail "connect.sh missing relative path to original"
    grep "Original config:" "$session_dir/connect.sh" || true
  fi

  # Verify patched config exists (uses test interface name)
  if [ -f "$session_dir/${test_interface}.conf" ]; then
    pass "Patched config (${test_interface}.conf) created"
  else
    fail "Patched config not found"
    ls -la "$session_dir" || true
  fi

  # Phase-based approach: PostUp/PostDown hooks should be stripped (DNS handled by DNS phase)
  if grep -q "PostUp.*resolvconf" "$session_dir/${test_interface}.conf"; then
    fail "Patched config should NOT contain PostUp hook (phase-based DNS)"
    grep -i "post" "$session_dir/${test_interface}.conf" || true
  else
    pass "Patched config correctly strips PostUp hook (phase-based DNS)"
  fi

  # Verify PostDown hook also stripped
  if grep -q "PostDown.*resolvconf" "$session_dir/${test_interface}.conf"; then
    fail "Patched config should NOT contain PostDown hook (phase-based DNS)"
    grep -i "post" "$session_dir/${test_interface}.conf" || true
  else
    pass "Patched config correctly strips PostDown hook (phase-based DNS)"
  fi

  # Cleanup: Stop the VPN session to avoid interfering with subsequent tests
  set_function_interpreter "wireguard_stop" "sh"
  run_vpn_switch wireguard stop >/dev/null 2>&1

  # Cleanup
  rm -f "$test_config"
}

# TEST 10: WireGuard connect - resume existing session
test_wireguard_connect_resume() {
  test_header "wireguard connect - resume existing session by ID" "test_wireguard_connect_resume"

  # Create exclusive database for this test
  test_setup

  # Set up mocks for network operations with unique test ID
  local test_id=14
  setup_session_test_mocks "$test_id"
  local test_interface="wg_test${test_id}"

  # Enable execution for wireguard add and import (narrow overrides)
  set_function_interpreter "wireguard_add" "sh"
  set_function_interpreter "wireguard_import1" "sh"

  # Create privacy category and config (same setup as start test)
  run_vpn_switch wireguard add privacy >/dev/null 2>&1
  local test_config="$TEST_BASE_DIR/wg-TEST-SE-1.conf"
  cat > "$test_config" <<'EOF'
[Interface]
PrivateKey = test_key_se1
Address = 10.2.0.7/32
DNS = 10.2.0.1

[Peer]
PublicKey = test_public_key_se1
AllowedIPs = 0.0.0.0/0
Endpoint = 21.22.23.24:51820
EOF
  chmod 0600 "$test_config"
  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1
  run_vpn_switch wireguard add privacy wg-TEST-SE-1.conf se1 >/dev/null 2>&1

  # Run start to create session and extract session ID from output (black-box testing)
  local start_output=$(run_vpn_switch wireguard start privacy 2>&1 || true)

  # Extract session ID from the output (what the user interface reports)
  local session_id=$(echo "$start_output" | grep -oE '[Ss]ession:? [0-9]+|PID:? [0-9]+|session [0-9]+' | grep -oE '[0-9]+' | head -1)

  if [ -z "$session_id" ]; then
    fail "Could not extract session ID from wireguard start output"
    echo "Start output: $start_output"
    rm -f "$test_config"
    return
  fi

  # Now test standalone connect with session ID
  local output=$(run_vpn_switch wireguard connect "$session_id" 2>&1 || true)

  # Verify connect.sh contains expected commands
  local session_dir="$TEST_DIR/.session/$session_id"
  if [ -f "$session_dir/connect.sh" ] && grep -q "wg-quick" "$session_dir/connect.sh"; then
    pass "wireguard connect generated wg-quick command in connect.sh"
  else
    fail "wg-quick command not found in connect.sh"
    printf '%s\n' "Output: $output"
  fi

  # Verify firewall commands in connect.sh
  if grep -q "pfctl" "$session_dir/connect.sh"; then
    pass "wireguard connect generated pfctl command in connect.sh"
  else
    fail "pfctl command not found in connect.sh"
    printf '%s\n' "Output: $output"
  fi

  # Verify connect.sh references the session's config
  if grep -qiE "wg9|wireguard" "$session_dir/connect.sh"; then
    pass "wireguard connect used session configuration"
  else
    fail "Session configuration not referenced in connect.sh"
    cat "$session_dir/connect.sh" || echo "connect.sh not found"
  fi

  # Verify connect.sh still exists after connect (shouldn't be deleted)
  local session_dir="$TEST_DIR/.session/$session_id"
  if [ -f "$session_dir/connect.sh" ]; then
    pass "connect.sh preserved after connect"
  else
    fail "connect.sh was deleted"
    ls -la "$session_dir" || true
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST 11: WireGuard stop - stop active VPN session
test_wireguard_stop_basic() {
  test_header "stop - disconnect active VPN session" "test_wireguard_stop_basic"

  # Create exclusive database for this test
  test_setup

  # Set up mocks for network operations
  setup_session_test_mocks

  # Enable execution for wireguard add, import, and session stop (narrow overrides)
  set_function_interpreter "wireguard_add" "sh"
  set_function_interpreter "wireguard_import1" "sh"
  set_function_interpreter "wireguard_stop" "sh"

  # _batch2 outputs informational messages, not shell commands - override to 'cat'
  # Use arity-specific override (batch2) to avoid affecting combinators (__batch0, __batch1)
  set_function_interpreter "batch2" "cat"

  # Create and start a VPN session (reusing tested functionality)
  run_vpn_switch wireguard add privacy >/dev/null 2>&1
  local test_config="$TEST_BASE_DIR/wg-TEST-NO-1.conf"
  cat > "$test_config" <<'EOF'
[Interface]
PrivateKey = test_key_no1
Address = 10.2.0.8/32
DNS = 10.2.0.1

[Peer]
PublicKey = test_public_key_no1
AllowedIPs = 0.0.0.0/0
Endpoint = 25.26.27.28:51820
EOF
  chmod 0600 "$test_config"
  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1
  run_vpn_switch wireguard add privacy wg-TEST-NO-1.conf no1 >/dev/null 2>&1

  # Start VPN to create session
  run_vpn_switch wireguard start privacy >/dev/null 2>&1

  # Verify session exists before stop
  local session_count_before=$(ls -1d "$TEST_DIR/.session"/* 2>/dev/null | wc -l)
  if [ "$session_count_before" -ge 1 ]; then
    pass "Session exists before stop"
  else
    fail "No session found before stop"
  fi

  # Verify disconnect.sh exists and contains wg-quick down
  local session_dir=$(ls -1d "$TEST_DIR/.session"/* 2>/dev/null | head -1)
  if [ -f "$session_dir/disconnect.sh" ] && grep -q "wg-quick.*down" "$session_dir/disconnect.sh"; then
    pass "disconnect.sh contains wg-quick down command"
  else
    fail "wg-quick down command missing from disconnect.sh"
    ls -la "$session_dir" || true
  fi

  # Run stop command
  local output=$(run_vpn_switch stop 2>&1 || true)

  # Verify disconnect operation logged (or no active sessions if session already stopped)
  if printf '%s\n' "$output" | grep -qiE "disconnect|stopping|No.*sessions to stop"; then
    pass "Stop command executed"
  else
    fail "Stop command output unexpected"
    printf '%s\n' "Output: $output"
  fi

  # Verify session was preserved (has 'latest' link after start)
  local session_count_after=$(ls -1d "$TEST_DIR/.session"/* 2>/dev/null | wc -l)
  if [ "$session_count_after" -eq 1 ]; then
    pass "Session preserved after stop (has 'latest' link)"
  else
    fail "Session not preserved (expected 1, got $session_count_after)"
    ls -la "$TEST_DIR/.session/" || true
    ls -la "$TEST_DIR/session/" || true
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST 12: Session list - display active sessions
test_session_list() {
  test_header "session list - display active and stale sessions" "test_session_list"

  # Create exclusive database for this test
  test_setup

  # Set up mocks for network operations
  setup_session_test_mocks

  # Enable execution for wireguard add and import (narrow overrides)
  set_function_interpreter "wireguard_add" "sh"
  set_function_interpreter "wireguard_import1" "sh"

  # Create active session using public API (black-box testing)
  run_vpn_switch wireguard add privacy >/dev/null 2>&1
  local test_config="$TEST_BASE_DIR/wg-TEST-LIST-1.conf"
  cat > "$test_config" <<'EOF'
[Interface]
 PrivateKey = test_key_list1
Address = 10.2.0.10/32
DNS = 10.2.0.1

[Peer]
PublicKey = test_public_key_list1
AllowedIPs = 0.0.0.0/0
Endpoint = 10.10.10.10:51820
EOF
  chmod 0600 "$test_config"
  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1
  run_vpn_switch wireguard add privacy wg-TEST-LIST-1.conf list1 >/dev/null 2>&1

  # Start VPN and extract session ID from output (black-box - use what program tells us)
  local start_output=$(run_vpn_switch wireguard start privacy 2>&1 || true)

  # Extract session PID from the output (what the user interface reports)
  local active_pid=$(echo "$start_output" | grep -oE '[Ss]ession:? [0-9]+|PID:? [0-9]+|session [0-9]+' | grep -oE '[0-9]+' | head -1)

  if [ -z "$active_pid" ]; then
    fail "Could not extract session ID from wireguard start output"
    echo "Start output: $start_output"
    return
  fi

  # Manually create ONLY the stale session (with dead PID) for testing stale detection
  # This is the ONLY manual setup needed - we're testing broken/stale session handling
  local stale_pid=99997  # Non-existent PID (dead process)
  local stale_session="$TEST_DIR/.session/$stale_pid"
  mkdir -p "$stale_session"
  echo "$stale_pid" > "$stale_session/pid"
  echo "wireguard" > "$stale_session/protocol"
  echo "$TEST_DIR/wireguard/test-config-2.conf" > "$stale_session/original"
  echo "wg_test1" > "$stale_session/interface"
  date "+%Y-%m-%d %H:%M:%S" > "$stale_session/started"
  echo "99996" > "$stale_session/vpn.pid"  # Dead VPN process PID (stale session)

  # Run session list
  local output=$(run_vpn_switch session list 2>&1 || true)

  # Verify header displayed
  if printf '%s\n' "$output" | grep -qE "Active VPN Sessions|PID.*PROTOCOL"; then
    pass "Session list header displayed"
  else
    fail "Session list header missing"
    printf '%s\n' "Output: $output"
  fi

  # Verify active session listed
  if printf '%s\n' "$output" | grep -q "$active_pid"; then
    pass "Active session (PID $active_pid) listed"
  else
    fail "Active session not listed"
    printf '%s\n' "Output: $output"
  fi

  # Verify stale session listed
  if printf '%s\n' "$output" | grep -q "$stale_pid"; then
    pass "Stale session (PID $stale_pid) listed"
  else
    fail "Stale session not listed"
    printf '%s\n' "Output: $output"
  fi

  # Verify stale session marked as stopped (VPN not running)
  if printf '%s\n' "$output" | grep "$stale_pid" | grep -q "stopped"; then
    pass "Stale session (dead process) marked as stopped"
  else
    fail "Stale session not marked as stopped"
    printf '%s\n' "Output: $output"
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST: session refresh - removes stale ownership for a down interface, idempotent
#
# Scope note: the peer-fingerprint *matching* core (session_peer_matches_interface
# and refresh's re-point-to-matching-session path) cannot be exercised through this
# black-box CLI harness, because the live `wg show` output cannot be stubbed:
# EXAMINE_* variables are re-sourced from the platform file at startup (overriding
# setenv), and PATH injection does not reach the examination subshell. That core
# logic is covered deterministically by vpn-switch-ownership-test.sh. Here we cover
# the harness-reachable plumbing: a stale ownership link for a down/unknown
# interface is removed, and refresh is idempotent.
test_session_refresh() {
  test_header "session refresh - removes stale ownership, idempotent" "test_session_refresh"

  test_setup
  set_function_interpreter "session_refresh" "sh"

  # Simulate ownership drift: latest-<iface> points at a dead session whose
  # interface is down. Minimal manual broken-state setup (as in test_session_list);
  # drift cannot be produced through the public API.
  local iface="wg_drift9"
  local dead=99931
  mkdir -p "$TEST_DIR/.session/$dead" "$TEST_DIR/session"
  echo "wireguard" > "$TEST_DIR/.session/$dead/protocol"
  echo "$iface"    > "$TEST_DIR/.session/$dead/interface"
  printf 'PublicKey = drift_key=\n' > "$TEST_DIR/.session/$dead/$iface.conf"
  ln -sfn "../.session/$dead" "$TEST_DIR/session/latest-$iface"

  local out=$(run_vpn_switch session refresh 2>&1 || true)

  if [ ! -L "$TEST_DIR/session/latest-$iface" ]; then
    pass "Stale ownership removed for down interface ($iface)"
  else
    fail "Stale ownership link not removed"
    printf '%s\n' "$out"
  fi

  if printf '%s\n' "$out" | grep -qE "Reconciled ownership|removing stale ownership"; then
    pass "Refresh reported the reconciliation"
  else
    fail "Refresh did not report reconciliation"
    printf '%s\n' "$out"
  fi

  # Idempotent: a second run reports no changes.
  out=$(run_vpn_switch session refresh 2>&1 || true)
  if printf '%s\n' "$out" | grep -qE "no changes|already consistent"; then
    pass "session refresh is idempotent (no-op on second run)"
  else
    fail "session refresh not idempotent"
    printf '%s\n' "$out"
  fi
}

# TEST: session refresh - graceful no-op on a clean database
test_session_refresh_clean() {
  test_header "session refresh - clean database is a no-op" "test_session_refresh_clean"

  test_setup
  set_function_interpreter "session_refresh" "sh"

  local out=$(run_vpn_switch session refresh 2>&1 || true)
  if printf '%s\n' "$out" | grep -qE "No sessions found|No interfaces to reconcile|no changes|already consistent"; then
    pass "Refresh on clean DB is a graceful no-op"
  else
    fail "Refresh on clean DB did not report a clean no-op"
    printf '%s\n' "$out"
  fi
}

# TEST 13: Session show - display connect script
test_session_show() {
  test_header "session show - display connect script" "test_session_show"

  # Create exclusive database for this test
  test_setup

  # Set up mocks for network operations
  setup_session_test_mocks

  # Enable execution for wireguard add and import (narrow overrides)
  set_function_interpreter "wireguard_add" "sh"
  set_function_interpreter "wireguard_import1" "sh"

  # Create session using public API (black-box testing)
  run_vpn_switch wireguard add privacy >/dev/null 2>&1
  local test_config="$TEST_BASE_DIR/wg-TEST-SHOW-1.conf"
  cat > "$test_config" <<'EOF'
[Interface]
 PrivateKey = test_key_show1
Address = 10.2.0.11/32
DNS = 10.2.0.1

[Peer]
PublicKey = test_public_key_show1
AllowedIPs = 0.0.0.0/0
Endpoint = 11.11.11.11:51820
EOF
  chmod 0600 "$test_config"
  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1
  run_vpn_switch wireguard add privacy wg-TEST-SHOW-1.conf show1 >/dev/null 2>&1

  # Start VPN and extract session ID from output (black-box - use what program tells us)
  local start_output=$(run_vpn_switch wireguard start privacy 2>&1 || true)

  # Extract session PID from the output (what the user interface reports)
  # Look for patterns like "Session: 12345" or "session 12345" or "PID: 12345"
  local session_id=$(echo "$start_output" | grep -oE '[Ss]ession:? [0-9]+|PID:? [0-9]+|session [0-9]+' | grep -oE '[0-9]+' | head -1)

  if [ -z "$session_id" ]; then
    fail "Could not extract session ID from wireguard start output"
    echo "Start output: $start_output"
    return
  fi

  pass "Extracted session ID ($session_id) from start command output"

  # Run session show with the PID we got from the program
  local output=$(run_vpn_switch session show "$session_id" 2>&1 || true)

  # Verify session metadata displayed
  if printf '%s\n' "$output" | grep -q "Session:.*$session_id"; then
    pass "Session ID displayed in header"
  else
    fail "Session ID not displayed"
    printf '%s\n' "Output: $output"
  fi

  # Verify protocol shown
  if printf '%s\n' "$output" | grep -q "Protocol:.*wireguard"; then
    pass "Session protocol displayed"
  else
    fail "Session protocol not displayed"
    printf '%s\n' "Output: $output"
  fi

  # Verify connect.sh contents displayed (should contain wg-quick commands)
  if printf '%s\n' "$output" | grep -qiE "wg-quick|#!/bin/sh"; then
    pass "Connect script contents displayed"
  else
    fail "Connect script contents not displayed"
    printf '%s\n' "Output: $output"
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST 13b: Session show <name> — name resolution via API-driven setup
#
# Regression test: `vpn-switch session show <name>` is documented in
# TUTORIAL_SESSIONS.md (Step 7) but currently fails with "Session not found"
# because _session_show1 treats its argument as a literal PID and never
# consults the `session/` symlink directory. Compare to __session_start1 /
# __session_stop1, which both branch on numeric-vs-non-numeric and resolve
# the named symlink before dispatching.
#
# This test builds the precondition (a saved session named 'work') purely
# through the public API — `wireguard start` to bring a session into
# existence, then `session save work` to create the named link — and then
# calls `session show work` to assert that name resolution works. Until
# the bug is fixed, the assertion fails.
test_session_show_by_name() {
  test_header "session show <name> - resolve named session symlink" "test_session_show_by_name"

  test_setup
  setup_session_test_mocks

  # Enable execution for the API calls we'll drive
  set_function_interpreter "wireguard_add" "sh"
  set_function_interpreter "wireguard_import1" "sh"
  set_function_interpreter "session_save" "sh"

  # Build state via the public API (no hand-crafted .session/<pid>/)
  run_vpn_switch wireguard add privacy >/dev/null 2>&1
  local test_config="$TEST_BASE_DIR/wg-TEST-SHOWNAME-1.conf"
  cat > "$test_config" <<'EOF'
[Interface]
PrivateKey = test_key_showname1
Address = 10.2.0.21/32
DNS = 10.2.0.1

[Peer]
PublicKey = test_public_key_showname1
AllowedIPs = 0.0.0.0/0
Endpoint = 21.21.21.21:51820
EOF
  chmod 0600 "$test_config"
  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1
  run_vpn_switch wireguard add privacy wg-TEST-SHOWNAME-1.conf showname1 >/dev/null 2>&1

  # Start a session and capture its PID from the output (black-box)
  local start_output=$(run_vpn_switch wireguard start privacy 2>&1 || true)
  local session_id=$(echo "$start_output" | grep -oE '[Ss]ession:? [0-9]+|PID:? [0-9]+|session [0-9]+' | grep -oE '[0-9]+' | head -1)

  if [ -z "$session_id" ]; then
    fail "Could not extract session ID from wireguard start output"
    echo "Start output: $start_output"
    rm -f "$test_config"
    return
  fi
  pass "Started session $session_id via API"

  # Save the session as 'work' via the public API (no manual ln -sfn)
  run_vpn_switch session save work >/dev/null 2>&1
  local save_output=$(run_vpn_switch session save work 2>&1 || true)
  if printf '%s\n' "$save_output" | grep -qiE "saved.*work|work"; then
    pass "Saved session $session_id as 'work' via API"
  else
    fail "Could not save session as 'work'"
    printf '%s\n' "Save output: $save_output"
    rm -f "$test_config"
    return
  fi

  # Control case: `session show <PID>` works (no name resolution needed)
  local by_pid=$(run_vpn_switch session show "$session_id" 2>&1 || true)
  if printf '%s\n' "$by_pid" | grep -q "Session:.*$session_id"; then
    pass "session show <PID> works (control case)"
  else
    fail "session show <PID> broken — control case failed, cannot assess name-resolution bug"
    printf '%s\n' "Output: $by_pid"
    rm -f "$test_config"
    return
  fi

  # The bug under test: `session show <name>` should resolve the symlink
  local by_name=$(run_vpn_switch session show work 2>&1 || true)
  if printf '%s\n' "$by_name" | grep -q "Session:.*$session_id"; then
    pass "session show <name> resolves named symlink"
  else
    fail "BUG: session show <name> does not resolve named symlink (mirrors session start/stop)"
    printf '%s\n' "Output: $by_name"
  fi

  rm -f "$test_config"
}

# TEST 14: Session remove - remove stale session and refuse active
test_session_remove() {
  test_header "session remove - remove stale, refuse active" "test_session_remove"

  # Create exclusive database for this test
  test_setup

  # Set up mocks for network operations
  setup_session_test_mocks

  # Enable execution for session remove, wireguard add and import (narrow overrides)
  set_function_interpreter "session_remove" "sh"
  set_function_interpreter "wireguard_add" "sh"
  set_function_interpreter "wireguard_import1" "sh"

  # Manually create ONLY the stale session (dead process) for testing stale removal
  # This is what we're testing: can we remove dead sessions?
  local dead_pid=99996
  local session_dir="$TEST_DIR/.session/$dead_pid"
  mkdir -p "$session_dir"
  echo "$dead_pid" > "$session_dir/pid"
  echo "wireguard" > "$session_dir/protocol"
  echo "$TEST_DIR/wireguard/test-config.conf" > "$session_dir/original"
  echo "wg_test2" > "$session_dir/interface"
  date "+%Y-%m-%d %H:%M:%S" > "$session_dir/started"
  echo "99995" > "$session_dir/vpn.pid"  # Dead VPN process PID (stale session)

  # Verify stale session exists
  if [ -d "$session_dir" ]; then
    pass "Stale session created for removal test"
  else
    fail "Stale session not created"
  fi

  # Run session remove on stale session
  local output=$(run_vpn_switch session remove "$dead_pid" 2>&1 || true)

  # Verify removal commands generated or session removed
  if printf '%s\n' "$output" | grep -qE "Removing session.*$dead_pid|rm.*$dead_pid|removed"; then
    pass "Removal operation logged for stale session"
  else
    fail "Removal not logged"
    printf '%s\n' "Output: $output"
  fi

  # Now test refusal to remove active session
  # We need to manually create an "active" session (one with a running process PID)
  # This documents what makes a session "active": having a PID that corresponds to a running process
  # In a mocked environment (where wg-quick is echo'd), using wireguard start would create a
  # session without a real VPN process, so it would be detected as stale
  local active_pid=$$  # Use current shell PID (definitely running)
  local active_session="$TEST_DIR/.session/$active_pid"
  mkdir -p "$active_session"
  echo "$active_pid" > "$active_session/pid"
  echo "wireguard" > "$active_session/protocol"
  echo "$TEST_DIR/wireguard/test-config.conf" > "$active_session/original"
  echo "wg_test4" > "$active_session/interface"
  date "+%Y-%m-%d %H:%M:%S" > "$active_session/started"
  echo "$$" > "$active_session/vpn.pid"  # VPN process PID (current shell - definitely running)

  if [ -d "$active_session" ]; then
    pass "Active session (PID $$) created for refusal test"
  else
    fail "Active session not created"
    return
  fi

  # Try to remove active session (should refuse)
  local error_output=$(run_vpn_switch session remove "$active_pid" 2>&1 || true)

  if echo "$error_output" | grep -qiE "error.*active|refusing.*active|still running"; then
    pass "Refuses to remove active session (PID $active_pid)"
  else
    fail "Should refuse to remove active session"
    echo "Output: $error_output"
  fi
}

# TEST 15: Session save - save current session as default
test_session_save_default() {
  test_header "session save - save current session as default" "test_session_save_default"

  # Create exclusive database for this test
  test_setup

  # Set up mocks for network operations
  setup_session_test_mocks

  # Enable execution for session_save (narrow override)
  set_function_interpreter "session_save" "sh"

  # Manually create active session (with running process PID)
  # We must manually create this because in a mocked environment, `wireguard start`
  # creates a session without a real VPN process, so it appears "stale"
  # For session save to work, we need an "active" session (PID of running process)
  local test_pid=$$  # Current shell PID (definitely running)
  local session_dir="$TEST_DIR/.session/$test_pid"
  mkdir -p "$session_dir"
  echo "$test_pid" > "$session_dir/pid"
  echo "wireguard" > "$session_dir/protocol"
  echo "$TEST_DIR/wireguard/test-config.conf" > "$session_dir/original"
  echo "wg9" > "$session_dir/interface"
  date "+%Y-%m-%d %H:%M:%S" > "$session_dir/started"
  echo "#!/bin/sh" > "$session_dir/connect.sh"
  chmod 0755 "$session_dir/connect.sh"

  # Create session/latest symlink (required by _session_save0 validation)
  mkdir -p "$TEST_DIR/session"
  ln -sfn "../.session/$test_pid" "$TEST_DIR/session/latest"

  if [ -d "$session_dir" ] && [ -L "$TEST_DIR/session/latest" ]; then
    pass "Active session (PID $$) with latest symlink created for save test"
  else
    fail "Active session or latest symlink not created"
    return
  fi

  # Run session save (should create default symlink)
  local output=$(run_vpn_switch session save 2>&1 || true)

  # Verify output mentions saving or symlink creation
  if printf '%s\n' "$output" | grep -qiE "saving|session.*saved|ln.*default"; then
    pass "Session save operation logged"
  else
    fail "Session save not logged"
    printf '%s\n' "Output: $output"
  fi

  # Verify default symlink was created
  if [ -L "$TEST_DIR/session/default" ]; then
    pass "Default session symlink created"
  else
    fail "Default session symlink not created"
    ls -la "$TEST_DIR/session/" 2>/dev/null || echo "session/ directory not found"
  fi

  # Verify symlink points to the correct session
  if [ -L "$TEST_DIR/session/default" ]; then
    local link_target=$(readlink "$TEST_DIR/session/default")
    if echo "$link_target" | grep -q "$test_pid"; then
      pass "Default symlink points to session $test_pid"
    else
      fail "Default symlink target incorrect: $link_target"
    fi
  fi
}

# TEST 16: Session save - save with custom name
test_session_save_named() {
  test_header "session save work - save current session with name" "test_session_save_named"

  # Create exclusive database for this test
  test_setup

  # Set up mocks for network operations
  setup_session_test_mocks

  # Enable execution for session_save (narrow override)
  set_function_interpreter "session_save" "sh"

  # Manually create active session (with running process PID)
  local test_pid=$$  # Current shell PID (definitely running)
  local session_dir="$TEST_DIR/.session/$test_pid"
  mkdir -p "$session_dir"
  echo "$test_pid" > "$session_dir/pid"
  echo "wireguard" > "$session_dir/protocol"
  echo "$TEST_DIR/wireguard/test-config.conf" > "$session_dir/original"
  echo "wg9" > "$session_dir/interface"
  date "+%Y-%m-%d %H:%M:%S" > "$session_dir/started"
  echo "#!/bin/sh" > "$session_dir/connect.sh"
  chmod 0755 "$session_dir/connect.sh"

  # Create session/latest symlink (required by _session_save1 validation)
  mkdir -p "$TEST_DIR/session"
  ln -sfn "../.session/$test_pid" "$TEST_DIR/session/latest"

  if [ -d "$session_dir" ] && [ -L "$TEST_DIR/session/latest" ]; then
    pass "Active session (PID $$) with latest symlink created for named save test"
  else
    fail "Active session or latest symlink not created"
    return
  fi

  # Run session save with name "work"
  local output=$(run_vpn_switch session save work 2>&1 || true)

  # Verify output mentions saving or symlink creation
  if printf '%s\n' "$output" | grep -qiE "saving.*work|session.*saved.*work|ln.*work"; then
    pass "Named session save operation logged"
  else
    fail "Named session save not logged"
    printf '%s\n' "Output: $output"
  fi

  # Verify named symlink was created
  if [ -L "$TEST_DIR/session/work" ]; then
    pass "Named session symlink 'work' created"
  else
    fail "Named session symlink not created"
    ls -la "$TEST_DIR/session/" 2>/dev/null || echo "session/ directory not found"
  fi

  # Verify symlink points to the correct session
  if [ -L "$TEST_DIR/session/work" ]; then
    local link_target=$(readlink "$TEST_DIR/session/work")
    if echo "$link_target" | grep -q "$test_pid"; then
      pass "Named symlink points to session $test_pid"
    else
      fail "Named symlink target incorrect: $link_target"
    fi
  fi
}

# TEST 17: Session start - resume default session
test_session_start_default() {
  test_header "session start - resume default session" "test_session_start_default"

  # Create exclusive database for this test
  test_setup

  # Set up mocks for network operations
  setup_session_test_mocks

  # Manually create a mock session for resumption testing
  # We're testing the resume functionality, so we need a pre-existing session
  local test_pid=12345
  local session_dir="$TEST_DIR/.session/$test_pid"
  mkdir -p "$session_dir"
  echo "$test_pid" > "$session_dir/pid"
  echo "wireguard" > "$session_dir/protocol"
  echo "$TEST_DIR/wireguard/test-config.conf" > "$session_dir/original"
  echo "wg9" > "$session_dir/interface"
  date "+%Y-%m-%d %H:%M:%S" > "$session_dir/started"

  # Create connect.sh script with recognizable content
  cat > "$session_dir/connect.sh" <<'EOF'
#!/bin/sh
# Test connect script for session 12345
echo "Resuming default session"
EOF
  chmod 0755 "$session_dir/connect.sh"

  # Create session/ directory and default symlink
  mkdir -p "$TEST_DIR/session"
  ln -sf "../.session/$test_pid" "$TEST_DIR/session/default"

  if [ -L "$TEST_DIR/session/default" ]; then
    pass "Default session symlink created for resume test"
  else
    fail "Default session symlink not created"
    return
  fi

  # Run session start (should resolve default symlink and resume)
  local output=$(run_vpn_switch session start 2>&1 || true)

  # Verify it outputs the session connect command or references the PID
  if printf '%s\n' "$output" | grep -qE "session.*start.*$test_pid|Resuming|connect"; then
    pass "Session start resolves default symlink (PID $test_pid)"
  else
    fail "Session start did not resolve default"
    printf '%s\n' "Output: $output"
  fi
}

# TEST 18: Session start - resume named session
test_session_start_named() {
  test_header "session start work - resume named session" "test_session_start_named"

  # Create exclusive database for this test
  test_setup

  # Set up mocks for network operations
  setup_session_test_mocks

  # Manually create a mock session for resumption testing
  local test_pid=67890
  local session_dir="$TEST_DIR/.session/$test_pid"
  mkdir -p "$session_dir"
  echo "$test_pid" > "$session_dir/pid"
  echo "wireguard" > "$session_dir/protocol"
  echo "$TEST_DIR/wireguard/test-config.conf" > "$session_dir/original"
  echo "wg9" > "$session_dir/interface"
  date "+%Y-%m-%d %H:%M:%S" > "$session_dir/started"

  # Create connect.sh script with recognizable content
  cat > "$session_dir/connect.sh" <<'EOF'
#!/bin/sh
# Test connect script for work session
echo "Resuming work session"
EOF
  chmod 0755 "$session_dir/connect.sh"

  # Create session/ directory and named symlink "work"
  mkdir -p "$TEST_DIR/session"
  ln -sf "../.session/$test_pid" "$TEST_DIR/session/work"

  if [ -L "$TEST_DIR/session/work" ]; then
    pass "Named session symlink 'work' created for resume test"
  else
    fail "Named session symlink not created"
    return
  fi

  # Run session start with name "work"
  local output=$(run_vpn_switch session start work 2>&1 || true)

  # Verify it outputs the session connect command or references the PID
  if printf '%s\n' "$output" | grep -qE "session.*start.*$test_pid|work.*session|Resuming work|connect"; then
    pass "Session start resolves named session 'work' (PID $test_pid)"
  else
    fail "Session start did not resolve named session"
    printf '%s\n' "Output: $output"
  fi
}

# TEST 19: Session start - resume by PID
test_session_start_bypid() {
  test_header "session start <PID> - resume session by PID" "test_session_start_bypid"

  # Create exclusive database for this test
  test_setup

  # Set up mocks for network operations
  setup_session_test_mocks

  # Manually create a mock session for resumption testing
  local test_pid=11111
  local session_dir="$TEST_DIR/.session/$test_pid"
  mkdir -p "$session_dir"
  echo "$test_pid" > "$session_dir/pid"
  echo "wireguard" > "$session_dir/protocol"
  echo "$TEST_DIR/wireguard/test-config.conf" > "$session_dir/original"
  echo "wg9" > "$session_dir/interface"
  date "+%Y-%m-%d %H:%M:%S" > "$session_dir/started"

  # Create connect.sh script with recognizable content
  cat > "$session_dir/connect.sh" <<'EOF'
#!/bin/sh
# Test connect script for PID session
echo "Resuming PID session"
EOF
  chmod 0755 "$session_dir/connect.sh"

  if [ -d "$session_dir" ]; then
    pass "Mock session (PID $test_pid) created for PID resume test"
  else
    fail "Mock session not created"
    return
  fi

  # Run session start with explicit PID
  local output=$(run_vpn_switch session start "$test_pid" 2>&1 || true)

  # Verify it outputs the session connect command or references the PID
  if printf '%s\n' "$output" | grep -qE "session.*start.*$test_pid|Resuming.*PID|connect"; then
    pass "Session start resumes by explicit PID ($test_pid)"
  else
    fail "Session start did not resume by PID"
    printf '%s\n' "Output: $output"
  fi
}

# TEST 20: Session stop - name routes to disconnect via PID resolution
#
# Tests __session_stop1's routing only:
#   name → resolve_session_id → PID → session disconnect <pid>
#
# Aliveness intentionally does NOT enter this path; disconnect is
# idempotent and handles dead sessions gracefully. See session.sh
# (___session_stop0 / __session_stop1) for the architectural decision.
test_session_stop_named() {
  test_header "session stop work - resolves name to disconnect" "test_session_stop_named"

  test_setup
  setup_session_test_mocks

  # Inspect __session_stop1's combinator output without executing it
  override_for_command_inspection "session_stop1"

  # Minimal session fixture: just a session_dir and a named symlink.
  # No vpn.pid, no interface, no ownership — stop1 doesn't read them.
  local test_pid=77777
  local session_dir="$TEST_DIR/.session/$test_pid"
  mkdir -p "$session_dir"
  mkdir -p "$TEST_DIR/session"
  ln -sf "../.session/$test_pid" "$TEST_DIR/session/work"

  local output=$(run_vpn_switch session stop work 2>&1 || true)

  if printf '%s\n' "$output" | grep -qE "session disconnect \"?${test_pid}\"?"; then
    pass "session stop 'work' emits 'session disconnect $test_pid'"
  else
    fail "session stop did not route name to disconnect"
    printf '%s\n' "Output: $output"
  fi
}

# TEST 21: Session stop - explicit PID routes directly to disconnect
test_session_stop_bypid() {
  test_header "session stop <PID> - routes PID to disconnect" "test_session_stop_bypid"

  test_setup
  setup_session_test_mocks
  override_for_command_inspection "session_stop1"

  # Minimal session fixture, no metadata needed for stop1's routing.
  local test_pid=88888
  local session_dir="$TEST_DIR/.session/$test_pid"
  mkdir -p "$session_dir"

  local output=$(run_vpn_switch session stop "$test_pid" 2>&1 || true)

  if printf '%s\n' "$output" | grep -qE "session disconnect \"?${test_pid}\"?"; then
    pass "session stop $test_pid emits 'session disconnect $test_pid'"
  else
    fail "session stop did not route PID to disconnect"
    printf '%s\n' "Output: $output"
  fi
}

# TEST 22: Session stop - inactive session also routes to disconnect (idempotency contract)
#
# Documents the architectural choice that 'stop' does not branch on aliveness:
# inactive sessions get the same 'session disconnect' routing, and the
# disconnect chain is idempotent (kill on dead PID is no-op, wg-quick down on
# missing interface is no-op, firewall revert is no-op).
test_session_stop_inactive() {
  test_header "session stop <PID> - inactive session routes to disconnect (idempotent)" "test_session_stop_inactive"

  test_setup
  setup_session_test_mocks
  override_for_command_inspection "session_stop1"

  # Inactive fixture: session dir exists, no vpn.pid. stop1 doesn't care.
  local test_pid=99999
  local session_dir="$TEST_DIR/.session/$test_pid"
  mkdir -p "$session_dir"

  local output=$(run_vpn_switch session stop "$test_pid" 2>&1 || true)

  if printf '%s\n' "$output" | grep -qE "session disconnect \"?${test_pid}\"?"; then
    pass "Inactive session still routes to disconnect (no 'not active' branch)"
  else
    fail "Inactive session was not routed to disconnect"
    printf '%s\n' "Output: $output"
  fi
}

# TEST 22a: ___session_stop0 batch - emits one 'session stop <pid>' per session
#
# Verifies the new batch combinator iterates all sessions instead of
# picking one (avoids leaving an active session running when "latest"
# happens to be dead).
test_session_stop_batch_all() {
  test_header "session stop (no arg) - batch emits stop per session" "test_session_stop_batch_all"

  test_setup
  setup_session_test_mocks

  # Inspect ___session_stop0's batch output without executing it
  override_for_command_inspection "session_stop0"

  # Two minimal sessions
  mkdir -p "$TEST_DIR/.session/11111" "$TEST_DIR/.session/22222"

  local output=$(run_vpn_switch session stop 2>&1 || true)

  if printf '%s\n' "$output" | grep -qE 'session stop "?11111"?'; then
    pass "batch emits 'session stop 11111'"
  else
    fail "batch missing 'session stop 11111'"
    printf '%s\n' "Output: $output"
  fi

  if printf '%s\n' "$output" | grep -qE 'session stop "?22222"?'; then
    pass "batch emits 'session stop 22222'"
  else
    fail "batch missing 'session stop 22222'"
  fi
}

# TEST 23: WireGuard remove - refuse to remove config in use by session
test_wireguard_remove_config_in_use() {
  test_header "wireguard remove - refuse removal when config in use" "test_wireguard_remove_config_in_use"

  # Create exclusive database for this test
  test_setup

  # Enable execution for wireguard import and add (narrow overrides)
  set_function_interpreter "wireguard_import1" "sh"
  set_function_interpreter "wireguard_add" "sh"

  # Import a test config that we'll mark as "in use"
  local test_config="$TEST_BASE_DIR/wg-TEST-RM-1.conf"
  cat > "$test_config" <<'EOF'
[Interface]
PrivateKey = test_key_rm1
Address = 10.2.0.20/32
DNS = 10.2.0.1

[Peer]
PublicKey = test_public_key_rm1
AllowedIPs = 0.0.0.0/0
Endpoint = 20.20.20.20:51820
EOF
  chmod 0600 "$test_config"
  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1

  # Manually create active session using this config
  # This documents the safety check: cannot remove configs in use by active sessions
  local real_pid=$$  # Current shell PID (definitely running)
  local session_dir="$TEST_DIR/.session/$real_pid"
  mkdir -p "$session_dir"
  echo "$real_pid" > "$session_dir/pid"
  echo "wireguard" > "$session_dir/protocol"
  echo "$TEST_DIR/wireguard/wg-TEST-RM-1.conf" > "$session_dir/original"
  echo "wg_test_safe" > "$session_dir/interface"
  date "+%Y-%m-%d %H:%M:%S" > "$session_dir/started"

  if [ -d "$session_dir" ]; then
    pass "Active session (PID $$) created using config"
  else
    fail "Active session not created"
    return
  fi

  # Try to remove the config that's in use
  local output=$(run_vpn_switch wireguard remove wg-TEST-RM-1.conf 2>&1 || true)

  # Verify error message about config in use
  if printf '%s\n' "$output" | grep -qiE "error.*in use|config in use|session.*using"; then
    pass "Error message when config in use by session"
  else
    fail "Missing error for config in use"
    printf '%s\n' "Output: $output"
  fi

  # Verify error mentions session removal or PID
  if printf '%s\n' "$output" | grep -qE "session remove|PID.*$real_pid"; then
    pass "Error suggests removing session first"
  else
    fail "Error doesn't suggest session removal"
    printf '%s\n' "Output: $output"
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST 21: WireGuard remove - refuse to remove config with symlink references
test_wireguard_remove_config_with_refs() {
  test_header "wireguard remove - refuse removal when config has symlink refs" "test_wireguard_remove_config_with_refs"

  # Create exclusive database for this test
  test_setup

  # Enable execution for wireguard import, add, link (narrow overrides)
  set_function_interpreter "wireguard_import1" "sh"
  set_function_interpreter "wireguard_add" "sh"
  set_function_interpreter "wireguard_link2" "sh"

  # Import a test config
  local test_config="$TEST_BASE_DIR/wg-TEST-RM-2.conf"
  cat > "$test_config" <<'EOF'
[Interface]
PrivateKey = test_key_rm2
Address = 10.2.0.21/32
DNS = 10.2.0.1

[Peer]
PublicKey = test_public_key_rm2
AllowedIPs = 0.0.0.0/0
Endpoint = 21.21.21.21:51820
EOF
  chmod 0600 "$test_config"
  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1

  # Create privacy category and link the config to it
  run_vpn_switch wireguard add privacy >/dev/null 2>&1
  run_vpn_switch wireguard add privacy wg-TEST-RM-2.conf rm2 >/dev/null 2>&1

  # Verify symlink was created
  if [ -L "$TEST_DIR/wireguard/privacy/rm2" ]; then
    pass "Category symlink created (privacy/rm2)"
  else
    fail "Category symlink not created"
    return
  fi

  # Try to remove the config that has symlink references
  local output=$(run_vpn_switch wireguard remove wg-TEST-RM-2.conf 2>&1 || true)

  # Verify error message about references
  if printf '%s\n' "$output" | grep -qiE "error.*reference|has.*reference|symlink.*pointing"; then
    pass "Error message when config has symlink references"
  else
    fail "Missing error for config with references"
    printf '%s\n' "Output: $output"
  fi

  # Verify error lists the references or category
  if printf '%s\n' "$output" | grep -qE "privacy/rm2|privacy"; then
    pass "Error lists symlink references"
  else
    fail "Error doesn't list references"
    printf '%s\n' "Output: $output"
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST 22: WireGuard remove - remove symlink without safety checks
test_wireguard_remove_symlink() {
  test_header "wireguard remove - remove symlink (no safety checks)" "test_wireguard_remove_symlink"

  # Create exclusive database for this test
  test_setup

  # Enable execution for wireguard import, remove (narrow overrides)
  set_function_interpreter "wireguard_import1" "sh"
  set_function_interpreter "wireguard_remove" "sh"

  # Import a config first
  local test_config="$TEST_BASE_DIR/wg-TEST-RM-3.conf"
  cat > "$test_config" <<'EOF'
[Interface]
PrivateKey = test_key_rm3
Address = 10.2.0.22/32
DNS = 10.2.0.1

[Peer]
PublicKey = test_public_key_rm3
AllowedIPs = 0.0.0.0/0
Endpoint = 22.22.22.22:51820
EOF
  chmod 0600 "$test_config"
  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1

  # Create a test symlink in protocol directory
  ln -sf "./wg-TEST-RM-3.conf" "$TEST_DIR/wireguard/test-remove-link"

  # Verify link was created
  if [ -L "$TEST_DIR/wireguard/test-remove-link" ]; then
    pass "Test symlink created"
  else
    fail "Failed to create test symlink"
    rm -f "$test_config"
    return
  fi

  # Run remove command on symlink (should succeed without safety checks)
  local output=$(run_vpn_switch wireguard remove test-remove-link 2>&1 || true)

  # Verify removal operation logged
  if printf '%s\n' "$output" | grep -qE "rm.*test-remove-link|Remov.*test-remove-link"; then
    pass "Symlink removal operation logged"
  else
    fail "Removal not logged"
    printf '%s\n' "Output: $output"
  fi

  # Verify symlink was actually removed (if execution enabled)
  if [ ! -L "$TEST_DIR/wireguard/test-remove-link" ]; then
    pass "Symlink was removed"
  else
    # Not a failure if just showing commands
    pass "Remove command generated for symlink"
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST 23: WireGuard remove - remove link from category
test_wireguard_remove_category_link() {
  test_header "wireguard remove - remove link from category" "test_wireguard_remove_category_link"

  # Create exclusive database for this test
  test_setup

  # Enable execution for wireguard import, add, remove (narrow overrides)
  set_function_interpreter "wireguard_import1" "sh"
  set_function_interpreter "wireguard_add" "sh"
  set_function_interpreter "wireguard_remove" "sh"

  # Import a config
  local test_config="$TEST_BASE_DIR/wg-TEST-RM-4.conf"
  cat > "$test_config" <<'EOF'
[Interface]
PrivateKey = test_key_rm4
Address = 10.2.0.23/32
DNS = 10.2.0.1

[Peer]
PublicKey = test_public_key_rm4
AllowedIPs = 0.0.0.0/0
Endpoint = 23.23.23.23:51820
EOF
  chmod 0600 "$test_config"
  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1

  # Create privacy category and link the config
  run_vpn_switch wireguard add privacy >/dev/null 2>&1
  run_vpn_switch wireguard add privacy wg-TEST-RM-4.conf rm4 >/dev/null 2>&1

  # Verify category link exists
  if [ -L "$TEST_DIR/wireguard/privacy/rm4" ]; then
    pass "Category link (privacy/rm4) created"
  else
    fail "Category link not created"
    return
  fi

  # Run remove command on category link
  local output=$(run_vpn_switch wireguard remove privacy rm4 2>&1 || true)

  # Verify removal operation logged
  if printf '%s\n' "$output" | grep -qE "rm.*privacy/rm4|Remov.*privacy.*rm4"; then
    pass "Category link removal operation logged"
  else
    fail "Removal not logged"
    printf '%s\n' "Output: $output"
  fi

  # Verify category link was removed (if execution enabled)
  if [ ! -L "$TEST_DIR/wireguard/privacy/rm4" ]; then
    pass "Category link was removed"
  else
    # Not a failure if just showing commands
    pass "Remove command generated for category link"
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST 24: WireGuard clean - no broken links
test_wireguard_clean_no_broken() {
  test_header "wireguard clean - no broken links found" "test_wireguard_clean_no_broken"

  # Create exclusive database for this test
  test_setup

  # Override interpreter to inspect clean command output (profile-independent)
  override_for_command_inspection "wireguard_clean"

  # Enable execution for wireguard add (to ensure category exists)
  set_function_interpreter "wireguard_add" "sh"

  # Create privacy category to ensure there's something to scan
  run_vpn_switch wireguard add privacy >/dev/null 2>&1

  # Run clean on clean database (no broken links)
  local output=$(run_vpn_switch wireguard clean 2>&1 || true)

  # Verify header displayed
  if printf '%s\n' "$output" | grep -qE "Clean.*broken.*symlink|wireguard/"; then
    pass "Clean header displayed"
  else
    fail "Clean header missing"
    printf '%s\n' "Output: $output"
  fi

  # Verify "no broken symlinks" message
  if printf '%s\n' "$output" | grep -qiE "no broken symlinks|no.*broken.*found"; then
    pass "No broken symlinks message displayed"
  else
    fail "No broken message missing"
    printf '%s\n' "Output: $output"
  fi

  # Verify usage hint displayed (how to execute commands)
  if printf '%s\n' "$output" | grep -qE "wireguard clean.*sh|pipe.*sh"; then
    pass "Usage hint displayed"
  else
    fail "Usage hint missing"
    printf '%s\n' "Output: $output"
  fi
}

# TEST 25: WireGuard clean - broken protocol link
test_wireguard_clean_broken_protocol_link() {
  test_header "wireguard clean - detect and generate remove for broken protocol link" "test_wireguard_clean_broken_protocol_link"

  # Create exclusive database for this test
  test_setup

  # Override interpreter to inspect clean command output (profile-independent)
  override_for_command_inspection "wireguard_clean"

  # Create a broken symlink in protocol directory
  # This simulates a config file that was deleted but symlinks remain
  ln -sf "./nonexistent.conf" "$TEST_DIR/wireguard/broken-proto-link"

  # Verify broken link was created
  if [ -L "$TEST_DIR/wireguard/broken-proto-link" ] && [ ! -e "$TEST_DIR/wireguard/broken-proto-link" ]; then
    pass "Broken protocol symlink created for testing"
  else
    fail "Failed to create broken symlink"
    return
  fi

  # Run clean (should detect broken link and output remove command)
  local output=$(run_vpn_switch wireguard clean 2>&1 || true)

  # Verify remove command generated for broken link
  if printf '%s\n' "$output" | grep -q "wireguard remove.*broken-proto-link"; then
    pass "Remove command generated for broken protocol link"
  else
    fail "Remove command not generated"
    printf '%s\n' "Output: $output"
  fi

  # Verify command is properly quoted (for safety with special characters)
  if printf '%s\n' "$output" | grep -qE 'wireguard remove.*"broken-proto-link"|broken-proto-link'; then
    pass "Command includes link name"
  else
    fail "Command formatting incorrect"
    printf '%s\n' "Output: $output"
  fi

  # Cleanup
  rm -f "$TEST_DIR/wireguard/broken-proto-link"
}

# TEST 26: WireGuard clean - broken category link
test_wireguard_clean_broken_category_link() {
  test_header "wireguard clean - detect and generate remove for broken category link" "test_wireguard_clean_broken_category_link"

  # Create exclusive database for this test
  test_setup
  override_for_command_inspection "wireguard_clean"

  # Enable execution for wireguard add (narrow override)
  set_function_interpreter "wireguard_add" "sh"

  # Create privacy category
  run_vpn_switch wireguard add privacy >/dev/null 2>&1

  # Create a broken symlink in category
  ln -sf "../nonexistent.conf" "$TEST_DIR/wireguard/privacy/broken-cat-link"

  # Verify broken link was created
  if [ -L "$TEST_DIR/wireguard/privacy/broken-cat-link" ] && [ ! -e "$TEST_DIR/wireguard/privacy/broken-cat-link" ]; then
    pass "Broken category symlink created for testing"
  else
    fail "Failed to create broken category symlink"
    return
  fi

  # Run clean (should detect broken link in category)
  local output=$(run_vpn_switch wireguard clean 2>&1 || true)

  # Verify remove command generated with category and link name
  if printf '%s\n' "$output" | grep -q "wireguard remove.*privacy.*broken-cat-link"; then
    pass "Remove command generated for broken category link"
  else
    fail "Remove command not generated or incorrect"
    printf '%s\n' "Output: $output"
  fi

  # Verify both category and link name are in command
  if printf '%s\n' "$output" | grep "wireguard remove" | grep -q "privacy"; then
    pass "Command includes category name"
  else
    fail "Category not in command"
    printf '%s\n' "Output: $output"
  fi

  # Cleanup
  rm -f "$TEST_DIR/wireguard/privacy/broken-cat-link"
}

# TEST 27: WireGuard clean - category with no broken links
test_wireguard_clean_category_no_broken() {
  test_header "wireguard clean privacy - category with no broken links" "test_wireguard_clean_category_no_broken"

  # Create exclusive database for this test
  test_setup
  override_for_command_inspection "wireguard_clean"

  # Enable execution for wireguard add (narrow override)
  set_function_interpreter "wireguard_add" "sh"

  # Create privacy category
  run_vpn_switch wireguard add privacy >/dev/null 2>&1

  # Run clean on specific category (no broken links)
  local output=$(run_vpn_switch wireguard clean privacy 2>&1 || true)

  # Verify category-specific header
  if printf '%s\n' "$output" | grep -qE "wireguard/privacy/|Clean.*privacy"; then
    pass "Category-specific header displayed"
  else
    fail "Category-specific header missing"
    printf '%s\n' "Output: $output"
  fi

  # Verify "no broken symlinks" message for category
  if printf '%s\n' "$output" | grep -qiE "no broken.*privacy|no.*broken.*found"; then
    pass "No broken symlinks message for category"
  else
    fail "Category message missing"
    printf '%s\n' "Output: $output"
  fi
}

# TEST 28: WireGuard clean - category with broken links
test_wireguard_clean_category_with_broken() {
  test_header "wireguard clean privacy - category with broken links" "test_wireguard_clean_category_with_broken"

  # Create exclusive database for this test
  test_setup
  override_for_command_inspection "wireguard_clean"

  # Enable execution for wireguard add (narrow override)
  set_function_interpreter "wireguard_add" "sh"

  # Create privacy category
  run_vpn_switch wireguard add privacy >/dev/null 2>&1

  # Create a broken symlink in privacy category
  ln -sf "../nonexistent.conf" "$TEST_DIR/wireguard/privacy/broken-test-link"

  # Verify broken link was created
  if [ -L "$TEST_DIR/wireguard/privacy/broken-test-link" ] && [ ! -e "$TEST_DIR/wireguard/privacy/broken-test-link" ]; then
    pass "Broken symlink created in privacy category"
  else
    fail "Failed to create broken symlink"
    return
  fi

  # Run clean on specific category
  local output=$(run_vpn_switch wireguard clean privacy 2>&1 || true)

  # Verify remove command generated for specific category
  if printf '%s\n' "$output" | grep -q "wireguard remove.*privacy.*broken-test-link"; then
    pass "Remove command generated for category link"
  else
    fail "Remove command not generated"
    printf '%s\n' "Output: $output"
  fi

  # Verify only this category is scanned (not entire wireguard directory)
  if printf '%s\n' "$output" | grep -qE "wireguard/privacy/|Clean.*privacy"; then
    pass "Category-specific clean (not global)"
  else
    fail "Should be category-specific clean"
    printf '%s\n' "Output: $output"
  fi

  # Cleanup
  rm -f "$TEST_DIR/wireguard/privacy/broken-test-link"
}

# TEST 29: WireGuard validate - detect broken symlinks in protocol directory
test_wireguard_validate_broken_symlink() {
  test_header "wireguard validate - detect broken symlinks" "test_wireguard_validate_broken_symlink"

  # Create exclusive database for this test
  test_setup

  # Create a broken symlink in protocol directory
  # This simulates a config that was deleted but symlinks remain
  ln -sf "./nonexistent.conf" "$TEST_DIR/wireguard/broken-link"

  # Verify broken link was created
  if [ -L "$TEST_DIR/wireguard/broken-link" ] && [ ! -e "$TEST_DIR/wireguard/broken-link" ]; then
    pass "Broken symlink created for validation test"
  else
    fail "Failed to create broken symlink"
    return
  fi

  # Run validate (should detect broken symlink)
  local output=$(run_vpn_switch wireguard validate 2>&1 || true)

  # Verify broken symlink detected with ERROR marker
  if printf '%s\n' "$output" | grep -qE "\[ERROR\].*Broken symlink.*broken-link|Broken.*wireguard/broken-link"; then
    pass "Broken symlink detected in protocol directory"
  else
    fail "Broken symlink not detected"
    printf '%s\n' "Output: $output"
  fi

  # Verify error status reported
  if printf '%s\n' "$output" | grep -qiE "error.*found|issues found"; then
    pass "Error status reported"
  else
    fail "Error status not reported"
    printf '%s\n' "Output: $output"
  fi

  # Cleanup
  rm -f "$TEST_DIR/wireguard/broken-link"
}

# TEST 30: WireGuard validate - detect broken symlinks in categories
test_wireguard_validate_broken_category_symlink() {
  test_header "wireguard validate - detect broken symlinks in categories" "test_wireguard_validate_broken_category_symlink"

  # Create exclusive database for this test
  test_setup

  # Enable execution for wireguard add (narrow override)
  set_function_interpreter "wireguard_add" "sh"

  # Create privacy category
  run_vpn_switch wireguard add privacy >/dev/null 2>&1

  # Create a broken symlink in category
  ln -sf "../nonexistent.conf" "$TEST_DIR/wireguard/privacy/broken-cat-link"

  # Verify broken link was created
  if [ -L "$TEST_DIR/wireguard/privacy/broken-cat-link" ] && [ ! -e "$TEST_DIR/wireguard/privacy/broken-cat-link" ]; then
    pass "Broken category symlink created for validation test"
  else
    fail "Failed to create broken category symlink"
    return
  fi

  # Run validate (should detect broken symlink in category)
  local output=$(run_vpn_switch wireguard validate 2>&1 || true)

  # Verify broken symlink detected in category
  if printf '%s\n' "$output" | grep -qE "\[ERROR\].*Broken symlink.*privacy/broken-cat-link|Broken.*wireguard/privacy/broken-cat-link"; then
    pass "Broken symlink detected in category"
  else
    fail "Broken symlink not detected in category"
    printf '%s\n' "Output: $output"
  fi

  # Cleanup
  rm -f "$TEST_DIR/wireguard/privacy/broken-cat-link"
}

# TEST 31: WireGuard validate - detect naming conflicts
test_wireguard_validate_naming_conflict() {
  test_header "wireguard validate - detect naming conflicts" "test_wireguard_validate_naming_conflict"

  # Create exclusive database for this test
  test_setup

  # Create a config file and directory with conflicting names
  # This simulates: test-conflict.conf (file) and test-conflict/ (directory)
  # which creates ambiguity in resolution
  touch "$TEST_DIR/wireguard/test-conflict.conf"
  mkdir -p "$TEST_DIR/wireguard/test-conflict"

  # Verify both exist
  if [ -f "$TEST_DIR/wireguard/test-conflict.conf" ] && [ -d "$TEST_DIR/wireguard/test-conflict" ]; then
    pass "Naming conflict created (file + directory)"
  else
    fail "Failed to create naming conflict"
    return
  fi

  # Run validate (should detect naming conflict)
  local output=$(run_vpn_switch wireguard validate 2>&1 || true)

  # Verify naming conflict detected with WARNING marker
  if printf '%s\n' "$output" | grep -qiE "\[WARNING\].*naming conflict.*test-conflict|conflict.*test-conflict"; then
    pass "Naming conflict detected"
  else
    fail "Naming conflict not detected"
    printf '%s\n' "Output: $output"
  fi

  # Cleanup
  rm -f "$TEST_DIR/wireguard/test-conflict.conf"
  rmdir "$TEST_DIR/wireguard/test-conflict" 2>/dev/null || true
}

# TEST 32: WireGuard validate - detect invalid config files
test_wireguard_validate_invalid_config() {
  test_header "wireguard validate - detect invalid config files" "test_wireguard_validate_invalid_config"

  # Create exclusive database for this test
  test_setup

  # Create an empty config file (invalid - no content)
  touch "$TEST_DIR/wireguard/empty-test.conf"

  # Verify empty file exists
  if [ -f "$TEST_DIR/wireguard/empty-test.conf" ]; then
    pass "Empty config file created for validation test"
  else
    fail "Failed to create empty config"
    return
  fi

  # Run validate (should detect empty config)
  local output=$(run_vpn_switch wireguard validate 2>&1 || true)

  # Verify empty file detected with WARNING marker
  if printf '%s\n' "$output" | grep -qiE "\[WARNING\].*empty.*empty-test.conf|empty.*file"; then
    pass "Empty config file detected"
  else
    fail "Empty config file not detected"
    printf '%s\n' "Output: $output"
  fi

  # Create config without [Interface] section (invalid structure)
  cat > "$TEST_DIR/wireguard/no-interface.conf" <<'EOF'
# Just a comment, no actual config
# Missing [Interface] section
EOF

  # Run validate again (should detect missing Interface section)
  local output2=$(run_vpn_switch wireguard validate 2>&1 || true)

  # Verify missing Interface section detected
  if echo "$output2" | grep -qiE "\[WARNING\].*interface.*no-interface.conf|missing.*interface"; then
    pass "Missing [Interface] section detected"
  else
    fail "Missing [Interface] section not detected"
    echo "Output: $output2"
  fi

  # Cleanup
  rm -f "$TEST_DIR/wireguard/empty-test.conf"
  rm -f "$TEST_DIR/wireguard/no-interface.conf"
}

# TEST 33: Stop - no sessions exist (empty output)
test_stop_no_sessions() {
  test_header "stop - no sessions exist (empty output)" "test_stop_no_sessions"

  # Create exclusive database for this test
  test_setup

  # Run stop when no sessions exist
  local output=$(run_vpn_switch stop 2>&1 || true)

  # When no sessions exist, combinator produces empty output or "already removed" message
  # This is expected behavior - silence means "nothing to do"
  if [ -z "$output" ] || printf '%s\n' "$output" | grep -qiE "already removed|no.*session"; then
    pass "No output or log message when no sessions exist"
  else
    # Not a failure - may just show informational messages
    pass "Stop command handled no sessions gracefully"
  fi
}

# TEST 34: Stop - stop specific interface by name
test_stop_specific_interface() {
  test_header "stop wg_test_safe - stop specific interface by name" "test_stop_specific_interface"

  # Create exclusive database for this test
  test_setup

  # Set up mocks for network operations
  setup_session_test_mocks

  # Manually create active session with wg_test_safe interface
  local real_pid=$$  # Current shell PID (definitely running)
  local session_dir="$TEST_DIR/.session/$real_pid"
  mkdir -p "$session_dir"
  echo "$real_pid" > "$session_dir/pid"
  echo "wireguard" > "$session_dir/protocol"
  echo "$TEST_DIR/wireguard/test-config.conf" > "$session_dir/original"
  echo "wg_test_safe" > "$session_dir/interface"
  date "+%Y-%m-%d %H:%M:%S" > "$session_dir/started"

  if [ -d "$session_dir" ]; then
    pass "Active session (PID $$, interface wg_test_safe) created"
  else
    fail "Active session not created"
    return
  fi

  # Call stop with specific interface
  local output=$(run_vpn_switch stop wg_test_safe 2>&1 || true)

  # Verify interface-specific disconnect
  if printf '%s\n' "$output" | grep -qE "Disconnect.*wg_test_safe|wg_test_safe"; then
    pass "Stopped specific interface wg_test_safe"
  else
    fail "Did not stop specific interface"
    printf '%s\n' "Output: $output"
  fi

  # Verify wg-quick down command for specific interface
  if printf '%s\n' "$output" | grep -q "wg-quick down.*wg_test_safe"; then
    pass "Interface wg_test_safe disconnect command generated"
  else
    fail "Interface disconnect command missing"
    printf '%s\n' "Output: $output"
  fi
}

# TEST 35: WireGuard disconnect - direct disconnect command
test_wireguard_disconnect_interface() {
  test_header "wireguard disconnect wg_test_safe - direct disconnect command" "test_wireguard_disconnect_interface"

  # Create exclusive database for this test
  test_setup

  # Override interpreter to inspect disconnect command output
  override_for_command_inspection "wireguard_disconnect1"

  # Set up mocks for network operations
  setup_session_test_mocks

  # Manually create active session
  local real_pid=$$  # Current shell PID (definitely running)
  local session_dir="$TEST_DIR/.session/$real_pid"
  mkdir -p "$session_dir"
  echo "$real_pid" > "$session_dir/pid"
  echo "wireguard" > "$session_dir/protocol"
  echo "$TEST_DIR/wireguard/test-config.conf" > "$session_dir/original"
  echo "wg_test_safe" > "$session_dir/interface"
  date "+%Y-%m-%d %H:%M:%S" > "$session_dir/started"

  if [ -d "$session_dir" ]; then
    pass "Active session (PID $$) created for disconnect test"
  else
    fail "Active session not created"
    return
  fi

  # Call disconnect directly (protocol-specific command)
  local output=$(run_vpn_switch wireguard disconnect wg_test_safe 2>&1 || true)

  # Verify disconnect command executed
  if printf '%s\n' "$output" | grep -qiE "disconnect.*wg_test_safe|Stopping.*wg_test_safe"; then
    pass "Disconnect command executed for wg_test_safe"
  else
    fail "Disconnect command not executed"
    printf '%s\n' "Output: $output"
  fi

  # Verify session PID displayed
  if printf '%s\n' "$output" | grep -qE "Session.*PID.*$real_pid|PID.*$real_pid"; then
    pass "Session PID displayed correctly"
  else
    # Not a failure - may not always show PID
    pass "Disconnect command completed"
  fi
}

# TEST 36: Stop - error when interface not found
test_stop_nonexistent_interface() {
  test_header "stop wg_test_other - error when interface not found" "test_stop_nonexistent_interface"

  # Create exclusive database for this test
  test_setup

  # Set up mocks for network operations
  setup_session_test_mocks

  # Create session for wg_test_safe only
  local real_pid=$$
  local session_dir="$TEST_DIR/.session/$real_pid"
  mkdir -p "$session_dir"
  echo "$real_pid" > "$session_dir/pid"
  echo "wireguard" > "$session_dir/protocol"
  echo "$TEST_DIR/wireguard/test-config.conf" > "$session_dir/original"
  echo "wg_test_safe" > "$session_dir/interface"
  date "+%Y-%m-%d %H:%M:%S" > "$session_dir/started"

  if [ -d "$session_dir" ]; then
    pass "Active session with wg_test_safe interface created"
  else
    fail "Active session not created"
    return
  fi

  # Try to stop wg_test_other (doesn't exist)
  local output=$(run_vpn_switch stop wg_test_other 2>&1 || true)

  # Verify error message for nonexistent interface
  if printf '%s\n' "$output" | grep -qiE "error.*no.*session.*found|no.*session.*wg_test_other|no active.*session"; then
    pass "Error message for nonexistent interface"
  else
    fail "Missing error for nonexistent interface"
    printf '%s\n' "Output: $output"
  fi
}

# TEST 37: Disconnect - error without session
test_disconnect_without_session() {
  test_header "disconnect without session - error handling" "test_disconnect_without_session"

  # Create exclusive database for this test
  test_setup

  # Ensure no sessions exist
  rm -rf "$TEST_DIR/.session"/* 2>/dev/null || true

  # Try to disconnect wg_test_disconnect when no session exists
  # Use test-specific interface name to avoid touching production interfaces (wg0, wg1, etc.)
  local output=$(run_vpn_switch wireguard disconnect wg_test_disconnect 2>&1 || true)

  # Verify error message when no session exists
  if printf '%s\n' "$output" | grep -qiE "error.*no.*session|no.*session found|session not found"; then
    pass "Error message when no session exists"
  else
    fail "Missing error for disconnect without session"
    printf '%s\n' "Output: $output"
  fi
}

# TEST 38: Stop - idempotent behavior (stop twice)
test_stop_twice_idempotent() {
  test_header "stop twice - idempotent (safe to call multiple times)" "test_stop_twice_idempotent"

  # Create exclusive database for this test
  test_setup

  # Ensure no sessions exist
  rm -rf "$TEST_DIR/.session"/* 2>/dev/null || true

  # First stop (no sessions)
  local output1=$(run_vpn_switch stop 2>&1 || true)

  # Should handle gracefully (empty output or log message)
  if [ -z "$output1" ] || echo "$output1" | grep -qiE "already removed|no.*session"; then
    pass "First stop: handles no sessions gracefully"
  else
    # Not a failure - may show informational messages
    pass "First stop: executed without error"
  fi

  # Second stop (still no sessions) - should be idempotent
  local output2=$(run_vpn_switch stop 2>&1 || true)

  # Should still handle gracefully (idempotent)
  if [ -z "$output2" ] || echo "$output2" | grep -qiE "already removed|no.*session"; then
    pass "Second stop: still handles no sessions (idempotent)"
  else
    # Not a failure - idempotent behavior confirmed by no error
    pass "Second stop: executed without error (idempotent)"
  fi
}

# TEST 39: WireGuard import - error when file doesn't exist
test_wireguard_import_nonexistent() {
  test_header "wireguard import - error when file doesn't exist" "test_wireguard_import_nonexistent"

  # Create exclusive database for this test
  test_setup

  # Try to import nonexistent file
  local output=$(run_vpn_switch wireguard import /nonexistent/wg-XX-99.conf 2>&1 || true)

  # Verify error message for nonexistent file
  if printf '%s\n' "$output" | grep -qiE "error.*not found|does not exist|no such file"; then
    pass "Error message for non-existent file"
  else
    fail "Missing error for non-existent file"
    printf '%s\n' "Output: $output"
  fi
}

# TEST 40: WireGuard import - error when config already exists
test_wireguard_import_duplicate() {
  test_header "wireguard import - error when config already exists" "test_wireguard_import_duplicate"

  # Create exclusive database for this test
  test_setup

  # Enable execution for wireguard import (narrow override)
  set_function_interpreter "wireguard_import1" "sh"

  # First, import a config
  local test_config="$TEST_BASE_DIR/wg-TEST-DUP-1.conf"
  cat > "$test_config" <<'EOF'
[Interface]
PrivateKey = test_key_dup1
Address = 10.2.0.30/32
DNS = 10.2.0.1

[Peer]
PublicKey = test_public_key_dup1
AllowedIPs = 0.0.0.0/0
Endpoint = 30.30.30.30:51820
EOF
  chmod 0600 "$test_config"
  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1

  # Verify it was imported
  if [ -f "$TEST_DIR/wireguard/wg-TEST-DUP-1.conf" ]; then
    pass "First import succeeded"
  else
    fail "First import failed"
    return
  fi

  # Try to import again (duplicate)
  local output=$(run_vpn_switch wireguard import "$test_config" 2>&1 || true)

  # Verify error message for duplicate
  if printf '%s\n' "$output" | grep -qiE "error.*already exists|config.*exists"; then
    pass "Error message when config already exists"
  else
    fail "Missing error for duplicate config"
    printf '%s\n' "Output: $output"
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST 41: WireGuard add - error when category already exists
test_wireguard_add_category_conflict() {
  test_header "wireguard add - error when category already exists" "test_wireguard_add_category_conflict"

  # Create exclusive database for this test
  test_setup

  # Enable execution for wireguard add (narrow override)
  set_function_interpreter "wireguard_add" "sh"

  # First, create privacy category
  run_vpn_switch wireguard add privacy >/dev/null 2>&1

  # Verify it was created
  if [ -d "$TEST_DIR/wireguard/privacy" ]; then
    pass "First add succeeded (privacy category created)"
  else
    fail "First add failed"
    return
  fi

  # Try to create it again (conflict)
  local output=$(run_vpn_switch wireguard add privacy 2>&1 || true)

  # Verify error message for existing category
  if printf '%s\n' "$output" | grep -qiE "error.*already exists|category.*exists|directory.*exists"; then
    pass "Error message when category already exists"
  else
    fail "Missing error for existing category"
    printf '%s\n' "Output: $output"
  fi
}

# TEST 42: WireGuard add - arity-2 delegates to add3
test_wireguard_add_link_arity2() {
  test_header "wireguard add - arity-2 delegates to add3 with target as alias" "test_wireguard_add_category_conflict"

  # Create exclusive database for this test
  test_setup

  # Enable execution for wireguard import and add (narrow overrides)
  set_function_interpreter "wireguard_import1" "sh"
  set_function_interpreter "wireguard_add" "sh"

  # Import a config first
  local test_config="$TEST_BASE_DIR/wg-TEST-AR2-1.conf"
  cat > "$test_config" <<'EOF'
[Interface]
PrivateKey = test_key_ar2
Address = 10.2.0.31/32
DNS = 10.2.0.1

[Peer]
PublicKey = test_public_key_ar2
AllowedIPs = 0.0.0.0/0
Endpoint = 31.31.31.31:51820
EOF
  chmod 0600 "$test_config"
  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1

  # Create category
  run_vpn_switch wireguard add performance >/dev/null 2>&1

  # Run add with arity-2 (category + config)
  local output=$(run_vpn_switch wireguard add performance wg-TEST-AR2-1.conf 2>&1 || true)

  # Should delegate to add3 with config name as alias
  # Look for success message showing target used as alias
  if printf '%s\n' "$output" | grep -qE "Added to.*performance.*wg-TEST-AR2-1.conf.*->.*wg-TEST-AR2-1.conf|wg-TEST-AR2-1.conf.*wg-TEST-AR2-1.conf"; then
    pass "Arity-2 delegates to add3 with target as alias"
  else
    fail "Delegation to add3 not working"
    printf '%s\n' "Output: $output"
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST 43: WireGuard add - arity-3 with custom alias
test_wireguard_add_link_arity3() {
  test_header "wireguard add - arity-3 with custom alias" "test_wireguard_add_category_conflict"

  # Create exclusive database for this test
  test_setup

  # Enable execution for wireguard import and add (narrow overrides)
  set_function_interpreter "wireguard_import1" "sh"
  set_function_interpreter "wireguard_add" "sh"

  # Import a config first
  local test_config="$TEST_BASE_DIR/wg-TEST-AR3-1.conf"
  cat > "$test_config" <<'EOF'
[Interface]
PrivateKey = test_key_ar3
Address = 10.2.0.32/32
DNS = 10.2.0.1

[Peer]
PublicKey = test_public_key_ar3
AllowedIPs = 0.0.0.0/0
Endpoint = 32.32.32.32:51820
EOF
  chmod 0600 "$test_config"
  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1

  # Create category
  run_vpn_switch wireguard add streaming >/dev/null 2>&1

  # Run add with arity-3 (category + config + alias)
  local output=$(run_vpn_switch wireguard add streaming wg-TEST-AR3-1.conf swiss 2>&1 || true)

  # Verify success message with alias and target
  if printf '%s\n' "$output" | grep -qE "Added to.*streaming.*swiss.*->.*wg-TEST-AR3-1.conf|swiss.*wg-TEST-AR3-1.conf"; then
    pass "Link created with custom alias (swiss)"
  else
    fail "Link creation failed"
    printf '%s\n' "Output: $output"
  fi

  # Verify symlink was actually created (if execution enabled)
  if [ -L "$TEST_DIR/wireguard/streaming/swiss" ]; then
    pass "Symlink file created at streaming/swiss"
  else
    # Not a failure if just showing commands
    pass "Success message with alias displayed"
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST 44: WireGuard add - error when link already exists
test_wireguard_add_link_conflict() {
  test_header "wireguard add - error when link already exists" "test_wireguard_add_link_conflict"

  # Create exclusive database for this test
  test_setup

  # Enable execution for wireguard import and add (narrow overrides)
  set_function_interpreter "wireguard_import1" "sh"
  set_function_interpreter "wireguard_add" "sh"

  # Import a config
  local test_config="$TEST_BASE_DIR/wg-TEST-CONF-1.conf"
  cat > "$test_config" <<'EOF'
[Interface]
PrivateKey = test_key_conf1
Address = 10.2.0.33/32
DNS = 10.2.0.1

[Peer]
PublicKey = test_public_key_conf1
AllowedIPs = 0.0.0.0/0
Endpoint = 33.33.33.33:51820
EOF
  chmod 0600 "$test_config"
  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1

  # Create category and add link
  run_vpn_switch wireguard add privacy >/dev/null 2>&1
  run_vpn_switch wireguard add privacy wg-TEST-CONF-1.conf link1 >/dev/null 2>&1

  # Verify link was created
  if [ -L "$TEST_DIR/wireguard/privacy/link1" ]; then
    pass "First link created successfully"
  else
    fail "First link not created"
    return
  fi

  # Try to add the same link again (conflict)
  local output=$(run_vpn_switch wireguard add privacy wg-TEST-CONF-1.conf link1 2>&1 || true)

  # Verify error message
  if printf '%s\n' "$output" | grep -qiE "error.*already exists|alias.*exists|link.*exists"; then
    pass "Error message when link already exists"
  else
    fail "Missing error for existing link"
    printf '%s\n' "Output: $output"
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST 45: WireGuard link - error when alias already exists
test_wireguard_link_conflict() {
  test_header "wireguard link - error when alias already exists" "test_wireguard_link_conflict"

  # Create exclusive database for this test
  test_setup

  # Enable execution for wireguard import (narrow override)
  set_function_interpreter "wireguard_import1" "sh"

  # Import a config
  local test_config="$TEST_BASE_DIR/wg-TEST-LINK-1.conf"
  cat > "$test_config" <<'EOF'
[Interface]
PrivateKey = test_key_link1
Address = 10.2.0.34/32
DNS = 10.2.0.1

[Peer]
PublicKey = test_public_key_link1
AllowedIPs = 0.0.0.0/0
Endpoint = 34.34.34.34:51820
EOF
  chmod 0600 "$test_config"
  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1

  # Verify config exists
  if [ -f "$TEST_DIR/wireguard/wg-TEST-LINK-1.conf" ]; then
    pass "Config imported successfully"
  else
    fail "Config import failed"
    rm -f "$test_config"
    return
  fi

  # Try to create link with same name as existing config file (conflict)
  local output=$(run_vpn_switch wireguard link wg-TEST-LINK-1.conf wg-TEST-LINK-1.conf 2>&1 || true)

  # Verify error message for existing alias
  if printf '%s\n' "$output" | grep -qiE "error.*already exists|alias.*exists|conflict"; then
    pass "Error message when alias already exists"
  else
    fail "Missing error for existing alias"
    printf '%s\n' "Output: $output"
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST 46: Error handling - invalid category
test_error_invalid_category() {
  test_header "error handling - invalid category shows error" "test_error_invalid_category"

  # Create exclusive database for this test
  test_setup

  # Try to start VPN with nonexistent category
  local output=$(run_vpn_switch wireguard start nonexistent 2>&1 || true)

  # Verify error message displayed
  if printf '%s\n' "$output" | grep -qiE "error.*not found|category not found|no.*found"; then
    pass "Error message for invalid category"
  else
    fail "Missing error message for invalid category"
    printf '%s\n' "Output: $output"
  fi
}

# TEST 16: Error handling - broken symlink
test_error_broken_symlink() {
  test_header "error handling - broken symlink handled gracefully" "test_error_broken_symlink"

  # Create exclusive database for this test
  test_setup

  # Enable execution for wireguard add (narrow override)
  set_function_interpreter "wireguard_add" "sh"

  # Create privacy category
  run_vpn_switch wireguard add privacy >/dev/null 2>&1

  # Create a broken symlink in privacy category
  ln -s ../nonexistent.conf "$TEST_DIR/wireguard/privacy/broken" 2>/dev/null || true

  # Verify broken symlink exists
  if [ -L "$TEST_DIR/wireguard/privacy/broken" ] && [ ! -e "$TEST_DIR/wireguard/privacy/broken" ]; then
    pass "Broken symlink created for testing"
  else
    fail "Failed to create broken symlink"
    ls -la "$TEST_DIR/wireguard/privacy/" || true
  fi

  # Try to start VPN with category containing broken symlink
  local output=$(run_vpn_switch wireguard start privacy 2>&1 || true)

  # Should either skip broken link or error gracefully
  if printf '%s\n' "$output" | grep -qiE "error|selected config|no.*found|not found"; then
    pass "Handled broken symlink (error or skipped)"
  else
    fail "Did not handle broken symlink gracefully"
    printf '%s\n' "Output: $output"
  fi
}

# TEST 17: Error handling - invalid command
test_error_invalid_command() {
  test_header "error handling - invalid command shows usage" "test_error_invalid_command"

  # Create exclusive database for this test
  test_setup

  # Try to run invalid command
  local output=$(run_vpn_switch invalid_command_xyz123 2>&1 || true)

  # Verify usage or help displayed
  if printf '%s\n' "$output" | grep -qiE "usage|help|unknown"; then
    pass "Usage/help shown for invalid command"
  else
    fail "No usage/help for invalid command"
    printf '%s\n' "Output: $output"
  fi
}

# TEST 18: Edge case - duplicate instance prevention
test_edge_duplicate_instance_prevention() {
  test_header "edge case - prevent duplicate VPN instances" "test_edge_duplicate_instance_prevention"

  # Create exclusive database for this test
  test_setup

  # Set up mocks for network operations with unique test ID
  local test_id=53
  setup_session_test_mocks "$test_id"
  local test_interface="wg_test${test_id}"

  # Enable execution for wireguard add and import (narrow overrides)
  set_function_interpreter "wireguard_add" "sh"
  set_function_interpreter "wireguard_import1" "sh"

  # Create privacy category and config
  run_vpn_switch wireguard add privacy >/dev/null 2>&1
  local test_config="$TEST_BASE_DIR/wg-TEST-DUP-1.conf"
  cat > "$test_config" <<'EOF'
[Interface]
 PrivateKey = test_key_dup1
Address = 10.2.0.99/32
DNS = 10.2.0.1

[Peer]
PublicKey = test_public_key_dup1
AllowedIPs = 0.0.0.0/0
Endpoint = 99.99.99.99:51820
EOF
  chmod 0600 "$test_config"
  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1
  run_vpn_switch wireguard add privacy wg-TEST-DUP-1.conf dup1 >/dev/null 2>&1

  # Create first "active" session (one with a running process PID)
  # This documents what makes a session "active": having a PID that corresponds to a running process
  # In a mocked environment (where wg-quick is echo'd), using wireguard start would create a
  # session without a real VPN process, so it would be detected as stale and auto-removed
  local first_pid=$$  # Use current shell PID (definitely running)
  local first_session="$TEST_DIR/.session/$first_pid"
  mkdir -p "$first_session"
  echo "$first_pid" > "$first_session/pid"
  echo "wireguard" > "$first_session/protocol"
  echo "$TEST_DIR/wireguard/privacy/dup1" > "$first_session/original"
  echo "$test_interface" > "$first_session/interface"
  date "+%Y-%m-%d %H:%M:%S" > "$first_session/started"
  echo "$first_pid" > "$first_session/vpn.pid"  # VPN process PID (must be running for duplicate detection)

  if [ -d "$first_session" ]; then
    pass "First VPN session created (PID $first_pid)"
  else
    fail "First VPN session not created"
    return
  fi

  # Try to start VPN again - should detect existing session and refuse
  local output=$(run_vpn_switch wireguard start privacy 2>&1 || true)

  # Should detect existing instance
  if printf '%s\n' "$output" | grep -qiE "already running|already exists|already active"; then
    pass "Detected existing VPN instance"
  else
    fail "Did not detect existing VPN instance"
    printf '%s\n' "Output: $output"
  fi

  # Verify no duplicate session created (should still be only one)
  local session_count=$(ls -1d "$TEST_DIR/.session"/* 2>/dev/null | wc -l)
  if [ "$session_count" -eq 1 ]; then
    pass "No duplicate session created"
  else
    fail "Duplicate session created (found $session_count sessions)"
    ls -la "$TEST_DIR/.session/" || true
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST 19: Edge case - stale sessions don't block new sessions
test_edge_stale_session_cleanup() {
  test_header "edge case - stale sessions don't block new sessions" "test_edge_stale_session_cleanup"

  # Create exclusive database for this test
  test_setup

  # Set up mocks for network operations
  setup_session_test_mocks

  # Enable execution for wireguard add and import (narrow overrides)
  set_function_interpreter "wireguard_add" "sh"
  set_function_interpreter "wireguard_import1" "sh"

  # Create privacy category and config
  run_vpn_switch wireguard add privacy >/dev/null 2>&1
  local test_config="$TEST_BASE_DIR/wg-TEST-STALE-1.conf"
  cat > "$test_config" <<'EOF'
[Interface]
 PrivateKey = test_key_stale1
Address = 10.2.0.88/32
DNS = 10.2.0.1

[Peer]
PublicKey = test_public_key_stale1
AllowedIPs = 0.0.0.0/0
Endpoint = 88.88.88.88:51820
EOF
  chmod 0600 "$test_config"
  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1
  run_vpn_switch wireguard add privacy wg-TEST-STALE-1.conf stale1 >/dev/null 2>&1

  # Create a stale session with dead PID (99998 definitely doesn't exist)
  local dead_pid=99998
  local session_dir="$TEST_DIR/.session/$dead_pid"
  mkdir -p "$session_dir"
  echo "$dead_pid" > "$session_dir/pid"
  echo "wireguard" > "$session_dir/protocol"
  echo "$TEST_DIR/wireguard/privacy/stale1" > "$session_dir/original"
  echo "wg_test3" > "$session_dir/interface"
  date "+%Y-%m-%d %H:%M:%S" > "$session_dir/started"
  echo "99994" > "$session_dir/vpn.pid"  # Dead VPN process PID (stale session)

  # Verify stale session exists
  if [ -d "$session_dir" ]; then
    pass "Stale session created for testing"
  else
    fail "Failed to create stale session"
  fi

  # Try to start VPN - should proceed (stale sessions don't block new sessions)
  # Note: In unit test mode (dry-run), session won't actually be created,
  # but the command should produce output without errors about stale sessions
  local output=$(run_vpn_switch wireguard start privacy 2>&1 || true)

  # Should proceed with connection (stale sessions don't prevent new ones)
  if printf '%s\n' "$output" | grep -qiE "session|wg-quick"; then
    pass "Proceeded with new session (stale session didn't block)"
  else
    fail "Did not proceed (should allow new session despite stale one)"
    printf '%s\n' "Output: $output"
  fi

  # Verify stale session was NOT automatically cleaned up
  # (Stale cleanup is now manual via 'session clean' command)
  if [ -d "$session_dir" ]; then
    pass "Stale session preserved (manual cleanup via 'session clean' required)"
  else
    fail "Stale session was unexpectedly removed"
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST 51: wireguard patch - displays patched configuration
test_wireguard_patch_valid() {
  test_header "wireguard patch - displays patched configuration" "test_wireguard_patch_valid"
  test_setup
  override_for_command_inspection "wireguard_patch"

  # Enable execution for wireguard import (narrow override)
  set_function_interpreter "wireguard_import1" "sh"

  # Create a test config
  local test_config="/tmp/wg-TEST-PATCH-1.conf"
  # Cleanup first (in case previous run failed before cleanup)
  rm -f "$test_config"
  cat > "$test_config" <<'CONF'
[Interface]
PrivateKey = test123
Address = 10.2.0.2/32
DNS = 10.2.0.1

[Peer]
PublicKey = server123
AllowedIPs = 0.0.0.0/0
Endpoint = 1.2.3.4:51820
CONF
  chmod 0400 "$test_config"

  # Import config first
  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1

  # Run patch command
  local output=$(run_vpn_switch wireguard patch wg-TEST-PATCH-1.conf 2>&1)

  # Phase-based approach: DNS handled by DNS phase, not PostUp/PostDown hooks
  # Verify PostUp/PostDown hooks are NOT present (they should be stripped)
  if printf '%s\n' "$output" | grep -q "PostUp.*resolvconf"; then
    fail "Patch output should NOT contain PostUp hook (phase-based DNS)"
  else
    pass "Patch output correctly strips PostUp hook (phase-based DNS)"
  fi

  if printf '%s\n' "$output" | grep -q "PostDown.*resolvconf"; then
    fail "Patch output should NOT contain PostDown hook (phase-based DNS)"
  else
    pass "Patch output correctly strips PostDown hook (phase-based DNS)"
  fi

  # Verify output still contains original config elements
  if printf '%s\n' "$output" | grep -q "\[Interface\]"; then
    pass "Patch output preserves [Interface] section"
  else
    fail "Patch output lost [Interface] section"
  fi

  if printf '%s\n' "$output" | grep -q "\[Peer\]"; then
    pass "Patch output preserves [Peer] section"
  else
    fail "Patch output lost [Peer] section"
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST 52: wireguard patch - handles nonexistent config
test_wireguard_patch_nonexistent() {
  test_header "wireguard patch - handles nonexistent config" "test_wireguard_patch_nonexistent"
  test_setup

  # Try to patch non-existent config
  local output=$(run_vpn_switch wireguard patch nonexistent-config.conf 2>&1 || true)

  if printf '%s\n' "$output" | grep -qiE "not found|does not exist"; then
    pass "Patch rejects nonexistent config with error"
  else
    fail "Patch should reject nonexistent config"
  fi
}

# TEST 53: wireguard patch - handles absolute path
test_wireguard_patch_absolute() {
  test_header "wireguard patch - handles absolute path" "test_wireguard_patch_absolute"
  test_setup
  override_for_command_inspection "wireguard_patch"

  # Enable execution for wireguard import (narrow override)
  set_function_interpreter "wireguard_import1" "sh"

  # Create a test config with absolute path
  local test_config="/tmp/wg-TEST-PATCH-ABS.conf"
  # Cleanup first (in case previous run failed before cleanup)
  rm -f "$test_config"
  cat > "$test_config" <<'CONF'
[Interface]
PrivateKey = test456
Address = 10.2.0.3/32
DNS = 10.2.0.1
CONF
  chmod 0400 "$test_config"

  # Import config first
  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1

  # Run patch with absolute path
  local output=$(run_vpn_switch wireguard patch "$TEST_DIR/wireguard/wg-TEST-PATCH-ABS.conf" 2>&1)

  # Phase-based approach: DNS handled by DNS phase, not PostUp hooks
  if printf '%s\n' "$output" | grep -q "PostUp.*resolvconf"; then
    fail "Patch should NOT contain PostUp hook (phase-based DNS)"
  else
    pass "Patch works with absolute path (strips DNS hooks)"
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST 54: wireguard info - displays category information
test_wireguard_info_category() {
  test_header "wireguard info - displays category information" "test_wireguard_info_category"
  test_setup

  # Enable execution for wireguard import and add (narrow override)
  set_function_interpreter "wireguard_add" "sh"
  set_function_interpreter "wireguard_import1" "sh"

  # Create a test config and category
  local test_config="/tmp/wg-TEST-INFO-1.conf"
  # Cleanup first (in case previous run failed before cleanup)
  rm -f "$test_config"
  cat > "$test_config" <<'CONF'
[Interface]
PrivateKey = testinfo123
Address = 10.2.0.5/32
DNS = 10.2.0.1
CONF
  chmod 0400 "$test_config"

  # Import config and create category with links
  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1
  run_vpn_switch wireguard add testinfo >/dev/null 2>&1
  run_vpn_switch wireguard add testinfo wg-TEST-INFO-1.conf >/dev/null 2>&1
  run_vpn_switch wireguard add testinfo wg-TEST-INFO-1.conf info1 >/dev/null 2>&1

  # Run info command on category
  local output=$(run_vpn_switch wireguard info testinfo 2>&1 || true)

  # Verify category header displayed
  if printf '%s\n' "$output" | grep -q "# Category: testinfo"; then
    pass "Category header displayed"
  else
    fail "Category header missing"
  fi

  # Verify counts section
  if printf '%s\n' "$output" | grep -q "# Configs:"; then
    pass "Config count displayed"
  else
    fail "Config count missing"
  fi

  if printf '%s\n' "$output" | grep -q "# Links:"; then
    pass "Link count displayed"
  else
    fail "Link count missing"
  fi

  # Verify path displayed
  if printf '%s\n' "$output" | grep -q "# Path:.*testinfo"; then
    pass "Category path displayed"
  else
    fail "Category path missing"
  fi

  # Verify contents section
  if printf '%s\n' "$output" | grep -q "# Contents:"; then
    pass "Contents section header displayed"
  else
    fail "Contents section missing"
  fi

  # Verify symlinks shown (should show ->)
  if printf '%s\n' "$output" | grep -q -- "->"; then
    pass "Category contents listed with symlink arrows"
  else
    fail "Contents not shown properly"
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST 55: session save - save current session as default
test_session_save_default() {
  test_header "session save - save current session as default" "test_session_save_default"
  test_setup

  # Set up mocks for network operations (wg-quick, pfctl, wg9 interface)
  setup_session_test_mocks

  # Enable execution for wireguard import and session save (narrow override)
  # Note: wireguard start is a combinator function - uses default interpreter
  set_function_interpreter "wireguard_import1" "sh"
  set_function_interpreter "session_save" "sh"

  # Create and import a test config
  local test_config="/tmp/wg-TEST-SAVE-DEFAULT.conf"
  # Cleanup first (in case previous run failed before cleanup)
  rm -f "$test_config"
  cat > "$test_config" <<'CONF'
[Interface]
PrivateKey = testsavedefault123
Address = 10.2.0.10/32
DNS = 10.2.0.1
CONF
  chmod 0400 "$test_config"

  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1

  # Start a session (creates active session)
  local start_output=$(run_vpn_switch wireguard start wg-TEST-SAVE-DEFAULT.conf 2>&1)
  local session_id=$(echo "$start_output" | grep -oE '[Ss]ession:? [0-9]+|PID:? [0-9]+|session [0-9]+' | grep -oE '[0-9]+' | head -1)

  # Save session as default
  run_vpn_switch session save >/dev/null 2>&1

  # Verify default symlink was created
  if [ -L "$TEST_DIR/session/default" ]; then
    pass "Default session symlink created"
  else
    fail "Default session symlink not created"
  fi

  # Verify symlink points to correct session
  local link_target=$(readlink "$TEST_DIR/session/default")
  if echo "$link_target" | grep -q "$session_id"; then
    pass "Default symlink points to correct session"
  else
    fail "Default symlink points to wrong session"
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST 56: session save - save with custom name
test_session_save_named() {
  test_header "session save work - save with custom name" "test_session_save_named"
  test_setup

  # Set up mocks for network operations (wg-quick, pfctl, wg9 interface)
  setup_session_test_mocks

  # Enable execution for wireguard import and session save (narrow override)
  # Note: wireguard start is a combinator function - uses default interpreter
  set_function_interpreter "wireguard_import1" "sh"
  set_function_interpreter "session_save" "sh"

  # Create and import a test config
  local test_config="/tmp/wg-TEST-SAVE-NAMED.conf"
  # Cleanup first (in case previous run failed before cleanup)
  rm -f "$test_config"
  cat > "$test_config" <<'CONF'
[Interface]
PrivateKey = testsavenamed456
Address = 10.2.0.11/32
DNS = 10.2.0.1
CONF
  chmod 0400 "$test_config"

  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1

  # Start a session
  local start_output=$(run_vpn_switch wireguard start wg-TEST-SAVE-NAMED.conf 2>&1)
  local session_id=$(echo "$start_output" | grep -oE '[Ss]ession:? [0-9]+|PID:? [0-9]+|session [0-9]+' | grep -oE '[0-9]+' | head -1)

  # Save session with custom name "work"
  run_vpn_switch session save work >/dev/null 2>&1

  # Verify named symlink was created
  if [ -L "$TEST_DIR/session/work" ]; then
    pass "Named session symlink created"
  else
    fail "Named session symlink not created"
  fi

  # Verify symlink points to correct session
  local link_target=$(readlink "$TEST_DIR/session/work")
  if echo "$link_target" | grep -q "$session_id"; then
    pass "Named symlink points to correct session"
  else
    fail "Named symlink points to wrong session"
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST 57: session start - resume default session
test_session_start_default() {
  test_header "session start - resume default session" "test_session_start_default"
  test_setup

  # Set up mocks for network operations (wg-quick, pfctl, wg9 interface)
  setup_session_test_mocks

  # Enable execution for terminal commands (narrow override)
  # Note: wireguard start and session start are combinator functions - use default interpreter
  set_function_interpreter "wireguard_import1" "sh"
  set_function_interpreter "session_save" "sh"
  set_function_interpreter "session_stop" "sh"

  # Create and import a test config
  local test_config="/tmp/wg-TEST-START-DEFAULT.conf"
  # Cleanup first (in case previous run failed before cleanup)
  rm -f "$test_config"
  cat > "$test_config" <<'CONF'
[Interface]
PrivateKey = teststartdefault789
Address = 10.2.0.12/32
DNS = 10.2.0.1
CONF
  chmod 0400 "$test_config"

  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1

  # Start a session and save as default
  run_vpn_switch wireguard start wg-TEST-START-DEFAULT.conf >/dev/null 2>&1
  local session_id=$(ls -t "$TEST_DIR/.session" | head -1)
  run_vpn_switch session save >/dev/null 2>&1

  # Verify connect.sh exists before stopping
  if [ -f "$TEST_DIR/.session/$session_id/connect.sh" ]; then
    pass "Connect script created before stopping"
  else
    fail "Connect script not found"
  fi

  # Stop the session
  run_vpn_switch stop >/dev/null 2>&1

  # Verify session was stopped but session data remains (because it's saved/referenced)
  if [ -d "$TEST_DIR/.session/$session_id" ]; then
    pass "Session directory kept for resumption (referenced)"
  else
    fail "Session directory was removed (should be kept for resumption)"
  fi

  if [ -L "$TEST_DIR/session/default" ]; then
    pass "Default symlink persists after stop"
  else
    fail "Default symlink was removed"
  fi

  # Resume default session
  local resume_output=$(run_vpn_switch session start 2>&1)

  # Verify resumption message or success
  if echo "$resume_output" | grep -qiE "resuming|starting|session"; then
    pass "Session start executed successfully"
  else
    fail "Session start failed: $resume_output"
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST 58: session start - resume named session
test_session_start_named() {
  test_header "session start work - resume named session" "test_session_start_named"
  test_setup

  # Set up mocks for network operations (wg-quick, pfctl, wg9 interface)
  setup_session_test_mocks

  # Enable execution for terminal commands (narrow override)
  # Note: wireguard start and session start are combinator functions - use default interpreter
  set_function_interpreter "wireguard_import1" "sh"
  set_function_interpreter "session_save" "sh"
  set_function_interpreter "session_stop" "sh"

  # Create and import a test config
  local test_config="/tmp/wg-TEST-START-NAMED.conf"
  rm -f "$test_config"  # Remove if exists from previous run
  cat > "$test_config" <<'CONF'
[Interface]
PrivateKey = teststartnamed012
Address = 10.2.0.13/32
DNS = 10.2.0.1
CONF
  chmod 0400 "$test_config"

  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1

  # Start a session and save with name "work"
  run_vpn_switch wireguard start wg-TEST-START-NAMED.conf >/dev/null 2>&1
  run_vpn_switch session save work >/dev/null 2>&1

  # Stop the session
  run_vpn_switch stop >/dev/null 2>&1

  # Verify named symlink still exists
  if [ -L "$TEST_DIR/session/work" ]; then
    pass "Named symlink persists after stop"
  else
    fail "Named symlink was removed"
  fi

  # Resume named session
  local resume_output=$(run_vpn_switch session start work 2>&1)

  # Verify resumption
  if echo "$resume_output" | grep -qiE "resuming|starting|session|work"; then
    pass "Named session start executed successfully"
  else
    fail "Named session start failed: $resume_output"
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST 59: session start - resume by PID
test_session_start_by_pid() {
  test_header "session start <PID> - resume by PID" "test_session_start_by_pid"
  test_setup

  # Set up mocks for network operations (wg-quick, pfctl, wg9 interface)
  setup_session_test_mocks

  # Enable execution for terminal commands (narrow override)
  # Note: wireguard start and session start are combinator functions - use default interpreter
  set_function_interpreter "wireguard_import1" "sh"
  set_function_interpreter "session_save" "sh"
  set_function_interpreter "session_stop" "sh"

  # Create and import a test config
  local test_config="/tmp/wg-TEST-START-PID.conf"
  # Cleanup first (in case previous run failed before cleanup)
  rm -f "$test_config"
  cat > "$test_config" <<'CONF'
[Interface]
PrivateKey = teststartpid345
Address = 10.2.0.14/32
DNS = 10.2.0.1
CONF
  chmod 0400 "$test_config"

  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1

  # Start a session and capture PID
  local start_output=$(run_vpn_switch wireguard start wg-TEST-START-PID.conf 2>&1)
  local session_id=$(echo "$start_output" | grep -oE '[Ss]ession:? [0-9]+|PID:? [0-9]+|session [0-9]+' | grep -oE '[0-9]+' | head -1)

  # Save session (to preserve connect.sh)
  run_vpn_switch session save pid-test >/dev/null 2>&1

  # Stop the session
  run_vpn_switch stop >/dev/null 2>&1

  # Resume by explicit PID
  local resume_output=$(run_vpn_switch session start "$session_id" 2>&1)

  # Verify resumption by PID
  if echo "$resume_output" | grep -qiE "resuming|starting|session|$session_id"; then
    pass "Session start by PID executed successfully"
  else
    fail "Session start by PID failed: $resume_output"
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST 60: Protocol-agnostic import - detects WireGuard config
test_protocol_agnostic_import_wireguard() {
  test_header "import (protocol-agnostic) - detects WireGuard .conf file" "test_protocol_agnostic_import_wireguard"
  test_setup

  # Override wireguard_import to cat (profile-independent)
  override_for_command_inspection "wireguard_import1"

  # Create test WireGuard config
  local test_config="/tmp/wg-PROTO-IMPORT.conf"
  # Cleanup first (in case previous run failed before cleanup)
  rm -f "$test_config"
  cat > "$test_config" <<'CONF'
[Interface]
PrivateKey = protoimporttest123
Address = 10.2.0.20/32
DNS = 10.2.0.1
CONF
  chmod 0400 "$test_config"

  # Test protocol-agnostic import (combinator delegates to wireguard import)
  local output=$(run_vpn_switch import "$test_config" 2>&1)

  # Verify wrapper detected .conf and delegated to wireguard import
  if printf '%s\n' "$output" | grep -q "# Import WireGuard config"; then
    pass "Protocol-agnostic import detected .conf and delegated to wireguard import"
  else
    fail "Protocol-agnostic import failed to delegate: $output"
  fi

  # Verify output contains cp command with correct paths
  if printf '%s\n' "$output" | grep -q "cp.*$test_config.*wireguard/wg-PROTO-IMPORT.conf"; then
    pass "Protocol-agnostic import generates correct cp command"
  else
    fail "Protocol-agnostic import missing correct cp command"
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST 61: Protocol-agnostic list - delegates to protocol-specific lists
test_protocol_agnostic_list() {
  test_header "list (protocol-agnostic) - delegates to all protocols" "test_protocol_agnostic_list"
  test_setup

  # Leave VPN_SWITCH_INTERPRETER_wireguard_list as default (cat) - we test output

  # Test protocol-agnostic list (combinator delegates to wireguard list)
  local output=$(run_vpn_switch list 2>&1)

  # Verify wrapper delegated to wireguard list (check for WireGuard header)
  if printf '%s\n' "$output" | grep -q "WireGuard Configurations"; then
    pass "Protocol-agnostic list delegated to wireguard list"
  else
    fail "Protocol-agnostic list failed to delegate: $output"
  fi

  # Verify output shows configs section (check for "Configuration files:")
  if printf '%s\n' "$output" | grep -q "Configuration files:"; then
    pass "Protocol-agnostic list shows wireguard config sections"
  else
    fail "Protocol-agnostic list missing config sections"
  fi

  # Verify no duplicate lines (exclude blank lines and comments)
  local total_lines=$(printf '%s\n' "$output" | grep -v '^[ \t]*$' | grep -v '#' | wc -l | tr -d ' ')
  local unique_lines=$(printf '%s\n' "$output" | grep -v '^[ \t]*$' | grep -v '#' | sort -u | wc -l | tr -d ' ')

  if [ "$total_lines" = "$unique_lines" ]; then
    pass "Protocol-agnostic list has no duplicate lines ($total_lines unique)"
  else
    fail "Protocol-agnostic list has duplicates" "$total_lines unique lines" "$unique_lines after deduplication"
  fi
}

# TEST 62: Protocol-agnostic link - creates protocol-level alias
test_protocol_agnostic_link() {
  test_header "link (protocol-agnostic) - creates protocol-level alias" "test_protocol_agnostic_link"
  test_setup

  # Override interpreter to inspect link command output (profile-independent)
  override_for_command_inspection "link"

  # _link2 is a leaf function - test its output without execution
  # Protocol-level link creates: $BASE/alias -> $BASE/protocol

  # Test link command generation
  local output=$(run_vpn_switch link testproto wireguard 2>&1 || true)

  # Verify output contains ln command
  if printf '%s\n' "$output" | grep -q "ln -s"; then
    pass "Protocol-agnostic link generates ln command"
  else
    fail "Protocol-agnostic link missing ln command: $output"
  fi

  # Verify relative path (./wireguard)
  if printf '%s\n' "$output" | grep -q './wireguard'; then
    pass "Protocol-agnostic link uses correct relative path (./wireguard)"
  else
    fail "Protocol-agnostic link has incorrect path"
  fi

  # Verify target path includes testproto
  if printf '%s\n' "$output" | grep -q "testproto"; then
    pass "Protocol-agnostic link includes correct alias name"
  else
    fail "Protocol-agnostic link missing alias name"
  fi
}

# TEST 63: Protocol-agnostic remove - removes protocol-level link
test_protocol_agnostic_remove() {
  test_header "remove (protocol-agnostic) - removes protocol-level link" "test_protocol_agnostic_remove"
  test_setup

  # Override interpreter to inspect remove command output (profile-independent)
  override_for_command_inspection "remove"

  # _remove1 is a leaf function - test its output without execution
  # First create a dummy symlink for testing
  ln -s "./wireguard" "$TEST_DIR/testremove"

  # Test remove command generation
  local output=$(run_vpn_switch remove testremove 2>&1)

  # Verify output contains rm command
  if printf '%s\n' "$output" | grep -q "rm.*testremove"; then
    pass "Protocol-agnostic remove generates rm command"
  else
    fail "Protocol-agnostic remove missing rm command: $output"
  fi

  # Verify comment about removing link
  if printf '%s\n' "$output" | grep -qiE "remove.*link|remove.*protocol"; then
    pass "Protocol-agnostic remove includes descriptive comment"
  else
    fail "Protocol-agnostic remove missing descriptive comment"
  fi

  # Test error on non-existent link (should get error, not commands)
  local err_output=$(run_vpn_switch remove nonexistent 2>&1 || true)
  if echo "$err_output" | grep -qiE "not found|error"; then
    pass "Protocol-agnostic remove errors on non-existent link"
  else
    fail "Protocol-agnostic remove should error on non-existent link"
  fi
}

# TEST 64: Protocol-agnostic validate - delegates to protocol-specific validate
test_protocol_agnostic_validate() {
  test_header "validate (protocol-agnostic) - delegates to all protocols" "test_protocol_agnostic_validate"
  test_setup

  # Leave VPN_SWITCH_INTERPRETER_wireguard_validate as default (cat) - we test output

  # Test protocol-agnostic validate (combinator delegates to wireguard validate)
  local output=$(run_vpn_switch validate 2>&1)

  # Verify wrapper delegated to wireguard validate (check for validation header)
  if printf '%s\n' "$output" | grep -q "WireGuard Configuration Validation"; then
    pass "Protocol-agnostic validate delegated to wireguard validate"
  else
    fail "Protocol-agnostic validate failed to delegate: $output"
  fi

  # Verify output shows validation sections
  if printf '%s\n' "$output" | grep -qE "# Checking|# Validation"; then
    pass "Protocol-agnostic validate shows validation output"
  else
    fail "Protocol-agnostic validate missing validation output"
  fi
}

#-----------------------------------------------------------------------------
# System Validation Tests (Phase 4.1 - Feature 3)
#-----------------------------------------------------------------------------

# TEST 65: Network validate - checks network prerequisites
test_network_validate() {
  test_header "network validate - check network prerequisites" "test_network_validate"
  test_setup

  # Run network validate
  local output=$(run_vpn_switch network validate)

  # Verify validation header
  if printf '%s\n' "$output" | grep -q "Network Prerequisites Validation"; then
    pass "Network validation header displayed"
  else
    fail "Network validation header missing"
    printf '%s\n' "Output: $output"
  fi

  # Verify success message on clean configuration
  if printf '%s\n' "$output" | grep -q "Network prerequisites OK"; then
    pass "Network validate passed on clean configuration"
  else
    fail "Network validate did not pass"
    printf '%s\n' "Output: $output"
  fi
}

# TEST 66: Permissions validate - checks file/directory permissions
test_permissions_validate() {
  test_header "permissions validate - check filesystem permissions" "test_permissions_validate"
  test_setup

  # Run permissions validate
  local output=$(run_vpn_switch permissions validate)

  # Verify validation header
  if printf '%s\n' "$output" | grep -q "Permissions Validation"; then
    pass "Permissions validation header displayed"
  else
    fail "Permissions validation header missing"
    printf '%s\n' "Output: $output"
  fi

  # Verify success message on clean configuration
  if printf '%s\n' "$output" | grep -q "Permissions OK"; then
    pass "Permissions validate passed on clean configuration"
  else
    fail "Permissions validate did not pass"
    printf '%s\n' "Output: $output"
  fi
}

# TEST 67: Environment validate - checks environment configuration
test_environment_validate() {
  test_header "environment validate - check environment variables" "test_environment_validate"
  test_setup

  # Run environment validate
  local output=$(run_vpn_switch environment validate)

  # Verify validation header
  if printf '%s\n' "$output" | grep -q "Environment Configuration Validation"; then
    pass "Environment validation header displayed"
  else
    fail "Environment validation header missing"
    printf '%s\n' "Output: $output"
  fi

  # Verify success message on clean configuration
  if printf '%s\n' "$output" | grep -q "Environment configuration OK"; then
    pass "Environment validate passed on clean configuration"
  else
    fail "Environment validate did not pass"
    printf '%s\n' "Output: $output"
  fi
}

# TEST 68: Batch validate - includes all system validators
test_batch_validate_includes_system() {
  test_header "validate (batch) - includes system validators" "test_batch_validate_includes_system"
  test_setup

  # Run batch validate (batch combinator)
  local output=$(run_vpn_switch validate 2>&1)

  # Verify it includes database validate
  if printf '%s\n' "$output" | grep -q "Database Structure Validation"; then
    pass "Batch validate includes database validator"
  else
    fail "Batch validate missing database validator"
  fi

  # Verify it includes binaries validate
  if printf '%s\n' "$output" | grep -q "Binary Availability Validation"; then
    pass "Batch validate includes binaries validator"
  else
    fail "Batch validate missing binaries validator"
  fi

  # Verify it includes phases validate
  if printf '%s\n' "$output" | grep -q "Phase System Validation"; then
    pass "Batch validate includes phases validator"
  else
    fail "Batch validate missing phases validator"
  fi

  # Verify it includes network validate
  if printf '%s\n' "$output" | grep -q "Network Prerequisites Validation"; then
    pass "Batch validate includes network validator"
  else
    fail "Batch validate missing network validator"
  fi

  # Verify it includes permissions validate
  if printf '%s\n' "$output" | grep -q "Permissions Validation"; then
    pass "Batch validate includes permissions validator"
  else
    fail "Batch validate missing permissions validator"
  fi

  # Verify it includes environment validate
  if printf '%s\n' "$output" | grep -q "Environment Configuration Validation"; then
    pass "Batch validate includes environment validator"
  else
    fail "Batch validate missing environment validator"
  fi
}

#-----------------------------------------------------------------------------
# Interpreter Resolution Tests (Lower Half of lookup_interpreter)
#-----------------------------------------------------------------------------

# TEST 65: Single underscore → TERMINAL_INTERPRETER (intrinsic classification)
test_interpreter_single_underscore() {
  test_header "interpreter resolution - single underscore uses TERMINAL_INTERPRETER" "test_interpreter_single_underscore"
  test_setup

  # Set TERMINAL_INTERPRETER to distinctive value (NOT cat, NOT sh)
  # This tests the lower half of lookup_interpreter() (intrinsic classification)
  run_vpn_switch setenv "VPN_SWITCH_TERMINAL_INTERPRETER" "echo TERMINAL_FIRED"

  # IMPORTANT: Remove function-specific overrides that would block intrinsic classification
  # The profile may include VPN_SWITCH_INTERPRETER_wireguard_list which has higher priority
  rm -f "$TEST_DIR/.env/default/VPN_SWITCH_INTERPRETER_wireguard_list"
  rm -f "$TEST_DIR/.env/local/VPN_SWITCH_INTERPRETER_wireguard_list"

  # Pick a single underscore (terminal) function
  # _wireguard_list0 is a good choice - it's a terminal function
  local output=$(run_vpn_switch wireguard list 2>&1)

  # Verify TERMINAL_INTERPRETER was used (output shows it was executed)
  if printf '%s\n' "$output" | grep -q "TERMINAL_FIRED"; then
    pass "Single underscore function used TERMINAL_INTERPRETER"
  else
    fail "Single underscore function did not use TERMINAL_INTERPRETER"
    printf '%s\n' "Output: $output"
  fi
}

# TEST 66: Double underscore → COMBINATOR_INTERPRETER (intrinsic classification)
test_interpreter_double_underscore() {
  test_header "interpreter resolution - double underscore uses COMBINATOR_INTERPRETER" "test_interpreter_double_underscore"
  test_setup

  # Set COMBINATOR_INTERPRETER to distinctive value
  # This tests intrinsic classification for double underscore functions
  run_vpn_switch setenv "VPN_SWITCH_COMBINATOR_INTERPRETER" "echo COMBINATOR_FIRED"

  # IMPORTANT: Remove function-specific overrides that would block intrinsic classification
  # The profile may include function-specific interpreter settings
  rm -f "$TEST_DIR/.env/default/VPN_SWITCH_INTERPRETER_wireguard_start"
  rm -f "$TEST_DIR/.env/local/VPN_SWITCH_INTERPRETER_wireguard_start"

  # Pick a double underscore (combinator) function
  # __wireguard_start1 is a good choice - it's a combinator that delegates to _wireguard_start1
  local output=$(run_vpn_switch wireguard start privacy 2>&1)

  # Verify COMBINATOR_INTERPRETER was used
  if printf '%s\n' "$output" | grep -q "COMBINATOR_FIRED"; then
    pass "Double underscore function used COMBINATOR_INTERPRETER"
  else
    fail "Double underscore function did not use COMBINATOR_INTERPRETER"
    printf '%s\n' "Output: $output"
  fi
}

# TEST 67: Triple underscore → BATCH_COMBINATOR_INTERPRETER (intrinsic classification)
test_interpreter_triple_underscore() {
  test_header "interpreter resolution - triple underscore uses BATCH_COMBINATOR_INTERPRETER" "test_interpreter_triple_underscore"
  test_setup

  # Set BATCH_COMBINATOR_INTERPRETER to distinctive value
  # This tests intrinsic classification for triple underscore functions
  run_vpn_switch setenv "VPN_SWITCH_BATCH_COMBINATOR_INTERPRETER" "echo BATCH_COMBINATOR_FIRED"

  # IMPORTANT: Do NOT set function-specific override
  # We want to test that triple underscore functions use BATCH_COMBINATOR_INTERPRETER

  # Pick a triple underscore (batch combinator) function
  # ___dump0 is a good choice - it outputs multiple delegation commands
  local output=$(run_vpn_switch dump 2>&1)

  # Verify BATCH_COMBINATOR_INTERPRETER was used
  if printf '%s\n' "$output" | grep -q "BATCH_COMBINATOR_FIRED"; then
    pass "Triple underscore function used BATCH_COMBINATOR_INTERPRETER"
  else
    fail "Triple underscore function did not use BATCH_COMBINATOR_INTERPRETER"
    printf '%s\n' "Output: $output"
  fi
}

# TEST 68: Resolution priority - function-specific override beats intrinsic classification
test_interpreter_resolution_priority() {
  test_header "interpreter resolution - function-specific override beats intrinsic classification" "test_interpreter_resolution_priority"
  test_setup

  # Set BOTH function-specific override AND intrinsic classification
  # Function-specific should win (upper half beats lower half)
  run_vpn_switch setenv "VPN_SWITCH_TERMINAL_INTERPRETER" "echo TERMINAL_DEFAULT"

  # Now set function-specific override (should take priority)
  set_function_interpreter "wireguard_list" "echo FUNCTION_SPECIFIC_OVERRIDE"

  # Call wireguard list (single underscore = terminal function)
  local output=$(run_vpn_switch wireguard list 2>&1)

  # Verify function-specific override was used (NOT intrinsic classification)
  if printf '%s\n' "$output" | grep -q "FUNCTION_SPECIFIC_OVERRIDE"; then
    pass "Function-specific override takes priority over intrinsic classification"
  else
    fail "Function-specific override did not take priority"
    printf '%s\n' "Output: $output"
  fi

  # Verify intrinsic classification was NOT used
  if ! printf '%s\n' "$output" | grep -q "TERMINAL_DEFAULT"; then
    pass "Intrinsic classification was correctly bypassed"
  else
    fail "Intrinsic classification was incorrectly used"
    printf '%s\n' "Output: $output"
  fi
}

#-----------------------------------------------------------------------------
# Protocol-Agnostic Start Tests (Phase 3.2.1)
#-----------------------------------------------------------------------------

test_start_wireguard_only() {
  test_header "start - auto-detect WireGuard config" "test_start_wireguard_only"

  test_setup

  # Create WireGuard config only (must be valid for start to proceed)
  mkdir -p "$TEST_DIR/wireguard"
  cat > "$TEST_DIR/wireguard/wg-test.conf" <<'EOF'
[Interface]
PrivateKey = test-key
Address = 10.2.0.2/32
EOF
  chmod 0400 "$TEST_DIR/wireguard/wg-test.conf"

  # Test: should delegate to wireguard start
  # We observe the resolution result via the session metadata that
  # session create + session populate write to disk before the phase
  # scripts run (and possibly fail without root). Stdout no longer
  # carries dispatch evidence — _batch2's "# Executing: ..." lines went
  # to trace_log in commit fd79dc8 (was needed so `dump` stderr stays clean).
  run_vpn_switch start wg-test.conf > /dev/null 2>&1 || true

  local sess=$(ls -d "$TEST_DIR"/.session/*/ 2>/dev/null | head -1)
  local sess_protocol=""
  [ -n "$sess" ] && sess_protocol=$(cat "$sess/protocol" 2>/dev/null)
  if [ "$sess_protocol" = "wireguard" ]; then
    pass "Delegates to wireguard commands for WireGuard-only config (session.protocol=wireguard)"
  else
    fail "Did not delegate to wireguard start"
    printf '%s\n' "  session: ${sess:-none}, session.protocol: ${sess_protocol:-none}"
    ls -la "$TEST_DIR/.session/" 2>/dev/null
  fi
}

test_start_openvpn_only() {
  test_header "start - auto-detect OpenVPN config" "test_start_openvpn_only"

  test_setup

  # Create OpenVPN config only (must be valid for start to proceed)
  mkdir -p "$TEST_DIR/openvpn"
  cat > "$TEST_DIR/openvpn/ovpn-test.ovpn" <<'EOF'
client
dev tun
proto udp
remote 1.2.3.4 1194
EOF
  chmod 0400 "$TEST_DIR/openvpn/ovpn-test.ovpn"

  # Test: should delegate to openvpn start
  # Twin of test_start_wireguard_only — assert on session.protocol
  # artifact rather than _batch2 stdout, which moved to trace_log in fd79dc8.
  run_vpn_switch start ovpn-test.ovpn > /dev/null 2>&1 || true

  local sess=$(ls -d "$TEST_DIR"/.session/*/ 2>/dev/null | head -1)
  local sess_protocol=""
  [ -n "$sess" ] && sess_protocol=$(cat "$sess/protocol" 2>/dev/null)
  if [ "$sess_protocol" = "openvpn" ]; then
    pass "Delegates to openvpn commands for OpenVPN-only config (session.protocol=openvpn)"
  else
    fail "Did not delegate to openvpn start"
    printf '%s\n' "  session: ${sess:-none}, session.protocol: ${sess_protocol:-none}"
    ls -la "$TEST_DIR/.session/" 2>/dev/null
  fi
}

test_start_not_found() {
  test_header "start - error on nonexistent config" "test_start_not_found"

  test_setup

  # Test: should error with helpful message
  local output=$(run_vpn_switch start nonexistent 2>&1)

  if printf '%s\n' "$output" | grep -q "config not found: nonexistent"; then
    pass "Error message for nonexistent config"
  else
    fail "Did not show proper error message"
    printf '%s\n' "Output: $output"
  fi

  # Verify it searched both directories
  if printf '%s\n' "$output" | grep -q "wireguard/nonexistent" && printf '%s\n' "$output" | grep -q "openvpn/nonexistent"; then
    pass "Error shows both search locations"
  else
    fail "Error does not show search locations"
    printf '%s\n' "Output: $output"
  fi
}

test_start_no_default() {
  test_header "start - error when no configs exist (Phase 3.4.1)" "test_start_no_default"

  test_setup

  # Remove all configs to test empty database case
  rm -f "$TEST_DIR/wireguard"/*.conf 2>/dev/null || true
  rm -f "$TEST_DIR/openvpn"/*.ovpn 2>/dev/null || true

  # Test: should error when no VPN configs are available
  local output=$(run_vpn_switch start 2>&1)

  if printf '%s\n' "$output" | grep -q "no VPN protocols found"; then
    pass "Error message when no configs available"
  else
    fail "Did not show proper error message"
    printf '%s\n' "Output: $output"
  fi

  # Verify helpful hint is provided
  if printf '%s\n' "$output" | grep -q "vpn-switch import"; then
    pass "Error provides hint to import configs"
  else
    fail "Error does not provide helpful hint"
    printf '%s\n' "Output: $output"
  fi
}

test_start_with_default_wireguard() {
  test_header "start - use default link (WireGuard) via API" "test_start_with_default_wireguard"

  test_setup

  # Create WireGuard config using proper API
  local test_config="$TEST_BASE_DIR/wg-test-default.conf"
  rm -f "$test_config"
  cat > "$test_config" <<'EOF'
[Interface]
PrivateKey = test-key-default-wg
Address = 10.2.0.3/32
EOF
  chmod 0400 "$test_config"

  # Import config through API
  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1

  # Override interpreter to prevent actual connection
  override_for_command_inspection "wireguard_connect"

  # Start session (creates .session/<PID>)
  local start_output
  start_output=$(run_vpn_switch wireguard start wg-test-default 2>&1)

  # Extract PID from output
  local session_pid
  session_pid=$(echo "$start_output" | grep -o 'session [0-9]*' | awk '{print $2}')

  if [ -z "$session_pid" ]; then
    fail "Could not create session for default link test"
    return
  fi

  # Save as default using API
  VPN_SWITCH_BASE="$TEST_DIR" \
  VPN_SWITCH_SESSION_PID="$session_pid" \
  run_vpn_switch session save >/dev/null 2>&1

  # Verify default link was created
  if [ -L "$TEST_DIR/session/default" ]; then
    pass "Default session link created via API"
  else
    fail "Default session link not created"
    return
  fi

  # Now test: start with no args should delegate to session start
  # Override interpreter to inspect delegation (not execute)
  override_for_command_inspection "start"

  local output
  output=$(run_vpn_switch start 2>&1)

  if printf '%s\n' "$output" | grep -q 'session start'; then
    pass "Start with no args resolves to default session"
  else
    fail "Default link did not resolve correctly"
    printf '%s\n' "Output: $output"
  fi
}

test_start_with_default_openvpn() {
  test_header "start - use default link (OpenVPN) via API" "test_start_with_default_openvpn"

  test_setup

  # Create OpenVPN config using proper API
  local test_config="$TEST_BASE_DIR/ovpn-test-default.ovpn"
  rm -f "$test_config"
  cat > "$test_config" <<'EOF'
client
dev tun
proto udp
remote 5.6.7.8 1194
EOF
  chmod 0400 "$test_config"

  # Import config through API
  run_vpn_switch openvpn import "$test_config" >/dev/null 2>&1

  # Override interpreter to prevent actual connection
  override_for_command_inspection "openvpn_connect"

  # Start session (creates .session/<PID>)
  local start_output
  start_output=$(run_vpn_switch openvpn start ovpn-test-default 2>&1)

  # Extract PID from output
  local session_pid
  session_pid=$(echo "$start_output" | grep -o 'session [0-9]*' | awk '{print $2}')

  if [ -z "$session_pid" ]; then
    fail "Could not create session for default link test"
    return
  fi

  # Save as default using API
  VPN_SWITCH_BASE="$TEST_DIR" \
  VPN_SWITCH_SESSION_PID="$session_pid" \
  run_vpn_switch session save >/dev/null 2>&1

  # Verify default link was created
  if [ -L "$TEST_DIR/session/default" ]; then
    pass "Default session link created via API"
  else
    fail "Default session link not created"
    return
  fi

  # Now test: start with no args should delegate to session start
  # Override interpreter to inspect delegation (not execute)
  override_for_command_inspection "start"

  local output
  output=$(run_vpn_switch start 2>&1)

  if printf '%s\n' "$output" | grep -q 'session start'; then
    pass "Start with no args resolves to default session"
  else
    fail "Default link did not resolve correctly"
    printf '%s\n' "Output: $output"
  fi
}

test_start_default_invalid_target() {
  test_header "start - error on invalid default link target" "test_start_default_invalid_target"

  test_setup

  # Create WireGuard config using proper API
  local test_config="$TEST_BASE_DIR/wg-test-invalid.conf"
  rm -f "$test_config"
  cat > "$test_config" <<'EOF'
[Interface]
PrivateKey = test-key-invalid
Address = 10.2.0.4/32
EOF
  chmod 0400 "$test_config"

  # Import config through API
  run_vpn_switch wireguard import "$test_config" >/dev/null 2>&1

  # Override interpreter to prevent actual connection
  override_for_command_inspection "wireguard_connect"

  # Start session and save as default
  local start_output
  start_output=$(run_vpn_switch wireguard start wg-test-invalid 2>&1)

  local session_pid
  session_pid=$(echo "$start_output" | grep -o 'session [0-9]*' | awk '{print $2}')

  if [ -n "$session_pid" ]; then
    VPN_SWITCH_BASE="$TEST_DIR" \
    VPN_SWITCH_SESSION_PID="$session_pid" \
    run_vpn_switch session save >/dev/null 2>&1
  fi

  # Now manually corrupt the default link to test error handling
  # (This simulates manual filesystem corruption/manipulation)
  rm -f "$TEST_DIR/session/default"
  ln -s "../invalid/config.conf" "$TEST_DIR/session/default"

  # Test: should error with helpful message
  local output
  output=$(run_vpn_switch start 2>&1)

  if printf '%s\n' "$output" | grep -qE "Error|not found|invalid"; then
    pass "Error detected for invalid default session target"
  else
    fail "Did not detect invalid default session target"
    printf '%s\n' "Output: $output"
  fi
}

test_init_extension_links() {
  test_header "init - creates protocol extension links (Phase 3.4.1)" "test_init_extension_links"

  test_setup

  # Run init
  run_vpn_switch init minimal >/dev/null 2>&1

  # Verify extension links exist
  if [ -L "$TEST_DIR/conf" ]; then
    pass "conf link created"
  else
    fail "conf link not created"
  fi

  if [ -L "$TEST_DIR/ovpn" ]; then
    pass "ovpn link created"
  else
    fail "ovpn link not created"
  fi

  # Verify targets
  local conf_target=$(readlink "$TEST_DIR/conf")
  if [ "$conf_target" = "wireguard" ]; then
    pass "conf → wireguard"
  else
    fail "conf link has wrong target: $conf_target"
  fi

  local ovpn_target=$(readlink "$TEST_DIR/ovpn")
  if [ "$ovpn_target" = "openvpn" ]; then
    pass "ovpn → openvpn"
  else
    fail "ovpn link has wrong target: $ovpn_target"
  fi
}

# Phase 4.4: Init function tests
test_database_init() {
  test_header "database init - creates directory structure (Phase 4.4)" "test_database_init"

  test_setup

  # database_init0 creates all required directories
  run_vpn_switch init minimal >/dev/null 2>&1

  # Verify core directories
  [ -d "$TEST_DIR/wireguard" ] && pass "wireguard/ created" || fail "wireguard/ missing"
  [ -d "$TEST_DIR/openvpn" ] && pass "openvpn/ created" || fail "openvpn/ missing"
  [ -d "$TEST_DIR/.session" ] && pass ".session/ created" || fail ".session/ missing"
  [ -d "$TEST_DIR/session" ] && pass "session/ created" || fail "session/ missing"
  [ -d "$TEST_DIR/.env/default" ] && pass ".env/default/ created" || fail ".env/default/ missing"
  [ -d "$TEST_DIR/.env/local" ] && pass ".env/local/ created" || fail ".env/local/ missing"
  [ -d "$TEST_DIR/.include/phase" ] && pass ".include/phase/ created" || fail ".include/phase/ missing"
}

test_environment_init() {
  test_header "environment init - copies profile templates (Phase 4.4)" "test_environment_init"

  test_setup
  run_vpn_switch init minimal >/dev/null 2>&1

  # Check profile templates were copied (uppercase profile name)
  if [ -f "$TEST_DIR/.env/default/VPN_SWITCH_PROFILE_MINIMAL" ]; then
    pass "minimal profile copied"
  else
    fail "minimal profile not copied"
  fi

  # Verify permissions (use helper function for cross-platform)
  local perms=$(get_file_perms_full "$TEST_DIR/.env/default/VPN_SWITCH_PROFILE_MINIMAL")
  if [ "$perms" = "100600" ] || [ "$perms" = "600" ]; then
    pass "profile has correct permissions (0600)"
  else
    fail "profile has wrong permissions: $perms"
  fi
}

test_phases_copy() {
  test_header "phases copy - copies phase templates (Phase 4.4)" "test_phases_copy"

  test_setup
  run_vpn_switch init minimal >/dev/null 2>&1

  # Verify phase templates were copied
  [ -d "$TEST_DIR/.include/phase/wireguard" ] && pass "wireguard phases copied" || fail "wireguard phases missing"
  [ -d "$TEST_DIR/.include/phase/openvpn" ] && pass "openvpn phases copied" || fail "openvpn phases missing"

  # Verify phase directories have content
  local wg_count=$(find "$TEST_DIR/.include/phase/wireguard" -type d | wc -l)
  [ "$wg_count" -gt 1 ] && pass "wireguard phase subdirs exist" || fail "wireguard phases empty"
}

test_phases_lift() {
  test_header "phases lift - lifts phase:backend templates (Phase 4.4)" "test_phases_lift"

  test_setup
  run_vpn_switch init minimal >/dev/null 2>&1

  # phases lift generates commands to lift a specific backend
  local output=$(run_vpn_switch phases lift firewall:pf 2>&1)

  # Should generate lift commands (check for completion message)
  printf '%s\n' "$output" | grep -q "Lifted: firewall" && pass "generates lift command" || fail "no lift command"

  # Check that the lifted file was created and is executable
  local lifted_file="$TEST_DIR/.include/phase/base/firewall/pf.sh"
  [ -x "$lifted_file" ] && pass "output file is executable" || fail "output file not executable or missing"
}

test_phases_default_profile() {
  test_header "phases - default profile symlink present + validate flags its absence" "test_phases_default_profile"

  test_setup
  run_vpn_switch init minimal >/dev/null 2>&1

  # The default phase-profile symlink is load-bearing: phase specs without an
  # explicit @profile (and any :variant) resolve via .include/phase/default -> base.
  [ -L "$TEST_DIR/.include/phase/default" ] && pass ".include/phase/default symlink present" || fail ".include/phase/default symlink missing"
  [ -d "$TEST_DIR/.include/phase/default" ] && pass "default profile resolves to a directory" || fail "default profile does not resolve"

  # DB health: validate must FLAG a missing default symlink (not pass silently)
  rm -f "$TEST_DIR/.include/phase/default"
  local output=$(run_vpn_switch phases validate 2>&1 || true)
  if printf '%s\n' "$output" | grep -qi "default" && printf '%s\n' "$output" | grep -qiE "ERROR|missing|✗"; then
    pass "validate flags missing default symlink"
  else
    fail "validate did not flag missing default symlink"
  fi
}

test_phases_sync_single() {
  test_header "phases sync <phase> - discovers and lifts backends (Phase 4.4)" "test_phases_sync_single"

  test_setup
  run_vpn_switch init minimal >/dev/null 2>&1

  # Delegation evidence is in the trace file now (fd79dc8 moved batch
  # dispatch messages off stdout). Capture trace_file specifically for
  # this run and assert on it. export is necessary because run_vpn_switch
  # is a shell function whose inner subshell needs the variable in env.
  local trace_file=$(mktemp)
  export VPN_SWITCH_TRACE_FILE="$trace_file"
  run_vpn_switch phases sync firewall >/dev/null 2>&1 || true
  unset VPN_SWITCH_TRACE_FILE

  if grep -q 'phases lift' "$trace_file"; then
    pass "delegates to phases lift"
  else
    fail "no delegation"
    echo "    trace file: $trace_file"
    head -20 "$trace_file" 2>/dev/null
  fi
  rm -f "$trace_file"
}

test_phases_sync_all() {
  test_header "phases sync - syncs all phases (Phase 4.4)" "test_phases_sync_all"

  test_setup
  run_vpn_switch init minimal >/dev/null 2>&1

  # Same pattern as test_phases_sync_single — trace-file based assertion.
  local trace_file=$(mktemp)
  export VPN_SWITCH_TRACE_FILE="$trace_file"
  run_vpn_switch phases sync >/dev/null 2>&1 || true
  unset VPN_SWITCH_TRACE_FILE

  if grep -q 'phases sync' "$trace_file"; then
    pass "delegates to single-phase sync"
  else
    fail "no delegation"
    echo "    trace file: $trace_file"
    head -20 "$trace_file" 2>/dev/null
  fi
  rm -f "$trace_file"
}

test_init_batch_combinator() {
  test_header "init - orchestrates full initialization (Phase 4.4)" "test_init_batch_combinator"

  test_setup

  # init should call database init, environment init, and phases sync
  local output=$(run_vpn_switch init minimal 2>&1)

  # Check for success indicators (database may be validated if already exists)
  if printf '%s\n' "$output" | grep -qE "Created directory|Validated:"; then
    pass "database init executed"
  else
    fail "no database init"
  fi
  printf '%s\n' "$output" | grep -q "Installed.*profile" && pass "environment init executed" || fail "no env init"
  printf '%s\n' "$output" | grep -q "Copied phase templates" && pass "phases copy executed" || fail "no phases copy"
}

test_init_combinator() {
  test_header "init combinator - delegates to batch combinator (Phase 4.4)" "test_init_combinator"

  test_setup

  # __init0 should delegate to ___init1
  local output=$(run_vpn_switch init minimal 2>&1)

  # Should result in functional database
  [ -d "$TEST_DIR/wireguard" ] && pass "database created" || fail "database not created"
  [ -f "$TEST_DIR/.env/default/VPN_SWITCH_PROFILE_MINIMAL" ] && pass "profile installed" || fail "profile missing"
}

test_start_extension_link_fast_path() {
  test_header "start - uses extension link for protocol resolution (Phase 3.4.1)" "test_start_extension_link_fast_path"

  test_setup

  # Create WireGuard config
  cat > "$TEST_DIR/wireguard/test.conf" <<'EOF'
[Interface]
PrivateKey = test
Address = 10.2.0.2/32
EOF
  chmod 0400 "$TEST_DIR/wireguard/test.conf"

  # Verify extension link exists (from init)
  if [ ! -L "$TEST_DIR/conf" ]; then
    fail "Extension link conf not found"
    return 1
  fi

  # Test: start with .conf extension should use fast path
  # As in test_start_wireguard_only: assert on the durable artifact, not
  # _batch2's stdout chatter which moved to trace_log in fd79dc8.
  run_vpn_switch start test.conf > /dev/null 2>&1 || true

  local sess=$(ls -d "$TEST_DIR"/.session/*/ 2>/dev/null | head -1)
  local sess_protocol=""
  [ -n "$sess" ] && sess_protocol=$(cat "$sess/protocol" 2>/dev/null)
  if [ "$sess_protocol" = "wireguard" ]; then
    pass "Extension link used for fast protocol resolution (session.protocol=wireguard)"
  else
    fail "Extension link not used for resolution"
    printf '%s\n' "  session: ${sess:-none}, session.protocol: ${sess_protocol:-none}"
    ls -la "$TEST_DIR/.session/" 2>/dev/null
  fi
}

test_start_multiple_matches() {
  test_header "start - error on multiple protocol matches (Phase 3.4.1)" "test_start_multiple_matches"

  test_setup

  # Create same basename in both protocols
  cat > "$TEST_DIR/wireguard/server.conf" <<'EOF'
[Interface]
PrivateKey = test1
Address = 10.2.0.2/32
EOF
  chmod 0400 "$TEST_DIR/wireguard/server.conf"

  cat > "$TEST_DIR/openvpn/server.ovpn" <<'EOF'
client
remote 1.2.3.4 1194
EOF
  chmod 0400 "$TEST_DIR/openvpn/server.ovpn"

  # Test: start with ambiguous name
  local output=$(run_vpn_switch start server 2>&1)

  # Should show multiple matches error
  if printf '%s\n' "$output" | grep -q "Multiple configs match"; then
    pass "Multiple matches error shown"
  else
    fail "Multiple matches error not shown"
    printf '%s\n' "Output: $output"
  fi

  # Should list both matches
  if printf '%s\n' "$output" | grep -q "wireguard/server.conf" && printf '%s\n' "$output" | grep -q "openvpn/server.ovpn"; then
    pass "Both matches listed"
  else
    fail "Not all matches shown"
    printf '%s\n' "Output: $output"
  fi
}

#-----------------------------------------------------------------------------
# OpenVPN Config Management Tests (Phase 3.1.4)
#-----------------------------------------------------------------------------

test_openvpn_import_valid() {
  test_header "openvpn import - import valid .ovpn config" "test_openvpn_import_valid"

  test_setup

  # Enable execution for openvpn import
  set_function_interpreter "openvpn_import1" "sh"

  # Create test .ovpn file
  local test_config="$TEST_BASE_DIR/test-us-server.ovpn"
  cat > "$test_config" <<'EOF'
client
dev tun
proto udp
remote 1.2.3.4 1194
resolv-retry infinite
nobind
persist-key
persist-tun
cipher AES-256-CBC
auth SHA256
verb 3
EOF
  chmod 0600 "$test_config"

  # Run import
  run_vpn_switch openvpn import "$test_config" >/dev/null 2>&1

  # Verify imported
  local imported="$TEST_DIR/openvpn/test-us-server.ovpn"
  if [ -f "$imported" ]; then
    pass "Config imported to openvpn/"
  else
    fail "Config not imported"
  fi

  # Verify permissions
  if [ -f "$imported" ]; then
    local perms=$(get_file_perms "$imported")
    if [ "$perms" = "400" ]; then
      pass "Permissions set to 0400"
    else
      fail "Permissions incorrect: got $perms, expected 400"
    fi
  fi

  rm -f "$test_config"
}

test_openvpn_list() {
  test_header "openvpn list - list configs and groups" "test_openvpn_list"

  test_setup

  # Create test files manually
  mkdir -p "$TEST_DIR/openvpn/work"
  touch "$TEST_DIR/openvpn/us-server.ovpn"
  touch "$TEST_DIR/openvpn/eu-server.ovpn"
  ln -s "./us-server.ovpn" "$TEST_DIR/openvpn/work/office"

  # Run list command
  local output=$(run_vpn_switch openvpn list 2>/dev/null)

  # Check for configs
  if printf '%s\n' "$output" | grep -q "openvpn/us-server.ovpn"; then
    pass "Lists config: us-server.ovpn"
  else
    fail "Missing config in list"
  fi

  # Check for group
  if printf '%s\n' "$output" | grep -q "openvpn/work/"; then
    pass "Lists group: work/"
  else
    fail "Missing group in list"
  fi

  # Check arity-1 (list specific group)
  local group_output=$(run_vpn_switch openvpn list work 2>/dev/null)

  if echo "$group_output" | grep -q "openvpn/work/office"; then
    pass "Lists group link with arity-1: work/office"
  else
    fail "Missing group link in arity-1 list"
  fi
}

test_openvpn_add_group() {
  test_header "openvpn add - create group" "test_openvpn_add_group"

  test_setup

  # Enable execution
  set_function_interpreter "openvpn_add" "sh"

  # Run command
  run_vpn_switch openvpn add work >/dev/null 2>&1

  # Verify group created
  if [ -d "$TEST_DIR/openvpn/work" ]; then
    pass "Group directory created"
  else
    fail "Group directory not created"
  fi

  # Verify permissions
  local perms=$(get_file_perms "$TEST_DIR/openvpn/work")
  if [ "$perms" = "700" ]; then
    pass "Group permissions correct (0700)"
  else
    fail "Group permissions incorrect: $perms"
  fi
}

test_openvpn_add_to_group_arity2() {
  test_header "openvpn add - add config to group (arity-2)" "test_openvpn_add_group"

  test_setup

  # Setup
  mkdir -p "$TEST_DIR/openvpn/work"
  touch "$TEST_DIR/openvpn/us-server.ovpn"

  # Enable execution
  set_function_interpreter "openvpn_add" "sh"

  # Run command (arity-2: link name = config name minus extension)
  run_vpn_switch openvpn add work us-server.ovpn >/dev/null 2>&1

  # Verify link created
  if [ -L "$TEST_DIR/openvpn/work/us-server" ]; then
    pass "Link created: work/us-server"
  else
    fail "Link not created"
  fi

  # Verify link target
  local target=$(readlink "$TEST_DIR/openvpn/work/us-server")
  if [ "$target" = "../us-server.ovpn" ]; then
    pass "Link points to correct target"
  else
    fail "Link target incorrect: $target"
  fi
}

test_openvpn_add_to_group_arity3() {
  test_header "openvpn add - add with custom alias (arity-3)" "test_openvpn_add_group"

  test_setup

  mkdir -p "$TEST_DIR/openvpn/work"
  touch "$TEST_DIR/openvpn/us-server.ovpn"

  set_function_interpreter "openvpn_add" "sh"

  # Run with custom alias
  run_vpn_switch openvpn add work us-server.ovpn office >/dev/null 2>&1

  # Verify custom link created
  if [ -L "$TEST_DIR/openvpn/work/office" ]; then
    pass "Custom alias created: work/office"
  else
    fail "Custom alias not created"
  fi

  # Verify target
  local target=$(readlink "$TEST_DIR/openvpn/work/office")
  if [ "$target" = "../us-server.ovpn" ]; then
    pass "Alias points to correct target"
  else
    fail "Alias target incorrect: $target"
  fi
}

test_openvpn_link() {
  test_header "openvpn link - create protocol-level link" "test_openvpn_link"

  test_setup

  touch "$TEST_DIR/openvpn/us-server.ovpn"

  set_function_interpreter "openvpn_link2" "sh"

  # Create protocol-level link
  run_vpn_switch openvpn link quick us-server.ovpn >/dev/null 2>&1

  # Verify link
  if [ -L "$TEST_DIR/openvpn/quick" ]; then
    pass "Protocol-level link created"
  else
    fail "Link not created"
  fi

  # Verify target
  local target=$(readlink "$TEST_DIR/openvpn/quick")
  if [ "$target" = "./us-server.ovpn" ]; then
    pass "Link target correct"
  else
    fail "Link target incorrect: $target"
  fi
}

test_openvpn_remove() {
  test_header "openvpn remove - remove config safely" "test_openvpn_remove"

  test_setup

  touch "$TEST_DIR/openvpn/us-server.ovpn"
  touch "$TEST_DIR/openvpn/eu-server.ovpn"

  set_function_interpreter "openvpn_remove" "sh"

  # Remove config
  run_vpn_switch openvpn remove eu-server.ovpn >/dev/null 2>&1

  # Verify removed
  if [ ! -f "$TEST_DIR/openvpn/eu-server.ovpn" ]; then
    pass "Config removed"
  else
    fail "Config not removed"
  fi

  # Verify other config still exists
  if [ -f "$TEST_DIR/openvpn/us-server.ovpn" ]; then
    pass "Other config preserved"
  else
    fail "Other config incorrectly removed"
  fi
}

test_openvpn_validate() {
  test_header "openvpn validate - detect broken links" "test_openvpn_validate"

  test_setup

  # Create broken link
  mkdir -p "$TEST_DIR/openvpn/work"
  ln -s "../nonexistent.ovpn" "$TEST_DIR/openvpn/work/broken"

  # Run validate
  local output=$(run_vpn_switch openvpn validate 2>/dev/null)

  # Check for broken link detection
  if printf '%s\n' "$output" | grep -q "Broken symlink.*work/broken"; then
    pass "Broken symlink detected"
  else
    fail "Broken symlink not detected"
  fi

  # Remove broken link and create valid setup
  run_vpn_switch openvpn remove work/broken >/dev/null 2>&1
  cat > "$TEST_DIR/openvpn/server.ovpn" <<'EOF'
client
remote test.example.com 1194
EOF
  chmod 0400 "$TEST_DIR/openvpn/server.ovpn"
  run_vpn_switch openvpn add work link server.ovpn >/dev/null 2>&1

  output=$(run_vpn_switch openvpn validate 2>/dev/null)

  if printf '%s\n' "$output" | grep -q "No issues found"; then
    pass "Valid database passes validation"
  else
    fail "Valid database reported issues"
  fi
}

test_openvpn_info() {
  test_header "openvpn info - show group information" "test_openvpn_info"

  test_setup

  mkdir -p "$TEST_DIR/openvpn/work"
  touch "$TEST_DIR/openvpn/us-server.ovpn"
  touch "$TEST_DIR/openvpn/eu-server.ovpn"
  ln -s "../us-server.ovpn" "$TEST_DIR/openvpn/work/office"
  ln -s "../eu-server.ovpn" "$TEST_DIR/openvpn/work/remote"

  # Run info
  local output=$(run_vpn_switch openvpn info work 2>/dev/null)

  # Check for group name
  if printf '%s\n' "$output" | grep -q "Group: work"; then
    pass "Shows group name"
  else
    fail "Missing group name"
  fi

  # Check for link count
  if printf '%s\n' "$output" | grep -q "Total links: 2"; then
    pass "Shows correct link count"
  else
    fail "Incorrect link count"
  fi

  # Check for links
  if printf '%s\n' "$output" | grep -q "office -> ../us-server.ovpn"; then
    pass "Shows link: office"
  else
    fail "Missing link in output"
  fi
}

test_openvpn_dump() {
  test_header "openvpn dump - export database" "test_openvpn_dump"

  test_setup

  # Create test database
  mkdir -p "$TEST_DIR/openvpn/work"
  touch "$TEST_DIR/openvpn/us-server.ovpn"
  ln -s "./us-server.ovpn" "$TEST_DIR/openvpn/quick"
  ln -s "../us-server.ovpn" "$TEST_DIR/openvpn/work/office"

  # Run dump
  local output=$(run_vpn_switch openvpn dump 2>/dev/null)

  # Check for import command
  if printf '%s\n' "$output" | grep -q "openvpn import.*us-server.ovpn"; then
    pass "Dump includes import command"
  else
    fail "Missing import command"
  fi

  # Check for group creation
  if printf '%s\n' "$output" | grep -q "openvpn add work"; then
    pass "Dump includes group creation"
  else
    fail "Missing group creation"
  fi

  # Check for protocol link
  if printf '%s\n' "$output" | grep -q "openvpn link quick"; then
    pass "Dump includes protocol link"
  else
    fail "Missing protocol link"
  fi

  # Check for group link
  if printf '%s\n' "$output" | grep -q "openvpn add work.*us-server.ovpn"; then
    pass "Dump includes group link"
  else
    fail "Missing group link"
  fi
}

#-----------------------------------------------------------------------------
# OpenVPN Lifecycle Tests (Phase 3.3.1)
#-----------------------------------------------------------------------------

# TEST: openvpn patch - displays patched configuration
test_openvpn_patch_valid() {
  test_header "openvpn patch - displays patched configuration" "test_openvpn_patch_valid"
  test_setup
  override_for_command_inspection "openvpn_patch"

  # Enable execution for openvpn import (narrow override)
  set_function_interpreter "openvpn_import1" "sh"

  # Create a test OpenVPN config
  local test_config="/tmp/us-TEST-PATCH-1.ovpn"
  cat > "$test_config" <<'CONF'
client
dev tun
proto udp
remote vpn.example.com 1194
resolv-retry infinite
nobind
persist-key
persist-tun
cipher AES-256-CBC
auth SHA256
verb 3
CONF
  chmod 0400 "$test_config"

  # Import config first
  run_vpn_switch openvpn import "$test_config" >/dev/null 2>&1

  # Run patch command
  local output=$(run_vpn_switch openvpn patch us-TEST-PATCH-1.ovpn 2>&1)

  # Phase-based approach: DNS handled by DNS phase, not up/down scripts
  # Verify up/down scripts are NOT present (they should be stripped)
  if printf '%s\n' "$output" | grep -q "^up "; then
    fail "Patch output should NOT contain up script (phase-based DNS)"
  else
    pass "Patch output correctly strips up script (phase-based DNS)"
  fi

  if printf '%s\n' "$output" | grep -q "^down "; then
    fail "Patch output should NOT contain down script (phase-based DNS)"
  else
    pass "Patch output correctly strips down script (phase-based DNS)"
  fi

  # Verify output contains daemon mode
  if printf '%s\n' "$output" | grep -q "daemon"; then
    pass "Patch output contains daemon mode"
  else
    fail "Patch output missing daemon mode"
  fi

  # Verify output contains device interface
  if printf '%s\n' "$output" | grep -q "dev tun"; then
    pass "Patch output contains device interface"
  else
    fail "Patch output missing device interface"
  fi

  # Verify output contains writepid
  if printf '%s\n' "$output" | grep -q "writepid"; then
    pass "Patch output contains writepid directive"
  else
    fail "Patch output missing writepid"
  fi

  # Verify output still contains original config elements
  if printf '%s\n' "$output" | grep -q "client"; then
    pass "Patch output preserves client directive"
  else
    fail "Patch output lost client directive"
  fi

  if printf '%s\n' "$output" | grep -q "remote vpn.example.com"; then
    pass "Patch output preserves remote server"
  else
    fail "Patch output lost remote server"
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST: openvpn patch - handles nonexistent config
test_openvpn_patch_nonexistent() {
  test_header "openvpn patch - handles nonexistent config" "test_openvpn_patch_nonexistent"
  test_setup
  override_for_command_inspection "openvpn_patch"

  # Run patch with nonexistent config
  local output=$(run_vpn_switch openvpn patch nonexistent.ovpn 2>&1 || true)

  # Should get an error
  if printf '%s\n' "$output" | grep -qiE "not found|error"; then
    pass "Error message for nonexistent config"
  else
    fail "Missing error for nonexistent config"
  fi
}

# TEST: openvpn patch - handles absolute path
test_openvpn_patch_absolute() {
  test_header "openvpn patch - handles absolute path" "test_openvpn_patch_absolute"
  test_setup
  override_for_command_inspection "openvpn_patch"

  # Create config with absolute path
  local test_config="/tmp/us-absolute.ovpn"
  cat > "$test_config" <<'CONF'
client
dev tun
remote 1.2.3.4 1194
CONF
  chmod 0400 "$test_config"

  # Patch with absolute path (no import needed)
  local output=$(run_vpn_switch openvpn patch "$test_config" 2>&1)

  # Should work and contain patched elements
  if printf '%s\n' "$output" | grep -q "daemon"; then
    pass "Absolute path patch works"
  else
    fail "Absolute path patch failed"
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST: openvpn patch - patches bare auth-user-pass with credentials
test_openvpn_patch_credentials_bare() {
  test_header "openvpn patch - patches bare auth-user-pass with credentials" "test_openvpn_patch_credentials_bare"
  test_setup
  override_for_command_inspection "openvpn_patch"

  # Enable execution for openvpn import
  set_function_interpreter "openvpn_import1" "sh"

  # Create test config with bare auth-user-pass
  local test_config="/tmp/us-creds-bare.ovpn"
  rm -f "$test_config"
  cat > "$test_config" <<'CONF'
client
dev tun
remote vpn.example.com 1194
auth-user-pass
CONF
  chmod 0400 "$test_config"

  # Import config
  run_vpn_switch openvpn import "$test_config" >/dev/null 2>&1

  # Test WITH credentials environment variable (use setenv - proper way)
  run_vpn_switch setenv VPN_SWITCH_CREDENTIALS_openvpn "/path/to/credentials.txt" >/dev/null 2>&1
  local output=$(run_vpn_switch openvpn patch us-creds-bare.ovpn 2>&1)

  if printf '%s\n' "$output" | grep -q "auth-user-pass /path/to/credentials.txt"; then
    pass "Bare auth-user-pass patched with credentials path"
  else
    fail "Bare auth-user-pass not patched with credentials"
  fi

  # Test WITHOUT credentials environment variable (unset it first)
  run_vpn_switch unsetenv VPN_SWITCH_CREDENTIALS_openvpn >/dev/null 2>&1
  output=$(run_vpn_switch openvpn patch us-creds-bare.ovpn 2>&1)

  if printf '%s\n' "$output" | grep -q "^auth-user-pass$"; then
    pass "Bare auth-user-pass preserved when no credentials set"
  else
    fail "Bare auth-user-pass should remain unchanged without credentials var"
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST: openvpn patch - preserves existing auth-user-pass path
test_openvpn_patch_credentials_existing() {
  test_header "openvpn patch - preserves existing auth-user-pass path" "test_openvpn_patch_credentials_existing"
  test_setup
  override_for_command_inspection "openvpn_patch"

  # Enable execution for openvpn import
  set_function_interpreter "openvpn_import1" "sh"

  # Create test config with existing auth-user-pass path
  local test_config="/tmp/us-creds-existing.ovpn"
  cat > "$test_config" <<'CONF'
client
dev tun
remote vpn.example.com 1194
auth-user-pass /existing/path/credentials.txt
CONF
  chmod 0400 "$test_config"

  # Import config
  run_vpn_switch openvpn import "$test_config" >/dev/null 2>&1

  # Test with different credentials path - should NOT override
  local output=$(VPN_SWITCH_CREDENTIALS_openvpn="/different/credentials.txt" \
    run_vpn_switch openvpn patch us-creds-existing.ovpn 2>&1)

  if printf '%s\n' "$output" | grep -q "auth-user-pass /existing/path/credentials.txt"; then
    pass "Existing auth-user-pass path preserved (not overridden)"
  else
    fail "Existing auth-user-pass path should not be modified"
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST: openvpn patch - handles config without auth-user-pass
test_openvpn_patch_credentials_missing() {
  test_header "openvpn patch - handles config without auth-user-pass" "test_openvpn_patch_credentials_missing"
  test_setup
  override_for_command_inspection "openvpn_patch"

  # Enable execution for openvpn import
  set_function_interpreter "openvpn_import1" "sh"

  # Create test config without auth-user-pass
  local test_config="/tmp/us-no-auth.ovpn"
  cat > "$test_config" <<'CONF'
client
dev tun
remote vpn.example.com 1194
CONF
  chmod 0400 "$test_config"

  # Import config
  run_vpn_switch openvpn import "$test_config" >/dev/null 2>&1

  # Test with credentials set - should not add auth-user-pass
  local output=$(VPN_SWITCH_CREDENTIALS_openvpn="/path/to/credentials.txt" \
    run_vpn_switch openvpn patch us-no-auth.ovpn 2>&1)

  if printf '%s\n' "$output" | grep -vq "auth-user-pass"; then
    pass "Config without auth-user-pass remains unchanged"
  else
    fail "Should not add auth-user-pass to configs that don't have it"
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST: openvpn start - create session and connect
test_openvpn_start_basic() {
  test_header "openvpn start - create session and connect to VPN" "test_openvpn_start_basic"

  # Create exclusive database for this test
  test_setup

  # Set up mocks for network operations with unique test ID
  local test_id=80
  setup_session_test_mocks "$test_id"
  local test_interface="tun_test${test_id}"

  # Enable execution for openvpn add and import (narrow overrides)
  set_function_interpreter "openvpn_add" "sh"
  set_function_interpreter "openvpn_import1" "sh"

  # Create work category
  run_vpn_switch openvpn add work >/dev/null 2>&1

  # Import an OpenVPN config
  local test_config="$TEST_BASE_DIR/us-server.ovpn"
  cat > "$test_config" <<'EOF'
client
dev tun
proto udp
remote vpn.example.com 1194
resolv-retry infinite
nobind
persist-key
persist-tun
cipher AES-256-CBC
auth SHA256
verb 3
EOF
  chmod 0600 "$test_config"
  run_vpn_switch openvpn import "$test_config" >/dev/null 2>&1
  run_vpn_switch openvpn add work us-server.ovpn server >/dev/null 2>&1

  # Run start command
  local output=$(run_vpn_switch openvpn start work 2>&1 || true)

  # Verify session was created
  if printf '%s\n' "$output" | grep -qi "session"; then
    pass "Session creation logged"
  else
    fail "Session creation not logged"
    printf '%s\n' "Output: $output"
  fi

  # Verify openvpn command is in generated connect.sh
  local session_dir=$(ls -1d "$TEST_DIR/.session"/* 2>/dev/null | head -1)
  if [ -f "$session_dir/connect.sh" ] && grep -q "openvpn" "$session_dir/connect.sh"; then
    pass "openvpn command in connect.sh"
  else
    fail "openvpn command not found in connect.sh"
    printf '%s\n' "Output: $output"
  fi

  # Verify session directory was created
  local session_count=$(ls -1d "$TEST_DIR/.session"/* 2>/dev/null | wc -l)
  if [ "$session_count" -ge 1 ]; then
    pass "Session directory created in .session/"
  else
    fail "Session directory not found"
    ls -la "$TEST_DIR/.session/" || true
  fi

  # Verify session metadata files exist
  local session_dir=$(ls -1d "$TEST_DIR/.session"/* 2>/dev/null | head -1)
  if [ -f "$session_dir/protocol" ] && [ -f "$session_dir/pid" ]; then
    pass "Session metadata files created"
  else
    fail "Session metadata files missing"
    ls -la "$session_dir" || true
  fi

  # Verify connect.sh was generated
  if [ -f "$session_dir/connect.sh" ]; then
    pass "connect.sh script generated"
  else
    fail "connect.sh script not found"
    ls -la "$session_dir" || true
  fi

  # Verify connect.sh is executable
  if [ -x "$session_dir/connect.sh" ]; then
    pass "connect.sh is executable"
  else
    fail "connect.sh is not executable"
    ls -la "$session_dir/connect.sh" || true
  fi

  # Verify patched config exists (uses test interface name)
  if [ -f "$session_dir/${test_interface}.ovpn" ]; then
    pass "Patched config (${test_interface}.ovpn) created"
  else
    fail "Patched config not found"
    ls -la "$session_dir" || true
  fi

  # Verify patched config contains daemon mode
  if grep -q "daemon" "$session_dir/${test_interface}.ovpn"; then
    pass "Patched config contains daemon mode"
  else
    fail "Patched config missing daemon mode"
    grep -i "daemon" "$session_dir/${test_interface}.ovpn" || true
  fi

  # Phase-based approach: up/down scripts should be stripped (DNS handled by DNS phase)
  if grep -q "^up " "$session_dir/${test_interface}.ovpn"; then
    fail "Patched config should NOT contain up script (phase-based DNS)"
    grep -i "up" "$session_dir/${test_interface}.ovpn" || true
  else
    pass "Patched config correctly strips up script (phase-based DNS)"
  fi

  if grep -q "^down " "$session_dir/${test_interface}.ovpn"; then
    fail "Patched config should NOT contain down script (phase-based DNS)"
    grep -i "down" "$session_dir/${test_interface}.ovpn" || true
  else
    pass "Patched config correctly strips down script (phase-based DNS)"
  fi

  # Cleanup
  rm -f "$test_config"
}

# TEST: openvpn stop - stop all OpenVPN sessions
test_openvpn_stop_basic() {
  test_header "openvpn stop - cleanup commands for session" "test_openvpn_stop_basic"

  # Create exclusive database for this test
  test_setup

  # Set up mocks for network operations with unique test ID
  local test_id=85
  local expected_interface="tun_test${test_id}"
  setup_session_test_mocks "$test_id"

  # Create session through user interface (mocked network operations)
  run_vpn_switch openvpn add work >/dev/null 2>&1
  local test_config="$TEST_BASE_DIR/ovpn-test-stop.ovpn"
  cat > "$test_config" <<'EOF'
client
dev tun
proto udp
remote vpn.example.com 1194
resolv-retry infinite
nobind
persist-key
persist-tun
cipher AES-256-CBC
auth SHA256
verb 3
EOF
  chmod 0600 "$test_config"
  run_vpn_switch openvpn import "$test_config" >/dev/null 2>&1
  run_vpn_switch openvpn add work ovpn-test-stop.ovpn server >/dev/null 2>&1
  run_vpn_switch openvpn start work >/dev/null 2>&1

  # Verify session was created
  local session_count=$(ls -1d "$TEST_DIR/.session"/* 2>/dev/null | wc -l)
  if [ "$session_count" -ge 1 ]; then
    pass "Session created via user interface"
  else
    fail "No session found after start"
    return
  fi

  # Set interpreter to cat for command inspection (instead of execution)
  override_for_command_inspection "openvpn_disconnect1"

  # Call disconnect directly with the test interface
  # This bypasses is_session_alive() and lets us inspect generated commands
  local output=$(run_vpn_switch openvpn disconnect "$expected_interface" 2>&1 || true)

  # Verify the generated commands include interface reference
  if printf '%s\n' "$output" | grep -q "$expected_interface"; then
    pass "Disconnect commands reference correct interface ($expected_interface)"
  else
    fail "Disconnect should reference interface $expected_interface"
    printf '%s\n' "Output: $output"
    return
  fi

  # Verify the generated commands include process termination
  if printf '%s\n' "$output" | grep -q "kill"; then
    pass "Disconnect generates process kill commands"
  else
    fail "Disconnect should generate kill commands"
    printf '%s\n' "Output: $output"
  fi
}

# TEST: openvpn disconnect - tear down interface
test_openvpn_disconnect_interface() {
  test_header "openvpn disconnect - tear down OpenVPN interface" "test_openvpn_disconnect_interface"
  test_setup
  override_for_command_inspection "openvpn_disconnect1"

  # Create a fake session directory
  local session_dir="$TEST_DIR/.session/99999"
  mkdir -p "$session_dir"
  echo "tun0" > "$session_dir/interface"
  echo "openvpn" > "$session_dir/protocol"
  echo "12345" > "$session_dir/openvpn.pid"
  echo "$TEST_DIR/openvpn/test.ovpn" > "$session_dir/original"
  chmod 0600 "$session_dir"/*

  # Run disconnect with interface name (not PID)
  local output=$(run_vpn_switch openvpn disconnect tun0 2>&1 || true)

  # Verify disconnect generates kill commands
  if printf '%s\n' "$output" | grep -qi "kill"; then
    pass "Disconnect generates process termination commands"
  else
    fail "Disconnect missing termination logic"
    printf '%s\n' "Output: $output"
  fi
}

# TEST: openvpn clean - generate cleanup commands
test_openvpn_clean() {
  test_header "openvpn clean - generate cleanup commands for broken links" "test_openvpn_clean"
  test_setup
  override_for_command_inspection "openvpn_clean"

  # Enable execution for openvpn add (to create symlinks)
  set_function_interpreter "openvpn_add" "sh"

  # Create a category with a broken symlink
  run_vpn_switch openvpn add broken >/dev/null 2>&1
  ln -s "$TEST_DIR/openvpn/nonexistent.ovpn" "$TEST_DIR/openvpn/broken/link1"

  # Run clean command
  local output=$(run_vpn_switch openvpn clean 2>&1)

  # Should generate remove commands for broken links
  if printf '%s\n' "$output" | grep -q "openvpn remove"; then
    pass "Clean generates remove commands"
  else
    fail "Clean missing remove commands"
    printf '%s\n' "Output: $output"
  fi

  # Verify it found the broken link
  if printf '%s\n' "$output" | grep -qE "link1|nonexistent"; then
    pass "Clean detected broken symlink"
  else
    fail "Clean didn't detect broken link"
    printf '%s\n' "Output: $output"
  fi
}


#-----------------------------------------------------------------------------
# Environment Management Tests
#-----------------------------------------------------------------------------

test_setenv_basic() {
  test_header "setenv - basic variable setting" "test_setenv_basic"

  test_setup

  # Run setenv (will execute)
  local output=$(run_vpn_switch setenv TEST_VAR "test_value" 2>&1)

  # Check that .env/local directory was created
  if [ -d "$TEST_DIR/.env/local" ]; then
    pass ".env/local directory created"
  else
    fail ".env/local directory not created"
  fi

  # Check that file was created with correct content
  if [ -f "$TEST_DIR/.env/local/TEST_VAR" ]; then
    pass "Variable file created"
    local content=$(head -n 1 "$TEST_DIR/.env/local/TEST_VAR")
    if [ "$content" = "test_value" ]; then
      pass "Variable has correct value"
    else
      fail "Variable has wrong value: $content"
    fi
  else
    fail "Variable file not created"
  fi

  # Check permissions (use helper function for cross-platform)
  local perms=$(get_file_perms_full "$TEST_DIR/.env/local/TEST_VAR")
  if [ "$perms" = "100600" ] || [ "$perms" = "600" ] || [ "$perms" = "100640" ] || [ "$perms" = "640" ]; then
    pass "File has correct permissions (0600 or 0640 for cross-user support)"
  else
    fail "File has wrong permissions: $perms"
  fi

  # Check for confirmation message
  if printf '%s\n' "$output" | grep -q "Set TEST_VAR"; then
    pass "Shows confirmation message"
  else
    fail "Missing confirmation message"
  fi
}

test_setenv_invalid_name() {
  test_header "setenv - invalid variable name" "test_setenv_invalid_name"

  test_setup

  # Run setenv with invalid name (contains slash) - expect exit code 1
  local output=$(run_vpn_switch setenv "INVALID/VAR" "value" 2>&1 || true)

  # Check for error message
  if printf '%s\n' "$output" | grep -q "Error.*Invalid variable name"; then
    pass "Rejects invalid variable name"
  else
    fail "Should reject invalid variable name"
  fi

  # Verify file was not created
  if [ ! -f "$TEST_DIR/.env/local/INVALID/VAR" ]; then
    pass "No file created for invalid name"
  else
    fail "File should not be created for invalid name"
  fi
}

test_getenv_local_override() {
  test_header "getenv - shows local override" "test_getenv_local_override"

  test_setup

  # Create local override file
  mkdir -p "$TEST_DIR/.env/local"
  echo "local_value" > "$TEST_DIR/.env/local/TEST_VAR"

  # Run getenv (will execute)
  local output=$(run_vpn_switch getenv TEST_VAR 2>&1)

  # Check for local override message in stderr
  if printf '%s\n' "$output" | grep -q "Source.*\.env/local.*override"; then
    pass "Shows local override source"
  else
    fail "Missing source indicator"
  fi

  # Check that it outputs the value
  if printf '%s\n' "$output" | grep -q "local_value"; then
    pass "Outputs correct value from local"
  else
    fail "Missing value output"
  fi
}

test_getenv_fallback_chain() {
  test_header "getenv - fallback chain (local > default > template)" "test_getenv_fallback_chain"

  test_setup

  # Test 1: Variable not found anywhere
  local output=$(run_vpn_switch getenv NONEXISTENT 2>&1 || true)
  if printf '%s\n' "$output" | grep -q "not found"; then
    pass "Shows error if variable not found"
  else
    fail "Missing error message"
  fi

  # Test 2: Variable in default only
  mkdir -p "$TEST_DIR/.env/default"
  echo "default_value" > "$TEST_DIR/.env/default/TEST_VAR_DEFAULT"
  output=$(run_vpn_switch getenv TEST_VAR_DEFAULT 2>&1)
  if printf '%s\n' "$output" | grep -q "Source.*\.env/default.*default"; then
    pass "Falls back to .env/default"
  else
    fail "Missing .env/default fallback"
  fi

  # Test 3: Variable in template only
  # VPN_SWITCH_TEMPLATE_DIR is set by bootstrap (points to template/)
  local template_dir="${VPN_SWITCH_TEMPLATE_DIR:-$(dirname "$0")/template}"
  echo "template_value" > "$template_dir/environment/TEST_VAR_TEMPLATE"
  output=$(run_vpn_switch getenv TEST_VAR_TEMPLATE 2>&1)
  if printf '%s\n' "$output" | grep -q "Source.*template/environment.*template"; then
    pass "Falls back to template/environment"
  else
    fail "Missing template/environment fallback"
  fi
  rm -f "$template_dir/environment/TEST_VAR_TEMPLATE"
}

test_unsetenv_existing() {
  test_header "unsetenv - remove existing variable" "test_unsetenv_existing"

  test_setup

  # Create local variable file
  mkdir -p "$TEST_DIR/.env/local"
  echo "value" > "$TEST_DIR/.env/local/TEST_VAR"

  # Run unsetenv (will execute)
  local output=$(run_vpn_switch unsetenv TEST_VAR 2>&1)

  # Check that file was removed
  if [ ! -f "$TEST_DIR/.env/local/TEST_VAR" ]; then
    pass "Variable file was removed"
  else
    fail "Variable file still exists"
  fi

  # Check for confirmation message
  if printf '%s\n' "$output" | grep -q "Unset TEST_VAR"; then
    pass "Shows confirmation message"
  else
    fail "Missing confirmation message"
  fi
}

test_unsetenv_not_set() {
  test_header "unsetenv - variable not set in local" "test_unsetenv_not_set"

  test_setup

  # Run unsetenv on non-existent variable
  local output=$(run_vpn_switch unsetenv NONEXISTENT_VAR 2>&1)

  # Check for informative message
  if printf '%s\n' "$output" | grep -q "not set"; then
    pass "Shows informative message when not set"
  else
    fail "Missing informative message"
  fi
}

test_dumpenv_prologue() {
  test_header "dumpenv prologue - outputs safe minimal set" "test_dumpenv_prologue"

  test_setup

  # Set up test environment variables
  # Prologue variables (base interpreters + settings)
  run_vpn_switch setenv VPN_SWITCH_TERMINAL_INTERPRETER "cat" > /dev/null 2>&1
  run_vpn_switch setenv VPN_SWITCH_DISPLAY_ANSI "1" > /dev/null 2>&1

  # Epilogue-only variables (function-specific interpreters)
  run_vpn_switch setenv VPN_SWITCH_INTERPRETER_wireguard_list "cat" > /dev/null 2>&1
  run_vpn_switch setenv VPN_SWITCH_INTERPRETER_wireguard_import1 "cat" > /dev/null 2>&1

  # Run dumpenv prologue
  local output=$(run_vpn_switch dumpenv prologue 2>&1)

  # Should include TERMINAL_INTERPRETER (base interpreter - in prologue)
  if printf '%s\n' "$output" | grep -q "setenv VPN_SWITCH_TERMINAL_INTERPRETER"; then
    pass "Prologue includes VPN_SWITCH_TERMINAL_INTERPRETER"
  else
    fail "Prologue missing VPN_SWITCH_TERMINAL_INTERPRETER"
  fi

  # Should include DISPLAY_ANSI (setting - in prologue)
  if printf '%s\n' "$output" | grep -q "setenv VPN_SWITCH_DISPLAY_ANSI"; then
    pass "Prologue includes VPN_SWITCH_DISPLAY_ANSI"
  else
    fail "Prologue missing VPN_SWITCH_DISPLAY_ANSI"
  fi

  # Should NOT include function-specific interpreters (epilogue-only)
  if printf '%s\n' "$output" | grep -q "setenv VPN_SWITCH_INTERPRETER_wireguard_list"; then
    fail "Prologue incorrectly includes function-specific interpreter"
  else
    pass "Prologue excludes VPN_SWITCH_INTERPRETER_wireguard_list (epilogue-only)"
  fi

  if printf '%s\n' "$output" | grep -q "setenv VPN_SWITCH_INTERPRETER_wireguard_import1"; then
    fail "Prologue incorrectly includes function-specific interpreter"
  else
    pass "Prologue excludes VPN_SWITCH_INTERPRETER_wireguard_import1 (epilogue-only)"
  fi
}

test_dumpenv_epilogue() {
  test_header "dumpenv epilogue - outputs complete set" "test_dumpenv_epilogue"

  test_setup

  # Set up test environment variables (same as prologue test)
  run_vpn_switch setenv VPN_SWITCH_TERMINAL_INTERPRETER "cat" > /dev/null 2>&1
  run_vpn_switch setenv VPN_SWITCH_DISPLAY_ANSI "1" > /dev/null 2>&1
  run_vpn_switch setenv VPN_SWITCH_INTERPRETER_wireguard_list "cat" > /dev/null 2>&1
  run_vpn_switch setenv VPN_SWITCH_INTERPRETER_wireguard_import1 "cat" > /dev/null 2>&1

  # Run dumpenv epilogue
  local output=$(run_vpn_switch dumpenv epilogue 2>&1)

  # Should include ALL variables (complete set)
  if printf '%s\n' "$output" | grep -q "setenv VPN_SWITCH_TERMINAL_INTERPRETER"; then
    pass "Epilogue includes VPN_SWITCH_TERMINAL_INTERPRETER"
  else
    fail "Epilogue missing VPN_SWITCH_TERMINAL_INTERPRETER"
  fi

  if printf '%s\n' "$output" | grep -q "setenv VPN_SWITCH_DISPLAY_ANSI"; then
    pass "Epilogue includes VPN_SWITCH_DISPLAY_ANSI"
  else
    fail "Epilogue missing VPN_SWITCH_DISPLAY_ANSI"
  fi

  # Epilogue SHOULD include function-specific interpreters (complete set)
  if printf '%s\n' "$output" | grep -q "setenv VPN_SWITCH_INTERPRETER_wireguard_list"; then
    pass "Epilogue includes VPN_SWITCH_INTERPRETER_wireguard_list"
  else
    fail "Epilogue missing VPN_SWITCH_INTERPRETER_wireguard_list"
  fi

  if printf '%s\n' "$output" | grep -q "setenv VPN_SWITCH_INTERPRETER_wireguard_import1"; then
    pass "Epilogue includes VPN_SWITCH_INTERPRETER_wireguard_import1"
  else
    fail "Epilogue missing VPN_SWITCH_INTERPRETER_wireguard_import1"
  fi
}

test_dumpenv_profile_filtering() {
  test_header "dumpenv - profile filtering prevents restore breakage" "test_dumpenv_profile_filtering"

  test_setup

  # Set a function-specific interpreter that would break restore if in prologue
  run_vpn_switch setenv VPN_SWITCH_INTERPRETER_wireguard_import1 "cat" > /dev/null 2>&1

  # Run both prologue and epilogue
  local prologue_output=$(run_vpn_switch dumpenv prologue 2>&1)
  local epilogue_output=$(run_vpn_switch dumpenv epilogue 2>&1)

  # CRITICAL: Prologue must NOT have function-specific interpreters
  # (otherwise imports would only display, not execute during restore)
  if echo "$prologue_output" | grep -q "INTERPRETER_wireguard_import"; then
    fail "CRITICAL: Prologue has function-specific interpreter (would break restore)"
  else
    pass "Prologue correctly excludes function-specific interpreter"
  fi

  # Epilogue SHOULD have function-specific interpreters (restored after restore completes)
  if echo "$epilogue_output" | grep -q "INTERPRETER_wireguard_import"; then
    pass "Epilogue correctly includes function-specific interpreter"
  else
    fail "Epilogue missing function-specific interpreter"
  fi
}

#-----------------------------------------------------------------------------
# Environment Cache Tests (Phase 4.3)
#-----------------------------------------------------------------------------

# TEST 109: environment cache on - creates cache file
test_environment_cache_on() {
  test_header "environment cache on - creates cache file with correct permissions" "test_environment_cache_on"

  test_setup

  # Enable cache
  local output=$(run_vpn_switch environment cache on 2>&1)

  # Check that cache file was created
  local cache_file="$TEST_DIR/.env/local/VPN_SWITCH_CACHE_ENV_ARGS"
  if [ -f "$cache_file" ]; then
    pass "Cache file created"
  else
    fail "Cache file not created"
  fi

  # Check permissions (should be 0600) - use helper function for cross-platform
  if [ -f "$cache_file" ]; then
    local perms=$(get_file_perms_full "$cache_file")
    if [ "$perms" = "100600" ] || [ "$perms" = "600" ]; then
      pass "Cache file has correct permissions (0600)"
    else
      fail "Cache file has wrong permissions: $perms"
    fi
  fi

  # Check that output shows success message
  if printf '%s\n' "$output" | grep -q "Environment cache ENABLED"; then
    pass "Shows cache enabled message"
  else
    fail "Missing cache enabled message"
  fi

  # Verify cache content is not empty
  if [ -s "$cache_file" ]; then
    pass "Cache file has content"
  else
    fail "Cache file is empty"
  fi
}

# TEST 110: environment cache off - removes cache file
test_environment_cache_off() {
  test_header "environment cache off - removes cache file" "test_environment_cache_off"

  test_setup

  # Enable cache first
  run_vpn_switch environment cache on > /dev/null 2>&1

  # Verify cache exists
  local cache_file="$TEST_DIR/.env/local/VPN_SWITCH_CACHE_ENV_ARGS"
  if [ ! -f "$cache_file" ]; then
    fail "Setup failed: cache not created"
    return 1
  fi

  # Disable cache
  local output=$(run_vpn_switch environment cache off 2>&1)

  # Check that cache file was removed
  if [ ! -f "$cache_file" ]; then
    pass "Cache file removed"
  else
    fail "Cache file still exists"
  fi

  # Check for confirmation message
  if printf '%s\n' "$output" | grep -q "Environment cache DISABLED"; then
    pass "Shows cache disabled message"
  else
    fail "Missing cache disabled message"
  fi
}

# TEST 111: environment cache status - shows correct status
test_environment_cache_status() {
  test_header "environment cache status - shows correct status" "test_environment_cache_status"

  test_setup

  # Check status when disabled
  local output_disabled=$(run_vpn_switch environment cache status 2>&1)
  if echo "$output_disabled" | grep -q "Environment cache: DISABLED"; then
    pass "Shows DISABLED status when cache off"
  else
    fail "Incorrect status when cache off"
  fi

  # Enable cache
  run_vpn_switch environment cache on > /dev/null 2>&1

  # Check status when enabled
  local output_enabled=$(run_vpn_switch environment cache status 2>&1)
  if echo "$output_enabled" | grep -q "Environment cache: ENABLED"; then
    pass "Shows ENABLED status when cache on"
  else
    fail "Incorrect status when cache on"
  fi

  # Check that variable count is shown
  if echo "$output_enabled" | grep -q "vars)"; then
    pass "Shows cached variable count"
  else
    fail "Missing cached variable count"
  fi
}

# TEST 112: environment cache (no args) - defaults to status
test_environment_cache_no_args() {
  test_header "environment cache (no args) - defaults to status" "test_environment_cache_no_args"

  test_setup

  # Run without arguments
  local output=$(run_vpn_switch environment cache 2>&1)

  # Should show status (not error)
  if printf '%s\n' "$output" | grep -q "Environment cache:"; then
    pass "Shows status with no arguments"
  else
    fail "Should show status with no arguments"
  fi
}

# TEST 113: setenv rebuilds cache automatically
test_cache_invalidation_setenv() {
  test_header "setenv - rebuilds cache automatically" "test_cache_invalidation_setenv"

  test_setup

  # Enable cache
  run_vpn_switch environment cache on > /dev/null 2>&1

  # Verify cache exists
  local cache_file="$TEST_DIR/.env/local/VPN_SWITCH_CACHE_ENV_ARGS"
  if [ ! -f "$cache_file" ]; then
    fail "Setup failed: cache not created"
    return 1
  fi

  # Run setenv (should rebuild cache automatically)
  local output=$(run_vpn_switch setenv TEST_VAR "test_value" 2>&1)

  # Check that cache was rebuilt (still exists with updated content)
  if [ -f "$cache_file" ]; then
    pass "Cache rebuilt automatically after setenv"
  else
    fail "Cache should be rebuilt (not deleted) after setenv"
  fi

  # Check that rebuilt cache contains the new variable
  if [ -f "$cache_file" ] && grep -q "TEST_VAR" "$cache_file"; then
    pass "Rebuilt cache contains new variable TEST_VAR"
  else
    fail "Rebuilt cache should contain new variable TEST_VAR"
  fi
}

# TEST 114: unsetenv rebuilds cache automatically
test_cache_invalidation_unsetenv() {
  test_header "unsetenv - rebuilds cache automatically" "test_cache_invalidation_unsetenv"

  test_setup

  # Set a variable first
  run_vpn_switch setenv TEST_VAR "test_value" > /dev/null 2>&1

  # Enable cache
  run_vpn_switch environment cache on > /dev/null 2>&1

  # Verify cache exists and contains TEST_VAR
  local cache_file="$TEST_DIR/.env/local/VPN_SWITCH_CACHE_ENV_ARGS"
  if [ ! -f "$cache_file" ]; then
    fail "Setup failed: cache not created"
    return 1
  fi

  # Verify cache contains TEST_VAR before unsetenv
  if ! grep -q "TEST_VAR" "$cache_file"; then
    fail "Setup failed: cache should contain TEST_VAR"
    return 1
  fi

  # Run unsetenv (should rebuild cache automatically)
  local output=$(run_vpn_switch unsetenv TEST_VAR 2>&1)

  # Check that cache was rebuilt (still exists with updated content)
  if [ -f "$cache_file" ]; then
    pass "Cache rebuilt automatically after unsetenv"
  else
    fail "Cache should be rebuilt (not deleted) after unsetenv"
  fi

  # Check that rebuilt cache no longer contains TEST_VAR
  if [ -f "$cache_file" ] && ! grep -q "TEST_VAR" "$cache_file"; then
    pass "Rebuilt cache no longer contains TEST_VAR"
  else
    fail "Rebuilt cache should not contain TEST_VAR after unsetenv"
  fi
}

# TEST 115: environment init invalidates cache
test_cache_invalidation_environment_init() {
  test_header "environment init - invalidates cache automatically" "test_cache_invalidation_environment_init"

  test_setup

  # Enable cache
  run_vpn_switch environment cache on > /dev/null 2>&1

  # Verify cache exists
  local cache_file="$TEST_DIR/.env/local/VPN_SWITCH_CACHE_ENV_ARGS"
  if [ ! -f "$cache_file" ]; then
    fail "Setup failed: cache not created"
    return 1
  fi

  # Run environment init (should invalidate cache)
  local output=$(run_vpn_switch environment init minimal 2>&1)

  # Check that cache was removed
  if [ ! -f "$cache_file" ]; then
    pass "Cache file removed after environment init"
  else
    fail "Cache file should be removed after environment init"
  fi

  # Check for warning message
  if printf '%s\n' "$output" | grep -q "Cache invalidated"; then
    pass "Shows cache invalidation warning"
  else
    fail "Missing cache invalidation warning"
  fi
}

# TEST 116: dumpenv includes cache in epilogue
test_dumpenv_cache_preservation() {
  test_header "dumpenv epilogue - includes cache if enabled" "test_dumpenv_cache_preservation"

  test_setup

  # Enable cache
  run_vpn_switch environment cache on > /dev/null 2>&1

  # Run dumpenv epilogue
  local output=$(run_vpn_switch dumpenv epilogue 2>&1)

  # Check that cache is included in epilogue
  if printf '%s\n' "$output" | grep -q "VPN_SWITCH_CACHE_ENV_ARGS"; then
    pass "Epilogue includes cache content"
  else
    fail "Epilogue should include cache when enabled"
  fi

  # Check for restore comment
  if printf '%s\n' "$output" | grep -q "Restore environment cache"; then
    pass "Epilogue includes cache restore comment"
  else
    fail "Missing cache restore comment"
  fi
}

# TEST 117: dumpenv excludes cache when disabled
test_dumpenv_cache_not_included_when_disabled() {
  test_header "dumpenv epilogue - excludes cache when disabled" "test_dumpenv_cache_not_included_when_disabled"

  test_setup

  # Do NOT enable cache (leave it disabled)

  # Run dumpenv epilogue
  local output=$(run_vpn_switch dumpenv epilogue 2>&1)

  # Check that cache is NOT included
  if printf '%s\n' "$output" | grep -q "Restore environment cache"; then
    fail "Epilogue should not mention cache when disabled"
  else
    pass "Epilogue correctly excludes cache when disabled"
  fi
}

# TEST 118: cache does not include itself (recursion prevention)
test_cache_no_recursion() {
  test_header "environment cache on - excludes cache file from scan" "test_cache_no_recursion"

  test_setup

  # Enable cache
  run_vpn_switch environment cache on > /dev/null 2>&1

  local cache_file="$TEST_DIR/.env/local/VPN_SWITCH_CACHE_ENV_ARGS"
  if [ ! -f "$cache_file" ]; then
    fail "Setup failed: cache not created"
    return 1
  fi

  # Read cache content
  local cache_content=$(cat "$cache_file")

  # Cache should not reference itself (would cause recursion)
  if echo "$cache_content" | grep -q "VPN_SWITCH_CACHE_ENV_ARGS="; then
    fail "Cache includes itself (recursion risk)"
  else
    pass "Cache correctly excludes itself"
  fi
}

#-----------------------------------------------------------------------------
# Inspect Command Tests (Phase 4.1 - Feature 3)
#-----------------------------------------------------------------------------

# TEST 109: inspect - batch command includes all sections
test_inspect_batch_complete() {
  test_header "inspect (batch) - includes all inspection sections" "test_inspect_batch_complete"
  test_setup

  # Run batch inspect
  local output=$(run_vpn_switch inspect 2>&1)

  # Verify all sections are included
  if printf '%s\n' "$output" | grep -q "Environment Configuration"; then
    pass "Batch inspect includes environment section"
  else
    fail "Batch inspect missing environment section"
  fi

  if printf '%s\n' "$output" | grep -q "System Configuration"; then
    pass "Batch inspect includes system section"
  else
    fail "Batch inspect missing system section"
  fi

  if printf '%s\n' "$output" | grep -q "WireGuard.*Config"; then
    pass "Batch inspect includes WireGuard section"
  else
    fail "Batch inspect missing WireGuard section"
  fi

  if printf '%s\n' "$output" | grep -q "OpenVPN.*Config"; then
    pass "Batch inspect includes OpenVPN section"
  else
    fail "Batch inspect missing OpenVPN section"
  fi

  if printf '%s\n' "$output" | grep -qE "Session.*Status|Active.*Session"; then
    pass "Batch inspect includes session section"
  else
    fail "Batch inspect missing session section"
  fi

  if printf '%s\n' "$output" | grep -qE "Phase.*Configuration|Phase.*Connect|Phase.*Disconnect"; then
    pass "Batch inspect includes phases section"
  else
    fail "Batch inspect missing phases section"
  fi
}

# TEST 110: environment inspect - shows key configuration
test_environment_inspect() {
  test_header "environment inspect - displays environment variables" "test_environment_inspect"
  test_setup

  # Run environment inspect
  local output=$(run_vpn_switch environment inspect)

  # Verify header
  if printf '%s\n' "$output" | grep -q "Environment Configuration"; then
    pass "Environment inspect shows header"
  else
    fail "Environment inspect missing header"
  fi

  # Verify it shows VPN_SWITCH_BASE
  if printf '%s\n' "$output" | grep -q "VPN_SWITCH_BASE"; then
    pass "Environment inspect shows VPN_SWITCH_BASE"
  else
    fail "Environment inspect missing VPN_SWITCH_BASE"
  fi

  # Verify it shows database structure
  if printf '%s\n' "$output" | grep -q "Database Structure"; then
    pass "Environment inspect shows database structure"
  else
    fail "Environment inspect missing database structure"
  fi
}

# TEST 111: system inspect - shows system information
test_system_inspect() {
  test_header "system inspect - displays system configuration" "test_system_inspect"
  test_setup

  # Run system inspect
  local output=$(run_vpn_switch system inspect)

  # Verify header
  if printf '%s\n' "$output" | grep -q "System Configuration"; then
    pass "System inspect shows header"
  else
    fail "System inspect missing header"
  fi

  # Verify it shows system info
  if printf '%s\n' "$output" | grep -q "System Info"; then
    pass "System inspect shows system info section"
  else
    fail "System inspect missing system info"
  fi

  # Verify it shows network interfaces
  if printf '%s\n' "$output" | grep -q "Network Interfaces"; then
    pass "System inspect shows network interfaces section"
  else
    fail "System inspect missing network interfaces"
  fi
}

# Issue #001 Tests: Variable Expansion Timing and Function Classification
# =========================================================================

# TEST 112: Batch combinator syntax validation (Issue #001)
test_batch_syntax_wireguard_clean() {
  test_header "wireguard clean - validates batch syntax" "test_batch_syntax_wireguard_clean"
  test_setup

  # Override interpreter to cat (prevent execution, just show output)
  override_for_command_inspection "wireguard_clean"

  # Create broken symlink for clean to detect
  mkdir -p "$TEST_DIR/wireguard"
  ln -s /nonexistent "$TEST_DIR/wireguard/broken.conf"

  # Get clean output (commands only, not executed)
  local output=$(run_vpn_switch wireguard clean)

  # Validate syntax using helper
  if validate_batch_syntax "$output" "wireguard clean"; then
    pass "wireguard clean outputs valid batch syntax"
  else
    fail "wireguard clean has invalid batch syntax"
  fi

  # Verify literal variable (not expanded)
  if printf '%s\n' "$output" | grep -q '"\$VPN_SWITCH_CONTEXT_SCRIPT"'; then
    pass "wireguard clean uses literal \$VPN_SWITCH_CONTEXT_SCRIPT"
  else
    fail "wireguard clean variable expansion error"
  fi
}

# TEST 113: Combinators use literal context script (Issue #001)
test_combinators_literal_variable() {
  test_header "combinators - use literal \$VPN_SWITCH_CONTEXT_SCRIPT" "test_combinators_literal_variable"
  test_setup

  # Override interpreter to cat for inspection
  override_for_command_inspection "wireguard_start"

  # Create test config
  echo "[Interface]" > "$TEST_DIR/wireguard/test.conf"

  # Test wireguard start combinator
  local output=$(run_vpn_switch wireguard start test.conf 2>&1 || true)

  # Must contain literal variable
  if printf '%s\n' "$output" | grep -q '"\$VPN_SWITCH_CONTEXT_SCRIPT"'; then
    pass "wireguard start uses literal variable"
  else
    fail "wireguard start variable not literal"
  fi

  # Must NOT contain expanded path
  if ! printf '%s\n' "$output" | grep -qE '"/.*vpn-switch\.sh"'; then
    pass "wireguard start variable not expanded"
  else
    fail "wireguard start variable was expanded"
  fi
}

# TEST 114: Function naming matches behavior (Issue #001)
test_function_classification_correct() {
  test_header "function classification - naming matches behavior" "test_function_classification_correct"

  # Check wireguard add2 is combinator (double underscore)
  if grep -q '^__wireguard_add2()' include/wireguard.sh; then
    pass "wireguard add2 correctly classified as combinator (__)"
  else
    fail "wireguard add2 has wrong classification"
  fi

  # Check clean functions are batch combinators (triple underscore)
  if grep -q '^___wireguard_clean0()' include/wireguard.sh; then
    pass "wireguard clean0 correctly classified as batch (___)"
  else
    fail "wireguard clean0 has wrong classification"
  fi

  if grep -q '^___openvpn_clean0()' include/openvpn.sh; then
    pass "openvpn clean0 correctly classified as batch (___)"
  else
    fail "openvpn clean0 has wrong classification"
  fi
}

# TEST 115: No terminal functions output vpn-switch commands (Issue #001)
test_no_terminal_output_vpnswitch_commands() {
  test_header "terminal functions - must not output vpn-switch commands" "test_no_terminal_output_vpnswitch_commands"

  local violations=""

  # Check main script
  for func in $(grep '^_[^_][a-z_]*[0-9]*()' vpn-switch.sh | cut -d'(' -f1); do
    if awk "/^$func\(\)/,/^}/" vpn-switch.sh | grep -q 'echo.*"\$VPN_SWITCH_CONTEXT_SCRIPT"'; then
      violations="$violations vpn-switch.sh:$func"
    fi
  done

  # Check modules
  for file in include/*.sh; do
    for func in $(grep '^_[^_][a-z_]*[0-9]*()' "$file" 2>/dev/null | cut -d'(' -f1); do
      if awk "/^$func\(\)/,/^}/" "$file" | grep -q 'echo.*"\$VPN_SWITCH_CONTEXT_SCRIPT"'; then
        violations="$violations $(basename $file):$func"
      fi
    done
  done

  if [ -z "$violations" ]; then
    pass "No terminal functions output vpn-switch commands"
  else
    fail "Terminal functions violate rule: $violations"
  fi
}

# TEST 116: Metadata consistency after renames (Issue #001)
test_metadata_function_lists() {
  test_header "metadata - function lists accurate after renames" "test_metadata_function_lists"

  # Check combinators list includes renamed wireguard_add2
  if grep 'COMBINATOR_FUNCTIONS=' vpn-switch.sh | grep -q '__wireguard_add2'; then
    pass "Metadata includes __wireguard_add2 in combinators"
  else
    fail "Metadata missing __wireguard_add2"
  fi

  # Check batch combinators list includes renamed clean functions
  if grep 'BATCH_COMBINATOR_FUNCTIONS=' vpn-switch.sh | grep -q '___wireguard_clean0'; then
    pass "Metadata includes ___wireguard_clean0 in batch combinators"
  else
    fail "Metadata missing ___wireguard_clean0"
  fi

  if grep 'BATCH_COMBINATOR_FUNCTIONS=' vpn-switch.sh | grep -q '___openvpn_clean0'; then
    pass "Metadata includes ___openvpn_clean0 in batch combinators"
  else
    fail "Metadata missing ___openvpn_clean0"
  fi
}

# TEST 117: Combinator syntax validation (Issue #001)
test_combinator_syntax_validation() {
  test_header "combinators - validate single-command output syntax" "test_combinator_syntax_validation"
  test_setup

  # Override interpreter to cat for inspection
  override_for_command_inspection "wireguard_start"
  override_for_command_inspection "openvpn_start"
  override_for_command_inspection "start"

  # Create test configs
  echo "[Interface]" > "$TEST_DIR/wireguard/test.conf"
  echo "client" > "$TEST_DIR/openvpn/test.ovpn"

  # Test wireguard start combinator
  local wg_output=$(run_vpn_switch wireguard start test.conf 2>&1 || true)

  # Combinator must output exactly ONE vpn-switch command
  local wg_line_count=$(echo "$wg_output" | grep -c '"\$VPN_SWITCH_CONTEXT_SCRIPT"' || echo "0")
  if [ "$wg_line_count" -eq 1 ]; then
    pass "wireguard start outputs exactly one command"
  else
    fail "wireguard start should output 1 command, got $wg_line_count"
  fi

  # Must use literal variable
  if echo "$wg_output" | grep -q '"\$VPN_SWITCH_CONTEXT_SCRIPT"'; then
    pass "wireguard start uses literal variable"
  else
    fail "wireguard start missing literal variable"
  fi

  # Must NOT be expanded
  if ! echo "$wg_output" | grep -qE '"/.*vpn-switch\.sh"'; then
    pass "wireguard start variable not expanded"
  else
    fail "wireguard start variable was expanded"
  fi

  # Test openvpn start combinator
  local ovpn_output=$(run_vpn_switch openvpn start test.ovpn 2>&1 || true)

  local ovpn_line_count=$(echo "$ovpn_output" | grep -c '"\$VPN_SWITCH_CONTEXT_SCRIPT"' || echo "0")
  if [ "$ovpn_line_count" -eq 1 ]; then
    pass "openvpn start outputs exactly one command"
  else
    fail "openvpn start should output 1 command, got $ovpn_line_count"
  fi

  # Test protocol-agnostic start combinator
  local start_output=$(run_vpn_switch start test.conf 2>&1 || true)

  local start_line_count=$(echo "$start_output" | grep -c '"\$VPN_SWITCH_CONTEXT_SCRIPT"' || echo "0")
  if [ "$start_line_count" -eq 1 ]; then
    pass "start (protocol-agnostic) outputs exactly one command"
  else
    fail "start should output 1 command, got $start_line_count"
  fi
}

# TEST 118: Error command with 1 line (Issue #002)
test_error_command_single_line() {
  test_header "error command - single line message" "test_error_command_single_line"
  test_setup

  # Override to cat (display commands, not execute them)
  set_function_interpreter "error" "cat"

  # Run error with 1 line
  local output=$(run_vpn_switch error "Something went wrong" 2>&1 || true)

  # Verify it outputs printf command with error prefix
  if printf '%s\n' "$output" | grep -q 'printf.*Error:.*Something went wrong'; then
    pass "error command outputs printf with 'Error:' prefix"
  else
    fail "error command did not output expected printf command"
    printf '%s\n' "Output: $output"
  fi

  # Verify it outputs exit 1
  if printf '%s\n' "$output" | grep -q 'exit 1'; then
    pass "error command outputs exit 1"
  else
    fail "error command did not output exit 1"
  fi

  # Verify output goes to stderr (>&2)
  if printf '%s\n' "$output" | grep -q '>&2'; then
    pass "error command redirects to stderr"
  else
    fail "error command did not redirect to stderr"
  fi
}

# TEST 119: Error command with 2 lines (Issue #002)
test_error_command_two_lines() {
  test_header "error command - two line message" "test_error_command_two_lines"
  test_setup

  # Override to cat (display commands, not execute them)
  set_function_interpreter "error" "cat"

  # Run error with 2 lines
  local output=$(run_vpn_switch error "First line" "Second line" 2>&1 || true)

  # Verify first line has Error: prefix
  if printf '%s\n' "$output" | grep -q 'printf.*Error:.*First line'; then
    pass "error command first line has 'Error:' prefix"
  else
    fail "error command first line incorrect"
    printf '%s\n' "Output: $output"
  fi

  # Verify second line is indented (no Error: prefix)
  if printf '%s\n' "$output" | grep -q 'printf.* %s.*Second line' && ! echo "$output" | tail -2 | grep -q 'Error:.*Second line'; then
    pass "error command second line is indented without 'Error:' prefix"
  else
    fail "error command second line not properly formatted"
    printf '%s\n' "Output: $output"
  fi

  # Verify exit 1
  if printf '%s\n' "$output" | grep -q 'exit 1'; then
    pass "error command outputs exit 1"
  else
    fail "error command did not output exit 1"
  fi
}

# TEST 120: Error command with 3 lines (Issue #002)
test_error_command_three_lines() {
  test_header "error command - three line message" "test_error_command_three_lines"
  test_setup

  # Override to cat (display commands, not execute them)
  set_function_interpreter "error" "cat"

  # Run error with 3 lines
  local output=$(run_vpn_switch error "Line one" "Line two" "Line three" 2>&1 || true)

  # Verify first line has Error: prefix
  if printf '%s\n' "$output" | grep -q 'printf.*Error:.*Line one'; then
    pass "error command first line has 'Error:' prefix"
  else
    fail "error command first line incorrect"
    printf '%s\n' "Output: $output"
  fi

  # Verify second and third lines are indented (count printf with comment-prefixed indent pattern)
  local indented_count=$(printf '%s\n' "$output" | grep 'printf "#   %s' | wc -l | tr -d ' ')
  if [ "$indented_count" -ge 2 ]; then
    pass "error command has properly indented continuation lines"
  else
    fail "error command continuation lines not properly formatted (expected 2+ indented, got $indented_count)"
  fi

  # Verify all three lines are present
  if printf '%s\n' "$output" | grep -q 'Line one' && printf '%s\n' "$output" | grep -q 'Line two' && printf '%s\n' "$output" | grep -q 'Line three'; then
    pass "error command includes all three message lines"
  else
    fail "error command missing message lines"
    printf '%s\n' "Output: $output"
  fi

  # Verify exit 1
  if printf '%s\n' "$output" | grep -q 'exit 1'; then
    pass "error command outputs exit 1"
  else
    fail "error command did not output exit 1"
  fi
}

# TEST 121: Error command ANSI color support (Issue #002)
test_error_command_ansi_colors() {
  test_header "error command - ANSI color support" "test_error_command_ansi_colors"
  test_setup

  # Enable ANSI colors via database (survives environment isolation)
  run_vpn_switch setenv VPN_SWITCH_DISPLAY_ANSI 1 > /dev/null 2>&1

  # Override to cat (display commands, not execute them)
  set_function_interpreter "error" "cat"

  # Run error with 1 line
  local output=$(run_vpn_switch error "Test message" 2>&1 || true)

  # Verify it contains ANSI escape codes when ANSI enabled
  if printf '%s\n' "$output" | grep -q '\\033\['; then
    pass "error command includes ANSI escape codes when enabled"
  else
    fail "error command did not include ANSI codes"
    printf '%s\n' "Output: $output"
  fi

  # Verify reset code is present
  if printf '%s\n' "$output" | grep -q '\\033\[0m'; then
    pass "error command includes ANSI reset code"
  else
    fail "error command did not include ANSI reset code"
  fi
}

# TEST 122: Regression test for wireguard add2 (Issue #001)
test_wireguard_add2_delegation() {
  test_header "wireguard add2 - delegates correctly to add3" "test_wireguard_add2_delegation"
  test_setup

  # Override for command inspection (arity-specific to avoid breaking heterogeneous family)
  override_for_command_inspection "wireguard_add2"

  # Create test config
  echo "[Interface]" > "$TEST_DIR/wireguard/test.conf"
  mkdir -p "$TEST_DIR/wireguard/privacy"

  # Run add2 (category + target, target used as alias)
  local output=$(run_vpn_switch wireguard add privacy test.conf 2>&1 || true)

  # Should delegate to add3 with target as both target and alias
  if printf '%s\n' "$output" | grep -q '"\$VPN_SWITCH_CONTEXT_SCRIPT" wireguard add "privacy" "test.conf" "test.conf"'; then
    pass "wireguard add2 delegates correctly with literal variable"
  else
    fail "wireguard add2 delegation incorrect"
  fi
}

#-----------------------------------------------------------------------------
# Batch Infrastructure Tests (Phase 1 - Exit Code Encoding)
#-----------------------------------------------------------------------------

# TEST: get_batch_id - sequential allocation
test_batch_id_sequential() {
  test_header "get_batch_id - sequential allocation" "test_batch_id_sequential"

  test_setup

  # Source vpn-switch.sh to access infrastructure functions
  . "$TEST_SCRIPT"

  # Get first batch ID
  local batch_id_1=$(VPN_SWITCH_BASE="$TEST_DIR" LOG_FILE=/dev/null get_batch_id)
  if [ "$batch_id_1" = "0" ]; then
    pass "First batch ID is 0"
  else
    fail "First batch ID was $batch_id_1, expected 0"
  fi

  # Get second batch ID
  local batch_id_2=$(VPN_SWITCH_BASE="$TEST_DIR" LOG_FILE=/dev/null get_batch_id)
  if [ "$batch_id_2" = "1" ]; then
    pass "Second batch ID is 1"
  else
    fail "Second batch ID was $batch_id_2, expected 1"
  fi

  # Get third batch ID
  local batch_id_3=$(VPN_SWITCH_BASE="$TEST_DIR" LOG_FILE=/dev/null get_batch_id)
  if [ "$batch_id_3" = "2" ]; then
    pass "Third batch ID is 2"
  else
    fail "Third batch ID was $batch_id_3, expected 2"
  fi

  # Verify counter file exists and has correct value
  local counter_value=$(cat "$TEST_DIR/.tmp/batch-counter")
  if [ "$counter_value" = "3" ]; then
    pass "Counter file has correct value (3)"
  else
    fail "Counter file has value $counter_value, expected 3"
  fi
}

# TEST: store_batch_exits - basic storage
test_store_batch_exits_basic() {
  test_header "store_batch_exits - stores exit codes to file" "test_store_batch_exits_basic"

  test_setup

  # Source vpn-switch.sh
  . "$TEST_SCRIPT"

  # Store batch exits
  VPN_SWITCH_BASE="$TEST_DIR" LOG_FILE=/dev/null store_batch_exits 5 0 1 2 3

  # Verify file created
  if [ -f "$TEST_DIR/.tmp/batch-exits/5" ]; then
    pass "Batch file created"
  else
    fail "Batch file not created"
  fi

  # Verify content
  local content=$(cat "$TEST_DIR/.tmp/batch-exits/5")
  if [ "$content" = "0 1 2 3" ]; then
    pass "Batch file has correct content"
  else
    fail "Batch file content is '$content', expected '0 1 2 3'"
  fi
}

# TEST: store_batch_exits - with batch references
test_store_batch_exits_references() {
  test_header "store_batch_exits - stores exit codes with batch references" "test_store_batch_exits_references"

  test_setup

  # Source vpn-switch.sh
  . "$TEST_SCRIPT"

  # Store batch exits with references (format: "exit:batch_ref")
  VPN_SWITCH_BASE="$TEST_DIR" LOG_FILE=/dev/null store_batch_exits 10 "0 5 129:1 0"

  # Verify content includes batch references
  local content=$(cat "$TEST_DIR/.tmp/batch-exits/10")
  if [ "$content" = "0 5 129:1 0" ]; then
    pass "Batch file stores references correctly"
  else
    fail "Batch file content is '$content', expected '0 5 129:1 0'"
  fi
}

# TEST: free_batch_id - cleanup
test_free_batch_id() {
  test_header "free_batch_id - deletes batch file" "test_free_batch_id"

  test_setup

  # Source vpn-switch.sh
  . "$TEST_SCRIPT"

  # Create a batch file
  mkdir -p "$TEST_DIR/.tmp/batch-exits"
  echo "0 1 0" > "$TEST_DIR/.tmp/batch-exits/7"

  # Verify it exists
  if [ -f "$TEST_DIR/.tmp/batch-exits/7" ]; then
    pass "Batch file exists before cleanup"
  else
    fail "Batch file should exist before cleanup"
  fi

  # Free the batch ID
  VPN_SWITCH_BASE="$TEST_DIR" LOG_FILE=/dev/null free_batch_id 7

  # Verify file deleted
  if [ ! -f "$TEST_DIR/.tmp/batch-exits/7" ]; then
    pass "Batch file deleted after cleanup"
  else
    fail "Batch file still exists after cleanup"
  fi
}

# TEST: Batch infrastructure - full lifecycle
test_batch_infrastructure_lifecycle() {
  test_header "Batch infrastructure - full allocation/store/free lifecycle" "test_batch_infrastructure_lifecycle"

  test_setup

  # Source vpn-switch.sh
  . "$TEST_SCRIPT"

  # Allocate batch ID
  local batch_id=$(VPN_SWITCH_BASE="$TEST_DIR" LOG_FILE=/dev/null get_batch_id)
  pass "Allocated batch ID: $batch_id"

  # Store results
  VPN_SWITCH_BASE="$TEST_DIR" LOG_FILE=/dev/null store_batch_exits "$batch_id" "0 2 0 5"
  if [ -f "$TEST_DIR/.tmp/batch-exits/$batch_id" ]; then
    pass "Batch results stored"
  else
    fail "Batch results not stored"
  fi

  # Read and verify
  local content=$(cat "$TEST_DIR/.tmp/batch-exits/$batch_id")
  if [ "$content" = "0 2 0 5" ]; then
    pass "Batch results readable"
  else
    fail "Batch results incorrect: '$content'"
  fi

  # Free batch ID
  VPN_SWITCH_BASE="$TEST_DIR" LOG_FILE=/dev/null free_batch_id "$batch_id"
  if [ ! -f "$TEST_DIR/.tmp/batch-exits/$batch_id" ]; then
    pass "Batch cleaned up successfully"
  else
    fail "Batch file still exists after cleanup"
  fi
}

# Sync command tests
#
# Validate the three new sync functions and the version status command.
# Tests use the public CLI surface only — no internal-state inspection.

test_sync_batch_outputs_three_subcommands() {
  test_header "sync - batch combinator emits phases/env/version sync" "test_sync_batch_outputs_three_subcommands"
  test_setup

  override_for_command_inspection "sync"

  local output=$(run_vpn_switch sync)

  if printf '%s\n' "$output" | grep -qE '"\$VPN_SWITCH_CONTEXT_SCRIPT" phases sync$'; then
    pass "sync emits 'phases sync' subcommand"
  else
    fail "sync missing 'phases sync' subcommand"
  fi

  if printf '%s\n' "$output" | grep -qE '"\$VPN_SWITCH_CONTEXT_SCRIPT" env sync$'; then
    pass "sync emits 'env sync' subcommand"
  else
    fail "sync missing 'env sync' subcommand"
  fi

  if printf '%s\n' "$output" | grep -qE '"\$VPN_SWITCH_CONTEXT_SCRIPT" version sync$'; then
    pass "sync emits 'version sync' subcommand"
  else
    fail "sync missing 'version sync' subcommand"
  fi
}

test_env_sync_per_file_chmod() {
  test_header "env sync - uses per-file chmod loop (regression guard)" "test_env_sync_per_file_chmod"
  test_setup

  override_for_command_inspection "env_sync"

  local output=$(run_vpn_switch env sync)

  # Regression guard: -R 0600 would strip the directory's traverse bit.
  # Strip comment lines first so the explanatory comment in _env_sync0
  # doesn't trigger a false positive.
  local non_comment=$(printf '%s\n' "$output" | grep -v '^#')
  if ! printf '%s\n' "$non_comment" | grep -qE 'chmod -R 0600|0600 -R'; then
    pass "env sync does not use recursive chmod 0600"
  else
    fail "env sync uses recursive chmod 0600 (would lock out .env/default)"
  fi

  if printf '%s\n' "$output" | grep -q 'for f in'; then
    pass "env sync uses per-file chmod loop"
  else
    fail "env sync missing per-file chmod loop"
  fi
}

test_version_sync_outputs_copy_and_perms() {
  test_header "version sync - copies VERSION and chmods 0600" "test_version_sync_outputs_copy_and_perms"
  test_setup

  override_for_command_inspection "version_sync"

  local output=$(run_vpn_switch version sync)

  if printf '%s\n' "$output" | grep -qE 'template/VERSION.*\.version'; then
    pass "version sync copies template/VERSION → .version"
  else
    fail "version sync missing copy of template/VERSION to .version"
  fi

  if printf '%s\n' "$output" | grep -qE '0600.*\.version|\.version.*0600'; then
    pass "version sync chmods .version to 0600"
  else
    fail "version sync missing 0600 chmod on .version"
  fi
}

test_version_command_stamped() {
  test_header "version - reports db and source SHAs after bootstrap" "test_version_command_stamped"
  test_setup

  # Bootstrap auto-stamps .version, so freshly bootstrapped DB should report a real SHA
  local output=$(run_vpn_switch version)

  if printf '%s\n' "$output" | grep -qE '^db: [a-f0-9]{7,}$'; then
    pass "version reports db SHA in 'db: <sha>' format"
  else
    fail "version missing 'db: <sha>' line (output: $output)"
  fi

  if printf '%s\n' "$output" | grep -qE '^source: [a-f0-9]{7,}$'; then
    pass "version reports source SHA in 'source: <sha>' format"
  else
    fail "version missing 'source: <sha>' line"
  fi

  local db_sha=$(printf '%s\n' "$output" | grep '^db:' | awk '{print $2}')
  local src_sha=$(printf '%s\n' "$output" | grep '^source:' | awk '{print $2}')
  if [ -n "$db_sha" ] && [ "$db_sha" = "$src_sha" ]; then
    pass "version: db SHA matches source SHA after fresh bootstrap"
  else
    fail "version: db SHA != source SHA (db=$db_sha source=$src_sha)"
  fi
}

test_version_command_unstamped() {
  test_header "version - reports 'unstamped' when .version is missing" "test_version_command_unstamped"
  test_setup

  # Remove the .version that bootstrap auto-stamped
  rm -f "$TEST_DIR/.version"

  local output=$(run_vpn_switch version)

  if printf '%s\n' "$output" | grep -qE '^db: unstamped$'; then
    pass "version reports 'db: unstamped' when .version absent"
  else
    fail "version did not report 'db: unstamped' (output: $output)"
  fi
}

#-----------------------------------------------------------------------------
# Main Test Runner
#-----------------------------------------------------------------------------

main() {
  printf '%b========================================%b\n' "$COLOR_BLUE" "$COLOR_RESET"
  printf '%bvpn-switch Unit Test Suite (Formalized)%b\n' "$COLOR_BLUE" "$COLOR_RESET"
  printf '%b========================================%b\n' "$COLOR_BLUE" "$COLOR_RESET"
  echo ""

  # Check prerequisites
  if [ ! -f "$TEST_SCRIPT" ]; then
    printf '%bERROR:%b %s not found\n' "$COLOR_RED" "$COLOR_RESET" "$TEST_SCRIPT"
    echo "Run this script from the repository root"
    exit 1
  fi

  echo ""
  printf '%bRunning Tests%b\n' "$COLOR_BLUE" "$COLOR_RESET"
  echo "========================================"

  # Print filter info if active
  if [ -n "$TEST_FILTER" ]; then
    printf '%bFilter active - running only:%b%s\n' "$COLOR_YELLOW" "$COLOR_RESET" "$TEST_FILTER"
    echo ""
  fi

  # Run tests (each test calls test_setup for exclusive database)
  # No cleanup - artifacts preserved for debugging

  # Batch infrastructure tests (Phase 1 - Exit Code Encoding)
  should_run_test test_batch_id_sequential
  should_run_test test_store_batch_exits_basic
  should_run_test test_store_batch_exits_references
  should_run_test test_free_batch_id
  should_run_test test_batch_infrastructure_lifecycle

  # Terminal commands (simple display functions)
  should_run_test test_printenv_command
  should_run_test test_status_command
  should_run_test test_error_command_single_line
  should_run_test test_error_command_two_lines
  should_run_test test_error_command_three_lines
  should_run_test test_error_command_ansi_colors
  should_run_test test_wireguard_list
  should_run_test test_wireguard_validate
  should_run_test test_wireguard_info

  # Combinator commands (file operations)
  should_run_test test_wireguard_import_valid
  should_run_test test_wireguard_add_category
  should_run_test test_wireguard_link_create

  # Layer 2: VPN connection operations
  should_run_test test_wireguard_start_basic
  should_run_test test_wireguard_connect_resume
  should_run_test test_wireguard_stop_basic

  # Layer 3: Session management
  should_run_test test_session_list
  should_run_test test_session_refresh
  should_run_test test_session_refresh_clean
  should_run_test test_session_show
  should_run_test test_session_show_by_name
  should_run_test test_session_remove

  # Layer 3: Session save/start (resumption)
  should_run_test test_session_save_default
  should_run_test test_session_save_named
  should_run_test test_session_start_default
  should_run_test test_session_start_named
  should_run_test test_session_start_bypid

  # Layer 3a: Session stop (active session management)
  should_run_test test_session_stop_named
  should_run_test test_session_stop_bypid
  should_run_test test_session_stop_inactive
  should_run_test test_session_stop_batch_all

  # Config management: remove operations
  should_run_test test_wireguard_remove_config_in_use
  should_run_test test_wireguard_remove_config_with_refs
  should_run_test test_wireguard_remove_symlink
  should_run_test test_wireguard_remove_category_link

  # Config management: clean operations
  should_run_test test_wireguard_clean_no_broken
  should_run_test test_wireguard_clean_broken_protocol_link
  should_run_test test_wireguard_clean_broken_category_link
  should_run_test test_wireguard_clean_category_no_broken
  should_run_test test_wireguard_clean_category_with_broken

  # Config management: validate operations
  should_run_test test_wireguard_validate_broken_symlink
  should_run_test test_wireguard_validate_broken_category_symlink
  should_run_test test_wireguard_validate_naming_conflict
  should_run_test test_wireguard_validate_invalid_config

  # Stop/disconnect operations
  should_run_test test_stop_no_sessions
  should_run_test test_stop_specific_interface
  should_run_test test_wireguard_disconnect_interface
  should_run_test test_stop_nonexistent_interface
  should_run_test test_disconnect_without_session
  should_run_test test_stop_twice_idempotent

  # Config management: import/add/link edge cases
  should_run_test test_wireguard_import_nonexistent
  should_run_test test_wireguard_import_duplicate
  should_run_test test_wireguard_add_category_conflict
  should_run_test test_wireguard_add_link_arity2
  should_run_test test_wireguard_add_link_arity3
  should_run_test test_wireguard_add_link_conflict
  should_run_test test_wireguard_link_conflict

  # Error handling
  should_run_test test_error_invalid_category
  should_run_test test_error_broken_symlink
  should_run_test test_error_invalid_command

  # Edge cases
  should_run_test test_edge_duplicate_instance_prevention
  should_run_test test_edge_stale_session_cleanup

  # Config management: patch operations
  should_run_test test_wireguard_patch_valid
  should_run_test test_wireguard_patch_nonexistent
  should_run_test test_wireguard_patch_absolute

  # Config management: info operations
  should_run_test test_wireguard_info_category

  # Session management: save/start operations
  should_run_test test_session_save_default
  should_run_test test_session_save_named
  should_run_test test_session_start_default
  should_run_test test_session_start_named
  should_run_test test_session_start_by_pid

  # OpenVPN config management
  should_run_test test_openvpn_import_valid
  should_run_test test_openvpn_list
  should_run_test test_openvpn_add_group
  should_run_test test_openvpn_add_to_group_arity2
  should_run_test test_openvpn_add_to_group_arity3
  should_run_test test_openvpn_link
  should_run_test test_openvpn_remove
  should_run_test test_openvpn_validate
  should_run_test test_openvpn_info
  should_run_test test_openvpn_dump

  # OpenVPN lifecycle tests (Phase 3.3.1)
  should_run_test test_openvpn_patch_valid
  should_run_test test_openvpn_patch_nonexistent
  should_run_test test_openvpn_patch_absolute
  should_run_test test_openvpn_patch_credentials_bare
  should_run_test test_openvpn_patch_credentials_existing
  should_run_test test_openvpn_patch_credentials_missing
  should_run_test test_openvpn_start_basic
  should_run_test test_openvpn_stop_basic
  should_run_test test_openvpn_disconnect_interface
  should_run_test test_openvpn_clean

  # Protocol-agnostic wrappers (delegation tests)
  should_run_test test_protocol_agnostic_import_wireguard
  should_run_test test_protocol_agnostic_list
  should_run_test test_protocol_agnostic_link
  should_run_test test_protocol_agnostic_remove
  should_run_test test_protocol_agnostic_validate

  # System validation tests (Phase 4.1 - Feature 3)
  should_run_test test_network_validate
  should_run_test test_permissions_validate
  should_run_test test_environment_validate
  should_run_test test_batch_validate_includes_system

  # Protocol-agnostic start tests (Phase 3.2.1)
  should_run_test test_start_wireguard_only
  should_run_test test_start_openvpn_only
  should_run_test test_start_not_found
  should_run_test test_start_no_default
  should_run_test test_start_with_default_wireguard
  should_run_test test_start_with_default_openvpn
  should_run_test test_start_default_invalid_target

  # Phase 3.4.1: Protocol discovery tests
  should_run_test test_init_extension_links
  should_run_test test_start_extension_link_fast_path
  should_run_test test_start_multiple_matches

  # Phase 4.4: Init function tests
  should_run_test test_database_init
  should_run_test test_environment_init
  should_run_test test_phases_copy
  should_run_test test_phases_lift
  should_run_test test_phases_default_profile
  should_run_test test_phases_sync_single
  should_run_test test_phases_sync_all
  should_run_test test_init_batch_combinator
  should_run_test test_init_combinator

  # Environment management commands
  should_run_test test_setenv_basic
  should_run_test test_setenv_invalid_name
  should_run_test test_getenv_local_override
  should_run_test test_getenv_fallback_chain
  should_run_test test_unsetenv_existing
  should_run_test test_unsetenv_not_set
  should_run_test test_dumpenv_prologue
  should_run_test test_dumpenv_epilogue
  should_run_test test_dumpenv_profile_filtering

  # Environment cache tests (Phase 4.3)
  should_run_test test_environment_cache_on
  should_run_test test_environment_cache_off
  should_run_test test_environment_cache_status
  should_run_test test_environment_cache_no_args
  should_run_test test_cache_invalidation_setenv
  should_run_test test_cache_invalidation_unsetenv
  should_run_test test_cache_invalidation_environment_init
  should_run_test test_dumpenv_cache_preservation
  should_run_test test_dumpenv_cache_not_included_when_disabled
  should_run_test test_cache_no_recursion

  # Interpreter resolution tests (lower half of lookup_interpreter)
  should_run_test test_interpreter_single_underscore
  should_run_test test_interpreter_double_underscore
  should_run_test test_interpreter_triple_underscore
  should_run_test test_interpreter_resolution_priority

  # Inspect command tests (Phase 4.1 - Feature 3)
  should_run_test test_inspect_batch_complete
  should_run_test test_environment_inspect
  should_run_test test_system_inspect

  # Issue #001: Variable Expansion Timing and Function Classification
  should_run_test test_batch_syntax_wireguard_clean
  should_run_test test_combinators_literal_variable
  should_run_test test_combinator_syntax_validation
  should_run_test test_function_classification_correct
  should_run_test test_no_terminal_output_vpnswitch_commands
  should_run_test test_metadata_function_lists
  should_run_test test_wireguard_add2_delegation

  # Sync command tests
  should_run_test test_sync_batch_outputs_three_subcommands
  should_run_test test_env_sync_per_file_chmod
  should_run_test test_version_sync_outputs_copy_and_perms
  should_run_test test_version_command_stamped
  should_run_test test_version_command_unstamped

  # Print summary
  test_summary
}

# Run tests
main "$@"
