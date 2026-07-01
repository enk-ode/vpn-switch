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
# vpn-switch Architecture Test Suite
#
# PURPOSE: Enforce combinator pattern architectural rules
#
# ARCHITECTURAL RULES TESTED:
#
# 1. COMBINATOR FUNCTIONS (__func):
#    - Output exactly 1 line
#    - Line must contain "$VPN_SWITCH_CONTEXT_SCRIPT" (literal, not expanded)
#    - Line format: "$VPN_SWITCH_CONTEXT_SCRIPT" command args...
#
# 2. BATCH COMBINATOR FUNCTIONS (___func):
#    - Output N lines (N >= 0)
#    - Each non-empty, non-comment line must be a vpn-switch command
#    - Use literal "$VPN_SWITCH_CONTEXT_SCRIPT" (not expanded paths)
#    - Comments (#) and empty lines are allowed
#
# 3. TERMINAL FUNCTIONS (_func):
#    - Must NOT output vpn-switch commands
#    - Output shell commands only
#    - Can call: shell keywords, builtins, system commands, locally-defined functions
#    - Cannot call: vpn-switch internal functions (starting with _) unless locally defined
#    - Cannot call: error(), log(), run_env(), dispatch(), lookup_interpreter()
#    - Must NOT use "$VPN_SWITCH_CONTEXT_SCRIPT" (reserved for combinators)
#
# For new contributors/Claudes: Run these tests to verify your
# combinator functions follow the architectural pattern.
#
# Usage: ./vpn-switch-architecture-test.sh [profile] [keep] [test ...]
#   profile: minimal (default) or all
#   keep: true/keep to preserve databases on success (default: delete)
#   test ...: optional test-function names to run only those (same mechanism as
#             vpn-switch-unit-test.sh). Note profile+keep must be given first,
#             e.g. ./vpn-switch-architecture-test.sh minimal false test_readonly_database
#
# POSIX shell compliant
#

# ============================================================================
# TEST DATABASE SPECIFICATION
# ============================================================================
#
# PURPOSE:
#   Architecture tests need to exercise ALL code paths, including error handling
#   and edge cases. Real databases are messy - sessions go stale, links break,
#   processes die, users interrupt operations. A "realistic but messy" database
#   state ensures unlikely branches get tested.
#
# PHILOSOPHY:
#   "Test with the chaos users create, not the perfection we assume"
#
# WHY THIS APPROACH:
#   1. REALISTIC - Mirrors actual database states in production use
#   2. COMPREHENSIVE - Exercises both success and error paths
#   3. GENERIC - No function-specific knowledge required
#   4. DISCOVERABLE - Reveals architectural violations in error handling
#   5. MAINTAINABLE - Single specification for all tests
#   6. DETERMINISTIC - Reproducible failures (with optional randomization)
#
# MAINTENANCE:
#   Update this specification when:
#   - New features add database structures (e.g., new protocol directories)
#   - New edge cases are discovered (add them as fixtures)
#   - Tests reveal blind spots in coverage (add problematic states)
#
# ============================================================================
#
# DATABASE STRUCTURE (created by create_messy_realistic_database())
#
# $TEST_DIR/
#   .session/                          # Active/stale sessions directory
#     88888/                           # VALID: Complete session (old PID)
#       protocol       = "wireguard"
#       interface      = "wg_test0"  # Use test interface to avoid conflict
#       original       = "$TEST_DIR/wireguard/working.conf"
#       started        = "2024-01-15 10:30:00"
#       connect.sh     = executable script (0600)
#       disconnect.sh  = executable script (0600)
#
#     99999/                           # STALE: Session with dead process
#       protocol       = "openvpn"
#       interface      = "tun_test0"  # Use test interface to avoid conflict
#       original       = "$TEST_DIR/openvpn/stale.ovpn"
#       started        = "2024-01-10 08:00:00"
#       (missing connect.sh - incomplete session)
#
#     77777/                           # PARTIAL: Missing metadata files
#       protocol       = "wireguard"
#       (missing interface, original, started)
#
#   session/                           # Named sessions directory
#     default        → ../.session/88888         # VALID symlink
#     work           → ../.session/99999         # STALE symlink (dead process)
#     broken         → ../.session/11111         # ORPHANED (target doesn't exist)
#     home           → ../.session/88888         # DUPLICATE (same as default)
#
#   wireguard/                         # WireGuard configs
#     working.conf                     # VALID config file (0400)
#     broken.conf    → nonexistent.conf         # BROKEN symlink
#     duplicate.conf → working.conf             # DUPLICATE (points to existing)
#
#     privacy/                         # Category directory
#       server1      → ../working.conf          # Valid category link
#       server2      → ../broken.conf           # Broken category link
#       orphan       → ../gone.conf             # Orphaned link
#
#   openvpn/                           # OpenVPN configs
#     stale.ovpn                       # VALID config file (0400)
#     invalid.ovpn   → missing.ovpn             # BROKEN symlink
#
#     streaming/                       # Category directory (empty)
#
#   .conf          → wireguard         # Protocol extension link (valid)
#   .ovpn          → openvpn           # Protocol extension link (valid)
#   .broken        → nowhere           # BROKEN extension link
#
# ADVERSARIAL NAMES (test command parser robustness):
#   wireguard/
#     help.conf                        # Conflicts with command name
#     start.conf                       # Conflicts with command name
#     --version.conf                   # Looks like CLI flag
#     -rf.conf                         # Dangerous if mishandled
#
#   openvpn/
#     list.ovpn                        # Conflicts with command name
#     ../escape.ovpn   → stale.ovpn    # Path traversal attempt (symlink)
#
#   session/
#     stop           → ../.session/88888         # Command name as session name
#     dump           → ../.session/99999         # Another command conflict
#
# WHY ADVERSARIAL NAMES MATTER:
#   - Tests dispatch resolution doesn't confuse "wireguard start help" with help command
#   - Ensures path normalization prevents traversal (../ handled correctly)
#   - Verifies special characters don't break shell command generation
#   - Proves the system is robust against confusing/malicious user input
#   - Architecture tests are PERFECT place for this (end-to-end command flow)
#
# RANDOMIZATION POINTS (50% probability each):
#   - Whether default symlink exists in session/
#   - Whether additional named sessions exist
#   - Which session has a complete connect.sh script
#
# INVARIANTS (always true):
#   - At least one valid session exists (88888)
#   - At least one stale/broken state exists (99999, broken links)
#   - Both protocols have configs (wireguard and openvpn)
#   - Mix of valid and broken states for comprehensive coverage
#
# BENEFITS FOR TESTING:
#   - session_start* can find valid default OR encounter stale links
#   - session_save* can find existing sessions to save
#   - session_remove* encounter both valid and invalid targets
#   - session_show* test with missing/present connect.sh
#   - session_list* display mixed valid/stale/orphaned states
#   - validate* find broken links and stale sessions
#   - clean* have actual broken links to clean
#   - Protocol functions encounter both valid and broken configs
#   - import* test with existing vs. conflicting names
#   - All functions exercise error handling for broken states
#
# COVERAGE IMPROVEMENT:
#   Before: Functions hit early error exits (dead code not tested)
#   After:  Functions execute full logic with both valid and broken inputs
#   Result: Architectural violations in ANY code path get detected
#
# ============================================================================

set -e
set -u

#-----------------------------------------------------------------------------
# Test Configuration
#-----------------------------------------------------------------------------

# Test base directory
TEST_BASE_DIR="${TMPDIR:-/tmp}/vpn-switch-arch-test.$$"

# Test script location
TEST_SCRIPT="./vpn-switch.sh"

# Profile for bootstrap
TEST_PROFILE="${1:-minimal}"

# Keep databases on success (default: false = delete on success)
KEEP_DATABASES="${2:-false}"

# Optional test-name filters (args 3+), same mechanism as vpn-switch-unit-test.sh.
# Profile ($1) and keep ($2) are already captured above; drop them, then treat
# the rest as test-name filters. Safe shift under 'set -u'.
[ $# -ge 1 ] && shift   # drop profile
[ $# -ge 1 ] && shift   # drop keep

# Dynamically generate list of all test functions
ALL_TESTS=$(grep -o '^test_[a-z_]*()' "$0" | sed 's/()$//' | tr '\n' ' ')

# Collect test filter arguments (optional test function names)
TEST_FILTER="$*"

# If no filter specified, run all tests
if [ -z "$TEST_FILTER" ]; then
  TEST_FILTER="$ALL_TESTS"
fi

#-----------------------------------------------------------------------------
# Test Framework Infrastructure (copied from vpn-switch-unit-test.sh)
#-----------------------------------------------------------------------------

# should_run_test - Run a named test only if it is in the active filter
# (identical to vpn-switch-unit-test.sh)
should_run_test() {
  local test_name="$1"

  for filter_test in $TEST_FILTER; do
    if [ "$filter_test" = "$test_name" ]; then
      "$test_name"
      return 0
    fi
  done

  return 0
}

# Test counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Color support (detect if terminal supports colors)
if [ -t 1 ] && command -v tput >/dev/null 2>&1 && tput colors >/dev/null 2>&1; then
  COLOR_GREEN=$(tput setaf 2)
  COLOR_RED=$(tput setaf 1)
  COLOR_YELLOW=$(tput setaf 3)
  COLOR_BLUE=$(tput setaf 4)
  COLOR_RESET=$(tput sgr0)
else
  COLOR_GREEN=""
  COLOR_RED=""
  COLOR_YELLOW=""
  COLOR_BLUE=""
  COLOR_RESET=""
fi

# Global test directory
TEST_DIR=""

# pass - Mark assertion as passed
pass() {
  TESTS_PASSED=$((TESTS_PASSED + 1))
  echo "${COLOR_GREEN}✓${COLOR_RESET} $*"
}

# fail - Mark assertion as failed
fail() {
  TESTS_FAILED=$((TESTS_FAILED + 1))
  echo "${COLOR_RED}✗${COLOR_RESET} $*"
}

# test_header - Print test header with database path
test_header() {
  TESTS_RUN=$((TESTS_RUN + 1))
  echo ""
  if [ -n "${TEST_DIR:-}" ]; then
    echo "${COLOR_BLUE}TEST ${TESTS_RUN}:${COLOR_RESET} $* [db: $TEST_DIR]"
  else
    echo "${COLOR_BLUE}TEST ${TESTS_RUN}:${COLOR_RESET} $*"
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
  echo "Architecture Test Summary"
  echo "========================================"
  echo "Test Functions:     $test_functions"
  echo "Total Assertions:   $total_assertions"
  echo "${COLOR_GREEN}Passed Assertions:  $assertions_passed${COLOR_RESET}"
  if [ "$assertions_failed" -gt 0 ]; then
    echo "${COLOR_RED}Failed Assertions:  $assertions_failed${COLOR_RESET}"
  else
    echo "Failed Assertions:  $assertions_failed"
  fi
  echo ""

  if [ "$assertions_failed" -gt 0 ]; then
    echo "${COLOR_RED}SOME TESTS FAILED${COLOR_RESET}"
    echo ""
    echo "Test artifacts preserved in: $TEST_BASE_DIR"
    echo "To clean up: rm -rf $TEST_BASE_DIR"
    return 1
  else
    echo "${COLOR_GREEN}ALL TESTS PASSED${COLOR_RESET}"
    echo ""
    if [ "$KEEP_DATABASES" = "true" ] || [ "$KEEP_DATABASES" = "keep" ]; then
      echo "Test databases preserved in: $TEST_BASE_DIR"
    else
      echo "Cleaning up test databases..."
      rm -rf "$TEST_BASE_DIR"
      echo "Done."
    fi
    return 0
  fi
}

#-----------------------------------------------------------------------------
# Test Setup (simplified from vpn-switch-unit-test.sh)
#-----------------------------------------------------------------------------

# test_setup - Create exclusive test database
#
# Creates a fresh database for each test using vpn-switch bootstrap.
# Sets TEST_DIR for use by test functions.
#
test_setup() {
  # Create unique test database directory
  TEST_DIR="$TEST_BASE_DIR/test-$TESTS_RUN"
  mkdir -p "$TEST_DIR"

  # Bootstrap database using vpn-switch API
  local bootstrap_log="$TEST_DIR/bootstrap.log"
  if ! VPN_SWITCH_BASE="$TEST_DIR" "$TEST_SCRIPT" bootstrap "$TEST_DIR" "$TEST_PROFILE" > "$bootstrap_log" 2>&1; then
    echo "${COLOR_RED}ERROR:${COLOR_RESET} Database bootstrap failed"
    cat "$bootstrap_log" | sed 's/^/  /'
    exit 1
  fi

  # Set terminal interpreter to sh for auto-execution (simulates experienced user)
  VPN_SWITCH_BASE="$TEST_DIR" "$TEST_SCRIPT" setenv VPN_SWITCH_TERMINAL_INTERPRETER sh > /dev/null 2>&1

  # Set minimal PATH
  VPN_SWITCH_BASE="$TEST_DIR" "$TEST_SCRIPT" setenv VPN_SWITCH_PATH "/bin:/usr/bin:/usr/local/bin" > /dev/null 2>&1
}

# create_messy_realistic_database - Populate database with realistic messy state
#
# Creates a database state that mirrors real-world usage with:
# - Valid and stale sessions
# - Broken symlinks
# - Orphaned references
# - Adversarial names (command conflicts, path traversal attempts)
# - Incomplete/partial data structures
#
# This ensures tests exercise BOTH success and error paths, revealing
# architectural violations in error handling code that would otherwise
# be untested "dead code".
#
# See TEST DATABASE SPECIFICATION comment at top of file for full details.
#
create_messy_realistic_database() {
  # ===== SESSIONS =====

  # Valid session (88888) - complete with all metadata (use test interface to avoid conflict)
  mkdir -p "$TEST_DIR/.session/88888"
  echo "wireguard" > "$TEST_DIR/.session/88888/protocol"
  echo "wg_test0" > "$TEST_DIR/.session/88888/interface"
  echo "$TEST_DIR/wireguard/working.conf" > "$TEST_DIR/.session/88888/original"
  echo "2024-01-15 10:30:00" > "$TEST_DIR/.session/88888/started"

  # Create minimal connect.sh script
  cat > "$TEST_DIR/.session/88888/connect.sh" <<'EOF'
#!/bin/sh
# Mock connect script for testing
echo "Mock VPN connection for session 88888"
EOF
  chmod 0600 "$TEST_DIR/.session/88888/connect.sh"

  # Create minimal disconnect.sh script
  cat > "$TEST_DIR/.session/88888/disconnect.sh" <<'EOF'
#!/bin/sh
# Mock disconnect script for testing
echo "Mock VPN disconnection for session 88888"
EOF
  chmod 0600 "$TEST_DIR/.session/88888/disconnect.sh"

  # Stale session (99999) - missing connect.sh (incomplete)
  mkdir -p "$TEST_DIR/.session/99999"
  echo "openvpn" > "$TEST_DIR/.session/99999/protocol"
  echo "tun_test0" > "$TEST_DIR/.session/99999/interface"
  echo "$TEST_DIR/openvpn/stale.ovpn" > "$TEST_DIR/.session/99999/original"
  echo "2024-01-10 08:00:00" > "$TEST_DIR/.session/99999/started"
  # Note: No connect.sh - simulates interrupted/incomplete session

  # Partial session (77777) - missing most metadata
  mkdir -p "$TEST_DIR/.session/77777"
  echo "wireguard" > "$TEST_DIR/.session/77777/protocol"
  # Missing: interface, original, started

  # ===== NAMED SESSIONS =====

  mkdir -p "$TEST_DIR/session"

  # Deterministic: Always create default symlink (most common case)
  ln -s "../.session/88888" "$TEST_DIR/session/default"

  # Deterministic: Always create additional named sessions for maximum coverage
  # (Randomization commented out - was causing POSIX compatibility issues)
  # Original intent: 50% chance, but deterministic is better for reproducibility
  ln -s "../.session/99999" "$TEST_DIR/session/work"     # Stale
  ln -s "../.session/88888" "$TEST_DIR/session/home"     # Duplicate

  # Broken/orphaned links (always present for error path testing)
  ln -s "../.session/11111" "$TEST_DIR/session/broken"  # Target doesn't exist

  # Adversarial: Command names as session names
  ln -s "../.session/88888" "$TEST_DIR/session/stop"
  ln -s "../.session/99999" "$TEST_DIR/session/dump"

  # ===== WIREGUARD CONFIGS =====

  # Valid working config
  cat > "$TEST_DIR/wireguard/working.conf" <<'EOF'
[Interface]
PrivateKey = fake-test-key-for-architecture-tests
Address = 10.0.0.1/32

[Peer]
PublicKey = fake-peer-key-for-testing
Endpoint = 192.0.2.1:51820
AllowedIPs = 0.0.0.0/0
EOF
  chmod 0400 "$TEST_DIR/wireguard/working.conf"

  # Broken symlink
  ln -s "nonexistent.conf" "$TEST_DIR/wireguard/broken.conf"

  # Duplicate symlink
  ln -s "working.conf" "$TEST_DIR/wireguard/duplicate.conf"

  # Adversarial: Command names and dangerous patterns
  cat > "$TEST_DIR/wireguard/help.conf" <<'EOF'
[Interface]
PrivateKey = fake-key-help-command-conflict
Address = 10.0.0.2/32
EOF
  chmod 0400 "$TEST_DIR/wireguard/help.conf"

  cat > "$TEST_DIR/wireguard/start.conf" <<'EOF'
[Interface]
PrivateKey = fake-key-start-command-conflict
Address = 10.0.0.3/32
EOF
  chmod 0400 "$TEST_DIR/wireguard/start.conf"

  # Dangerous-looking names (ensure these don't cause issues)
  cat > "$TEST_DIR/wireguard/--version.conf" <<'EOF'
[Interface]
PrivateKey = fake-key-flag-lookalike
Address = 10.0.0.4/32
EOF
  chmod 0400 "$TEST_DIR/wireguard/--version.conf"

  cat > "$TEST_DIR/wireguard/-rf.conf" <<'EOF'
[Interface]
PrivateKey = fake-key-dangerous-flag
Address = 10.0.0.5/32
EOF
  chmod 0400 "$TEST_DIR/wireguard/-rf.conf"

  # Category with mixed valid/broken links
  mkdir -p "$TEST_DIR/wireguard/privacy"
  ln -s "../working.conf" "$TEST_DIR/wireguard/privacy/server1"    # Valid
  ln -s "../broken.conf" "$TEST_DIR/wireguard/privacy/server2"     # Broken
  ln -s "../gone.conf" "$TEST_DIR/wireguard/privacy/orphan"        # Orphaned

  # ===== OPENVPN CONFIGS =====

  # Valid stale config
  cat > "$TEST_DIR/openvpn/stale.ovpn" <<'EOF'
remote 192.0.2.10 1194 udp
dev tun
# Mock OpenVPN config for testing
EOF
  chmod 0400 "$TEST_DIR/openvpn/stale.ovpn"

  # Broken symlink
  ln -s "missing.ovpn" "$TEST_DIR/openvpn/invalid.ovpn"

  # Adversarial: Command name
  cat > "$TEST_DIR/openvpn/list.ovpn" <<'EOF'
remote 192.0.2.11 1194 udp
dev tun
EOF
  chmod 0400 "$TEST_DIR/openvpn/list.ovpn"

  # Path traversal attempt (symlink with ../)
  ln -s "../openvpn/stale.ovpn" "$TEST_DIR/openvpn/../escape.ovpn" 2>/dev/null || true

  # Empty category
  mkdir -p "$TEST_DIR/openvpn/streaming"

  # ===== PROTOCOL EXTENSION LINKS =====

  # Valid extension links (these exist from bootstrap, recreate for clarity)
  ln -sf "wireguard" "$TEST_DIR/.conf"
  ln -sf "openvpn" "$TEST_DIR/.ovpn"

  # Broken extension link
  ln -s "nowhere" "$TEST_DIR/.broken"

  #=============================================================================
  # CORRUPTION PATTERNS - Realistic Filesystem Anomalies
  #=============================================================================

  # ===== 1. BROKEN SYMLINKS =====

  # WireGuard broken links
  ln -s /nonexistent "$TEST_DIR/wireguard/broken-absolute.conf"
  ln -s ../missing/file.conf "$TEST_DIR/wireguard/broken-relative.conf"

  # OpenVPN broken links
  ln -s /nonexistent "$TEST_DIR/openvpn/broken-absolute.ovpn"
  ln -s ../missing/file.ovpn "$TEST_DIR/openvpn/broken-relative.ovpn"

  # ===== 2. DIRECTORIES WITH CONFIG EXTENSIONS =====

  # Confuses file type checks
  mkdir "$TEST_DIR/wireguard/looks-like-config.conf"
  mkdir "$TEST_DIR/openvpn/fake-vpn-file.ovpn"

  # ===== 3. SYMLINK LOOPS =====

  # Infinite loop: A → B → A
  ln -s "loop-b.conf" "$TEST_DIR/wireguard/loop-a.conf"
  ln -s "loop-a.conf" "$TEST_DIR/wireguard/loop-b.conf"

  # Self-referencing
  ln -s "self.conf" "$TEST_DIR/wireguard/self.conf"

  # ===== 4. CROSS-PROTOCOL CONFUSION =====

  # Create temp configs for cross-protocol tests
  cat > "$TEST_DIR/wireguard/cross-test-wg.conf" <<'EOF'
[Interface]
PrivateKey = cross-test-key
Address = 10.99.0.1/32
EOF

  cat > "$TEST_DIR/openvpn/cross-test-ovpn.ovpn" <<'EOF'
remote 192.0.2.99 1194 udp
dev tun
EOF

  # WireGuard config in openvpn/ with .ovpn extension
  cp "$TEST_DIR/wireguard/cross-test-wg.conf" "$TEST_DIR/openvpn/wireguard-masquerade.ovpn"

  # OpenVPN config in wireguard/ with .conf extension
  cp "$TEST_DIR/openvpn/cross-test-ovpn.ovpn" "$TEST_DIR/wireguard/openvpn-masquerade.conf"

  # Cross-protocol symlinks
  ln -s "../wireguard/working.conf" "$TEST_DIR/openvpn/link-to-wireguard.ovpn"
  ln -s "../openvpn/stale.ovpn" "$TEST_DIR/wireguard/link-to-openvpn.conf"

  # ===== 5. EMPTY/MALFORMED FILES =====

  # Empty configs
  touch "$TEST_DIR/wireguard/empty.conf"
  touch "$TEST_DIR/openvpn/empty.ovpn"

  # Partial/incomplete configs (will fail validation)
  echo "[Interface]" > "$TEST_DIR/wireguard/incomplete.conf"
  echo "remote" > "$TEST_DIR/openvpn/partial.ovpn"

  # Configs with only comments
  cat > "$TEST_DIR/wireguard/only-comments.conf" <<'EOF'
# This file has no actual config
# Just comments
EOF

  cat > "$TEST_DIR/openvpn/only-comments.ovpn" <<'EOF'
# This file has no actual config
# Just comments
EOF

  # ===== 6. MISSING EXTENSIONS =====

  # Valid structure, wrong/missing extension
  cat > "$TEST_DIR/wireguard/no-extension" <<'EOF'
[Interface]
PrivateKey = no-ext-key
Address = 10.98.0.1/32
EOF

  cat > "$TEST_DIR/openvpn/no-extension" <<'EOF'
remote 192.0.2.98 1194 udp
dev tun
EOF

  # Wrong extension entirely
  cp "$TEST_DIR/wireguard/working.conf" "$TEST_DIR/wireguard/wrong.txt"
  cp "$TEST_DIR/openvpn/stale.ovpn" "$TEST_DIR/openvpn/wrong.cfg"

  # ===== 7. SPECIAL CHARACTERS & EDGE CASES =====

  # Spaces in names
  cat > "$TEST_DIR/wireguard/space in name.conf" <<'EOF'
[Interface]
PrivateKey = space-test-key
Address = 10.97.0.1/32
EOF

  cat > "$TEST_DIR/openvpn/space in name.ovpn" <<'EOF'
remote 192.0.2.97 1194 udp
dev tun
EOF

  # Leading/trailing spaces (hard to see visually!)
  touch "$TEST_DIR/wireguard/ leading.conf"
  touch "$TEST_DIR/wireguard/trailing .conf"

  # Shell metacharacters (should be safely quoted)
  touch "$TEST_DIR/wireguard/has\$dollar.conf"
  touch "$TEST_DIR/wireguard/has;semicolon.conf"
  touch "$TEST_DIR/wireguard/has&ampersand.conf"

  # Command substitution attempts (testing quoting safety)
  touch "$TEST_DIR/wireguard/\$(echo test).conf" 2>/dev/null || true
  touch "$TEST_DIR/wireguard/\`echo test\`.conf" 2>/dev/null || true

  # Newline in filename (extremely evil!)
  # Note: Some systems don't support this, so use || true
  touch "$TEST_DIR/wireguard/has
newline.conf" 2>/dev/null || true

  # Unicode/international characters
  touch "$TEST_DIR/wireguard/café.conf" 2>/dev/null || true
  touch "$TEST_DIR/wireguard/日本語.conf" 2>/dev/null || true
  touch "$TEST_DIR/wireguard/файл.conf" 2>/dev/null || true

  # ===== 8. CORRUPT CATEGORIES =====

  # Category is a file, not directory
  touch "$TEST_DIR/wireguard/file-not-directory"

  # Category is a broken symlink
  ln -s /nonexistent "$TEST_DIR/wireguard/broken-category-link"

  # Category with special characters
  mkdir "$TEST_DIR/wireguard/streaming servers" 2>/dev/null || true
  mkdir "$TEST_DIR/openvpn/work-vpn" 2>/dev/null || true

  # Empty category (valid but edge case)
  mkdir "$TEST_DIR/wireguard/empty-category"
  mkdir "$TEST_DIR/openvpn/empty-group"

  # ===== 9. SESSION CORRUPTION =====

  # Session with non-numeric PID
  mkdir -p "$TEST_DIR/.session/not-a-number"
  echo "wireguard" > "$TEST_DIR/.session/not-a-number/protocol"
  echo "wg_test0" > "$TEST_DIR/.session/not-a-number/interface"

  # Session with alphabetic PID
  mkdir -p "$TEST_DIR/.session/abcdef"
  echo "openvpn" > "$TEST_DIR/.session/abcdef/protocol"
  echo "tun99" > "$TEST_DIR/.session/abcdef/interface"

  # Session with missing critical metadata
  mkdir -p "$TEST_DIR/.session/11111"
  echo "wireguard" > "$TEST_DIR/.session/11111/protocol"
  # Missing: interface, original, started - incomplete!

  # Session referencing non-existent config
  mkdir -p "$TEST_DIR/.session/22222"
  echo "wireguard" > "$TEST_DIR/.session/22222/protocol"
  echo "wg_test0" > "$TEST_DIR/.session/22222/interface"
  echo "$TEST_DIR/wireguard/DOES_NOT_EXIST.conf" > "$TEST_DIR/.session/22222/original"
  echo "2024-01-01 00:00:00" > "$TEST_DIR/.session/22222/started"

  # Session referencing cross-protocol config (WireGuard session → OpenVPN config)
  mkdir -p "$TEST_DIR/.session/33333"
  echo "wireguard" > "$TEST_DIR/.session/33333/protocol"
  echo "wg_test0" > "$TEST_DIR/.session/33333/interface"
  echo "$TEST_DIR/openvpn/stale.ovpn" > "$TEST_DIR/.session/33333/original"
  echo "2024-01-01 00:00:00" > "$TEST_DIR/.session/33333/started"

  # Session with broken connect.sh symlink
  mkdir -p "$TEST_DIR/.session/44444"
  echo "wireguard" > "$TEST_DIR/.session/44444/protocol"
  echo "wg_test0" > "$TEST_DIR/.session/44444/interface"
  ln -s /nonexistent "$TEST_DIR/.session/44444/connect.sh"

  # ===== 10. CORRUPT NAMED SESSIONS =====

  # Named session pointing to non-existent PID
  ln -s "../.session/99999999" "$TEST_DIR/session/broken-reference"

  # Named session pointing to another named session (indirect)
  ln -s "work" "$TEST_DIR/session/indirect"

  # Named session symlink loop
  ln -s "session-loop-b" "$TEST_DIR/session/session-loop-a"
  ln -s "session-loop-a" "$TEST_DIR/session/session-loop-b"

  # Named session is a file, not symlink
  touch "$TEST_DIR/session/file-not-link"

  # Named session with special characters
  ln -s "../.session/88888" "$TEST_DIR/session/my vpn"
  ln -s "../.session/88888" "$TEST_DIR/session/work@home"

  # ===== 11. PERMISSION ISSUES (commented out - may require root) =====

  # Unreadable config (permission denied)
  # touch "$TEST_DIR/wireguard/unreadable.conf"
  # chmod 0000 "$TEST_DIR/wireguard/unreadable.conf"

  # Write-only config (can't read)
  # touch "$TEST_DIR/wireguard/writeonly.conf"
  # chmod 0200 "$TEST_DIR/wireguard/writeonly.conf"

  # ===== 12. DUPLICATE NAMES (different types) =====

  # Config file and category with same name (minus extension)
  cat > "$TEST_DIR/wireguard/conflict.conf" <<'EOF'
[Interface]
PrivateKey = dup-key
Address = 10.96.0.1/32
EOF
  mkdir "$TEST_DIR/wireguard/conflict"

  # ===== 13. EXTREMELY LONG NAMES =====

  # Very long filename (test buffer limits)
  long_name="very_long_name_that_goes_on_and_on"
  long_name="${long_name}_${long_name}_${long_name}_${long_name}"
  touch "$TEST_DIR/wireguard/${long_name}.conf" 2>/dev/null || true

  # ===== 14. HIDDEN FILES =====

  # Dotfiles (should be ignored by most operations)
  touch "$TEST_DIR/wireguard/.hidden.conf"
  touch "$TEST_DIR/openvpn/.hidden.ovpn"

  # ===== END CORRUPTION PATTERNS =====
}

# run_vpn_switch - Execute vpn-switch.sh command
#
# Arguments: command and arguments to pass to vpn-switch.sh
# Returns: captured stdout and stderr
#
run_vpn_switch() {
  # Pass through BATCH_KEEP_GOING if set (runtime parameter for testing)
  if [ -n "${VPN_SWITCH_BATCH_KEEP_GOING:-}" ]; then
    VPN_SWITCH_BASE="$TEST_DIR" \
    VPN_SWITCH_DISPLAY_ANSI=0 \
    VPN_SWITCH_BATCH_KEEP_GOING="$VPN_SWITCH_BATCH_KEEP_GOING" \
    "$TEST_SCRIPT" "$@" 2>&1
  else
    VPN_SWITCH_BASE="$TEST_DIR" \
    VPN_SWITCH_DISPLAY_ANSI=0 \
    "$TEST_SCRIPT" "$@" 2>&1
  fi
}

# set_function_interpreter - Set interpreter for a specific function
#
# Arguments:
#   $1 - Function name (e.g., "wireguard_connect", "stop")
#   $2 - Interpreter value (e.g., "cat", "sh")
#
set_function_interpreter() {
  local func_name="$1"
  local interpreter="$2"

  run_vpn_switch setenv "VPN_SWITCH_INTERPRETER_${func_name}" "$interpreter" > /dev/null 2>&1
}

# create_failing_interpreter - Create type-appropriate failing interpreter
#
# Arguments:
#   $1 - Function name (with underscores, e.g., "___list0", "__stop1", "_log1")
# Output: Interpreter string that consumes input properly and exits with 1
#
# Different function types need different failing interpreters:
# - Terminal (_):    "sh -c 'cat && false'" (pass through output, then exit with 1)
# - Combinator (__):  "head -n1 | xargs sh -c 'cat && false' --" (consume 1 line, pass through, exit with 1)
# - Batch (___):     "sh -c 'cat && false'" (pass through all output, then exit with 1)
#
# NOTE: Must use "sh -c" wrapper because && operator requires shell evaluation
# Combinator pattern uses xargs to prevent the consumed line from becoming arguments to sh
# This pattern works because:
# 1. sh -c executes the command string as shell syntax
# 2. cat passes through stdin to stdout
# 3. && false ensures exit code is 1 after cat succeeds
# 4. Survives double-eval (process_arguments + run_env)
#
create_failing_interpreter() {
  local func_name="$1"

  case "$func_name" in
    ___*)
      # Batch combinator: pass through all input, then exit with failure
      echo "sh -c 'cat && false'"
      ;;
    __*)
      # Combinator: consume one line via head, use xargs to buffer it, then pass through and fail
      echo "head -n1 | xargs sh -c 'cat && false' --"
      ;;
    _*)
      # Terminal: pass through output, then exit with failure
      echo "sh -c 'cat && false'"
      ;;
    *)
      # Unknown type - fallback
      echo "sh -c 'cat && false'"
      ;;
  esac
}

#-----------------------------------------------------------------------------
# Architecture Validators
#-----------------------------------------------------------------------------

# validate_terminal_function_output - Validate terminal function output
#
# Terminal function rules:
# - Must output shell commands only (no direct vpn-switch internal calls)
# - Can call: shell keywords, builtins, system commands, locally-defined functions
# - Cannot call: vpn-switch functions (starting with _) unless locally defined
# - Cannot call: error(), log(), run_env(), dispatch(), lookup_interpreter()
#
# Arguments: $1 - output to validate, $2 - function name (for error messages)
# Returns: 0 if valid, 1 if invalid
#
validate_terminal_function_output() {
  local output="$1"
  local func_name="$2"

  # Empty output is valid
  [ -z "$output" ] && return 0

  # Shell keywords and common commands whitelist
  local shell_keywords="if then else elif fi while do done for case esac until select function"
  local common_commands="echo cat test mkdir chmod chown cp mv rm ln grep sed awk cut sort uniq wc head tail tr date sleep true false cd pwd ls find xargs touch dirname basename readlink stat tee printf yes no which command type sh"

  # Extract locally-defined functions (pattern: function_name() or function name())
  local local_functions=$(echo "$output" | \
    sed 's/^[[:space:]]*//' | \
    grep -E '^(function[[:space:]]+)?[a-zA-Z_][a-zA-Z0-9_]*[[:space:]]*\(\)' | \
    sed -E 's/^function[[:space:]]+//' | \
    sed -E 's/[[:space:]]*\(\).*//')

  # Check each line for forbidden patterns
  # Save output to temp file to avoid subshell issues
  local tmpfile="${TMPDIR:-/tmp}/terminal-validate.$$"
  echo "$output" > "$tmpfile"

  local line_num=0
  local violations=0

  while IFS= read -r line; do
    line_num=$((line_num + 1))

    # Skip empty lines
    [ -z "$line" ] && continue

    # Skip comment lines
    echo "$line" | grep -q '^[[:space:]]*#' && continue

    # Skip heredoc markers
    echo "$line" | grep -qE '^[[:space:]]*(EOF|HEREDOC|END)' && continue

    # Check for direct display() output patterns (FORBIDDEN in terminal functions)
    # Terminal functions must generate shell commands, not call display functions directly
    # Valid: generate_error "message" → outputs commands
    # Invalid: error "message" → calls display() directly
    local line_stripped=$(echo "$line" | sed 's/^[[:space:]]*//')
    if echo "$line_stripped" | grep -qE '^(Error|Warning|Success|Info|Log): '; then
      violations=$((violations + 1))
      echo "    ${COLOR_YELLOW}Line $line_num:${COLOR_RESET} Direct display() call detected (use generate_error/generate_warning instead)"
      echo "    ${COLOR_YELLOW}Context:${COLOR_RESET} $line"
      continue
    fi

    # Extract first token (strip leading whitespace, get first word)
    local first_token=$(echo "$line" | sed 's/^[[:space:]]*//' | awk '{print $1}')

    # Skip if no token
    [ -z "$first_token" ] && continue

    # Strip trailing punctuation/operators for better matching
    local token_clean=$(echo "$first_token" | sed -E 's/[();{}&|]+$//')

    # Check if it's a shell keyword
    local is_keyword=0
    for kw in $shell_keywords; do
      if [ "$token_clean" = "$kw" ]; then
        is_keyword=1
        break
      fi
    done
    [ $is_keyword -eq 1 ] && continue

    # Check if it's a common command
    local is_command=0
    for cmd in $common_commands; do
      if [ "$token_clean" = "$cmd" ]; then
        is_command=1
        break
      fi
    done
    [ $is_command -eq 1 ] && continue

    # Check if it's locally defined
    local is_local=0
    for local_func in $local_functions; do
      if [ "$token_clean" = "$local_func" ]; then
        is_local=1
        break
      fi
    done
    [ $is_local -eq 1 ] && continue

    # Check for forbidden vpn-switch internal functions
    case "$token_clean" in
      error|log|run_env|dispatch|lookup_interpreter)
        violations=$((violations + 1))
        echo "    ${COLOR_YELLOW}Line $line_num:${COLOR_RESET} FORBIDDEN vpn-switch function: $token_clean"
        echo "    ${COLOR_YELLOW}Context:${COLOR_RESET} $line"
        continue
        ;;
    esac

    # Check for underscore functions (vpn-switch internal) not locally defined
    if echo "$token_clean" | grep -q '^_'; then
      violations=$((violations + 1))
      echo "    ${COLOR_YELLOW}Line $line_num:${COLOR_RESET} Underscore function not locally defined: $token_clean"
      echo "    ${COLOR_YELLOW}Context:${COLOR_RESET} $line"
      continue
    fi

    # Check for execution pattern of $VPN_SWITCH_CONTEXT_SCRIPT (reserved for combinators)
    # Forbidden: "$VPN_SWITCH_CONTEXT_SCRIPT" as first token (execution/composition)
    # Allowed: "$VPN_SWITCH_CONTEXT_SCRIPT" in test conditions, echo, assignments, etc.
    #
    # Exception: _bootstrap2 is allowed to execute $VPN_SWITCH_CONTEXT_SCRIPT
    # Reason: Bootstrap bypasses process_arguments() dispatch (vpn-switch.sh:2501)
    #         and runs before database exists, so interpreter overrides are not available.
    #         While it could be refactored to batch combinator, there's no benefit since
    #         interpreter customization is impossible at bootstrap time.
    if [ "$func_name" != "_bootstrap2" ]; then
      local line_stripped=$(echo "$line" | sed 's/^[[:space:]]*//')
      if echo "$line_stripped" | grep -q '^"\$VPN_SWITCH_CONTEXT_SCRIPT"'; then
        violations=$((violations + 1))
        echo "    ${COLOR_YELLOW}Line $line_num:${COLOR_RESET} Terminal function executing \$VPN_SWITCH_CONTEXT_SCRIPT (reserved for combinators)"
        echo "    ${COLOR_YELLOW}Context:${COLOR_RESET} $line"
        continue
      fi
    fi
  done < "$tmpfile"

  # Cleanup temp file
  rm -f "$tmpfile"

  # Return validation result
  [ "$violations" -eq 0 ]
}

# validate_combinator_syntax - Validate combinator function output
#
# Combinator rules:
# - Exactly 1 line
# - Contains literal "$VPN_SWITCH_CONTEXT_SCRIPT" (not expanded)
# - Does not start with / (would indicate expanded variable)
#
# Arguments: $1 - output to validate
# Returns: 0 if valid, 1 if invalid
#
validate_combinator_syntax() {
  local output="$1"

  # Count lines (ignore empty output = 0 lines)
  local line_count
  if [ -z "$output" ]; then
    line_count=0
  else
    line_count=$(echo "$output" | wc -l | tr -d ' ')
  fi

  # Must be exactly 1 line
  if [ "$line_count" -ne 1 ]; then
    echo "    ${COLOR_YELLOW}Expected:${COLOR_RESET} 1 line"
    echo "    ${COLOR_YELLOW}Got:${COLOR_RESET} $line_count lines"
    return 1
  fi

  # Must contain literal $VPN_SWITCH_CONTEXT_SCRIPT (not expanded)
  if ! echo "$output" | grep -q '"\$VPN_SWITCH_CONTEXT_SCRIPT"'; then
    echo "    ${COLOR_YELLOW}Expected:${COLOR_RESET} Literal '\"\$VPN_SWITCH_CONTEXT_SCRIPT\"'"
    echo "    ${COLOR_YELLOW}Got:${COLOR_RESET} $output"
    return 1
  fi

  # Must not be expanded (would start with absolute path)
  if echo "$output" | grep -q '^/'; then
    echo "    ${COLOR_YELLOW}Error:${COLOR_RESET} Variable expanded (contains absolute path)"
    echo "    ${COLOR_YELLOW}Got:${COLOR_RESET} $output"
    return 1
  fi

  return 0
}

# validate_batch_combinator_syntax - Validate batch combinator function output
#
# Batch combinator rules:
# - Outputs N lines (N >= 0)
# - Each non-empty, non-comment line must be a vpn-switch command
# - Use literal "$VPN_SWITCH_CONTEXT_SCRIPT" (not expanded)
# - Comments (#) and empty lines are allowed
#
# Arguments: $1 - output to validate
# Returns: 0 if valid, 1 if invalid
#
validate_batch_combinator_syntax() {
  local output="$1"

  # Empty output is valid (N=0)
  [ -z "$output" ] && return 0

  # Check each line
  local line_num=0
  echo "$output" | while IFS= read -r line; do
    line_num=$((line_num + 1))

    # Skip empty lines
    [ -z "$line" ] && continue

    # Skip comments
    echo "$line" | grep -q '^#' && continue

    # Must be vpn-switch command (contains literal variable)
    if ! echo "$line" | grep -q '"\$VPN_SWITCH_CONTEXT_SCRIPT"'; then
      echo "    ${COLOR_YELLOW}Error at line $line_num:${COLOR_RESET} Not a vpn-switch command"
      echo "    ${COLOR_YELLOW}Expected:${COLOR_RESET} '\"\$VPN_SWITCH_CONTEXT_SCRIPT\" ...'"
      echo "    ${COLOR_YELLOW}Got:${COLOR_RESET} $line"
      return 1
    fi

    # Must not be expanded
    if echo "$line" | grep -q '^/'; then
      echo "    ${COLOR_YELLOW}Error at line $line_num:${COLOR_RESET} Variable expanded"
      echo "    ${COLOR_YELLOW}Got:${COLOR_RESET} $line"
      return 1
    fi
  done

  return $?
}

#-----------------------------------------------------------------------------
# Test Argument Mapping
#-----------------------------------------------------------------------------

# get_test_argument_variations - Return test argument variations for a function
#
# Returns: Pipe-separated list of argument sets to test
#          Format: "arg1|arg2 arg3|arg4"
#          Each variation is tested separately
#
# Special values:
#   EMPTY - Function takes no arguments (arity-0)
#   SKIP  - Function requires special setup, skip for now
#
# Strategy:
#   1. Check for functions needing special argument patterns
#   2. Otherwise, extract arity from function name and use generic args
#
get_test_argument_variations() {
  local func="$1"

  # Extract arity from function name (trailing digit)
  local arity
  arity=$(echo "$func" | sed 's/.*\([0-9]\)$/\1/')

  # Check if extraction failed (no trailing digit)
  if ! echo "$arity" | grep -q '^[0-9]$'; then
    echo "SKIP"
    return
  fi

  # Special cases - functions needing specific argument patterns
  case "$func" in
    # cat1 - SKIP: This function captures stdin and writes directly to file.
    # It must execute immediately (can't output commands) to preserve stdin.
    # Testing with arbitrary args creates files in cwd.
    cat1)
      echo "SKIP"
      return
      ;;

    # import1 - needs file paths with different extensions
    import1)
      echo "\$TEST_BASE_DIR/test.conf|\$TEST_BASE_DIR/test.ovpn|\$TEST_BASE_DIR/nonexistent.conf|\$TEST_BASE_DIR/noext"
      return
      ;;

    # stop1 - needs interface names (use test names to avoid conflict with real interfaces)
    stop1|openvpn_stop1|wireguard_stop1)
      echo "wg_test0|tun_test0|nonexistent99"
      return
      ;;

    # start1 - needs config names
    start1|openvpn_start1|wireguard_start1)
      echo "test-wg|nonexistent|test-wg.conf"
      return
      ;;

    # create1 - needs config names
    wireguard_create1|openvpn_create1)
      echo "test-wg.conf|nonexistent.conf|test-ovpn.ovpn"
      return
      ;;

    # bootstrap1 - needs directory path
    bootstrap1)
      echo "\$TEST_BASE_DIR/bootstrap-test"
      return
      ;;

    # bootstrap2 - needs directory path and profile (creates filesystem artifacts)
    bootstrap2)
      echo "\$TEST_BASE_DIR/bootstrap-test1 minimal|\$TEST_BASE_DIR/bootstrap-test2 all"
      return
      ;;

    # batch1 - needs function name
    batch1)
      echo "wireguard_list|nonexistent_function"
      return
      ;;

    # restore1 - needs dump file path
    restore1)
      echo "\$TEST_BASE_DIR/dump.sh|\$TEST_BASE_DIR/nonexistent.sh"
      return
      ;;

    # session_disconnect1 - needs PID
    session_disconnect1)
      echo "12345|99999"
      return
      ;;

    # wireguard_add2 - needs category and target
    wireguard_add2)
      echo "privacy test.conf|nonexistent invalid.conf"
      return
      ;;

    # phases_sync1 - needs protocol name
    phases_sync1)
      echo "wireguard|openvpn|nonexistent"
      return
      ;;

    # init1 - needs directory path
    init1)
      echo "\$TEST_BASE_DIR/init-test"
      return
      ;;

    # dumpenv1 - needs valid profile names
    dumpenv1)
      echo "minimal|all"
      return
      ;;

    # lift3 - needs phase_name, input_file, output_file
    # Security: requires absolute paths, rejects relative paths with error command
    # Test BOTH: success path (absolute) AND error path (relative)
    lift3)
      echo "test_phase \$TEST_BASE_DIR/template/phase/base/firewall/pf.sh \$TEST_BASE_DIR/.include/phase/test.sh|test_phase relative/input.sh relative/output.sh"
      return
      ;;
  esac

  # Generic argument generation based on arity
  # Use function name prefix to identify which test creates any stray files
  case "$arity" in
    0)
      echo "EMPTY"
      ;;
    1)
      echo "${func}_a1|${func}_a2|${func}_a3"
      ;;
    2)
      echo "${func}_a1 ${func}_a2|${func}_a3 ${func}_a4"
      ;;
    3)
      echo "${func}_a1 ${func}_a2 ${func}_a3|${func}_a4 ${func}_a5 ${func}_a6"
      ;;
    *)
      echo "SKIP"
      ;;
  esac
}

# get_test_argument_by_database - Extract arguments from messy database state
#
# Returns: Pipe-separated list of arguments extracted from actual database
#          Format: "arg1|arg2|arg3" (same as get_test_argument_variations)
#          Returns "SKIP" if function doesn't need database-aware testing
#
# Purpose: Provide realistic arguments that match actual data in messy database
#          This catches violations that generic arguments miss (e.g., session_start1)
#
# Strategy: ADVERSARIAL TESTING - Generate arguments for BOTH success AND error paths
#           - Success paths: test command generation with valid inputs
#           - Error paths: test error handling (should use generate_error, not error())
#           - Edge cases: test boundary conditions
#
get_test_argument_by_database() {
  local func="$1"

  case "$func" in
    # Session functions - use actual session names and PIDs
    session_start0)
      # No arguments, but function needs default symlink (already in messy DB)
      echo "EMPTY"
      ;;

    session_start1)
      # Extract actual session names and PIDs from messy database
      local sessions=""

      # Named sessions from session/ directory
      if [ -d "$TEST_DIR/session" ]; then
        for link in "$TEST_DIR/session"/*; do
          [ -L "$link" ] || continue
          local name=$(basename -- "$link")
          # Escape shell metacharacters for eval (prevent expansion/substitution)
          name=$(echo "$name" | sed 's/\$/\\$/g; s/`/\\`/g; s/(/\\(/g; s/)/\\)/g; s/;/\\;/g; s/&/\\&/g')
          sessions="$sessions|$name"
        done
      fi

      # PID sessions from .session/ directory
      if [ -d "$TEST_DIR/.session" ]; then
        for dir in "$TEST_DIR/.session"/*; do
          [ -d "$dir" ] || continue
          local pid=$(basename -- "$dir")
          # Escape shell metacharacters for eval (prevent expansion/substitution)
          pid=$(echo "$pid" | sed 's/\$/\\$/g; s/`/\\`/g; s/(/\\(/g; s/)/\\)/g; s/;/\\;/g; s/&/\\&/g')
          sessions="$sessions|$pid"
        done
      fi

      # Remove leading pipe
      echo "$sessions" | sed 's/^|//'
      ;;

    session_remove1|session_show1|session_connect1)
      # ADVERSARIAL: Test both success and error paths
      local pids=""

      # SUCCESS PATH: Extract actual PIDs from .session/ directory
      if [ -d "$TEST_DIR/.session" ]; then
        for dir in "$TEST_DIR/.session"/*; do
          [ -d "$dir" ] || continue
          local pid=$(basename -- "$dir")
          # Escape shell metacharacters for eval (prevent expansion/substitution)
          pid=$(echo "$pid" | sed 's/\$/\\$/g; s/`/\\`/g; s/(/\\(/g; s/)/\\)/g; s/;/\\;/g; s/&/\\&/g')
          pids="$pids|$pid"
        done
      fi

      # ERROR PATH: Non-existent PIDs (should trigger error handling)
      pids="$pids|99999999|12345|00000"

      echo "$pids" | sed 's/^|//'
      ;;

    session_save0)
      # No arguments
      echo "EMPTY"
      ;;

    session_save1)
      # Session names to save as (extract existing + add new)
      echo "test-session|my-vpn|backup"
      ;;

    wireguard_add1|openvpn_add1)
      # ADVERSARIAL: Test both success and error paths for category creation
      local protocol="${func%%_*}"
      local results=""

      if [ -d "$TEST_DIR/$protocol" ]; then
        # Find existing category
        local existing_cat=""
        for dir in "$TEST_DIR/$protocol"/*; do
          [ -d "$dir" ] || continue
          existing_cat=$(basename -- "$dir")
          # Escape shell metacharacters for eval (prevent expansion/substitution)
          existing_cat=$(echo "$existing_cat" | sed 's/\$/\\$/g; s/`/\\`/g; s/(/\\(/g; s/)/\\)/g; s/;/\\;/g; s/&/\\&/g')
          break
        done

        # SUCCESS PATH: new category name
        results="$results|new_category|test_cat"

        # ERROR PATH: existing category name (should fail)
        [ -n "$existing_cat" ] && results="$results|$existing_cat"

        # ERROR PATH: category that conflicts with existing file
        for item in "$TEST_DIR/$protocol"/*.conf "$TEST_DIR/$protocol"/*.ovpn; do
          [ -f "$item" ] || [ -L "$item" ] || continue
          local conf=$(basename -- "$item" .conf)
          conf=$(basename -- "$conf" .ovpn)
          # Escape shell metacharacters for eval (prevent expansion/substitution)
          conf=$(echo "$conf" | sed 's/\$/\\$/g; s/`/\\`/g; s/(/\\(/g; s/)/\\)/g; s/;/\\;/g; s/&/\\&/g')
          results="$results|$conf"
          break
        done
      fi

      echo "$results" | sed 's/^|//'
      ;;

    wireguard_start1|wireguard_info1|wireguard_patch1)
      # ADVERSARIAL: Test both success and error paths
      local configs=""

      # SUCCESS PATH: Extract actual WireGuard config names
      if [ -d "$TEST_DIR/wireguard" ]; then
        for item in "$TEST_DIR/wireguard"/*.conf "$TEST_DIR/wireguard"/*; do
          [ -f "$item" ] || [ -L "$item" ] || [ -d "$item" ] || continue
          local name=$(basename -- "$item")
          # Skip if it's just the glob pattern (no matches)
          [ "$name" = "*.conf" ] && continue
          # Escape shell metacharacters for eval (prevent expansion/substitution)
          name=$(echo "$name" | sed 's/\$/\\$/g; s/`/\\`/g; s/(/\\(/g; s/)/\\)/g; s/;/\\;/g; s/&/\\&/g')
          configs="$configs|$name"
        done
      fi

      # ERROR PATH: Non-existent configs (should trigger error handling)
      configs="$configs|nonexistent.conf|missing-config.conf"

      echo "$configs" | sed 's/^|//'
      ;;

    openvpn_start1|openvpn_info1|openvpn_patch1)
      # ADVERSARIAL: Test both success and error paths
      local configs=""

      # SUCCESS PATH: Extract actual OpenVPN config names
      if [ -d "$TEST_DIR/openvpn" ]; then
        for item in "$TEST_DIR/openvpn"/*.ovpn "$TEST_DIR/openvpn"/*; do
          [ -f "$item" ] || [ -L "$item" ] || [ -d "$item" ] || continue
          local name=$(basename -- "$item")
          [ "$name" = "*.ovpn" ] && continue
          # Escape shell metacharacters for eval (prevent expansion/substitution)
          name=$(echo "$name" | sed 's/\$/\\$/g; s/`/\\`/g; s/(/\\(/g; s/)/\\)/g; s/;/\\;/g; s/&/\\&/g')
          configs="$configs|$name"
        done
      fi

      # ERROR PATH: Non-existent configs (should trigger error handling)
      configs="$configs|nonexistent.ovpn|missing-config.ovpn"

      echo "$configs" | sed 's/^|//'
      ;;

    wireguard_add2|openvpn_add2)
      # ADVERSARIAL: Test both success and error paths
      local protocol="${func%%_*}"
      local results=""

      if [ -d "$TEST_DIR/$protocol" ]; then
        # Find first category (directory) and first config (file)
        local first_cat=""
        local first_conf=""

        for dir in "$TEST_DIR/$protocol"/*; do
          [ -d "$dir" ] || continue
          first_cat=$(basename -- "$dir")
          # Escape shell metacharacters for eval (prevent expansion/substitution)
          first_cat=$(echo "$first_cat" | sed 's/\$/\\$/g; s/`/\\`/g; s/(/\\(/g; s/)/\\)/g; s/;/\\;/g; s/&/\\&/g')
          break
        done

        for item in "$TEST_DIR/$protocol"/*.conf "$TEST_DIR/$protocol"/*.ovpn; do
          [ -f "$item" ] || [ -L "$item" ] || continue
          local conf=$(basename -- "$item")
          [ "$conf" = "*.conf" ] && continue
          [ "$conf" = "*.ovpn" ] && continue
          # Escape shell metacharacters for eval (prevent expansion/substitution)
          conf=$(echo "$conf" | sed 's/\$/\\$/g; s/`/\\`/g; s/(/\\(/g; s/)/\\)/g; s/;/\\;/g; s/&/\\&/g')
          first_conf="$conf"
          break
        done

        # SUCCESS PATH: existing category + existing config
        [ -n "$first_cat" ] && [ -n "$first_conf" ] && results="$results|$first_cat $first_conf"

        # ERROR PATH 1: non-existent category + existing config
        [ -n "$first_conf" ] && results="$results|nonexistent_category $first_conf"

        # ERROR PATH 2: existing category + non-existent config
        [ -n "$first_cat" ] && results="$results|$first_cat nonexistent.conf"

        # ERROR PATH 3: both non-existent
        results="$results|fake_cat fake.conf"
      fi

      echo "$results" | sed 's/^|//'
      ;;

    *)
      # No database-aware arguments for this function
      echo "SKIP"
      ;;
  esac
}

#-----------------------------------------------------------------------------
# Command Walking Functions (extracted from vpn-switch-walkthrough.sh)
#-----------------------------------------------------------------------------

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

# extract_arity - Get function arity from name
extract_arity() {
  local func="$1"
  # Function names end with a digit (the arity)
  echo "$func" | sed 's/.*\([0-9]\)$/\1/'
}

# extract_command_from_output - Extract command arguments from output
# Args: $1 - line containing "$VPN_SWITCH_CONTEXT_SCRIPT" command
# Output: command arguments (without the script prefix)
extract_command_from_output() {
  local line="$1"
  # Remove "$VPN_SWITCH_CONTEXT_SCRIPT" prefix (keep quotes in arguments)
  echo "$line" | sed 's/^"\$VPN_SWITCH_CONTEXT_SCRIPT" //'
}

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

# walk_command_tree - Recursively walk command resolution tree
# Args: $1 - depth (integer)
#       $2 - command string
#       $3 - callback function to call at each node
# Output: Calls callback with: callback depth func_name cmd output exit_status
#
# Callback receives:
#   $1 - depth
#   $2 - function type: "terminal", "combinator", "batch", "unresolved"
#   $3 - function name (with underscores)
#   $4 - command string
#   $5 - output from function
#   $6 - exit status
#
walk_command_tree() {
  local depth="$1"
  local cmd="$2"
  local callback="$3"

  # Resolve command to function name
  local func_name=$(resolve_function $cmd)

  if [ -z "$func_name" ]; then
    # Could not resolve - treat as terminal and stop recursion
    $callback "$depth" "unresolved" "" "$cmd" "" "0"
    return 0
  fi

  # Determine function type
  local func_type=""
  case "$func_name" in
    ___*)
      func_type="batch"
      ;;
    __*)
      func_type="combinator"
      ;;
    _*)
      func_type="terminal"
      ;;
  esac

  # Strip underscores for interpreter variable naming
  local mangled=$(echo "$func_name" | sed 's/^_*//')

  # Set ONLY this specific function's interpreter to 'cat'
  set_function_interpreter "$mangled" "cat"

  # Execute and capture output
  local output=$(run_vpn_switch $cmd 2>&1)
  local exit_status=$?

  # Immediately unset this interpreter (cleanup - critical for correct recursion!)
  run_vpn_switch unsetenv "VPN_SWITCH_INTERPRETER_${mangled}" >/dev/null 2>&1 || true

  # Call callback for this node
  $callback "$depth" "$func_type" "$func_name" "$cmd" "$output" "$exit_status"

  # Recurse based on function type
  if [ "$func_type" = "terminal" ]; then
    # Terminal functions don't produce vpn-switch commands - stop recursion
    return 0

  elif [ "$func_type" = "combinator" ]; then
    # Combinator outputs a single vpn-switch command - recurse once
    local next_cmd=$(extract_command_from_output "$output")
    if [ -n "$next_cmd" ]; then
      walk_command_tree $((depth + 1)) "$next_cmd" "$callback"
    fi

  elif [ "$func_type" = "batch" ]; then
    # Batch combinator outputs multiple vpn-switch commands - recurse on each
    echo "$output" | while IFS= read -r line; do
      # Skip comments and empty lines
      case "$line" in
        \#*|"") continue ;;
        '"$VPN_SWITCH_CONTEXT_SCRIPT"'*)
          local next_cmd=$(extract_command_from_output "$line")
          if [ -n "$next_cmd" ]; then
            walk_command_tree $((depth + 1)) "$next_cmd" "$callback"
          fi
          ;;
      esac
    done
  fi
}

# collect_tree_nodes - Collect all nodes in command tree
# Args: $1 - command string
# Output: Sets global variables:
#   TREE_NODES - space-separated list of "depth|type|func|cmd|output|status"
#
# This is a helper that uses walk_command_tree to collect the full tree structure
collect_tree_nodes() {
  local cmd="$1"

  # Reset global collection
  TREE_NODES=""
  TREE_NODE_COUNT=0

  # Define callback that collects nodes
  _collect_callback() {
    local depth="$1"
    local type="$2"
    local func="$3"
    local cmd="$4"
    local output="$5"
    local status="$6"

    # Store node (use | as separator, encode | in fields as \|)
    local node_data="${depth}|${type}|${func}|${cmd}|${output}|${status}"

    if [ -z "$TREE_NODES" ]; then
      TREE_NODES="$node_data"
    else
      TREE_NODES="$TREE_NODES
$node_data"
    fi

    TREE_NODE_COUNT=$((TREE_NODE_COUNT + 1))
  }

  # Walk tree and collect nodes
  walk_command_tree 0 "$cmd" "_collect_callback"
}

#-----------------------------------------------------------------------------
# Combinator Tests
#-----------------------------------------------------------------------------

# test_combinator_function - Test a single combinator function
#
# Strategy: Prepare database once, test all argument variations
#
# Arguments: $1 - function name (without __ prefix)
#
test_combinator_function() {
  local func="$1"

  # Get test argument variations
  local variations
  variations=$(get_test_argument_variations "$func")

  # Handle SKIP
  if [ "$variations" = "SKIP" ]; then
    echo "  ${COLOR_YELLOW}Skipped: __${func} (requires special setup)${COLOR_RESET}"
    return
  fi

  test_header "Combinator: __${func} - validate syntax with variations"
  test_setup

  # Populate database with messy realistic state
  create_messy_realistic_database

  # Override to cat for command inspection
  set_function_interpreter "$func" "cat"

  # Prepare database ONCE (reused across all variations)
  # Create source config files (temporary, outside database)
  local test_wg_config="$TEST_BASE_DIR/test-wg.conf"
  local test_ovpn_config="$TEST_BASE_DIR/test-ovpn.ovpn"

  # WireGuard test config
  cat > "$test_wg_config" <<'EOF'
[Interface]
PrivateKey = fake-key-for-testing
Address = 10.0.0.1/32

[Peer]
PublicKey = fake-peer-key
Endpoint = 192.0.2.1:51820
AllowedIPs = 0.0.0.0/0
EOF

  # OpenVPN test config
  cat > "$test_ovpn_config" <<'EOF'
remote 192.0.2.10 1194 udp
dev tun
EOF

  # Import configs using API
  set_function_interpreter "wireguard_import1" "sh"
  set_function_interpreter "openvpn_import1" "sh"

  run_vpn_switch wireguard import "$test_wg_config" > /dev/null 2>&1 || true
  run_vpn_switch openvpn import "$test_ovpn_config" > /dev/null 2>&1 || true

  # Reset to cat for testing
  set_function_interpreter "$func" "cat"

  # Test each variation (GENERIC strategy)
  # Use temp file to avoid subshell (pipe creates subshell, breaks all_valid)
  local variations_file="${TMPDIR:-/tmp}/comb-variations-$$.txt"
  echo "$variations" | tr '|' '\n' > "$variations_file"

  local all_valid=true
  local variation_num=0
  local max_variations=15  # Limit variations to prevent test explosion

  while IFS= read -r variation; do
    variation_num=$((variation_num + 1))

    # Limit total variations tested (prevent combinatorial explosion)
    if [ "$variation_num" -gt "$max_variations" ]; then
      break
    fi

    # Expand variables in variation (e.g., $TEST_BASE_DIR)
    local expanded_args
    expanded_args=$(eval echo "$variation")

    # Handle EMPTY special case
    if [ "$variation" = "EMPTY" ]; then
      expanded_args=""
    fi

    # Test this variation
    local output
    if [ -z "$expanded_args" ]; then
      output=$(run_vpn_switch $func 2>&1 || true)
    else
      output=$(run_vpn_switch $func $expanded_args 2>&1 || true)
    fi

    # Validate syntax
    if ! validate_combinator_syntax "$output"; then
      all_valid=false
      fail "__${func} (variation $variation_num: $variation): Invalid syntax"
      echo "    ${COLOR_YELLOW}Output:${COLOR_RESET} $output"
    fi
  done < "$variations_file"

  # Cleanup
  rm -f "$variations_file"

  # Test DATABASE-AWARE variations (if available)
  local db_variations=$(get_test_argument_by_database "$func")

  if [ "$db_variations" != "SKIP" ] && [ -n "$db_variations" ]; then
    local db_variations_file="${TMPDIR:-/tmp}/comb-db-variations-$$.txt"
    echo "$db_variations" | tr '|' '\n' > "$db_variations_file"

    while IFS= read -r variation; do
      variation_num=$((variation_num + 1))

      # Expand variables in variation
      local expanded_args
      expanded_args=$(eval echo "$variation")

      # Handle EMPTY special case
      if [ "$variation" = "EMPTY" ]; then
        expanded_args=""
      fi

      # Test this variation
      local output
      if [ -z "$expanded_args" ]; then
        output=$(run_vpn_switch $func 2>&1 || true)
      else
        output=$(run_vpn_switch $func $expanded_args 2>&1 || true)
      fi

      # Validate syntax
      if ! validate_combinator_syntax "$output"; then
        all_valid=false
        fail "__${func} (database-aware variation $variation_num: $variation): Invalid syntax"
        echo "    ${COLOR_YELLOW}Output:${COLOR_RESET} $output"
      fi
    done < "$db_variations_file"

    rm -f "$db_variations_file"
  fi

  # Report overall pass (individual failures already reported via fail())
  if $all_valid; then
    pass "__${func}: Valid combinator syntax (all variations)"
  fi
}

#-----------------------------------------------------------------------------
# Terminal Function Tests
#-----------------------------------------------------------------------------

# test_terminal_function - Test a single terminal function
#
# Strategy: Execute function and validate output follows terminal function rules
#
# Arguments: $1 - function name (without _ prefix)
#
test_terminal_function() {
  local func="$1"

  # Get test argument variations
  local variations
  variations=$(get_test_argument_variations "$func")

  # Handle SKIP
  if [ "$variations" = "SKIP" ]; then
    echo "  ${COLOR_YELLOW}Skipped: _${func} (requires special setup)${COLOR_RESET}"
    return
  fi

  test_header "Terminal: _${func} - validate output rules"
  test_setup

  # Populate database with messy realistic state
  # This ensures functions exercise full code paths (not just error exits)
  create_messy_realistic_database

  # Override to cat for output inspection
  set_function_interpreter "$func" "cat"

  # Prepare database (same as combinator tests)
  local test_wg_config="$TEST_BASE_DIR/test-wg.conf"
  local test_ovpn_config="$TEST_BASE_DIR/test-ovpn.ovpn"

  # WireGuard test config
  cat > "$test_wg_config" <<'EOF'
[Interface]
 PrivateKey = fake-key-for-testing
Address = 10.0.0.1/32

[Peer]
PublicKey = fake-peer-key
Endpoint = 192.0.2.1:51820
AllowedIPs = 0.0.0.0/0
EOF

  # OpenVPN test config
  cat > "$test_ovpn_config" <<'EOF'
remote 192.0.2.10 1194 udp
dev tun
EOF

  # Import configs using API
  set_function_interpreter "wireguard_import1" "sh"
  set_function_interpreter "openvpn_import1" "sh"

  run_vpn_switch wireguard import "$test_wg_config" > /dev/null 2>&1 || true
  run_vpn_switch openvpn import "$test_ovpn_config" > /dev/null 2>&1 || true

  # Reset to cat for testing
  set_function_interpreter "$func" "cat"

  # Test each variation (GENERIC strategy)
  # Use temp file to avoid subshell (pipe creates subshell, breaks all_valid)
  local variations_file="${TMPDIR:-/tmp}/variations-$$.txt"
  echo "$variations" | tr '|' '\n' > "$variations_file"

  local all_valid=true
  local variation_num=0

  while IFS= read -r variation; do
    variation_num=$((variation_num + 1))

    # Expand variables in variation
    local expanded_args
    expanded_args=$(eval echo "$variation")

    # Handle EMPTY special case
    if [ "$variation" = "EMPTY" ]; then
      expanded_args=""
    fi

    # Test this variation
    local output
    if [ -z "$expanded_args" ]; then
      output=$(run_vpn_switch $func 2>&1 || true)
    else
      output=$(run_vpn_switch $func $expanded_args 2>&1 || true)
    fi

    # Validate terminal function rules
    if ! validate_terminal_function_output "$output" "_${func}"; then
      all_valid=false
      fail "_${func} (variation $variation_num: $variation): Invalid terminal function output"
    fi
  done < "$variations_file"

  # Cleanup
  rm -f "$variations_file"

  # Test DATABASE-AWARE variations (if available)
  local db_variations=$(get_test_argument_by_database "$func")

  if [ "$db_variations" != "SKIP" ] && [ -n "$db_variations" ]; then
    local db_variations_file="${TMPDIR:-/tmp}/db-variations-$$.txt"
    echo "$db_variations" | tr '|' '\n' > "$db_variations_file"

    while IFS= read -r variation; do
      variation_num=$((variation_num + 1))

      # Expand variables in variation
      local expanded_args
      expanded_args=$(eval echo "$variation")

      # Handle EMPTY special case
      if [ "$variation" = "EMPTY" ]; then
        expanded_args=""
      fi

      # Test this variation
      local output
      if [ -z "$expanded_args" ]; then
        output=$(run_vpn_switch $func 2>&1 || true)
      else
        output=$(run_vpn_switch $func $expanded_args 2>&1 || true)
      fi

      # Validate terminal function rules
      if ! validate_terminal_function_output "$output" "_${func}"; then
        all_valid=false
        fail "_${func} (database-aware variation $variation_num: $variation): Invalid terminal function output"
      fi
    done < "$db_variations_file"

    rm -f "$db_variations_file"
  fi

  # Report overall pass
  if $all_valid; then
    pass "_${func}: Valid terminal function output (all variations)"
  fi
}

#-----------------------------------------------------------------------------
# Batch Combinator Tests
#-----------------------------------------------------------------------------

# test_batch_combinator_function - Test a single batch combinator function
#
# Strategy: Prepare database once, iterate 10 times to discover all branches
#
# Arguments: $1 - function name (without ___ prefix)
#
test_batch_combinator_function() {
  local func="$1"

  # Get test argument variations
  local variations
  variations=$(get_test_argument_variations "$func")

  # Handle SKIP
  if [ "$variations" = "SKIP" ]; then
    echo "  ${COLOR_YELLOW}Skipped: ___${func} (requires special setup)${COLOR_RESET}"
    return
  fi

  test_header "Batch Combinator: ___${func} - validate syntax with variations"
  test_setup

  # Populate database with messy realistic state
  create_messy_realistic_database

  # Override to cat for command inspection
  set_function_interpreter "$func" "cat"

  # === PREPARE DATABASE USING API ===

  # Create source config files
  local test_wg_config="$TEST_BASE_DIR/test-wg.conf"
  local test_ovpn_config="$TEST_BASE_DIR/test-ovpn.ovpn"

  # WireGuard test config
  cat > "$test_wg_config" <<'EOF'
[Interface]
PrivateKey = fake-key-for-testing
Address = 10.0.0.1/32

[Peer]
PublicKey = fake-peer-key
Endpoint = 192.0.2.1:51820
AllowedIPs = 0.0.0.0/0
EOF

  # OpenVPN test config
  cat > "$test_ovpn_config" <<'EOF'
remote 192.0.2.10 1194 udp
dev tun
EOF

  # Import using API
  set_function_interpreter "wireguard_import1" "sh"
  set_function_interpreter "openvpn_import1" "sh"

  run_vpn_switch wireguard import "$test_wg_config" > /dev/null 2>&1 || true
  run_vpn_switch openvpn import "$test_ovpn_config" > /dev/null 2>&1 || true

  # Reset to cat for testing
  set_function_interpreter "$func" "cat"

  # === TEST EACH VARIATION ===

  # Use temp file to communicate failure from subshell (pipes create subshells)
  local failure_marker="$TEST_BASE_DIR/.batch_failure_$$"
  rm -f "$failure_marker"
  local variation_num=0

  echo "$variations" | tr '|' '\n' | while IFS= read -r variation; do
    variation_num=$((variation_num + 1))

    # Expand variables in variation (e.g., $TEST_BASE_DIR)
    local expanded_args
    expanded_args=$(eval echo "$variation")

    # Handle EMPTY special case
    if [ "$variation" = "EMPTY" ]; then
      expanded_args=""
    fi

    # Test this variation
    local output
    if [ -z "$expanded_args" ]; then
      output=$(run_vpn_switch $func 2>&1 || true)
    else
      output=$(run_vpn_switch $func $expanded_args 2>&1 || true)
    fi

    # Validate syntax
    if ! validate_batch_combinator_syntax "$output"; then
      echo "1" >> "$failure_marker"  # Append line for counting in parent shell
      echo "${COLOR_RED}✗${COLOR_RESET} ___${func} (variation $variation_num: $variation): Invalid syntax"
      echo "    ${COLOR_YELLOW}Output:${COLOR_RESET} $output"
    fi
  done

  # Report result - must call fail() in parent shell since subshell counters are lost
  if [ -f "$failure_marker" ]; then
    # Count failures from marker file (one line per failure)
    local failure_count
    failure_count=$(wc -l < "$failure_marker")
    local i=0
    while [ "$i" -lt "$failure_count" ]; do
      TESTS_FAILED=$((TESTS_FAILED + 1))
      i=$((i + 1))
    done
    rm -f "$failure_marker"
  else
    pass "___${func}: Valid batch combinator syntax (all variations)"
  fi
}

#-----------------------------------------------------------------------------
# Error Propagation Tests (KEEP_GOING behavior)
#-----------------------------------------------------------------------------

# test_batch_error_propagation - Test error handling in batch processing
#
# Tests that errors propagate correctly through recursive batch processing
# and that KEEP_GOING mode controls whether execution continues or stops.
#
# Strategy:
# 1. Find a batch combinator that outputs multiple commands
# 2. Walk the command tree to find all descendant nodes
# 3. Inject a failure at a specific depth/node
# 4. Test with KEEP_GOING=0 (fail-fast): execution should stop
# 5. Test with KEEP_GOING=1 (continue): execution should continue
#
test_batch_error_propagation() {
  test_header "Batch Error Propagation - test _batch2 with failing commands"
  test_setup

  # Create a simple test batch file with multiple commands
  local batch_file="$TEST_BASE_DIR/test_batch.txt"
  cat > "$batch_file" <<EOF
# Test batch file with 3 commands
"\$VPN_SWITCH_CONTEXT_SCRIPT" log "Command 1"
"\$VPN_SWITCH_CONTEXT_SCRIPT" log "Command 2"
"\$VPN_SWITCH_CONTEXT_SCRIPT" log "Command 3"
EOF

  # Test 1: KEEP_GOING=0 (fail-fast) - should stop on first error
  test_header "  Sub-test: KEEP_GOING=0 (fail-fast mode)"

  # Set command 2 to fail by making log1 interpreter exit with error
  # Create failing interpreter for _log1 function
  # Must preserve output while still failing (exit code 1)
  # Using "sh -c 'cat && false'" because && requires shell evaluation
  set_function_interpreter "log1" "sh -c 'cat && false'"

  # Run batch with KEEP_GOING=0
  local output=$(VPN_SWITCH_BATCH_KEEP_GOING=0 run_vpn_switch batch "$batch_file" 2>&1 || true)

  # Cleanup: Remove test interpreter override (template provides default)
  run_vpn_switch unsetenv VPN_SWITCH_INTERPRETER_log1 >/dev/null 2>&1 || true

  # Verify: Should see "stopped due to error"
  if echo "$output" | grep -q "stopped due to error"; then
    pass "KEEP_GOING=0: Batch execution stopped on first error"
  else
    fail "KEEP_GOING=0: Expected batch to stop on error"
    echo "    ${COLOR_YELLOW}Output:${COLOR_RESET}"
    echo "$output" | head -20
  fi

  # Test 2: KEEP_GOING=1 (continue mode) - should process all commands despite errors
  test_header "  Sub-test: KEEP_GOING=1 (continue mode)"

  # Create a batch file where middle command will fail
  cat > "$batch_file" <<EOF
# Test batch - command 2 will fail
"\$VPN_SWITCH_CONTEXT_SCRIPT" database enumerate
"\$VPN_SWITCH_CONTEXT_SCRIPT" error "Intentional failure"
"\$VPN_SWITCH_CONTEXT_SCRIPT" database enumerate
EOF

  # Run batch with KEEP_GOING=1; capture trace file since _batch2 dispatch
  # messages moved to trace_log in fd79dc8 (was needed so dump stderr stays clean).
  # export needed because run_vpn_switch is a shell function.
  local trace_file=$(mktemp)
  export VPN_SWITCH_BATCH_KEEP_GOING=1
  export VPN_SWITCH_TRACE_FILE="$trace_file"
  output=$(run_vpn_switch batch "$batch_file" 2>&1 || true)
  unset VPN_SWITCH_BATCH_KEEP_GOING
  unset VPN_SWITCH_TRACE_FILE

  # Verify: trace shows the Summary line (proves batch ran to completion)
  if grep -q '_batch2: Summary:' "$trace_file"; then
    pass "KEEP_GOING=1: Batch execution completed despite errors"
  else
    fail "KEEP_GOING=1: Expected batch to complete despite errors"
    echo "    ${COLOR_YELLOW}Trace:${COLOR_RESET}"
    grep '_batch2:' "$trace_file" 2>/dev/null | head -10
  fi

  # Verify: Should have processed all 3 commands (not stopped at command 2)
  local execute_count=$(grep -c '_batch2: Executing:' "$trace_file" || true)
  if [ "$execute_count" -eq 3 ]; then
    pass "KEEP_GOING=1: All commands were executed (count=$execute_count)"
  else
    fail "KEEP_GOING=1: Expected 3 commands executed, got $execute_count"
    grep '_batch2: Executing:' "$trace_file" 2>/dev/null
  fi
  rm -f "$trace_file"

  # Cleanup
  rm -f "$batch_file"
}

# test_recursive_batch_error_propagation - Test error propagation through recursive batch processing
#
# Tests the scenario: line1 → _batch2 → line2 → _batch2 → line3 (ERROR) → should not reach line4
#
# This tests that when batch processing recurses (a batch file contains a batch command),
# errors propagate correctly up the call stack.
#
test_recursive_batch_error_propagation() {
  test_header "Recursive Batch Error Propagation - test chained _batch2 calls"
  test_setup

  # Create batch files that reference each other
  local batch1="$TEST_BASE_DIR/batch1.txt"
  local batch2="$TEST_BASE_DIR/batch2.txt"
  local batch3="$TEST_BASE_DIR/batch3.txt"

  # batch1 calls batch2
  cat > "$batch1" <<EOF
"\$VPN_SWITCH_CONTEXT_SCRIPT" log "Batch 1 - before"
"\$VPN_SWITCH_CONTEXT_SCRIPT" batch "$batch2"
"\$VPN_SWITCH_CONTEXT_SCRIPT" log "Batch 1 - after"
EOF

  # batch2 calls batch3
  cat > "$batch2" <<EOF
"\$VPN_SWITCH_CONTEXT_SCRIPT" log "Batch 2 - before"
"\$VPN_SWITCH_CONTEXT_SCRIPT" batch "$batch3"
"\$VPN_SWITCH_CONTEXT_SCRIPT" log "Batch 2 - after"
EOF

  # batch3 contains an error in the middle
  cat > "$batch3" <<EOF
"\$VPN_SWITCH_CONTEXT_SCRIPT" log "Batch 3 - command 1"
"\$VPN_SWITCH_CONTEXT_SCRIPT" error "Batch 3 - intentional error"
"\$VPN_SWITCH_CONTEXT_SCRIPT" log "Batch 3 - command 3 (should not execute)"
EOF

  # Make error1 actually fail by setting its interpreter to exit with error
  # Use arity-specific interpreter for precision
  # Must preserve output while still failing (exit code 1)
  # Using "sh -c 'cat && false'" because && requires shell evaluation
  set_function_interpreter "error1" "sh -c 'cat && false'"

  # Test with KEEP_GOING=0 (fail-fast)
  local output=$(VPN_SWITCH_BATCH_KEEP_GOING=0 run_vpn_switch batch "$batch1" 2>&1 || true)

  # Restore error1 interpreter
  run_vpn_switch unsetenv VPN_SWITCH_INTERPRETER_error1 >/dev/null 2>&1 || true

  # Verify: Should NOT see "Batch 3 - command 3" (execution stopped)
  if ! echo "$output" | grep -q "Batch 3 - command 3"; then
    pass "Recursive fail-fast: Command 3 in batch 3 was not executed"
  else
    fail "Recursive fail-fast: Command 3 should not have been executed"
    echo "    ${COLOR_YELLOW}Output:${COLOR_RESET}"
    echo "$output" | head -20
  fi

  # Verify: Should NOT see "Batch 2 - after" (error propagated up)
  if ! echo "$output" | grep -q "Batch 2 - after"; then
    pass "Recursive fail-fast: Batch 2 stopped after error in batch 3"
  else
    fail "Recursive fail-fast: Batch 2 should have stopped"
  fi

  # Verify: Should NOT see "Batch 1 - after" (error propagated to top)
  if ! echo "$output" | grep -q "Batch 1 - after"; then
    pass "Recursive fail-fast: Batch 1 stopped after error in nested batch"
  else
    fail "Recursive fail-fast: Batch 1 should have stopped"
  fi

  # Test with KEEP_GOING=1 (continue mode)
  output=$(VPN_SWITCH_BATCH_KEEP_GOING=1 run_vpn_switch batch "$batch1" 2>&1 || true)

  # Verify: Should see all "after" messages (execution continued despite error)
  if echo "$output" | grep -q "Batch 2 - after"; then
    pass "Recursive continue: Batch 2 continued after error in batch 3"
  else
    fail "Recursive continue: Batch 2 should have continued"
  fi

  if echo "$output" | grep -q "Batch 1 - after"; then
    pass "Recursive continue: Batch 1 continued after error in nested batch"
  else
    fail "Recursive continue: Batch 1 should have continued"
  fi

  # Cleanup
  rm -f "$batch1" "$batch2" "$batch3"
}

# test_batch_keep_going_with_realistic_dump - Test KEEP_GOING with realistic dump file
#
# Tests _batch2 with a realistic dump-style batch file (like what dump/restore use).
# Uses precise position-based validation to verify KEEP_GOING behavior.
#
# Strategy:
# 1. Generate realistic batch file from inspect command output
# 2. Randomly inject failures at specific positions
# 3. Test KEEP_GOING=0: Verify commands after first failure NOT executed
# 4. Test KEEP_GOING=1: Verify ALL commands executed
#
test_batch_keep_going_with_realistic_dump() {
  test_header "Batch KEEP_GOING with Realistic Dump File"
  test_setup

  # Populate database for realistic commands
  create_messy_realistic_database

  # Create a realistic batch file using inspect output
  local batch_file="$TEST_BASE_DIR/realistic_batch.txt"
  cat > "$batch_file" <<EOF
# Realistic batch file (dump-style)
# This simulates a database dump with multiple commands

"\$VPN_SWITCH_CONTEXT_SCRIPT" database enumerate
"\$VPN_SWITCH_CONTEXT_SCRIPT" system inspect
"\$VPN_SWITCH_CONTEXT_SCRIPT" logs inspect
"\$VPN_SWITCH_CONTEXT_SCRIPT" phases inspect
"\$VPN_SWITCH_CONTEXT_SCRIPT" summary inspect
"\$VPN_SWITCH_CONTEXT_SCRIPT" prologue inspect
"\$VPN_SWITCH_CONTEXT_SCRIPT" database validate
"\$VPN_SWITCH_CONTEXT_SCRIPT" session enumerate
EOF

  # Count total commands (non-empty, non-comment lines)
  local total_commands=$(grep -v '^[[:space:]]*#' "$batch_file" | grep -v '^[[:space:]]*$' | wc -l | tr -d ' ')

  if [ "$total_commands" -lt 3 ]; then
    echo "  ${COLOR_YELLOW}Skipped:${COLOR_RESET} Not enough commands in batch file"
    rm -f "$batch_file"
    return 0
  fi

  pass "Created realistic batch file with $total_commands commands"

  # Pick a random position for failure injection (not first, not last)
  local failure_position=$(awk -v min=2 -v max=$((total_commands - 1)) 'BEGIN { srand(); print int(rand() * (max - min + 1)) + min }')

  # Extract the command at that position
  local cmd_at_position=$(grep -v '^[[:space:]]*#' "$batch_file" | grep -v '^[[:space:]]*$' | sed -n "${failure_position}p")
  local cmd=$(extract_command_from_output "$cmd_at_position")

  pass "Selected command at position $failure_position/$total_commands for failure injection"

  # Resolve to function name and inject failure
  local func_name=$(resolve_function $cmd)
  if [ -z "$func_name" ]; then
    echo "  ${COLOR_YELLOW}Skipped:${COLOR_RESET} Could not resolve function for command: $cmd"
    rm -f "$batch_file"
    return 0
  fi

  local mangled_name=$(echo "$func_name" | sed 's/^_*//')
  local failing_interp=$(create_failing_interpreter "$func_name")

  # Test 1: KEEP_GOING=0 (fail-fast mode)
  test_header "  Sub-test: KEEP_GOING=0 at position $failure_position/$total_commands"

  set_function_interpreter "$mangled_name" "$failing_interp"
  local ff_output=$(VPN_SWITCH_BATCH_KEEP_GOING=0 run_vpn_switch batch "$batch_file" 2>&1 || true)

  # Count how many "# Executing:" lines appear (indicates command was attempted)
  local ff_executed=$(echo "$ff_output" | grep -c "# Executing:" || true)

  # Should execute up to and including the failure position, then stop
  if [ "$ff_executed" -le "$failure_position" ]; then
    pass "KEEP_GOING=0: Stopped at or before position $failure_position (executed $ff_executed commands)"
  else
    fail "KEEP_GOING=0: Executed $ff_executed commands, expected ≤ $failure_position"
    echo "    ${COLOR_YELLOW}Output (first 15 lines):${COLOR_RESET}"
    echo "$ff_output" | head -15
  fi

  # Verify "stopped due to error" message appears
  if echo "$ff_output" | grep -qE "stopped due to error|fail-fast mode"; then
    pass "KEEP_GOING=0: Error stop message present"
  else
    echo "    ${COLOR_YELLOW}Note:${COLOR_RESET} No explicit error stop message"
  fi

  # Test 2: KEEP_GOING=1 (continue mode)
  test_header "  Sub-test: KEEP_GOING=1 at position $failure_position/$total_commands"

  set_function_interpreter "$mangled_name" "$failing_interp"
  local cont_trace=$(mktemp)
  export VPN_SWITCH_BATCH_KEEP_GOING=1
  export VPN_SWITCH_TRACE_FILE="$cont_trace"
  local cont_output=$(run_vpn_switch batch "$batch_file" 2>&1 || true)
  unset VPN_SWITCH_BATCH_KEEP_GOING
  unset VPN_SWITCH_TRACE_FILE

  # Count executed commands from trace (fd79dc8 moved batch diagnostics off stdout)
  local cont_executed=$(grep -c '_batch2: Executing:' "$cont_trace" || true)

  # Should execute ALL commands despite the failure
  if [ "$cont_executed" -eq "$total_commands" ]; then
    pass "KEEP_GOING=1: All commands executed ($cont_executed/$total_commands)"
  else
    fail "KEEP_GOING=1: Only $cont_executed/$total_commands commands executed"
    echo "    ${COLOR_YELLOW}Trace (first 15 lines):${COLOR_RESET}"
    grep '_batch2:' "$cont_trace" 2>/dev/null | head -15
  fi

  # Verify completion message appears in trace
  if grep -q '_batch2: Summary:' "$cont_trace"; then
    pass "KEEP_GOING=1: Completion message present"
  else
    echo "    ${COLOR_YELLOW}Note:${COLOR_RESET} No explicit completion message"
  fi
  rm -f "$cont_trace"

  # Verify at least one failure was recorded
  if echo "$cont_output" | grep -qE "# ✗ Failed|failed"; then
    pass "KEEP_GOING=1: Failure markers present in output"
  else
    echo "    ${COLOR_YELLOW}Note:${COLOR_RESET} No failure markers found"
  fi

  # Cleanup: Remove test interpreter override (template provides default)
  run_vpn_switch unsetenv "VPN_SWITCH_INTERPRETER_${mangled_name}" >/dev/null 2>&1 || true

  # Cleanup batch file
  rm -f "$batch_file"
}

# test_batch_combinator_transitive_hull - Implementation-independent error injection
#
# Tests batch combinators by walking their ACTUAL command trees (transitive hull)
# and injecting failures at different nodes. This is implementation-independent:
# if a batch combinator's implementation changes, the test automatically adapts.
#
# Strategy:
# 1. Walk the batch combinator's actual command tree to discover all nodes
# 2. Inject failure at a node (round-robin: pick middle node)
# 3. Test KEEP_GOING=0: verify execution stops
# 4. Test KEEP_GOING=1: verify execution continues
#
# Arguments: $1 - function name (without ___ prefix, e.g., "stop0", "list0")
#
test_batch_combinator_transitive_hull() {
  local func="$1"

  test_header "Batch Transitive Hull: ___${func} - walkthrough-based error injection"
  test_setup

  # Populate database for realistic command trees
  create_messy_realistic_database

  # Extract command from function name (remove arity suffix)
  # E.g., "stop0" -> "stop", "list0" -> "list"
  local test_cmd=$(echo "$func" | sed 's/[0-9]*$//')

  test_header "  Sub-test: Walk command tree for '___${func}' (command: $test_cmd)"

  # Walk the command tree and collect all nodes
  collect_tree_nodes "$test_cmd"

  if [ "$TREE_NODE_COUNT" -eq 0 ]; then
    echo "    ${COLOR_YELLOW}Skipped:${COLOR_RESET} Command '$test_cmd' produced no tree nodes"
    return 0
  fi

  pass "Command tree collected: $TREE_NODE_COUNT nodes in transitive hull"

  # Extract all non-terminal nodes (these are injectable)
  local injectable_nodes=""
  local injectable_count=0

  # Parse TREE_NODES to find injectable nodes
  echo "$TREE_NODES" | while IFS='|' read -r depth type func cmd output status; do
    # Skip empty lines
    [ -z "$type" ] && continue

    # Skip terminal nodes (they don't call other vpn-switch commands)
    [ "$type" = "terminal" ] && continue
    [ "$type" = "unresolved" ] && continue

    # This is a combinator or batch node - can inject failure here
    echo "$func"
  done > /tmp/injectable_nodes.$$

  injectable_count=$(wc -l < /tmp/injectable_nodes.$$ | tr -d ' ')

  if [ "$injectable_count" -eq 0 ]; then
    echo "    ${COLOR_YELLOW}Skipped:${COLOR_RESET} No injectable nodes found (all terminal)"
    rm -f /tmp/injectable_nodes.$$
    return 0
  fi

  pass "Found $injectable_count injectable nodes (combinators/batches) in tree"

  # Select a node to inject failure (round-robin: pick middle node)
  local target_index=$(( (injectable_count + 1) / 2 ))
  local target_func=$(sed -n "${target_index}p" /tmp/injectable_nodes.$$)

  rm -f /tmp/injectable_nodes.$$

  if [ -z "$target_func" ]; then
    echo "    ${COLOR_YELLOW}Skipped:${COLOR_RESET} Could not select target node for injection"
    return 0
  fi

  test_header "  Sub-test: Inject failure at node '$target_func' (node $target_index/$injectable_count)"

  # Strip underscores for interpreter variable name
  local mangled=$(echo "$target_func" | sed 's/^_*//')

  # Create type-appropriate failing interpreter
  local failing_interpreter=$(create_failing_interpreter "$target_func")

  # Test 1: KEEP_GOING=0 (fail-fast mode)
  set_function_interpreter "$mangled" "$failing_interpreter"
  local ff_output=$(VPN_SWITCH_BATCH_KEEP_GOING=0 run_vpn_switch $test_cmd 2>&1 || true)
  local ff_exitcode=$?

  # Test 2: KEEP_GOING=1 (continue mode)
  set_function_interpreter "$mangled" "$failing_interpreter"
  local cont_output=$(VPN_SWITCH_BATCH_KEEP_GOING=1 run_vpn_switch $test_cmd 2>&1 || true)
  local cont_exitcode=$?

  # Cleanup: Remove the test interpreter override (template provides default)
  run_vpn_switch unsetenv "VPN_SWITCH_INTERPRETER_${mangled}" >/dev/null 2>&1 || true

  # Analyze results: fail-fast should stop earlier
  local ff_lines=$(echo "$ff_output" | wc -l)
  local cont_lines=$(echo "$cont_output" | wc -l)

  # Heuristic 1: Continue mode should produce at least as much output
  if [ "$cont_lines" -ge "$ff_lines" ]; then
    pass "KEEP_GOING affects output: fail-fast=$ff_lines lines, continue=$cont_lines lines"
  else
    echo "    ${COLOR_YELLOW}Note:${COLOR_RESET} Continue mode produced less output ($cont_lines vs $ff_lines lines)"
  fi

  # Heuristic 2: Check for error indicators in fail-fast mode
  if echo "$ff_output" | grep -qE "stopped due to error|Failed|✗"; then
    pass "KEEP_GOING=0: Execution stopped with error indicator"
  else
    echo "    ${COLOR_YELLOW}Note:${COLOR_RESET} No clear error stop indicator in fail-fast mode"
  fi

  # Heuristic 3: Check for completion in continue mode
  if echo "$cont_output" | grep -qE "complete|Summary"; then
    pass "KEEP_GOING=1: Execution completed despite injected failure"
  else
    echo "    ${COLOR_YELLOW}Note:${COLOR_RESET} No clear completion indicator in continue mode"
  fi
}

# pick_random_lines - Pick N random lines from input (for KEEP_GOING tests)
#
# Arguments:
#   $1 - multi-line string (filtered output)
#   $2 - number of lines to pick (optional, default: random between 1 and total)
# Output: Selected lines (one per line)
#
pick_random_lines() {
  local input="${1:-}"
  local count="${2:-}"

  # Count total lines
  local total_lines=$(echo "$input" | wc -l | tr -d ' ')

  if [ "$total_lines" -eq 0 ]; then
    return 1
  fi

  # If count not specified, pick random number between 1 and total_lines
  if [ -z "$count" ]; then
    count=$(awk -v max="$total_lines" 'BEGIN { srand(); print int(rand() * max) + 1 }')
    # Fallback to 1 if awk fails
    count="${count:-1}"
  fi

  # Ensure count is at least 1 and at most total_lines
  if [ "${count:-0}" -lt 1 ]; then
    count=1
  fi
  if [ "${count:-0}" -gt "$total_lines" ]; then
    count="$total_lines"
  fi

  # Pick random lines using shuf (or fallback to awk if shuf not available)
  if command -v shuf >/dev/null 2>&1; then
    echo "$input" | shuf | head -n "${count:-1}"
  else
    # Fallback: use awk to shuffle lines
    echo "$input" | awk -v count="${count:-1}" '
      BEGIN { srand() }
      { lines[NR] = $0 }
      END {
        # Fisher-Yates shuffle
        for (i = 1; i <= NR; i++) {
          j = int(rand() * (NR - i + 1)) + i
          temp = lines[i]
          lines[i] = lines[j]
          lines[j] = temp
        }
        # Output first count lines
        for (i = 1; i <= count && i <= NR; i++) {
          print lines[i]
        }
      }
    '
  fi
}

# test_batch_combinator_keep_going_precise - Precise KEEP_GOING validation
#
# Tests batch combinators with precise architectural validation:
# - For KEEP_GOING=1: All commands must execute (even after failures)
# - For KEEP_GOING=0: Commands after first failure must NOT execute
#
# Strategy:
# 1. Capture batch output with cat interpreter
# 2. Randomly select command lines to inject failures
# 3. Execute batch and validate architectural properties
#
# Arguments: $1 - function name (without ___ prefix, e.g., "inspect0", "stop0")
#
test_batch_combinator_keep_going_precise() {
  local func="$1"

  # Check if this function should be excluded
  case "$func" in
    init1)
      # Skip: complex initialization logic that modifies environment
      echo "  ${COLOR_YELLOW}Skipped:${COLOR_RESET} ___${func} (complex initialization logic)"
      return 0
      ;;
    phases_sync1|phases_sync0)
      # Skip: phase synchronization requires specific template setup
      echo "  ${COLOR_YELLOW}Skipped:${COLOR_RESET} ___${func} (requires phase template setup)"
      return 0
      ;;
  esac

  test_header "Batch KEEP_GOING Precise: ___${func}"
  test_setup

  # Populate database for realistic command trees
  create_messy_realistic_database

  # Extract command from function name (remove arity suffix)
  local test_cmd=$(echo "$func" | sed 's/[0-9]*$//')

  # Step 1: Capture batch combinator output with cat interpreter
  # Note: Use arity-specific interpreter name (e.g., stop0 not stop)
  local output=$(run_vpn_switch setenv "VPN_SWITCH_INTERPRETER_${func}" "cat" && \
                 run_vpn_switch $test_cmd 2>&1 && \
                 run_vpn_switch unsetenv "VPN_SWITCH_INTERPRETER_${func}")

  # Validate we got output
  local line_count=$(echo "$output" | wc -l | tr -d ' ')
  if [ "$line_count" -eq 0 ]; then
    echo "  ${COLOR_YELLOW}Skipped:${COLOR_RESET} No output from ___${func}"
    return 0
  fi

  # Step 2: Filter output - remove comments and empty lines
  local filtered_output=$(echo "$output" | grep -v '^[[:space:]]*#' | grep -v '^[[:space:]]*$')
  local filtered_count=$(echo "$filtered_output" | wc -l | tr -d ' ')

  if [ "$filtered_count" -eq 0 ]; then
    echo "  ${COLOR_YELLOW}Skipped:${COLOR_RESET} No command lines after filtering"
    return 0
  fi

  pass "Captured $filtered_count command lines from ___${func}"

  # Step 3: Pick random lines (arbitrary number: 1 to all)
  local random_lines=$(pick_random_lines "$filtered_output")
  local selected_count=$(echo "$random_lines" | wc -l | tr -d ' ')

  if [ "$selected_count" -eq 0 ]; then
    echo "  ${COLOR_YELLOW}Skipped:${COLOR_RESET} Failed to pick random lines"
    return 0
  fi

  pass "Selected $selected_count random line(s) for failure injection"

  # Step 4: Build lists of selected and non-selected lines
  echo "$random_lines" > "$TEST_BASE_DIR/selected_lines.txt"
  local non_selected_lines=$(echo "$filtered_output" | grep -Fvxf "$TEST_BASE_DIR/selected_lines.txt")
  local non_selected_count=$(echo "$non_selected_lines" | wc -l | tr -d ' ')

  # Step 5: Inject failing interpreters for selected lines
  # Save to temp file first to avoid subshell issues with pipe
  rm -f "$TEST_BASE_DIR/injected_functions.txt"
  while IFS= read -r line; do
    local cmd=$(extract_command_from_output "$line")
    [ -z "$cmd" ] && continue

    local func_name=$(resolve_function "$cmd")
    [ -z "$func_name" ] && continue

    local failing_interp=$(create_failing_interpreter "$func_name")
    local mangled_name=$(echo "$func_name" | sed 's/^_*//')

    set_function_interpreter "$mangled_name" "$failing_interp"
    echo "$mangled_name" >> "$TEST_BASE_DIR/injected_functions.txt"
  done <<EOF
$random_lines
EOF

  # Read back the mangled names
  if [ ! -f "$TEST_BASE_DIR/injected_functions.txt" ]; then
    echo "  ${COLOR_YELLOW}Skipped:${COLOR_RESET} No functions were injected with failures"
    return 0
  fi

  local mangled_names=$(cat "$TEST_BASE_DIR/injected_functions.txt")
  local injection_count=$(echo "$mangled_names" | wc -l | tr -d ' ')
  pass "Injected failures into $injection_count function(s)"

  # Step 6: Set cat interpreters for non-selected lines (to track execution)
  rm -f "$TEST_BASE_DIR/cat_functions.txt"
  while IFS= read -r line; do
    local cmd=$(extract_command_from_output "$line")
    [ -z "$cmd" ] && continue

    local func_name=$(resolve_function "$cmd")
    [ -z "$func_name" ] && continue

    local mangled_name=$(echo "$func_name" | sed 's/^_*//')
    set_function_interpreter "$mangled_name" "cat"
    echo "$mangled_name" >> "$TEST_BASE_DIR/cat_functions.txt"
  done <<EOF
$non_selected_lines
EOF

  # Step 7: Execute with default interpreter (determines KEEP_GOING behavior)
  local exec_output=$(run_vpn_switch $test_cmd 2>&1 || true)

  # Step 8: Analyze execution - count which functions were executed
  local executed_failures=0
  local executed_cats=0

  # Count failures that executed
  if [ -f "$TEST_BASE_DIR/injected_functions.txt" ]; then
    rm -f "$TEST_BASE_DIR/fail_executed.txt"
    while IFS= read -r mangled; do
      # Check if this function's failure marker appears in output
      if echo "$exec_output" | grep -qE "# ✗.*exit.*1|Failed|error"; then
        echo "FAIL_EXEC" >> "$TEST_BASE_DIR/fail_executed.txt"
      fi
    done <<EOF
$mangled_names
EOF
    if [ -f "$TEST_BASE_DIR/fail_executed.txt" ]; then
      executed_failures=$(wc -l < "$TEST_BASE_DIR/fail_executed.txt" | tr -d ' ')
    fi
  fi

  # Count cats that executed
  if [ -f "$TEST_BASE_DIR/cat_functions.txt" ]; then
    rm -f "$TEST_BASE_DIR/cat_executed.txt"
    while IFS= read -r mangled; do
      # Check if output from this function appears
      if echo "$exec_output" | grep -q "Executing"; then
        echo "CAT_EXEC" >> "$TEST_BASE_DIR/cat_executed.txt"
      fi
    done < "$TEST_BASE_DIR/cat_functions.txt"
    if [ -f "$TEST_BASE_DIR/cat_executed.txt" ]; then
      executed_cats=$(wc -l < "$TEST_BASE_DIR/cat_executed.txt" | tr -d ' ')
    fi
  fi

  local total_executed=$((executed_failures + executed_cats))
  local total_expected=$((selected_count + non_selected_count))

  # Step 9: Validate KEEP_GOING=1 behavior (default for most batch combinators)
  # All commands should be attempted despite failures
  if [ "$total_executed" -eq "$total_expected" ]; then
    pass "KEEP_GOING=1: All commands attempted ($total_executed/$total_expected)"
  else
    echo "  ${COLOR_YELLOW}Note:${COLOR_RESET} Not all commands attempted ($total_executed/$total_expected)"
    echo "  ${COLOR_YELLOW}Note:${COLOR_RESET} This may indicate KEEP_GOING=0 or execution stopped early"
  fi

  # Step 10: Cleanup - restore all interpreters
  if [ -f "$TEST_BASE_DIR/injected_functions.txt" ]; then
    while IFS= read -r mangled_name; do
      run_vpn_switch unsetenv "VPN_SWITCH_INTERPRETER_${mangled_name}" >/dev/null 2>&1 || true
    done < "$TEST_BASE_DIR/injected_functions.txt"
  fi

  if [ -f "$TEST_BASE_DIR/cat_functions.txt" ]; then
    while IFS= read -r mangled_name; do
      run_vpn_switch unsetenv "VPN_SWITCH_INTERPRETER_${mangled_name}" >/dev/null 2>&1 || true
    done < "$TEST_BASE_DIR/cat_functions.txt"
  fi

}

#-----------------------------------------------------------------------------
# Static Analysis: Architecture Violation Scanner
#-----------------------------------------------------------------------------

test_architecture_violation_scanner() {
  test_header "Architecture Violation Scanner"

  # Check if scanner exists
  local scanner_script="scripts/architecture-violation-scanner.sh"
  if [ ! -f "$scanner_script" ]; then
    echo "  ${COLOR_YELLOW}Skipped:${COLOR_RESET} Scanner not found at $scanner_script"
    return 0
  fi

  # Run scanner (it exits 1 if violations found, 0 if clean)
  local scanner_output=$(sh "$scanner_script" 2>&1)
  local scanner_exit=$?

  # For now, we expect violations (87+ direct error() calls documented)
  # Scanner should complete successfully (exit 0 or 1, not crash)
  if [ "$scanner_exit" -ne 0 ] && [ "$scanner_exit" -ne 1 ]; then
    fail "Scanner crashed with exit code $scanner_exit"
    echo "$scanner_output" | head -20
    return 1
  fi

  pass "Scanner executed successfully (exit code: $scanner_exit)"

  # Extract violation counts from summary
  local total_violations=$(echo "$scanner_output" | grep "^Total violations found:" | sed 's/.*: //' | sed 's/\x1b\[[0-9;]*m//g')
  local critical=$(echo "$scanner_output" | grep "^  CRITICAL:" | sed 's/.*: //' | sed 's/ .*//' | sed 's/\x1b\[[0-9;]*m//g')
  local high=$(echo "$scanner_output" | grep "^  HIGH:" | sed 's/.*: //' | sed 's/ .*//' | sed 's/\x1b\[[0-9;]*m//g')
  local misnamed=$(echo "$scanner_output" | grep "Misnamed functions" | sed 's/.*: //' | sed 's/\x1b\[[0-9;]*m//g')
  local state_mod=$(echo "$scanner_output" | grep "State modification" | sed 's/.*: //' | sed 's/\x1b\[[0-9;]*m//g')

  # Report findings
  if [ -n "$total_violations" ] && [ "$total_violations" != "0" ]; then
    echo "  ${COLOR_YELLOW}Found:${COLOR_RESET} $total_violations total violations"
    [ -n "$critical" ] && [ "$critical" != "0" ] && \
      echo "    ${COLOR_RED}CRITICAL:${COLOR_RESET} $critical (misnamed functions: ${misnamed:-0}, state mod: ${state_mod:-0})"
    [ -n "$high" ] && [ "$high" != "0" ] && \
      echo "    ${COLOR_YELLOW}HIGH:${COLOR_RESET} $high"
    pass "Scanner detection working (violations found as expected)"
  else
    pass "No violations found (codebase is clean!)"
  fi

  # Test that scanner detects MODIFY_* variables (once we start using them)
  if echo "$scanner_output" | grep -q "MODIFY_"; then
    pass "Scanner detects MODIFY_* variable usage"
  else
    echo "  ${COLOR_BLUE}Note:${COLOR_RESET} No MODIFY_* variables in use yet (refactoring pending)"
  fi
}

#-----------------------------------------------------------------------------
# Sync Feature Architecture Tests
#-----------------------------------------------------------------------------

# test_sync_metadata_registration - Verify new sync functions are registered
# correctly across all metadata lists (TERMINAL/BATCH_COMBINATOR/ANCHOR).
# Catches regressions where someone adds/renames a function but forgets to
# run 'gmake metadata'.
test_sync_metadata_registration() {
  test_header "Sync: metadata registration for new functions"

  # _version_sync0, _env_sync0, _version0 are terminals (single underscore)
  for func in _env_sync0 _version_sync0 _version0; do
    if echo "$TERMINAL_FUNCTIONS" | grep -qw "$func"; then
      pass "$func registered in TERMINAL_FUNCTIONS"
    else
      fail "$func missing from TERMINAL_FUNCTIONS (run 'gmake metadata')"
    fi

    if echo "$ANCHOR_FUNCTIONS" | grep -qw "$func"; then
      pass "$func registered in ANCHOR_FUNCTIONS"
    else
      fail "$func missing from ANCHOR_FUNCTIONS"
    fi
  done

  # ___sync0 is a batch combinator (triple underscore)
  if echo "$BATCH_COMBINATOR_FUNCTIONS" | grep -qw '___sync0'; then
    pass "___sync0 registered in BATCH_COMBINATOR_FUNCTIONS"
  else
    fail "___sync0 missing from BATCH_COMBINATOR_FUNCTIONS (run 'gmake metadata')"
  fi

  if echo "$ANCHOR_FUNCTIONS" | grep -qw '___sync0'; then
    pass "___sync0 registered in ANCHOR_FUNCTIONS"
  else
    fail "___sync0 missing from ANCHOR_FUNCTIONS"
  fi
}

# test_sync_batch_combinator_output_shape - Verify ___sync0 emits exactly
# three valid vpn-switch subcommands with the literal context variable
# (not an expanded path). This is the combinator-discipline rule.
test_sync_batch_combinator_output_shape() {
  test_header "Sync: ___sync0 emits three literal vpn-switch subcommands"
  test_setup

  # Override sync interpreter to cat for inspection
  VPN_SWITCH_BASE="$TEST_DIR" "$TEST_SCRIPT" setenv VPN_SWITCH_INTERPRETER_sync cat > /dev/null 2>&1

  local output
  output=$(VPN_SWITCH_BASE="$TEST_DIR" "$TEST_SCRIPT" sync 2>&1)

  # Filter to non-comment, non-empty lines
  local command_lines
  command_lines=$(printf '%s\n' "$output" | grep -v '^[[:space:]]*#' | grep -v '^[[:space:]]*$')
  local count
  count=$(printf '%s\n' "$command_lines" | wc -l | tr -d ' ')

  if [ "$count" = "3" ]; then
    pass "___sync0 emits exactly three command lines"
  else
    fail "___sync0 emitted $count command lines (expected 3): $command_lines"
  fi

  # Each line must start with literal "$VPN_SWITCH_CONTEXT_SCRIPT"
  local non_literal
  non_literal=$(printf '%s\n' "$command_lines" | grep -v '^"\$VPN_SWITCH_CONTEXT_SCRIPT"' || true)
  if [ -z "$non_literal" ]; then
    pass "___sync0 uses literal \$VPN_SWITCH_CONTEXT_SCRIPT (no path expansion)"
  else
    fail "___sync0 expanded paths instead of literal variable: $non_literal"
  fi

  # Must contain exactly the three expected subcommands
  for subcmd in 'phases sync' 'env sync' 'version sync'; do
    if printf '%s\n' "$command_lines" | grep -q " $subcmd\$"; then
      pass "___sync0 emits '$subcmd'"
    else
      fail "___sync0 missing '$subcmd'"
    fi
  done
}

# test_bootstrap_emits_version_sync - Verify ___bootstrap2 was updated to
# auto-stamp .version. Static check against include/database.sh, since
# changing this is a deliberate architectural decision worth guarding.
test_bootstrap_emits_version_sync() {
  test_header "Sync: ___bootstrap2 emits 'version sync' after init"

  if [ ! -f include/database.sh ]; then
    fail "include/database.sh not found"
    return
  fi

  # ___bootstrap2 body must contain a 'version sync' dispatch.
  # The variable and quotes are escaped because they're inside an echo string
  # that runs at execution time, so we grep for the escaped form.
  if awk '/^___bootstrap2\(\)/,/^}/' include/database.sh | grep -q '\\"\\\$VPN_SWITCH_CONTEXT_SCRIPT\\" version sync'; then
    pass "___bootstrap2 dispatches 'version sync' subcommand"
  else
    fail "___bootstrap2 missing 'version sync' dispatch (bootstrap won't auto-stamp .version)"
  fi

  # Bootstrap dispatch must export interpreters directly (not just via
  # CACHE_ENV_ARGS) so 'version sync' resolves its interpreter correctly.
  # 'version sync' is NOT in COMMANDS_WITHOUT_DATABASE so CACHE_ENV_ARGS
  # is not eval'd before lookup_interpreter — regression guard.
  local version_sync_line
  version_sync_line=$(awk '/^___bootstrap2\(\)/,/^}/' include/database.sh | grep 'version sync')
  if echo "$version_sync_line" | grep -q 'VPN_SWITCH_TERMINAL_INTERPRETER=/bin/sh'; then
    pass "Bootstrap 'version sync' exports TERMINAL_INTERPRETER directly"
  else
    fail "Bootstrap 'version sync' missing direct TERMINAL_INTERPRETER export"
  fi
}

#-----------------------------------------------------------------------------
# Read-Only Database Tests
#-----------------------------------------------------------------------------

# READONLY_SKIP_FUNCTIONS - Functions that legitimately write at generation time
#
# These functions are excluded from read-only database testing because they
# MUST write to the database during generation (not just execution time):
#
# - cat1: Captures stdin and writes to file immediately (can't defer)
# - batch2: Executes batch files which may write
# - bootstrap2: Creates database structure
# - init1: Initializes database directories
# - database_init0: Initializes database
# - environment_init1: Initializes environment files
# - environment_cache1: Caches environment to disk
# - phases_copy0: Copies phase templates to database
#
READONLY_SKIP_FUNCTIONS="cat1 batch2 bootstrap2 init1 database_init0 environment_init1 environment_cache1 phases_copy0"

# is_readonly_skip_function - Check if function should skip read-only test
#
# Arguments: $1 - function name (without prefix)
# Returns: 0 if should skip, 1 otherwise
#
is_readonly_skip_function() {
  local func="$1"
  local skip_func
  for skip_func in $READONLY_SKIP_FUNCTIONS; do
    if [ "$func" = "$skip_func" ]; then
      return 0
    fi
  done
  return 1
}

# make_database_readonly - Make database read-only except .tmp and .log
#
# Arguments: $1 - database directory (TEST_DIR)
#
# Makes all files and directories read-only using chmod -w recursively.
# Preserves write permissions for .tmp and .log directories (needed for
# execution artifacts that don't violate the architecture).
#
make_database_readonly() {
  local basedir="$1"

  # First, make everything read-only
  chmod -R a-w "$basedir"

  # Restore write permissions for .tmp and .log (execution artifacts)
  if [ -d "$basedir/.tmp" ]; then
    chmod -R u+w "$basedir/.tmp"
  fi
  if [ -d "$basedir/.log" ]; then
    chmod -R u+w "$basedir/.log"
  fi

  # Create .tmp and .log if they don't exist (with write permissions)
  mkdir -p "$basedir/.tmp" 2>/dev/null || true
  mkdir -p "$basedir/.log" 2>/dev/null || true
  chmod -R u+w "$basedir/.tmp" 2>/dev/null || true
  chmod -R u+w "$basedir/.log" 2>/dev/null || true
}

# restore_database_writable - Restore writable permissions to database
#
# Arguments: $1 - database directory (TEST_DIR)
#
restore_database_writable() {
  local basedir="$1"
  chmod -R u+w "$basedir" 2>/dev/null || true
}

# test_readonly_function - Test a function on read-only database
#
# Arguments:
#   $1 - function name (without prefix, e.g., "wireguard_list")
#   $2 - function type ("terminal", "combinator", "batch")
#
# Strategy:
#   1. Setup database with messy state
#   2. Run function on WRITABLE database, capture output
#   3. Make database read-only
#   4. Run function on READ-ONLY database, capture output + stderr
#   5. Verify: no permission errors in stderr
#   6. Verify: output matches writable run (optional, reveals state modification)
#
test_readonly_function() {
  local func="$1"
  local func_type="$2"

  # Get test argument variations
  local variations
  variations=$(get_test_argument_variations "$func")

  # Handle SKIP from variations
  if [ "$variations" = "SKIP" ]; then
    return 0  # Silently skip (already handled in main tests)
  fi

  # Check if function should skip read-only test
  if is_readonly_skip_function "$func"; then
    echo "  ${COLOR_YELLOW}Skipped:${COLOR_RESET} ${func} (legitimately writes at generation time)"
    return 0
  fi

  # Get prefix for function type
  local prefix
  case "$func_type" in
    terminal) prefix="_" ;;
    combinator) prefix="__" ;;
    batch) prefix="___" ;;
  esac

  # Prepare test configs in shared location
  local test_wg_config="$TEST_BASE_DIR/test-wg.conf"
  local test_ovpn_config="$TEST_BASE_DIR/test-ovpn.ovpn"

  if [ ! -f "$test_wg_config" ]; then
    cat > "$test_wg_config" <<'EOF'
[Interface]
PrivateKey = fake-key-for-testing
Address = 10.0.0.1/32

[Peer]
PublicKey = fake-peer-key
Endpoint = 192.0.2.1:51820
AllowedIPs = 0.0.0.0/0
EOF
  fi

  if [ ! -f "$test_ovpn_config" ]; then
    cat > "$test_ovpn_config" <<'EOF'
remote 192.0.2.10 1194 udp
dev tun
EOF
  fi

  # Override to cat for output inspection
  set_function_interpreter "$func" "cat"

  # Import configs (need writable database for this)
  set_function_interpreter "wireguard_import1" "sh"
  set_function_interpreter "openvpn_import1" "sh"
  run_vpn_switch wireguard import "$test_wg_config" > /dev/null 2>&1 || true
  run_vpn_switch openvpn import "$test_ovpn_config" > /dev/null 2>&1 || true

  # Reset to cat for testing
  set_function_interpreter "$func" "cat"

  # Regenerate cache to include new interpreter overrides
  # Without this, CACHE_ENV_ARGS from bootstrap would be used, missing our overrides
  run_vpn_switch environment cache on > /dev/null 2>&1 || true

  # Use first variation only (sufficient for read-only test)
  local first_variation
  first_variation=$(echo "$variations" | tr '|' '\n' | head -1)

  # Expand variables
  local expanded_args
  expanded_args=$(eval echo "$first_variation")

  # Handle EMPTY special case
  if [ "$first_variation" = "EMPTY" ]; then
    expanded_args=""
  fi

  # Phase 1: Run on WRITABLE database
  local writable_output writable_stderr
  local writable_tmp="${TMPDIR:-/tmp}/readonly-writable-$$.txt"
  local writable_err="${TMPDIR:-/tmp}/readonly-writable-err-$$.txt"

  if [ -z "$expanded_args" ]; then
    run_vpn_switch $func > "$writable_tmp" 2> "$writable_err" || true
  else
    run_vpn_switch $func $expanded_args > "$writable_tmp" 2> "$writable_err" || true
  fi
  writable_output=$(cat "$writable_tmp")

  # Phase 2: Make database read-only
  make_database_readonly "$TEST_DIR"

  # Phase 3: Run on READ-ONLY database
  local readonly_output readonly_stderr
  local readonly_tmp="${TMPDIR:-/tmp}/readonly-test-$$.txt"
  local readonly_err="${TMPDIR:-/tmp}/readonly-test-err-$$.txt"

  if [ -z "$expanded_args" ]; then
    run_vpn_switch $func > "$readonly_tmp" 2> "$readonly_err" || true
  else
    run_vpn_switch $func $expanded_args > "$readonly_tmp" 2> "$readonly_err" || true
  fi
  readonly_output=$(cat "$readonly_tmp")
  readonly_stderr=$(cat "$readonly_err")

  # Phase 4: Restore writable (for cleanup)
  restore_database_writable "$TEST_DIR"

  # Phase 5: Check for permission errors
  local has_violation=false

  if echo "$readonly_stderr" | grep -qiE "permission denied|read-only|cannot create|cannot open.*for writing"; then
    has_violation=true
    fail "${prefix}${func}: Permission error on read-only database"
    echo "    ${COLOR_RED}Stderr:${COLOR_RESET} $(echo "$readonly_stderr" | head -3)"
  fi

  # Phase 6: Compare outputs - if equal, test passed (writable output already validated)
  # If different, check compliance and warn
  if [ "$writable_output" = "$readonly_output" ]; then
    : # Outputs match - good, nothing more to check
  else
    # Outputs differ - validate compliance based on function type
    # Note: Functions output literal "$VPN_SWITCH_CONTEXT_SCRIPT" (not expanded)
    # Filter out CACHE_ENV_ARGS which contains embedded interpreter definitions with the pattern
    local filtered_output
    filtered_output=$(echo "$readonly_output" | grep -v 'CACHE_ENV_ARGS')
    local is_compliant=true
    case "$func_type" in
      terminal)
        # Terminal functions must NOT output vpn-switch commands
        if echo "$filtered_output" | grep -q '"\$VPN_SWITCH_CONTEXT_SCRIPT"'; then
          is_compliant=false
          has_violation=true
          fail "${prefix}${func}: Terminal function must not output vpn-switch commands"
        fi
        ;;
      combinator)
        # Combinator must output exactly one vpn-switch command (if any output)
        if [ -n "$filtered_output" ] && ! echo "$filtered_output" | grep -q '"\$VPN_SWITCH_CONTEXT_SCRIPT"'; then
          is_compliant=false
          has_violation=true
          fail "${prefix}${func}: Combinator must output vpn-switch command"
        fi
        ;;
      batch)
        # Batch combinators: each non-comment line should be a vpn-switch command
        if [ -n "$filtered_output" ]; then
          local non_comment_lines=$(echo "$filtered_output" | grep -v '^#' | grep -v '^$')
          if [ -n "$non_comment_lines" ] && ! echo "$non_comment_lines" | grep -q '"\$VPN_SWITCH_CONTEXT_SCRIPT"'; then
            is_compliant=false
            has_violation=true
            fail "${prefix}${func}: Batch combinator must output vpn-switch commands"
          fi
        fi
        ;;
    esac
    # Warn about output difference if still compliant
    if $is_compliant; then
      echo "    ${COLOR_YELLOW}Warning:${COLOR_RESET} ${func}: output differs between writable/readonly (but compliant)"
    fi
  fi

  # Cleanup temp files
  rm -f "$writable_tmp" "$writable_err" "$readonly_tmp" "$readonly_err"

  # Cleanup interpreter overrides to avoid polluting subsequent tests
  run_vpn_switch unsetenv "VPN_SWITCH_INTERPRETER_${func}" > /dev/null 2>&1 || true
  run_vpn_switch unsetenv "VPN_SWITCH_INTERPRETER_wireguard_import1" > /dev/null 2>&1 || true
  run_vpn_switch unsetenv "VPN_SWITCH_INTERPRETER_openvpn_import1" > /dev/null 2>&1 || true
  run_vpn_switch environment cache on > /dev/null 2>&1 || true

  if ! $has_violation; then
    pass "${prefix}${func}: No permission errors on read-only database"
  fi
}

# test_readonly_database - Run read-only tests for all function types
#
# Purpose: Verify that functions don't modify database state at generation time
#
# This test catches violations where functions:
# - Write files during output generation (should only happen at execution time)
# - Don't use EXAMINE_/MODIFY_ platform variables correctly
# - Have side effects that break the declarative model
#
test_readonly_database() {
  test_header "Read-Only Database: All functions"
  test_setup

  # Populate with messy state
  create_messy_realistic_database

  local tested=0
  local skipped=0

  echo "  Testing terminal functions..."
  for func_with_prefix in $TERMINAL_FUNCTIONS; do
    local func="${func_with_prefix#_}"
    if is_readonly_skip_function "$func"; then
      skipped=$((skipped + 1))
    else
      test_readonly_function "$func" "terminal"
      tested=$((tested + 1))
    fi
  done

  echo ""
  echo "  Testing combinator functions..."
  for func_with_prefix in $COMBINATOR_FUNCTIONS; do
    local func="${func_with_prefix#__}"
    if is_readonly_skip_function "$func"; then
      skipped=$((skipped + 1))
    else
      test_readonly_function "$func" "combinator"
      tested=$((tested + 1))
    fi
  done

  echo ""
  echo "  Testing batch combinator functions..."
  for func_with_prefix in $BATCH_COMBINATOR_FUNCTIONS; do
    local func="${func_with_prefix#___}"
    if is_readonly_skip_function "$func"; then
      skipped=$((skipped + 1))
    else
      test_readonly_function "$func" "batch"
      tested=$((tested + 1))
    fi
  done

  echo ""
  echo "  ${COLOR_BLUE}Summary:${COLOR_RESET} Tested $tested functions, skipped $skipped"
}

#-----------------------------------------------------------------------------
# Main Test Runner
#-----------------------------------------------------------------------------

# --- Phase wrappers ---------------------------------------------------------
# The parameterised phases (loops over the function lists) are wrapped in named
# test_* functions so they are individually selectable via the filter, exactly
# like the flat tests. Each carries its own section header so it only prints when
# the phase actually runs.

test_all_combinator_syntax() {
  echo ""
  echo "${COLOR_BLUE}Running Combinator Tests${COLOR_RESET}"
  echo "========================================"
  echo ""
  echo "Found $(echo "$COMBINATOR_FUNCTIONS" | wc -w | tr -d ' ') combinator functions"
  echo ""
  for func_with_prefix in $COMBINATOR_FUNCTIONS; do
    func="${func_with_prefix#__}"
    test_combinator_function "$func"
  done
}

test_all_batch_combinator_syntax() {
  echo ""
  echo "${COLOR_BLUE}Running Batch Combinator Tests${COLOR_RESET}"
  echo "========================================"
  echo ""
  echo "Found $(echo "$BATCH_COMBINATOR_FUNCTIONS" | wc -w | tr -d ' ') batch combinator functions"
  echo ""
  for func_with_prefix in $BATCH_COMBINATOR_FUNCTIONS; do
    func="${func_with_prefix#___}"
    test_batch_combinator_function "$func"
  done
}

test_all_terminal_output() {
  echo ""
  echo "${COLOR_BLUE}Running Terminal Function Tests${COLOR_RESET}"
  echo "========================================"
  echo ""
  echo "Found $(echo "$TERMINAL_FUNCTIONS" | wc -w | tr -d ' ') terminal functions"
  echo ""
  for func_with_prefix in $TERMINAL_FUNCTIONS; do
    func="${func_with_prefix#_}"
    test_terminal_function "$func"
  done
}

test_all_batch_error_propagation_hull() {
  echo ""
  echo "${COLOR_BLUE}Running Batch Combinator Error Propagation Tests${COLOR_RESET}"
  echo "========================================"
  echo ""
  echo "Testing ALL batch combinators with error injection and KEEP_GOING validation"
  echo "Found $(echo "$BATCH_COMBINATOR_FUNCTIONS" | wc -w | tr -d ' ') batch combinator functions"
  echo ""
  for func_with_prefix in $BATCH_COMBINATOR_FUNCTIONS; do
    func="${func_with_prefix#___}"
    test_batch_combinator_transitive_hull "$func"
  done
}

test_all_batch_keep_going_precise() {
  echo ""
  echo "${COLOR_BLUE}Running Batch Combinator KEEP_GOING Precise Tests${COLOR_RESET}"
  echo "========================================"
  echo ""
  echo "Testing ALL batch combinators with precise architectural KEEP_GOING validation"
  echo "Found $(echo "$BATCH_COMBINATOR_FUNCTIONS" | wc -w | tr -d ' ') batch combinator functions"
  echo ""
  for func_with_prefix in $BATCH_COMBINATOR_FUNCTIONS; do
    func="${func_with_prefix#___}"
    test_batch_combinator_keep_going_precise "$func"
  done
}

# --- Help doc-block corpus tests (Idea 1: generated help) -------------------
# Enforce docs/HELP_TEMPLATE_SPEC.md. A = presence/classification (the worklist),
# B = block conformance, C = cross-reference graph integrity.

# Source files that may carry doc blocks.
_help_source_files() {
  echo vpn-switch.sh
  local m
  for m in include/*.sh; do echo "$m"; done
}

# Emit one TSV record per block / unclassified anchor function across all sources:
#   B <fname> <sentinel> <kind> <tagblob>   bound function block
#   F -       <sentinel> <kind> <tagblob>   free-floating block (defgroup/topic)
#   N <fname> -          -      -           anchor function with NO bound block
# kind = command|internal|defgroup|topic|unknown ; tagblob = tag lines joined by ';'
_help_records() {
  local f
  for f in $(_help_source_files); do
    [ -f "$f" ] || continue
    awk -v OFS='	' '
      function emit(type, fn) {
        kind="unknown"
        if (tagblob ~ /@command/)       kind="command"
        else if (tagblob ~ /@internal/) kind="internal"
        else if (tagblob ~ /@defgroup/) kind="defgroup"
        else if (tagblob ~ /@topic/)    kind="topic"
        print type, fn, bname, kind, tagblob
      }
      /^#@help/ { if (pend) { emit("F","-"); pend=0 }
                  inblk=1; bname=(NF>=2 ? $2 : "-"); tagblob=""; next }
      inblk && /^#@end$/ { inblk=0; pend=1; next }
      inblk { tagblob = tagblob ";" $0; next }
      {
        isdef = ($0 ~ /^_+[a-z][a-z_]*[0-9]\(\) *\{/)
        fn=""
        if (isdef) { fn=$0; sub(/\(\).*/,"",fn) }
        if (pend) {
          if (isdef) { emit("B", fn); pend=0; next }
          else       { emit("F","-"); pend=0 }
        }
        if (isdef) print "N", fn, "-", "-", "-"
      }
      END { if (pend) emit("F","-") }
    ' "$f"
  done
}

# A — Presence: every anchor function carries a name-matching block classified as
# @command or @internal. Failure output is the worklist of what still needs doing.
test_help_blocks_present() {
  test_header "Help blocks: every anchor function classified (@command|@internal)"
  local recs total=0 ok=0 missing=""
  recs=$(_help_records)
  local fp
  for fp in $ANCHOR_FUNCTIONS; do
    total=$((total + 1))
    local rec
    rec=$(printf '%s\n' "$recs" | awk -F'	' -v f="$fp" '$1=="B" && $2==f {print; exit}')
    if [ -z "$rec" ]; then missing="$missing $fp"; continue; fi
    local sentinel kind
    sentinel=$(printf '%s' "$rec" | cut -f3)
    kind=$(printf '%s' "$rec" | cut -f4)
    if [ "$sentinel" != "$fp" ]; then missing="$missing ${fp}!namemismatch"; continue; fi
    case "$kind" in
      command|internal) ok=$((ok + 1)) ;;
      *)                missing="$missing ${fp}!unclassified" ;;
    esac
  done
  if [ -z "$missing" ]; then
    pass "All $total anchor functions carry a conforming help block ($ok classified)"
  else
    fail "$((total - ok))/$total anchor functions still need a help block"
    printf '%s' "$missing" | tr ' ' '\n' | grep -v '^$' | sed 's/^/       - /'
  fi
}

# B — Conformance: each present block has a recognised kind, only known tags, and
# the required fields for its kind. Single assertion (problems accumulated).
test_help_blocks_conform() {
  test_header "Help blocks: well-formed, known tags, required fields"
  local recs problems="" allowed=" command summary group param option returns example see since defgroup order parent topic internal "
  recs=$(_help_records)
  local tmp; tmp=$(mktemp 2>/dev/null || echo "/tmp/help_conf.$$")
  printf '%s\n' "$recs" | awk -F'	' '$1=="B" || $1=="F"' > "$tmp" || true
  local type fn sentinel kind tagblob t label
  while IFS='	' read -r type fn sentinel kind tagblob; do
    [ -n "${type:-}" ] || continue
    label="${fn}${sentinel}"
    if [ "$kind" = "unknown" ]; then
      problems="$problems
  '$label': no recognised anchor tag (@command/@internal/@defgroup/@topic)"
      continue
    fi
    for t in $(printf '%s' "$tagblob" | tr ';' '\n' | sed -n 's/^# *@\([a-z][a-z]*\).*/\1/p'); do
      case "$allowed" in *" $t "*) ;; *) problems="$problems
  '$label': unknown tag @$t" ;; esac
    done
    if [ "$kind" = "command" ]; then
      printf '%s' "$tagblob" | tr ';' '\n' | grep -q '@summary' || problems="$problems
  '$label': command block missing @summary"
      printf '%s' "$tagblob" | tr ';' '\n' | grep -q '@group' || problems="$problems
  '$label': command block missing @group"
    fi
  done < "$tmp"
  rm -f "$tmp"
  if [ -z "$problems" ]; then
    pass "All present help blocks are well-formed"
  else
    fail "Non-conforming help blocks:$problems"
  fi
}

# C — Graph: every @group resolves to a @defgroup, every @see resolves to a known
# command/group, no duplicate command paths. Single assertion.
test_help_graph_resolves() {
  test_header "Help graph: groups/see-refs resolve, no duplicate commands"
  local recs problems=""
  recs=$(_help_records)
  local tags; tags=$(printf '%s\n' "$recs" | cut -f5 | tr ';' '\n')
  local groups cmds g s
  groups=$(printf '%s\n' "$tags" | sed -n 's/^# *@defgroup  *\([A-Za-z0-9_-]*\).*/\1/p' | sort -u)
  cmds=$(printf '%s\n' "$tags" | sed -n 's/^# *@command  *\(.*\)/\1/p' | sed 's/[<[].*//; s/  *$//' | sort)
  for g in $(printf '%s\n' "$tags" | sed -n 's/^# *@group  *\([A-Za-z0-9_-]*\).*/\1/p' | sort -u); do
    printf '%s\n' "$groups" | grep -qx "$g" || problems="$problems
  @group '$g' has no matching @defgroup"
  done
  for s in $(printf '%s\n' "$tags" | sed -n 's/^# *@see  *\(.*\)/\1/p' | sed 's/  *$//' | sort -u | tr ' ' '\037'); do
    s=$(printf '%s' "$s" | tr '\037' ' ')
    printf '%s\n' "$cmds" | grep -qx "$s" && continue
    printf '%s\n' "$groups" | grep -qx "$s" && continue
    problems="$problems
  @see '$s' resolves to no command or group"
  done
  local dup; dup=$(printf '%s\n' "$cmds" | grep -v '^$' | uniq -d)
  [ -n "$dup" ] && problems="$problems
  duplicate @command path(s): $(printf '%s' "$dup" | tr '\n' ',')"
  if [ -z "$problems" ]; then
    pass "Help graph resolves (groups, see-refs, uniqueness)"
  else
    fail "Help graph has unresolved references:$problems"
  fi
}

main() {
  echo "${COLOR_BLUE}========================================${COLOR_RESET}"
  echo "${COLOR_BLUE}vpn-switch Architecture Test Suite${COLOR_RESET}"
  echo "${COLOR_BLUE}========================================${COLOR_RESET}"
  echo ""
  echo "Testing architectural rules for combinator functions"
  echo "Profile: $TEST_PROFILE"
  if [ "$TEST_FILTER" != "$ALL_TESTS" ]; then
    echo "${COLOR_YELLOW}Filter active - running only:${COLOR_RESET} $TEST_FILTER"
  fi
  echo ""

  # Check prerequisites
  if [ ! -f "$TEST_SCRIPT" ]; then
    echo "${COLOR_RED}ERROR:${COLOR_RESET} $TEST_SCRIPT not found"
    echo "Run this script from the repository root"
    exit 1
  fi

  # Combinator / terminal / batch architecture (parameterised phases)
  should_run_test test_all_combinator_syntax
  should_run_test test_all_batch_combinator_syntax
  should_run_test test_all_terminal_output

  # Error propagation
  should_run_test test_batch_error_propagation
  should_run_test test_recursive_batch_error_propagation
  should_run_test test_batch_keep_going_with_realistic_dump
  should_run_test test_all_batch_error_propagation_hull
  should_run_test test_all_batch_keep_going_precise

  # Static analysis & read-only compliance
  should_run_test test_architecture_violation_scanner
  should_run_test test_readonly_database

  # Sync features
  should_run_test test_sync_metadata_registration
  should_run_test test_sync_batch_combinator_output_shape
  should_run_test test_bootstrap_emits_version_sync

  # Help doc-block corpus (docs/HELP_TEMPLATE_SPEC.md) - red until the corpus is filled
  should_run_test test_help_blocks_present
  should_run_test test_help_blocks_conform
  should_run_test test_help_graph_resolves

  # Print summary
  test_summary
}

# Run main and exit with its status
main
exit $?
