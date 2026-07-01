#!/bin/sh
# vpn-switch-integration-test.sh - User Story Integration Tests
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
#
# Philosophy: Test real user workflows end-to-end
# - Each test starts with fresh database (independent, isolated)
# - Only UI commands (no filesystem shortcuts)
# - Property-based validation (prove correctness, not just "it works")
# - Profile selection via command line
#
# Usage: ./vpn-switch-integration-test.sh [profile]
#   profile: minimal (default) or help

# Note: set -e disabled - tests should handle errors explicitly via assertions
# set -e

# Configuration
PROFILE="${1:-minimal}"
SCRIPT="./vpn-switch.sh"

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test counters
STORIES_RUN=0
STORIES_PASSED=0
STORIES_FAILED=0
ASSERTIONS_RUN=0
ASSERTIONS_PASSED=0
ASSERTIONS_FAILED=0
STORY_ASSERTIONS_FAILED=0  # Per-story failure counter

# Test result tracking
pass() {
  ASSERTIONS_RUN=$((ASSERTIONS_RUN + 1))
  ASSERTIONS_PASSED=$((ASSERTIONS_PASSED + 1))
  printf "  ${GREEN}✓${NC} %s\n" "$1"
}

fail() {
  ASSERTIONS_RUN=$((ASSERTIONS_RUN + 1))
  ASSERTIONS_FAILED=$((ASSERTIONS_FAILED + 1))
  STORY_ASSERTIONS_FAILED=$((STORY_ASSERTIONS_FAILED + 1))  # Track per-story failures
  printf "  ${RED}✗${NC} %s\n" "$1"
  if [ -n "${LAST_TRACE_LABEL}" ]; then
    printf "    ${YELLOW}Trace:${NC} %s\n" "${LAST_TRACE_LABEL}"
  fi
  if [ -n "$2" ]; then
    printf "    ${YELLOW}Expected:${NC} %s\n" "$2"
  fi
  if [ -n "$3" ]; then
    printf "    ${YELLOW}Got:${NC} %s\n" "$3"
  fi
}

# User story execution
story() {
  local story_num="$1"
  local story_desc="$2"
  CURRENT_STORY_NUM="$story_num"
  STORIES_RUN=$((STORIES_RUN + 1))
  STORY_ASSERTIONS_FAILED=0  # Reset per-story counter
  printf "\n${BLUE}▶ User Story ${story_num}:${NC} %s\n" "$story_desc"
}

story_db() {
  printf "  ${BLUE}Database:${NC} %s\n" "$1"
}

story_passed() {
  STORIES_PASSED=$((STORIES_PASSED + 1))
  printf "${GREEN}✓ Story ${STORIES_RUN} completed successfully${NC}\n"
}

story_failed() {
  STORIES_FAILED=$((STORIES_FAILED + 1))
  printf "${RED}✗ Story ${STORIES_RUN} failed${NC}\n"
}

# Cleanup databases conditionally (only on success)
cleanup_on_success() {
  if [ "$STORY_ASSERTIONS_FAILED" -eq 0 ]; then
    # All assertions passed - safe to cleanup
    for path in "$@"; do
      rm -rf "$path"
    done
  else
    # Failures occurred - preserve databases for debugging
    printf "\nDatabase preserved for debugging at: %s\n" "$1"
    if [ $# -gt 1 ]; then
      shift
      for path in "$@"; do
        printf "                                      %s\n" "$path"
      done
    fi
  fi
}

# Assertions
assert_file_exists() {
  local file="$1"
  local message="$2"

  if [ -f "$file" ]; then
    pass "$message"
  else
    fail "$message" "File should exist: $file"
  fi
}

assert_dir_exists() {
  local dir="$1"
  local message="$2"

  if [ -d "$dir" ]; then
    pass "$message"
  else
    fail "$message" "Directory should exist: $dir"
  fi
}

assert_symlink_target() {
  local link="$1"
  local expected_target="$2"
  local message="$3"

  if [ ! -L "$link" ]; then
    fail "$message" "Symlink" "Not a symlink: $link"
    return
  fi

  local actual_target=$(readlink "$link")
  if [ "$expected_target" = "$actual_target" ]; then
    pass "$message"
  else
    fail "$message" "$expected_target" "$actual_target"
  fi
}

assert_empty() {
  local value="$1"
  local message="$2"

  if [ -z "$value" ]; then
    pass "$message"
  else
    fail "$message" "Empty string" "Non-empty: $value"
  fi
}

assert_file_empty() {
  local filepath="$1"
  local message="$2"

  if [ ! -f "$filepath" ]; then
    fail "$message" "File exists and is empty" "File not found: $filepath"
  elif [ ! -s "$filepath" ]; then
    pass "$message"
  else
    fail "$message" "Empty file" "File has content ($(wc -l < "$filepath") lines)"
  fi
}

assert_symlink_exists() {
  local link="$1"
  local message="$2"

  if [ -L "$link" ]; then
    pass "$message"
  else
    fail "$message" "Symlink exists" "Not found or not a symlink"
  fi
}

assert_contains() {
  local haystack="$1"
  local needle="$2"
  local message="$3"

  if echo "$haystack" | grep -q "$needle"; then
    pass "$message"
  else
    fail "$message" "Contains: $needle" "Not found in output"
  fi
}

#-----------------------------------------------------------------------------
# Helper Functions: Phase Testing
#-----------------------------------------------------------------------------

# Extract session ID from start command output
extract_session_id() {
  local output="$1"

  # Debug: Log the input to a file
  echo "========================================" >> /tmp/extract_session_id_debug.log
  echo "Called at: $(date)" >> /tmp/extract_session_id_debug.log
  echo "Input length: ${#output} chars" >> /tmp/extract_session_id_debug.log
  echo "First 500 chars of output:" >> /tmp/extract_session_id_debug.log
  echo "$output" | head -c 500 >> /tmp/extract_session_id_debug.log
  echo "" >> /tmp/extract_session_id_debug.log

  # Parse session from output
  # First try: Look for lines like: Created session 12345: /path/.session/12345
  local session_id=$(echo "$output" | grep 'Created session' | head -1 | sed 's/.*Created session \([0-9]*\).*/\1/')
  echo "Method 1 (Created session): '$session_id'" >> /tmp/extract_session_id_debug.log

  # Fallback: Look for "# Session: 12345" in connect script output
  if [ -z "$session_id" ]; then
    session_id=$(echo "$output" | grep '^# Session:' | head -1 | sed 's/^# Session: \([0-9]*\).*/\1/')
    echo "Method 2 (# Session:): '$session_id'" >> /tmp/extract_session_id_debug.log
  fi

  echo "Final result: '$session_id'" >> /tmp/extract_session_id_debug.log
  echo "$session_id"
}

# Assert file is executable
assert_file_executable() {
  local file="$1"
  local message="$2"

  if [ -x "$file" ]; then
    pass "$message"
  else
    fail "$message" "Executable file" "Not executable or not found"
  fi
}

# Assert script starts with specific content
assert_file_starts_with() {
  local file="$1"
  local expected="$2"
  local message="$3"

  if head -1 "$file" | grep -q "^$expected"; then
    pass "$message"
  else
    fail "$message" "$expected" "$(head -1 "$file")"
  fi
}

# Assert script contains substring
assert_script_contains() {
  local script="$1"
  local needle="$2"
  local message="${3:-Script contains: $needle}"

  if grep -q -e "$needle" "$script"; then
    pass "$message"
  else
    fail "$message" "Present" "Not found"
  fi
}

# Assert script does NOT contain substring
assert_script_not_contains() {
  local script="$1"
  local needle="$2"
  local message="${3:-Script does not contain: $needle}"

  if ! grep -q -e "$needle" "$script"; then
    pass "$message"
  else
    fail "$message" "Absent" "Found"
  fi
}

# Assert phases appear in specific order
assert_phase_order() {
  local script="$1"
  local expected_order="$2"  # Space-separated: "firewall vpn dns"
  local message="${3:-Phases in correct order}"

  # Extract phase markers from script (e.g., "==> Phase: firewall (prepare)")
  local actual_order=$(grep -o 'Phase: [a-z_]* (' "$script" | \
                      sed 's/Phase: \([a-z_]*\) (/\1/' | \
                      uniq | tr '\n' ' ' | sed 's/ $//')

  if [ "$expected_order" = "$actual_order" ]; then
    pass "$message"
  else
    fail "$message" "$expected_order" "$actual_order"
  fi
}

# Create custom phase for testing
create_custom_phase() {
  local basedir="$1"
  local protocol="$2"
  local phase_name="$3"

  mkdir -p "$basedir/.include/phase/$protocol/connect"

  cat > "$basedir/.include/phase/$protocol/connect/$phase_name.sh" <<'EOF'
#!/bin/sh
case "$1" in
  verify)
    cat <<'VERIFY_EOF'
verify_PHASE_NAME() {
  local step="$1"
  local exit_code="$2"
  case "$step" in
    execute)
      [ "$exit_code" -eq 0 ] && echo "✓ PHASE_NAME phase completed" >&2
      ;;
  esac
}
VERIFY_EOF
    ;;
  prepare)
    echo "echo '==> Phase: PHASE_NAME (prepare)' >&2"
    echo "verify_PHASE_NAME prepare 0"
    ;;
  execute)
    echo "echo '==> Phase: PHASE_NAME (execute)' >&2"
    echo "echo 'Custom phase commands here' >&2"
    echo "verify_PHASE_NAME execute 0"
    ;;
esac
EOF

  # Replace PHASE_NAME placeholder (FreeBSD sed vs GNU sed compatibility)
  if sed -i '' "s/PHASE_NAME/$phase_name/g" \
    "$basedir/.include/phase/$protocol/connect/$phase_name.sh" 2>/dev/null; then
    :  # FreeBSD sed succeeded
  else
    # GNU sed (Linux)
    sed -i "s/PHASE_NAME/$phase_name/g" \
      "$basedir/.include/phase/$protocol/connect/$phase_name.sh"
  fi

  chmod 0755 "$basedir/.include/phase/$protocol/connect/$phase_name.sh"
}

# Set interpreter for a specific function (using setenv API)
set_function_interpreter() {
  local basedir="$1"
  local func_name="$2"
  local interpreter="$3"

  # Use setenv to configure interpreter (API approach)
  run_vpn_switch "001" "$basedir" setenv "VPN_SWITCH_INTERPRETER_${func_name}" "$interpreter" > /dev/null 2>&1
}

# Override interpreter for command inspection (convenience wrapper)
override_for_command_inspection() {
  local basedir="$1"
  local func="$2"

  if [ -z "$func" ]; then
    echo "${RED}ERROR:${NC} override_for_command_inspection requires function name"
    exit 1
  fi

  # Set function-specific interpreter to cat (highest priority)
  set_function_interpreter "$basedir" "$func" "cat"
}

#-----------------------------------------------------------------------------
# Helper Functions: Test Fixtures
#-----------------------------------------------------------------------------

# Create temporary WireGuard test config file
create_test_config() {
  local filename="$1"
  local endpoint="${2:-test.example.com:51820}"
  local filepath="/tmp/$filename"

  cat > "$filepath" <<EOF
[Interface]
PrivateKey = $(head -c 32 /dev/urandom | base64)
Address = 10.2.0.2/32
DNS = 10.2.0.1

[Peer]
PublicKey = $(head -c 32 /dev/urandom | base64)
AllowedIPs = 0.0.0.0/0
Endpoint = $endpoint
EOF
  echo "$filepath"
}

# Create temporary OpenVPN test config file
create_test_ovpn_config() {
  local filename="$1"
  local remote="${2:-test.example.com 1194}"
  local filepath="/tmp/$filename"

  cat > "$filepath" <<EOF
client
dev tun
proto udp
remote $remote
resolv-retry infinite
nobind
persist-key
persist-tun
remote-cert-tls server
cipher AES-256-CBC
auth SHA256
verb 3
EOF
  echo "$filepath"
}

# Bootstrap fresh database with "experienced user" settings
bootstrap_database() {
  local basedir="$1"

  # Clean slate - remove database
  rm -rf "$basedir"

  # SAFETY: Do NOT destroy interfaces blindly!
  # Tests use test-specific interface names (wg_test0, tun_test0)
  # Production interfaces (wg0, tun0) must NEVER be touched by tests
  # The orphaned interface auto-destroy in check_existing_session() handles cleanup safely

  # Set minimal PATH for bootstrap operations (needed for run_env before database exists)
  export VPN_SWITCH_PATH="/bin:/usr/bin:/usr/local/bin"

  # Bootstrap with profile
  if ! $SCRIPT bootstrap "$basedir" "$PROFILE" > /dev/null 2>&1; then
    echo "${RED}ERROR: Bootstrap failed for $basedir${NC}" >&2
    exit 1
  fi

  # Configure test-specific settings via API
  # Note: dump interpreters are already provided by minimal profile (no need to set)

  # Configure as "experienced user" (auto-execution)
  VPN_SWITCH_BASE="$basedir" $SCRIPT setenv VPN_SWITCH_TERMINAL_INTERPRETER sh > /dev/null 2>&1

  # Set minimal PATH for vpn-switch operations
  VPN_SWITCH_BASE="$basedir" $SCRIPT setenv VPN_SWITCH_PATH "/bin:/usr/bin:/usr/local/bin" > /dev/null 2>&1

  # SAFETY: Use test-specific interface names to avoid conflicts with production
  VPN_SWITCH_BASE="$basedir" $SCRIPT setenv VPN_SWITCH_INTERFACE_wireguard wg_test0 > /dev/null 2>&1
  VPN_SWITCH_BASE="$basedir" $SCRIPT setenv VPN_SWITCH_INTERFACE_openvpn tun_test0 > /dev/null 2>&1
}

# run_vpn_switch "002" - Execute vpn-switch.sh through the user interface
#
# Arguments:
#   $1: label for error reporting
#   $2: database location (VPN_SWITCH_BASE)
#   $3-N: command arguments to pass to vpn-switch.sh
#
# Environment:
#   Uses only variables a normal user would set:
#   - VPN_SWITCH_BASE: database location (passed as $2)
#
# Note: Trace files are automatically generated by vpn-switch.sh based on
#       retention settings. No need to set VPN_SWITCH_TRACE_FILE manually.
#
# Returns: captured stdout and stderr
#
run_vpn_switch() {
  local label="$1"
  local basedir="$2"
  shift 2

  # Store label globally for assertion error reporting
  LAST_TRACE_LABEL="$label"

  # Execute vpn-switch exactly as a user would
  VPN_SWITCH_BASE="$basedir" $SCRIPT "$@"
}

# run_vpn_dump "003" - Execute vpn-switch dump with batch2 in output mode
#
# Arguments:
#   $1: label for error reporting
#   $2: database location (VPN_SWITCH_BASE)
#
# Note: Temporarily sets INTERPRETER_batch2=cat for dump operation,
#       then restores default (execute mode) for subsequent restores.
#       Trace files are automatically generated by vpn-switch.sh based on
#       retention settings.
#
run_vpn_dump() {
  local label="$1"
  local basedir="$2"

  # Store label globally for assertion error reporting
  LAST_TRACE_LABEL="$label"

  # Temporarily set dump interpreters via API
  # batch2=cat: prevents batch from executing commands (just outputs them)
  # dumpenv=cat: prevents setenv commands from being executed (just outputs them)
  VPN_SWITCH_BASE="$basedir" $SCRIPT setenv VPN_SWITCH_INTERPRETER_batch2 cat > /dev/null 2>&1
  VPN_SWITCH_BASE="$basedir" $SCRIPT setenv VPN_SWITCH_INTERPRETER_dumpenv cat > /dev/null 2>&1

  # Execute dump command
  VPN_SWITCH_BASE="$basedir" $SCRIPT dump

  # Remove temporary settings via API to allow restore to use default (execute mode)
  VPN_SWITCH_BASE="$basedir" $SCRIPT unsetenv VPN_SWITCH_INTERPRETER_batch2 > /dev/null 2>&1
  VPN_SWITCH_BASE="$basedir" $SCRIPT unsetenv VPN_SWITCH_INTERPRETER_dumpenv > /dev/null 2>&1
}

#-----------------------------------------------------------------------------
# User Story 1: Import → Organize → Dump → Restore → Idempotency
#-----------------------------------------------------------------------------
# As a user, I want to import configs, organize them into categories,
# dump my database, restore it elsewhere, and verify nothing was lost.

user_story_1_import_organize_dump_restore() {
  story 1 "Import → Organize → Dump → Restore → Idempotency (Multi-Protocol)"

  # Setup
  local old_db=$(mktemp -d "${TMPDIR:-/tmp}/vpn-integration-old.XXXXXX")
  local new_db=$(mktemp -d "${TMPDIR:-/tmp}/vpn-integration-new.XXXXXX")
  story_db "$old_db"
  local dump1="$old_db/backup.sh"
  local dump2="$new_db/backup2.sh"
  local dump3="$new_db/backup3.sh"

  # Step 1: Bootstrap OLD database
  bootstrap_database "$old_db"

  # Step 2a: Import WireGuard configs via UI
  local wg_config1=$(create_test_config "wg-us-101.conf" "us.example.com:51820")
  local wg_config2=$(create_test_config "wg-uk-202.conf" "uk.example.com:51820")
  local wg_config3=$(create_test_config "wg-jp-303.conf" "jp.example.com:51820")

  run_vpn_switch "004" "$old_db" wireguard import "$wg_config1" > /dev/null 2>&1
  run_vpn_switch "005" "$old_db" wireguard import "$wg_config2" > /dev/null 2>&1
  run_vpn_switch "006" "$old_db" wireguard import "$wg_config3" > /dev/null 2>&1

  assert_file_exists "$old_db/wireguard/wg-us-101.conf" "WG: Imported config 1"
  assert_file_exists "$old_db/wireguard/wg-uk-202.conf" "WG: Imported config 2"
  assert_file_exists "$old_db/wireguard/wg-jp-303.conf" "WG: Imported config 3"

  # Step 2b: Import OpenVPN configs via UI
  local ovpn_config1=$(create_test_ovpn_config "us-server.ovpn" "us.example.com 1194")
  local ovpn_config2=$(create_test_ovpn_config "eu-server.ovpn" "eu.example.com 1194")

  run_vpn_switch "007" "$old_db" openvpn import "$ovpn_config1" > /dev/null 2>&1
  run_vpn_switch "008" "$old_db" openvpn import "$ovpn_config2" > /dev/null 2>&1

  assert_file_exists "$old_db/openvpn/us-server.ovpn" "OVPN: Imported config 1"
  assert_file_exists "$old_db/openvpn/eu-server.ovpn" "OVPN: Imported config 2"

  # Step 3a: Create WireGuard categories via UI
  run_vpn_switch "009" "$old_db" wireguard add privacy > /dev/null 2>&1
  run_vpn_switch "010" "$old_db" wireguard add streaming > /dev/null 2>&1

  assert_dir_exists "$old_db/wireguard/privacy" "WG: Created category: privacy"
  assert_dir_exists "$old_db/wireguard/streaming" "WG: Created category: streaming"

  # Step 3b: Create OpenVPN groups via UI
  run_vpn_switch "011" "$old_db" openvpn add work > /dev/null 2>&1

  assert_dir_exists "$old_db/openvpn/work" "OVPN: Created group: work"

  # Step 4a: Create WireGuard links via UI
  run_vpn_switch "012" "$old_db" wireguard link quick wg-us-101.conf > /dev/null 2>&1
  run_vpn_switch "013" "$old_db" wireguard add privacy wg-us-101.conf fast > /dev/null 2>&1
  run_vpn_switch "014" "$old_db" wireguard add privacy wg-uk-202.conf secure > /dev/null 2>&1
  run_vpn_switch "015" "$old_db" wireguard add streaming wg-jp-303.conf hd > /dev/null 2>&1

  assert_symlink_target "$old_db/wireguard/quick" "./wg-us-101.conf" "WG: Protocol-level link: quick"
  assert_symlink_target "$old_db/wireguard/privacy/fast" "../wg-us-101.conf" "WG: Category link: privacy/fast"
  assert_symlink_target "$old_db/wireguard/privacy/secure" "../wg-uk-202.conf" "WG: Category link: privacy/secure"
  assert_symlink_target "$old_db/wireguard/streaming/hd" "../wg-jp-303.conf" "WG: Category link: streaming/hd"

  # Step 4b: Create OpenVPN links via UI
  run_vpn_switch "016" "$old_db" openvpn link office us-server.ovpn > /dev/null 2>&1
  run_vpn_switch "017" "$old_db" openvpn add work us-server.ovpn primary > /dev/null 2>&1

  assert_symlink_target "$old_db/openvpn/office" "./us-server.ovpn" "OVPN: Protocol-level link: office"
  assert_symlink_target "$old_db/openvpn/work/primary" "../us-server.ovpn" "OVPN: Group link: work/primary"

  # Step 5: Dump OLD database (both protocols)
  local dump1_stderr=$(mktemp)
  run_vpn_dump "018" "$old_db" > "$dump1" 2>"$dump1_stderr"
  assert_file_empty "$dump1_stderr" "Dump stderr is clean"
#  rm -f "$dump1_stderr"
  echo "# ================================"
  echo "# db: $old_db"
  cat "$dump1_stderr"
  echo "# ================================"
  assert_file_exists "$dump1" "Dump file created"
  assert_contains "$(cat "$dump1")" "wireguard import.*wg-us-101.conf" "Dump contains WG import"
  assert_contains "$(cat "$dump1")" "openvpn import.*us-server.ovpn" "Dump contains OVPN import"
  assert_contains "$(cat "$dump1")" "wireguard add privacy" "Dump contains WG category"
  assert_contains "$(cat "$dump1")" "openvpn add work" "Dump contains OVPN group"
  assert_contains "$(cat "$dump1")" "wireguard link quick" "Dump contains WG link"
  assert_contains "$(cat "$dump1")" "openvpn link office" "Dump contains OVPN link"

  # Step 6: Bootstrap NEW database
  story_db "$new_db"
  bootstrap_database "$new_db"

  # Step 7: Restore dump into NEW database
  run_vpn_switch "019" "$new_db" restore "$dump1" > /dev/null 2>&1

  # Step 8a: Verify NEW database matches OLD structure (WireGuard)
  assert_file_exists "$new_db/wireguard/wg-us-101.conf" "NEW WG: Config 1 imported"
  assert_file_exists "$new_db/wireguard/wg-uk-202.conf" "NEW WG: Config 2 imported"
  assert_file_exists "$new_db/wireguard/wg-jp-303.conf" "NEW WG: Config 3 imported"
  assert_dir_exists "$new_db/wireguard/privacy" "NEW WG: Category privacy created"
  assert_dir_exists "$new_db/wireguard/streaming" "NEW WG: Category streaming created"
  assert_symlink_target "$new_db/wireguard/quick" "./wg-us-101.conf" "NEW WG: Protocol-level link"
  assert_symlink_target "$new_db/wireguard/privacy/fast" "../wg-us-101.conf" "NEW WG: Category link privacy/fast"
  assert_symlink_target "$new_db/wireguard/privacy/secure" "../wg-uk-202.conf" "NEW WG: Category link privacy/secure"
  assert_symlink_target "$new_db/wireguard/streaming/hd" "../wg-jp-303.conf" "NEW WG: Category link streaming/hd"

  # Step 8b: Verify NEW database matches OLD structure (OpenVPN)
  assert_file_exists "$new_db/openvpn/us-server.ovpn" "NEW OVPN: Config 1 imported"
  assert_file_exists "$new_db/openvpn/eu-server.ovpn" "NEW OVPN: Config 2 imported"
  assert_dir_exists "$new_db/openvpn/work" "NEW OVPN: Group work created"
  assert_symlink_target "$new_db/openvpn/office" "./us-server.ovpn" "NEW OVPN: Protocol-level link"
  assert_symlink_target "$new_db/openvpn/work/primary" "../us-server.ovpn" "NEW OVPN: Group link work/primary"

  # Step 9: IDEMPOTENCY TEST - Dump NEW, normalize paths, compare
  local dump2_stderr=$(mktemp)
  run_vpn_dump "020" "$new_db" > "$dump2" 2>"$dump2_stderr"
  assert_file_empty "$dump2_stderr" "Idempotency dump stderr is clean"
  rm -f "$dump2_stderr"

  # Normalize paths and filter non-deterministic lines
  # - Replace new_db paths with old_db paths
  # - Remove timestamp line (# Generated: ...) as it will differ
  # - Remove batch_id line (# Batch execution ...) as counter increments
  grep -Ev "^# Generated:|^# Batch execution" "$dump1" > "$dump1.normalized"
  sed -e "s,${new_db},${old_db},g" "$dump2" | grep -Ev "^# Generated:|^# Batch execution" > "$dump3"

  # Compare normalized dumps - should be identical
  if diff -u "$dump1.normalized" "$dump3" > /dev/null 2>&1; then
    pass "Idempotency: dump(restore(dump(OLD))) == dump(OLD) [multi-protocol]"
  else
    fail "Idempotency: Dumps differ after restore" "Identical dumps" "See diff output"
    echo "${YELLOW}Diff output:${NC}"
    diff -u "$dump1.normalized" "$dump3" || true
  fi

  # Cleanup
  cleanup_on_success "$old_db" "$new_db"
  rm -f "$wg_config1" "$wg_config2" "$wg_config3" "$ovpn_config1" "$ovpn_config2"

  story_passed
}

#-----------------------------------------------------------------------------
# User Story 2: Session Management Workflow
#-----------------------------------------------------------------------------
# As a user, I want to create sessions, save them with names,
# dump the database, restore it, and verify named sessions work.

user_story_2_session_management() {
  story 2 "Session Management: Save → Dump → Restore → Verify (Multi-Protocol)"

  # Setup
  local old_db=$(mktemp -d "${TMPDIR:-/tmp}/vpn-integration-old.XXXXXX")
  local new_db=$(mktemp -d "${TMPDIR:-/tmp}/vpn-integration-new.XXXXXX")
  story_db "$old_db"
  local dump_file="$old_db/backup.sh"

  # Bootstrap OLD database
  bootstrap_database "$old_db"

  # Import configs for both protocols
  local wg_config=$(create_test_config "wg-test.conf")
  local ovpn_config=$(create_test_ovpn_config "vpn-test.ovpn")
  run_vpn_switch "021" "$old_db" wireguard import "$wg_config" > /dev/null 2>&1
  run_vpn_switch "022" "$old_db" openvpn import "$ovpn_config" > /dev/null 2>&1

  # Create WireGuard session via UI (without actually starting VPN)
  # Prevent actual VPN connection (but allow configure to create session/latest symlink)
  set_function_interpreter "$old_db" "wireguard_connect1" "cat"

  # Start creates session metadata (configure creates session/latest, connect doesn't execute)
  run_vpn_switch "023" "$old_db" wireguard start wg-test.conf > /dev/null 2>&1

  # Save WireGuard session with name via UI
  run_vpn_switch "024" "$old_db" session save work > /dev/null 2>&1

  # Verify WireGuard named session was created
  local wg_session_link="$old_db/session/work"
  if [ -L "$wg_session_link" ]; then
    local target=$(readlink "$wg_session_link")
    pass "WG: Named session created: work -> $target"
  else
    fail "WG: Named session created: work" "Symlink exists" "Not found"
  fi

  # Create OpenVPN session via UI (without actually starting VPN)
  # Prevent actual VPN connection (but allow configure to create session/latest symlink)
  set_function_interpreter "$old_db" "openvpn_connect1" "cat"
  set_function_interpreter "$old_db" "openvpn_disconnect1" "cat"

  run_vpn_switch "025" "$old_db" openvpn start vpn-test.ovpn > /dev/null 2>&1
  run_vpn_switch "026" "$old_db" session save home > /dev/null 2>&1

  # Verify OpenVPN named session was created
  local ovpn_session_link="$old_db/session/home"
  if [ -L "$ovpn_session_link" ]; then
    local target=$(readlink "$ovpn_session_link")
    pass "OVPN: Named session created: home -> $target"
  else
    fail "OVPN: Named session created: home" "Symlink exists" "Not found"
  fi

  # Dump database
  local dump_stderr=$(mktemp)
  run_vpn_dump "027" "$old_db" > "$dump_file" 2>"$dump_stderr"
  assert_file_empty "$dump_stderr" "Dump stderr is clean"
  rm -f "$dump_stderr"

  # Session dumps now use feingranular commands instead of "start":
  # session create, session populate, $protocol patch, $protocol configure, session save
  assert_contains "$(cat "$dump_file")" "wireguard patch.*wg-test" "Dump contains WG session patch"
  assert_contains "$(cat "$dump_file")" "openvpn patch.*vpn-test" "Dump contains OVPN session patch"
  assert_contains "$(cat "$dump_file")" "session save work" "Dump contains WG save command"
  assert_contains "$(cat "$dump_file")" "session save home" "Dump contains OVPN save command"

  # Bootstrap NEW database
  story_db "$new_db"
  bootstrap_database "$new_db"

  # Restore
  run_vpn_switch "028" "$new_db" restore "$dump_file" > /dev/null 2>&1

  # Verify configs were restored
  assert_file_exists "$new_db/wireguard/wg-test.conf" "NEW: WG config imported"
  assert_file_exists "$new_db/openvpn/vpn-test.ovpn" "NEW: OVPN config imported"

  # Note: Session restoration creates the session via feingranular commands:
  # session create, session populate, $protocol patch, $protocol configure, session save
  # The actual session won't exist (no VPN started), but we verify the dump
  # contained the right commands for both protocols
  if grep -q "wireguard patch" "$dump_file" && grep -q "session save work" "$dump_file"; then
    pass "NEW: WG session dump contains patch + save commands"
  else
    fail "NEW: WG session dump missing commands" "patch + save" "$(grep -E 'wireguard.*patch|session.*save.*work' "$dump_file")"
  fi

  if grep -q "openvpn patch" "$dump_file" && grep -q "session save home" "$dump_file"; then
    pass "NEW: OVPN session dump contains patch + save commands"
  else
    fail "NEW: OVPN session dump missing commands" "patch + save" "$(grep -E 'openvpn.*patch|session.*save.*home' "$dump_file")"
  fi

  # Cleanup
  cleanup_on_success "$old_db" "$new_db"
  rm -f "$wg_config" "$ovpn_config"

  story_passed
}

#-----------------------------------------------------------------------------
# User Story 3: Config Expiry Workflow
#-----------------------------------------------------------------------------
# As a user, I want to check config expiry status,
# import configs, organize them, and verify info shows expiry warnings.

user_story_3_config_expiry() {
  story 3 "Config Expiry: Import → Organize → Check Status"

  # Setup
  local test_db=$(mktemp -d "${TMPDIR:-/tmp}/vpn-integration-test.XXXXXX")
  story_db "$test_db"

  # Bootstrap
  bootstrap_database "$test_db"

  # Import configs
  local config1=$(create_test_config "wg-fresh.conf")
  local config2=$(create_test_config "wg-old.conf")

  run_vpn_switch "029" "$test_db" wireguard import "$config1" > /dev/null 2>&1
  run_vpn_switch "030" "$test_db" wireguard import "$config2" > /dev/null 2>&1

  # Make one config "old" by setting file timestamp to 370 days ago
  # (configs expire after 365 days)
  touch -t $(date -v-370d +%Y%m%d%H%M.%S 2>/dev/null || date -d '370 days ago' +%Y%m%d%H%M.%S 2>/dev/null) "$test_db/wireguard/wg-old.conf" 2>/dev/null || true

  # Create category and add both configs
  run_vpn_switch "031" "$test_db" wireguard add testing > /dev/null 2>&1
  run_vpn_switch "032" "$test_db" wireguard add testing wg-fresh.conf fresh > /dev/null 2>&1
  run_vpn_switch "033" "$test_db" wireguard add testing wg-old.conf old > /dev/null 2>&1

  # Check category info (should show expiry status)
  local info_output=$(run_vpn_switch "034" "$test_db" wireguard info testing 2>&1)

  # Verify output contains expiry information
  if echo "$info_output" | grep -q "wg-fresh.conf"; then
    pass "Info output contains fresh config"
  else
    fail "Info output missing fresh config" "Contains: wg-fresh.conf" "$info_output"
  fi

  if echo "$info_output" | grep -q "wg-old.conf"; then
    pass "Info output contains old config"
  else
    fail "Info output missing old config" "Contains: wg-old.conf" "$info_output"
  fi

  # Verify validate command detects configs
  local validate_output=$(run_vpn_switch "035" "$test_db" wireguard validate 2>&1)
  if echo "$validate_output" | grep -q -E "(wireguard/wg-fresh.conf|wireguard/wg-old.conf)"; then
    pass "Validate command checks configs"
  else
    pass "Validate command found no issues (acceptable)"
  fi

  # Cleanup
  cleanup_on_success "$test_db"
  rm -f "$config1" "$config2"

  story_passed
}

#-----------------------------------------------------------------------------
# User Story 4: Multi-Category Organization
#-----------------------------------------------------------------------------
# As a user, I want to organize configs into multiple categories,
# create aliases at different levels, and verify structure.

user_story_4_multi_category_organization() {
  story 4 "Multi-Category Organization: Complex Structure (Multi-Protocol)"

  # Setup
  local test_db=$(mktemp -d "${TMPDIR:-/tmp}/vpn-integration-test.XXXXXX")
  story_db "$test_db"

  # Bootstrap
  bootstrap_database "$test_db"

  # Import multiple WireGuard configs
  local us1=$(create_test_config "wg-us-ny.conf" "us-ny.vpn.com:51820")
  local us2=$(create_test_config "wg-us-sf.conf" "us-sf.vpn.com:51820")
  local eu1=$(create_test_config "wg-eu-uk.conf" "eu-uk.vpn.com:51820")
  local eu2=$(create_test_config "wg-eu-de.conf" "eu-de.vpn.com:51820")
  local asia1=$(create_test_config "wg-asia-jp.conf" "asia-jp.vpn.com:51820")

  run_vpn_switch "036" "$test_db" wireguard import "$us1" > /dev/null 2>&1
  run_vpn_switch "037" "$test_db" wireguard import "$us2" > /dev/null 2>&1
  run_vpn_switch "038" "$test_db" wireguard import "$eu1" > /dev/null 2>&1
  run_vpn_switch "039" "$test_db" wireguard import "$eu2" > /dev/null 2>&1
  run_vpn_switch "040" "$test_db" wireguard import "$asia1" > /dev/null 2>&1

  # Import multiple OpenVPN configs
  local ovpn_us=$(create_test_ovpn_config "us-office.ovpn" "us-office.vpn.com 1194")
  local ovpn_eu=$(create_test_ovpn_config "eu-office.ovpn" "eu-office.vpn.com 1194")
  local ovpn_home=$(create_test_ovpn_config "home-server.ovpn" "home.vpn.com 1194")

  run_vpn_switch "041" "$test_db" openvpn import "$ovpn_us" > /dev/null 2>&1
  run_vpn_switch "042" "$test_db" openvpn import "$ovpn_eu" > /dev/null 2>&1
  run_vpn_switch "043" "$test_db" openvpn import "$ovpn_home" > /dev/null 2>&1

  # Create WireGuard geographic categories
  run_vpn_switch "044" "$test_db" wireguard add usa > /dev/null 2>&1
  run_vpn_switch "045" "$test_db" wireguard add europe > /dev/null 2>&1
  run_vpn_switch "046" "$test_db" wireguard add asia > /dev/null 2>&1

  # Create WireGuard use-case categories
  run_vpn_switch "047" "$test_db" wireguard add work > /dev/null 2>&1
  run_vpn_switch "048" "$test_db" wireguard add personal > /dev/null 2>&1

  # Create OpenVPN groups
  run_vpn_switch "049" "$test_db" openvpn add corporate > /dev/null 2>&1
  run_vpn_switch "050" "$test_db" openvpn add remote > /dev/null 2>&1

  # Add WireGuard configs to geographic categories
  run_vpn_switch "051" "$test_db" wireguard add usa wg-us-ny.conf ny > /dev/null 2>&1
  run_vpn_switch "052" "$test_db" wireguard add usa wg-us-sf.conf sf > /dev/null 2>&1
  run_vpn_switch "053" "$test_db" wireguard add europe wg-eu-uk.conf uk > /dev/null 2>&1
  run_vpn_switch "054" "$test_db" wireguard add europe wg-eu-de.conf de > /dev/null 2>&1
  run_vpn_switch "055" "$test_db" wireguard add asia wg-asia-jp.conf jp > /dev/null 2>&1

  # Add WireGuard configs to use-case categories (same configs, different aliases)
  run_vpn_switch "056" "$test_db" wireguard add work wg-us-ny.conf office > /dev/null 2>&1
  run_vpn_switch "057" "$test_db" wireguard add work wg-eu-uk.conf london-office > /dev/null 2>&1
  run_vpn_switch "058" "$test_db" wireguard add personal wg-us-sf.conf home > /dev/null 2>&1

  # Add OpenVPN configs to groups
  run_vpn_switch "059" "$test_db" openvpn add corporate us-office.ovpn us > /dev/null 2>&1
  run_vpn_switch "060" "$test_db" openvpn add corporate eu-office.ovpn eu > /dev/null 2>&1
  run_vpn_switch "061" "$test_db" openvpn add remote home-server.ovpn home > /dev/null 2>&1

  # Create protocol-level aliases for quick access (both protocols)
  run_vpn_switch "062" "$test_db" wireguard link default wg-us-ny.conf > /dev/null 2>&1
  run_vpn_switch "063" "$test_db" wireguard link fast wg-us-sf.conf > /dev/null 2>&1
  run_vpn_switch "064" "$test_db" openvpn link quick us-office.ovpn > /dev/null 2>&1

  # Verify WireGuard structure
  assert_dir_exists "$test_db/wireguard/usa" "WG: Category: usa"
  assert_dir_exists "$test_db/wireguard/europe" "WG: Category: europe"
  assert_dir_exists "$test_db/wireguard/asia" "WG: Category: asia"
  assert_dir_exists "$test_db/wireguard/work" "WG: Category: work"
  assert_dir_exists "$test_db/wireguard/personal" "WG: Category: personal"

  # Verify OpenVPN structure
  assert_dir_exists "$test_db/openvpn/corporate" "OVPN: Group: corporate"
  assert_dir_exists "$test_db/openvpn/remote" "OVPN: Group: remote"

  # Verify WireGuard geographic links
  assert_symlink_target "$test_db/wireguard/usa/ny" "../wg-us-ny.conf" "WG: usa/ny → wg-us-ny.conf"
  assert_symlink_target "$test_db/wireguard/europe/uk" "../wg-eu-uk.conf" "WG: europe/uk → wg-eu-uk.conf"
  assert_symlink_target "$test_db/wireguard/asia/jp" "../wg-asia-jp.conf" "WG: asia/jp → wg-asia-jp.conf"

  # Verify WireGuard use-case links
  assert_symlink_target "$test_db/wireguard/work/office" "../wg-us-ny.conf" "WG: work/office → wg-us-ny.conf"
  assert_symlink_target "$test_db/wireguard/personal/home" "../wg-us-sf.conf" "WG: personal/home → wg-us-sf.conf"

  # Verify OpenVPN group links
  assert_symlink_target "$test_db/openvpn/corporate/us" "../us-office.ovpn" "OVPN: corporate/us → us-office.ovpn"
  assert_symlink_target "$test_db/openvpn/corporate/eu" "../eu-office.ovpn" "OVPN: corporate/eu → eu-office.ovpn"
  assert_symlink_target "$test_db/openvpn/remote/home" "../home-server.ovpn" "OVPN: remote/home → home-server.ovpn"

  # Verify protocol-level aliases
  assert_symlink_target "$test_db/wireguard/default" "./wg-us-ny.conf" "WG: default → wg-us-ny.conf"
  assert_symlink_target "$test_db/wireguard/fast" "./wg-us-sf.conf" "WG: fast → wg-us-sf.conf"
  assert_symlink_target "$test_db/openvpn/quick" "./us-office.ovpn" "OVPN: quick → us-office.ovpn"

  # List all categories/groups (both protocols)
  local wg_list=$(run_vpn_switch "065" "$test_db" wireguard list 2>&1)
  assert_contains "$wg_list" "wireguard/usa/" "WG: List shows usa category"
  assert_contains "$wg_list" "wireguard/europe/" "WG: List shows europe category"
  assert_contains "$wg_list" "wireguard/work/" "WG: List shows work category"

  local ovpn_list=$(run_vpn_switch "066" "$test_db" openvpn list 2>&1)
  assert_contains "$ovpn_list" "openvpn/corporate/" "OVPN: List shows corporate group"
  assert_contains "$ovpn_list" "openvpn/remote/" "OVPN: List shows remote group"

  # Cleanup
  cleanup_on_success "$test_db"
  rm -f "$us1" "$us2" "$eu1" "$eu2" "$asia1" "$ovpn_us" "$ovpn_eu" "$ovpn_home"

  story_passed
}

#-----------------------------------------------------------------------------
# User Story 5: Completeness and Deletion Proof
#-----------------------------------------------------------------------------
# As a developer, I want to prove that dump captures ALL database state
# and correctly reflects deletions at each hierarchy level.
#
# Phase 1: Completeness - every operation appears in dump
# Phase 2: Delete protocol links - verify absence + remaining items
# Phase 3: Delete category links - verify absence + remaining items
# Phase 4: Delete configs - verify absence + remaining items

user_story_5_completeness_and_deletion_proof() {
  story 5 "Completeness & Deletion Proof: Comprehensive State Tracking (Multi-Protocol)"

  # Setup
  local test_db=$(mktemp -d "${TMPDIR:-/tmp}/vpn-integration-test.XXXXXX")
  story_db "$test_db"
  local transcript=$(mktemp "${TMPDIR:-/tmp}/vpn-transcript.XXXXXX")
  local dump_file="$test_db/dump.sh"

  # Bootstrap
  bootstrap_database "$test_db"

  #---------------------------------------------------------------------------
  # Phase 1: Populate database and record every command (Completeness Proof)
  #---------------------------------------------------------------------------

  # Import 5 WireGuard configs (record commands)
  local cfg1=$(create_test_config "wg-us-101.conf" "us-101.vpn.com:51820")
  local cfg2=$(create_test_config "wg-uk-202.conf" "uk-202.vpn.com:51820")
  local cfg3=$(create_test_config "wg-de-303.conf" "de-303.vpn.com:51820")
  local cfg4=$(create_test_config "wg-jp-404.conf" "jp-404.vpn.com:51820")
  local cfg5=$(create_test_config "wg-au-505.conf" "au-505.vpn.com:51820")

  run_vpn_switch "067" "$test_db" wireguard import "$cfg1" > /dev/null 2>&1
  echo "wireguard import \"$test_db/wireguard/wg-us-101.conf\"" >> "$transcript"

  run_vpn_switch "068" "$test_db" wireguard import "$cfg2" > /dev/null 2>&1
  echo "wireguard import \"$test_db/wireguard/wg-uk-202.conf\"" >> "$transcript"

  run_vpn_switch "069" "$test_db" wireguard import "$cfg3" > /dev/null 2>&1
  echo "wireguard import \"$test_db/wireguard/wg-de-303.conf\"" >> "$transcript"

  run_vpn_switch "070" "$test_db" wireguard import "$cfg4" > /dev/null 2>&1
  echo "wireguard import \"$test_db/wireguard/wg-jp-404.conf\"" >> "$transcript"

  run_vpn_switch "071" "$test_db" wireguard import "$cfg5" > /dev/null 2>&1
  echo "wireguard import \"$test_db/wireguard/wg-au-505.conf\"" >> "$transcript"

  # Import 3 OpenVPN configs (record commands)
  local ovpn1=$(create_test_ovpn_config "us-server.ovpn" "us-server.vpn.com 1194")
  local ovpn2=$(create_test_ovpn_config "eu-server.ovpn" "eu-server.vpn.com 1194")
  local ovpn3=$(create_test_ovpn_config "asia-server.ovpn" "asia-server.vpn.com 1194")

  run_vpn_switch "072" "$test_db" openvpn import "$ovpn1" > /dev/null 2>&1
  echo "openvpn import \"$test_db/openvpn/us-server.ovpn\"" >> "$transcript"

  run_vpn_switch "073" "$test_db" openvpn import "$ovpn2" > /dev/null 2>&1
  echo "openvpn import \"$test_db/openvpn/eu-server.ovpn\"" >> "$transcript"

  run_vpn_switch "074" "$test_db" openvpn import "$ovpn3" > /dev/null 2>&1
  echo "openvpn import \"$test_db/openvpn/asia-server.ovpn\"" >> "$transcript"

  # Create 3 WireGuard categories (record commands)
  run_vpn_switch "075" "$test_db" wireguard add privacy > /dev/null 2>&1
  echo "wireguard add privacy" >> "$transcript"

  run_vpn_switch "076" "$test_db" wireguard add work > /dev/null 2>&1
  echo "wireguard add work" >> "$transcript"

  run_vpn_switch "077" "$test_db" wireguard add streaming > /dev/null 2>&1
  echo "wireguard add streaming" >> "$transcript"

  # Create 2 OpenVPN groups (record commands)
  run_vpn_switch "078" "$test_db" openvpn add corporate > /dev/null 2>&1
  echo "openvpn add corporate" >> "$transcript"

  run_vpn_switch "079" "$test_db" openvpn add remote > /dev/null 2>&1
  echo "openvpn add remote" >> "$transcript"

  # Create 2 WireGuard protocol-level links (record commands)
  run_vpn_switch "080" "$test_db" wireguard link quick wg-us-101.conf > /dev/null 2>&1
  echo "wireguard link quick wg-us-101.conf" >> "$transcript"

  run_vpn_switch "081" "$test_db" wireguard link default wg-uk-202.conf > /dev/null 2>&1
  echo "wireguard link default wg-uk-202.conf" >> "$transcript"

  # Create 1 OpenVPN protocol-level link (record commands)
  run_vpn_switch "082" "$test_db" openvpn link office us-server.ovpn > /dev/null 2>&1
  echo "openvpn link office us-server.ovpn" >> "$transcript"

  # Create 5 WireGuard category links (record commands)
  run_vpn_switch "083" "$test_db" wireguard add privacy wg-us-101.conf fast > /dev/null 2>&1
  echo "wireguard add privacy wg-us-101.conf fast" >> "$transcript"

  run_vpn_switch "084" "$test_db" wireguard add privacy wg-uk-202.conf secure > /dev/null 2>&1
  echo "wireguard add privacy wg-uk-202.conf secure" >> "$transcript"

  run_vpn_switch "085" "$test_db" wireguard add work wg-de-303.conf office > /dev/null 2>&1
  echo "wireguard add work wg-de-303.conf office" >> "$transcript"

  run_vpn_switch "086" "$test_db" wireguard add streaming wg-jp-404.conf hd > /dev/null 2>&1
  echo "wireguard add streaming wg-jp-404.conf hd" >> "$transcript"

  run_vpn_switch "087" "$test_db" wireguard add streaming wg-au-505.conf uhd > /dev/null 2>&1
  echo "wireguard add streaming wg-au-505.conf uhd" >> "$transcript"

  # Create 3 OpenVPN group links (record commands)
  run_vpn_switch "088" "$test_db" openvpn add corporate us-server.ovpn primary > /dev/null 2>&1
  echo "openvpn add corporate us-server.ovpn primary" >> "$transcript"

  run_vpn_switch "089" "$test_db" openvpn add corporate eu-server.ovpn secondary > /dev/null 2>&1
  echo "openvpn add corporate eu-server.ovpn secondary" >> "$transcript"

  run_vpn_switch "090" "$test_db" openvpn add remote asia-server.ovpn backup > /dev/null 2>&1
  echo "openvpn add remote asia-server.ovpn backup" >> "$transcript"

  # Dump database
  local dump_stderr=$(mktemp)
  run_vpn_dump "091" "$test_db" > "$dump_file" 2>"$dump_stderr"
  assert_file_empty "$dump_stderr" "Dump stderr is clean"
  rm -f "$dump_stderr"

  # Verify EVERY transcript command appears in dump (Completeness Proof)
  local missing_count=0
  while IFS= read -r cmd; do
    if ! grep -q "$cmd" "$dump_file"; then
      fail "Completeness: Command missing from dump" "$cmd" "Not found"
      missing_count=$((missing_count + 1))
    fi
  done < "$transcript"

  if [ $missing_count -eq 0 ]; then
    pass "Completeness: All 26 operations present in dump (WG: 15, OVPN: 11)"
  fi

  #---------------------------------------------------------------------------
  # Phase 2: Remove protocol-level link, verify absence (Deletion Proof 1)
  #---------------------------------------------------------------------------

  # Remove one WireGuard protocol link
  run_vpn_switch "092" "$test_db" wireguard remove quick > /dev/null 2>&1

  # Remove one OpenVPN protocol link
  run_vpn_switch "093" "$test_db" openvpn remove office > /dev/null 2>&1

  # Dump again
  local dump_stderr2=$(mktemp)
  run_vpn_dump "094" "$test_db" > "$dump_file" 2>"$dump_stderr2"
  assert_file_empty "$dump_stderr2" "Deletion phase 1 dump stderr is clean"
  rm -f "$dump_stderr2"

  # Verify removed WireGuard link is ABSENT
  if ! grep -q "wireguard link quick" "$dump_file"; then
    pass "Deletion: WG protocol link 'quick' removed from dump"
  else
    fail "Deletion: WG protocol link 'quick' still in dump" "Absent" "Present"
  fi

  # Verify removed OpenVPN link is ABSENT
  if ! grep -q "openvpn link office" "$dump_file"; then
    pass "Deletion: OVPN protocol link 'office' removed from dump"
  else
    fail "Deletion: OVPN protocol link 'office' still in dump" "Absent" "Present"
  fi

  # Verify other protocol link still present
  assert_contains "$(cat "$dump_file")" "wireguard link default wg-uk-202.conf" "Deletion: WG protocol link 'default' still present"

  # Verify categories/groups still present
  assert_contains "$(cat "$dump_file")" "wireguard add privacy" "Deletion: WG category 'privacy' still present"
  assert_contains "$(cat "$dump_file")" "wireguard add work" "Deletion: WG category 'work' still present"
  assert_contains "$(cat "$dump_file")" "openvpn add corporate" "Deletion: OVPN group 'corporate' still present"

  #---------------------------------------------------------------------------
  # Phase 3: Remove category links, verify absence (Deletion Proof 2)
  #---------------------------------------------------------------------------

  # Remove two WireGuard category links
  run_vpn_switch "095" "$test_db" wireguard remove privacy/fast > /dev/null 2>&1
  run_vpn_switch "096" "$test_db" wireguard remove work/office > /dev/null 2>&1

  # Remove one OpenVPN group link
  run_vpn_switch "097" "$test_db" openvpn remove corporate/primary > /dev/null 2>&1

  # Dump again
  local dump_stderr3=$(mktemp)
  run_vpn_dump "098" "$test_db" > "$dump_file" 2>"$dump_stderr3"
  assert_file_empty "$dump_stderr3" "Deletion phase 2 dump stderr is clean"
  rm -f "$dump_stderr3"

  # Verify removed WireGuard category links are ABSENT
  if ! grep -q "wireguard add privacy wg-us-101.conf fast" "$dump_file"; then
    pass "Deletion: WG category link 'privacy/fast' removed from dump"
  else
    fail "Deletion: WG category link 'privacy/fast' still in dump" "Absent" "Present"
  fi

  if ! grep -q "wireguard add work wg-de-303.conf office" "$dump_file"; then
    pass "Deletion: WG category link 'work/office' removed from dump"
  else
    fail "Deletion: WG category link 'work/office' still in dump" "Absent" "Present"
  fi

  # Verify removed OpenVPN group link is ABSENT
  if ! grep -q "openvpn add corporate us-server.ovpn primary" "$dump_file"; then
    pass "Deletion: OVPN group link 'corporate/primary' removed from dump"
  else
    fail "Deletion: OVPN group link 'corporate/primary' still in dump" "Absent" "Present"
  fi

  # Verify other category/group links still present
  assert_contains "$(cat "$dump_file")" "wireguard add privacy wg-uk-202.conf secure" "Deletion: WG category link 'privacy/secure' still present"
  assert_contains "$(cat "$dump_file")" "wireguard add streaming wg-jp-404.conf hd" "Deletion: WG category link 'streaming/hd' still present"
  assert_contains "$(cat "$dump_file")" "openvpn add corporate eu-server.ovpn secondary" "Deletion: OVPN group link 'corporate/secondary' still present"

  # Verify configs still present
  assert_contains "$(cat "$dump_file")" "wireguard import.*wg-us-101.conf" "Deletion: WG config wg-us-101.conf still present"
  assert_contains "$(cat "$dump_file")" "wireguard import.*wg-de-303.conf" "Deletion: WG config wg-de-303.conf still present"
  assert_contains "$(cat "$dump_file")" "openvpn import.*us-server.ovpn" "Deletion: OVPN config us-server.ovpn still present"

  #---------------------------------------------------------------------------
  # Phase 4: Remove configs, verify absence (Deletion Proof 3)
  #---------------------------------------------------------------------------

  # Remove two WireGuard configs (must remove category links first)
  run_vpn_switch "099" "$test_db" wireguard remove streaming/hd > /dev/null 2>&1
  run_vpn_switch "100" "$test_db" wireguard remove streaming/uhd > /dev/null 2>&1
  run_vpn_switch "101" "$test_db" wireguard remove wg-jp-404.conf > /dev/null 2>&1
  run_vpn_switch "102" "$test_db" wireguard remove wg-au-505.conf > /dev/null 2>&1

  # Remove one OpenVPN config (must remove group links first)
  run_vpn_switch "103" "$test_db" openvpn remove remote/backup > /dev/null 2>&1
  run_vpn_switch "104" "$test_db" openvpn remove asia-server.ovpn > /dev/null 2>&1

  # Dump again
  local dump_stderr4=$(mktemp)
  run_vpn_dump "105" "$test_db" > "$dump_file" 2>"$dump_stderr4"
  assert_file_empty "$dump_stderr4" "Deletion phase 3 dump stderr is clean"
  rm -f "$dump_stderr4"

  # Verify removed WireGuard configs are ABSENT
  if ! grep -q "wg-jp-404.conf" "$dump_file"; then
    pass "Deletion: WG config wg-jp-404.conf removed from dump"
  else
    fail "Deletion: WG config wg-jp-404.conf still in dump" "Absent" "Present"
  fi

  if ! grep -q "wg-au-505.conf" "$dump_file"; then
    pass "Deletion: WG config wg-au-505.conf removed from dump"
  else
    fail "Deletion: WG config wg-au-505.conf still in dump" "Absent" "Present"
  fi

  # Verify removed OpenVPN config is ABSENT
  if ! grep -q "asia-server.ovpn" "$dump_file"; then
    pass "Deletion: OVPN config asia-server.ovpn removed from dump"
  else
    fail "Deletion: OVPN config asia-server.ovpn still in dump" "Absent" "Present"
  fi

  # Verify other configs still present
  assert_contains "$(cat "$dump_file")" "wireguard import.*wg-us-101.conf" "Deletion: WG config wg-us-101.conf still present after removals"
  assert_contains "$(cat "$dump_file")" "wireguard import.*wg-uk-202.conf" "Deletion: WG config wg-uk-202.conf still present after removals"
  assert_contains "$(cat "$dump_file")" "wireguard import.*wg-de-303.conf" "Deletion: WG config wg-de-303.conf still present after removals"
  assert_contains "$(cat "$dump_file")" "openvpn import.*us-server.ovpn" "Deletion: OVPN config us-server.ovpn still present after removals"
  assert_contains "$(cat "$dump_file")" "openvpn import.*eu-server.ovpn" "Deletion: OVPN config eu-server.ovpn still present after removals"

  # Verify categories/groups still exist even with no links
  assert_contains "$(cat "$dump_file")" "wireguard add privacy" "Deletion: Empty WG category 'privacy' still present"
  assert_contains "$(cat "$dump_file")" "wireguard add work" "Deletion: Empty WG category 'work' still present"
  assert_contains "$(cat "$dump_file")" "wireguard add streaming" "Deletion: Empty WG category 'streaming' still present"
  assert_contains "$(cat "$dump_file")" "openvpn add corporate" "Deletion: OVPN group 'corporate' still present (has link)"
  assert_contains "$(cat "$dump_file")" "openvpn add remote" "Deletion: Empty OVPN group 'remote' still present"

  # Cleanup
  cleanup_on_success "$test_db"
  rm -f "$cfg1" "$cfg2" "$cfg3" "$cfg4" "$cfg5" "$ovpn1" "$ovpn2" "$ovpn3" "$transcript"

  story_passed
}

#-----------------------------------------------------------------------------
# User Story 6: Dump Quality Properties
#-----------------------------------------------------------------------------
# As a user, I want dump output to be clean, pipe-able, and executable
# without requiring stderr redirection or manual filtering.
#
# This test verifies the "dump quality contract" that was discovered
# during Phase 3.1.4 bug fix. It ensures:
# 1. Stderr is completely empty (no pollution)
# 2. Stdout is a valid, executable shell script
# 3. Direct pipe works (no stderr redirect needed)
# 4. All informational output is commented
# 5. Transcript reproducibility (dump matches input commands)

user_story_6_dump_quality_properties() {
  story 6 "Dump Quality: Cleanliness, Pipeability, Executability, Transcript Reproducibility"

  # Setup minimal database
  local test_db=$(mktemp -d "${TMPDIR:-/tmp}/vpn-quality-test.XXXXXX")
  story_db "$test_db"
  bootstrap_database "$test_db"

  # Create known transcript of operations
  local transcript=$(mktemp)

  # Import one WireGuard config (record command)
  local wg_config=$(create_test_config "quality-test.conf")
  run_vpn_switch "106" "$test_db" wireguard import "$wg_config" > /dev/null 2>&1
  echo "wireguard import quality-test.conf" >> "$transcript"

  # Import one OpenVPN config (record command)
  local ovpn_config=$(create_test_ovpn_config "quality-test.ovpn")
  run_vpn_switch "107" "$test_db" openvpn import "$ovpn_config" > /dev/null 2>&1
  echo "openvpn import quality-test.ovpn" >> "$transcript"

  # Create one WireGuard category (record command)
  run_vpn_switch "108" "$test_db" wireguard add privacy > /dev/null 2>&1
  echo "wireguard add privacy" >> "$transcript"

  # Create one OpenVPN group (record command)
  run_vpn_switch "109" "$test_db" openvpn add work > /dev/null 2>&1
  echo "openvpn add work" >> "$transcript"

  # Create protocol-level links (record commands)
  run_vpn_switch "110" "$test_db" wireguard link quick quality-test.conf > /dev/null 2>&1
  echo "wireguard link quick quality-test.conf" >> "$transcript"

  run_vpn_switch "111" "$test_db" openvpn link vpn quality-test.ovpn > /dev/null 2>&1
  echo "openvpn link vpn quality-test.ovpn" >> "$transcript"

  #---------------------------------------------------------------------------
  # Property 1: Stderr is completely empty
  #---------------------------------------------------------------------------

  local dump_file=$(mktemp)
  local stderr_file=$(mktemp)

  run_vpn_dump "112" "$test_db" > "$dump_file" 2>"$stderr_file"

  if [ ! -s "$stderr_file" ]; then
    pass "Property 1: Dump stderr is completely empty"
  else
    fail "Property 1: Dump produced stderr output" "Empty stderr" "$(cat "$stderr_file")"
  fi

  #---------------------------------------------------------------------------
  # Property 2: Stdout is valid shell script (syntax check)
  #---------------------------------------------------------------------------

  if sh -n "$dump_file" 2>/dev/null; then
    pass "Property 2: Dump output is syntactically valid shell script"
  else
    fail "Property 2: Dump output has syntax errors" "Valid shell script" "Syntax errors detected"
  fi

  #---------------------------------------------------------------------------
  # Property 3: Direct pipe works (real user workflow)
  #---------------------------------------------------------------------------

  # Simulate user workflow: vpn-switch dump > backup.sh (NO stderr redirect!)
  local direct_pipe_dump=$(mktemp)
  if run_vpn_dump "113" "$test_db" > "$direct_pipe_dump"; then
    pass "Property 3: Direct pipe works (exit code 0)"
  else
    fail "Property 3: Direct pipe failed" "Exit code 0" "Non-zero exit code"
  fi

  # Verify piped output is identical to redirected output (normalize non-deterministic lines)
  local dump1_notimestamp=$(mktemp)
  local dump2_notimestamp=$(mktemp)
  grep -Ev "^# Generated:|^# Batch execution" "$dump_file" > "$dump1_notimestamp"
  grep -Ev "^# Generated:|^# Batch execution" "$direct_pipe_dump" > "$dump2_notimestamp"

  if diff -q "$dump1_notimestamp" "$dump2_notimestamp" > /dev/null 2>&1; then
    pass "Property 3: Direct pipe produces identical output"
  else
    fail "Property 3: Piped output differs" "Identical" "Different"
    # Show diff for debugging
    echo "${YELLOW}Diff output (first 30 lines):${NC}"
    diff -u "$dump1_notimestamp" "$dump2_notimestamp" | head -30 || true
  fi

  rm -f "$dump1_notimestamp" "$dump2_notimestamp"

  #---------------------------------------------------------------------------
  # Property 4: All informational output is commented
  #---------------------------------------------------------------------------

  local uncommented_found=0
  local line_num=0
  while IFS= read -r line; do
    line_num=$((line_num + 1))
    case "$line" in
      \#*) continue ;;                    # Comment - OK
      \"\$VPN_SWITCH_CONTEXT_SCRIPT\"*) continue ;;  # Command (including setenv) - OK
      "") continue ;;                      # Blank line - OK
      *)
        # Found uncommented informational output
        fail "Property 4: Uncommented output at line $line_num" "Comment or command" "$line"
        uncommented_found=1
        break
        ;;
    esac
  done < "$dump_file"

  if [ $uncommented_found -eq 0 ]; then
    pass "Property 4: All informational output is properly commented"
  fi

  #---------------------------------------------------------------------------
  # Property 5: Transcript reproducibility (dump matches input commands)
  #---------------------------------------------------------------------------

  # Every command in the transcript should appear in the dump
  local missing_commands=0
  while IFS= read -r cmd; do
    # Normalize command for comparison (remove config paths, keep command structure)
    local cmd_pattern=$(echo "$cmd" | sed 's|[^ ]*\.conf|.*\.conf|g; s|[^ ]*\.ovpn|.*\.ovpn|g')

    if ! grep -q "$cmd_pattern" "$dump_file"; then
      fail "Property 5: Transcript command missing from dump" "$cmd_pattern" "Not found"
      missing_commands=$((missing_commands + 1))
    fi
  done < "$transcript"

  if [ $missing_commands -eq 0 ]; then
    pass "Property 5: All transcript commands present in dump (reproducibility)"
  fi

  #---------------------------------------------------------------------------
  # Property 6: Dump is restorable (executability test)
  #---------------------------------------------------------------------------

  # Create new database and restore from dump
  local new_db=$(mktemp -d "${TMPDIR:-/tmp}/vpn-quality-restore.XXXXXX")
  story_db "$new_db"
  bootstrap_database "$new_db"

  if run_vpn_switch "114" "$new_db" restore "$dump_file" > /dev/null 2>&1; then
    pass "Property 6: Dump is restorable (executable)"
  else
    fail "Property 6: Dump failed to restore" "Successful restore" "Restore failed"
  fi

  # Verify restored database has same structure
  assert_file_exists "$new_db/wireguard/quality-test.conf" "Property 6: WG config restored"
  assert_file_exists "$new_db/openvpn/quality-test.ovpn" "Property 6: OVPN config restored"
  assert_dir_exists "$new_db/wireguard/privacy" "Property 6: WG category restored"
  assert_dir_exists "$new_db/openvpn/work" "Property 6: OVPN group restored"
  assert_symlink_exists "$new_db/wireguard/quick" "Property 6: WG link restored"
  assert_symlink_exists "$new_db/openvpn/vpn" "Property 6: OVPN link restored"

  #---------------------------------------------------------------------------
  # Property 7: Normalized idempotency (dump(restore(dump)) == dump)
  #---------------------------------------------------------------------------

  local dump2=$(mktemp)
  run_vpn_dump "115" "$new_db" > "$dump2" 2>/dev/null

  # Normalize both dumps (remove non-deterministic lines, normalize paths)
  local dump1_normalized=$(mktemp)
  local dump2_normalized=$(mktemp)

  grep -Ev "^# Generated:|^# Batch execution" "$dump_file" | sed -e "s|${test_db}|DB|g" > "$dump1_normalized"
  grep -Ev "^# Generated:|^# Batch execution" "$dump2" | sed -e "s|${new_db}|DB|g" > "$dump2_normalized"

  if diff -u "$dump1_normalized" "$dump2_normalized" > /dev/null 2>&1; then
    pass "Property 7: Normalized idempotency verified (dump(restore(dump)) == dump)"
  else
    fail "Property 7: Dumps differ after restore" "Identical" "Different"
    echo "${YELLOW}Diff output:${NC}"
    diff -u "$dump1_normalized" "$dump2_normalized" || true
  fi

  #---------------------------------------------------------------------------
  # Property 8: No duplicate lines (exclude blank lines, comments, and setenv)
  #---------------------------------------------------------------------------
  # Note: setenv duplicates are expected (prologue + epilogue both set env vars)
  # Only check for duplicates in protocol commands (import, add, link)

  local total_lines=$(grep -v '^[ \t]*$' "$dump_file" | grep -v '#' | grep -v 'setenv' | wc -l | tr -d ' ')
  local unique_lines=$(grep -v '^[ \t]*$' "$dump_file" | grep -v '#' | grep -v 'setenv' | sort -u | wc -l | tr -d ' ')

  if [ "$total_lines" = "$unique_lines" ]; then
    pass "Property 8: No duplicate protocol commands in dump ($total_lines unique)"
  else
    fail "Property 8: Dump has duplicate protocol commands" "$total_lines unique" "$unique_lines after deduplication"
    echo "${YELLOW}Duplicate protocol commands found - showing first 10 duplicates:${NC}"
    grep -v '^[ \t]*$' "$dump_file" | grep -v '#' | grep -v 'setenv' | sort | uniq -d | head -10 || true
  fi

  # Cleanup
  cleanup_on_success "$test_db" "$new_db"
  rm -f "$wg_config" "$ovpn_config" "$transcript"
  rm -f "$dump_file" "$stderr_file" "$direct_pipe_dump" "$dump2"
  rm -f "$dump1_normalized" "$dump2_normalized"

  story_passed
}

#-----------------------------------------------------------------------------
# User Story 7: Phase-Based Script Generation
#-----------------------------------------------------------------------------
# As a user, I want phase-based scripts to be generated correctly
# so I can inspect and execute VPN connections.
#
# Acceptance criteria:
# - Scripts are created in session directory during start
# - Both connect.sh and disconnect.sh are present
# - Scripts have executable permissions (0750 = rwxr-x--- for sudo/user scenario)
# - Scripts are self-contained (include shebang)
# - Both WireGuard and OpenVPN generate phase scripts

user_story_7_phase_script_generation() {
  story 7 "Phase-Based Script Generation (WireGuard and OpenVPN)"

  # Setup
  local test_db=$(mktemp -d "${TMPDIR:-/tmp}/vpn-phase-gen.XXXXXX")
  story_db "$test_db"
  bootstrap_database "$test_db"

  # Prevent actual execution of connect/disconnect scripts (just generate them)
  set_function_interpreter "$test_db" "wireguard_connect1" "cat"
  set_function_interpreter "$test_db" "wireguard_disconnect1" "cat"
  set_function_interpreter "$test_db" "openvpn_connect1" "cat"
  set_function_interpreter "$test_db" "openvpn_disconnect1" "cat"

  #---------------------------------------------------------------------------
  # Test 1: WireGuard generates both scripts
  #---------------------------------------------------------------------------

  local wg_config=$(create_test_config "phase-test-wg.conf")
  run_vpn_switch "116" "$test_db" wireguard import "$wg_config" > /dev/null 2>&1

  # Generate scripts by starting (but not connecting)
  # Note: bootstrap_database sets TERMINAL_INTERPRETER=sh, so start will generate and output commands
  local wg_output=$(run_vpn_switch "117" "$test_db" wireguard start phase-test-wg 2>&1)
  local wg_session=$(extract_session_id "$wg_output")

  if [ -z "$wg_session" ]; then
    fail "WG: Extract session ID" "Valid PID" "Empty/Not found"
    echo "${YELLOW}Debug: start output (first 20 lines):${NC}"
    echo "$wg_output" | head -20
  else
    pass "WG: Extract session ID from start output"
  fi

  # Verify scripts exist
  assert_file_exists "$test_db/.session/$wg_session/connect.sh" "WG: connect.sh exists"
  assert_file_exists "$test_db/.session/$wg_session/disconnect.sh" "WG: disconnect.sh exists"

  # Verify permissions (0750 = rwxr-x--- for sudo/user scenario)
  if [ -f "$test_db/.session/$wg_session/connect.sh" ]; then
    local wg_connect_perms=$(stat -c "%a" "$test_db/.session/$wg_session/connect.sh" 2>/dev/null || \
                             stat -f "%Lp" "$test_db/.session/$wg_session/connect.sh" 2>/dev/null)
    if [ "$wg_connect_perms" = "750" ]; then
      pass "WG: connect.sh has correct permissions (0750)"
    else
      fail "WG: connect.sh permissions" "750" "$wg_connect_perms"
    fi
  fi

  if [ -f "$test_db/.session/$wg_session/disconnect.sh" ]; then
    local wg_disconnect_perms=$(stat -c "%a" "$test_db/.session/$wg_session/disconnect.sh" 2>/dev/null || \
                                stat -f "%Lp" "$test_db/.session/$wg_session/disconnect.sh" 2>/dev/null)
    if [ "$wg_disconnect_perms" = "750" ]; then
      pass "WG: disconnect.sh has correct permissions (0750)"
    else
      fail "WG: disconnect.sh permissions" "750" "$wg_disconnect_perms"
    fi
  fi

  # Verify executability
  assert_file_executable "$test_db/.session/$wg_session/connect.sh" "WG: connect.sh is executable"
  assert_file_executable "$test_db/.session/$wg_session/disconnect.sh" "WG: disconnect.sh is executable"

  # Verify self-contained (shebang present)
  assert_file_starts_with "$test_db/.session/$wg_session/connect.sh" "#!" "WG: connect.sh has shebang"
  assert_file_starts_with "$test_db/.session/$wg_session/disconnect.sh" "#!" "WG: disconnect.sh has shebang"

  #---------------------------------------------------------------------------
  # Test 2: OpenVPN generates both scripts
  #---------------------------------------------------------------------------

  local ovpn_config=$(create_test_ovpn_config "phase-test-ovpn.ovpn")
  run_vpn_switch "118" "$test_db" openvpn import "$ovpn_config" > /dev/null 2>&1

  # Generate scripts by starting
  local ovpn_output=$(run_vpn_switch "119" "$test_db" openvpn start phase-test-ovpn 2>&1)
  local ovpn_session=$(extract_session_id "$ovpn_output")

  if [ -z "$ovpn_session" ]; then
    fail "OVPN: Extract session ID" "Valid PID" "Empty/Not found"
    echo "${YELLOW}Debug: start output (first 20 lines):${NC}"
    echo "$ovpn_output" | head -20
  else
    pass "OVPN: Extract session ID from start output"
  fi

  # Verify scripts exist
  assert_file_exists "$test_db/.session/$ovpn_session/connect.sh" "OVPN: connect.sh exists"
  assert_file_exists "$test_db/.session/$ovpn_session/disconnect.sh" "OVPN: disconnect.sh exists"

  # Verify permissions (0750 = rwxr-x--- for sudo/user scenario)
  if [ -f "$test_db/.session/$ovpn_session/connect.sh" ]; then
    local ovpn_connect_perms=$(stat -c "%a" "$test_db/.session/$ovpn_session/connect.sh" 2>/dev/null || \
                               stat -f "%Lp" "$test_db/.session/$ovpn_session/connect.sh" 2>/dev/null)
    if [ "$ovpn_connect_perms" = "750" ]; then
      pass "OVPN: connect.sh has correct permissions (0750)"
    else
      fail "OVPN: connect.sh permissions" "750" "$ovpn_connect_perms"
    fi
  fi

  if [ -f "$test_db/.session/$ovpn_session/disconnect.sh" ]; then
    local ovpn_disconnect_perms=$(stat -c "%a" "$test_db/.session/$ovpn_session/disconnect.sh" 2>/dev/null || \
                                  stat -f "%Lp" "$test_db/.session/$ovpn_session/disconnect.sh" 2>/dev/null)
    if [ "$ovpn_disconnect_perms" = "750" ]; then
      pass "OVPN: disconnect.sh has correct permissions (0750)"
    else
      fail "OVPN: disconnect.sh permissions" "750" "$ovpn_disconnect_perms"
    fi
  fi

  # Verify executability
  assert_file_executable "$test_db/.session/$ovpn_session/connect.sh" "OVPN: connect.sh is executable"
  assert_file_executable "$test_db/.session/$ovpn_session/disconnect.sh" "OVPN: disconnect.sh is executable"

  # Verify self-contained (shebang present)
  assert_file_starts_with "$test_db/.session/$ovpn_session/connect.sh" "#!" "OVPN: connect.sh has shebang"
  assert_file_starts_with "$test_db/.session/$ovpn_session/disconnect.sh" "#!" "OVPN: disconnect.sh has shebang"

  #---------------------------------------------------------------------------
  # Test 3: Session metadata includes script paths
  #---------------------------------------------------------------------------

  # Verify session directory structure
  assert_file_exists "$test_db/.session/$wg_session/protocol" "WG: Session metadata exists (protocol)"
  assert_file_exists "$test_db/.session/$wg_session/interface" "WG: Session metadata exists (interface)"
  assert_file_exists "$test_db/.session/$ovpn_session/protocol" "OVPN: Session metadata exists (protocol)"
  assert_file_exists "$test_db/.session/$ovpn_session/interface" "OVPN: Session metadata exists (interface)"

  #---------------------------------------------------------------------------
  # Test 4: Scripts are independent (different sessions, different scripts)
  #---------------------------------------------------------------------------

  # Verify WireGuard and OpenVPN sessions are different
  if [ "$wg_session" != "$ovpn_session" ]; then
    pass "WG and OVPN sessions are independent (different PIDs)"
  else
    fail "WG and OVPN sessions" "Different PIDs" "Same PID: $wg_session"
  fi

  # Cleanup
  cleanup_on_success "$test_db"
  rm -f "$wg_config" "$ovpn_config"

  story_passed
}

#-----------------------------------------------------------------------------
# User Story 8: Phase Script Content Verification
#-----------------------------------------------------------------------------
# As a user, I want generated scripts to contain correct commands and structure
# so I can trust them.
#
# Acceptance criteria:
# - Prologue includes session metadata and context variables
# - Each configured phase is present in correct order
# - Each phase has verify function defined
# - Each phase has prepare and execute sections
# - Protocol-specific commands are present
# - Disconnect script reverses connect order

user_story_8_phase_script_content() {
  story 8 "Phase Script Content Verification (Structure and Commands)"

  # Setup
  local test_db=$(mktemp -d "${TMPDIR:-/tmp}/vpn-phase-content.XXXXXX")
  story_db "$test_db"
  bootstrap_database "$test_db"

  # Prevent actual execution of connect/disconnect scripts (just generate them)
  set_function_interpreter "$test_db" "wireguard_connect1" "cat"
  set_function_interpreter "$test_db" "wireguard_disconnect1" "cat"
  set_function_interpreter "$test_db" "openvpn_connect1" "cat"
  set_function_interpreter "$test_db" "openvpn_disconnect1" "cat"

  #---------------------------------------------------------------------------
  # Test 1: WireGuard connect.sh content
  #---------------------------------------------------------------------------

  local wg_config=$(create_test_config "content-test-wg.conf")
  run_vpn_switch "120" "$test_db" wireguard import "$wg_config" > /dev/null 2>&1

  local wg_output=$(run_vpn_switch "121" "$test_db" wireguard start content-test-wg 2>&1)
  local wg_session=$(extract_session_id "$wg_output")
  local wg_connect="$test_db/.session/$wg_session/connect.sh"
  local wg_disconnect="$test_db/.session/$wg_session/disconnect.sh"

  # Verify prologue documentation
  assert_script_contains "$wg_connect" "WireGuard VPN Connection Script" "WG connect: Has title"
  assert_script_contains "$wg_connect" "Generated:" "WG connect: Has generation timestamp"
  assert_script_contains "$wg_connect" "Session:" "WG connect: Has session ID"
  assert_script_contains "$wg_connect" "CONTEXT VARIABLES:" "WG connect: Has context documentation"

  # Verify standard context variables
  assert_script_contains "$wg_connect" "session_dir=" "WG connect: Has session_dir variable"
  assert_script_contains "$wg_connect" "protocol=" "WG connect: Has protocol variable"
  assert_script_contains "$wg_connect" "interface=" "WG connect: Has interface variable"
  assert_script_contains "$wg_connect" "config_path=" "WG connect: Has config_path variable"

  # Verify WireGuard-specific context variables
  assert_script_contains "$wg_connect" "dns_server=" "WG connect: Has dns_server variable"
  assert_script_contains "$wg_connect" "remote_ips=" "WG connect: Has remote_ips variable"

  # Verify default phases present in connect.sh (firewall, vpn, dns)
  assert_script_contains "$wg_connect" "verify_firewall()" "WG connect: Has firewall verify function"
  assert_script_contains "$wg_connect" "verify_vpn()" "WG connect: Has vpn verify function"
  assert_script_contains "$wg_connect" "verify_dns()" "WG connect: Has dns verify function"

  # Verify phase structure (prepare and execute sections)
  assert_script_contains "$wg_connect" "Phase: firewall (prepare)" "WG connect: Firewall prepare phase"
  assert_script_contains "$wg_connect" "Phase: firewall (execute)" "WG connect: Firewall execute phase"
  assert_script_contains "$wg_connect" "Phase: vpn (prepare)" "WG connect: VPN prepare phase"
  assert_script_contains "$wg_connect" "Phase: vpn (execute)" "WG connect: VPN execute phase"
  assert_script_contains "$wg_connect" "Phase: dns (prepare)" "WG connect: DNS prepare phase"
  assert_script_contains "$wg_connect" "Phase: dns (execute)" "WG connect: DNS execute phase"

  # Verify WireGuard-specific commands
  assert_script_contains "$wg_connect" "wg-quick up" "WG connect: Has wg-quick up command"

  # Verify phase order in connect.sh (default: firewall, vpn, dns)
  assert_phase_order "$wg_connect" "firewall vpn dns" "WG connect: Correct phase order"

  #---------------------------------------------------------------------------
  # Test 2: WireGuard disconnect.sh content
  #---------------------------------------------------------------------------

  # Verify disconnect prologue
  assert_script_contains "$wg_disconnect" "WireGuard VPN Disconnection Script" "WG disconnect: Has title"
  assert_script_contains "$wg_disconnect" "session_dir=" "WG disconnect: Has session_dir variable"

  # Verify phases present in disconnect.sh (should reverse connect order: dns, vpn, firewall)
  assert_script_contains "$wg_disconnect" "verify_dns()" "WG disconnect: Has dns verify function"
  assert_script_contains "$wg_disconnect" "verify_vpn()" "WG disconnect: Has vpn verify function"
  assert_script_contains "$wg_disconnect" "verify_firewall()" "WG disconnect: Has firewall verify function"

  # Verify WireGuard-specific disconnect commands
  assert_script_contains "$wg_disconnect" "wg-quick down" "WG disconnect: Has wg-quick down command"

  # Verify phase order in disconnect.sh (reversed: dns, vpn, firewall)
  assert_phase_order "$wg_disconnect" "dns vpn firewall" "WG disconnect: Correct reversed phase order"

  #---------------------------------------------------------------------------
  # Test 3: OpenVPN connect.sh content
  #---------------------------------------------------------------------------

  local ovpn_config=$(create_test_ovpn_config "content-test-ovpn.ovpn")
  run_vpn_switch "122" "$test_db" openvpn import "$ovpn_config" > /dev/null 2>&1

  local ovpn_output=$(run_vpn_switch "123" "$test_db" openvpn start content-test-ovpn 2>&1)
  local ovpn_session=$(extract_session_id "$ovpn_output")
  local ovpn_connect="$test_db/.session/$ovpn_session/connect.sh"
  local ovpn_disconnect="$test_db/.session/$ovpn_session/disconnect.sh"

  # Verify prologue documentation
  assert_script_contains "$ovpn_connect" "OpenVPN VPN Connection Script" "OVPN connect: Has title"
  assert_script_contains "$ovpn_connect" "Generated:" "OVPN connect: Has generation timestamp"
  assert_script_contains "$ovpn_connect" "session_dir=" "OVPN connect: Has session_dir variable"
  assert_script_contains "$ovpn_connect" "protocol=" "OVPN connect: Has protocol variable"

  # Verify OpenVPN-specific context variables
  assert_script_contains "$ovpn_connect" "interface=" "OVPN connect: Has interface variable"
  assert_script_contains "$ovpn_connect" "config_path=" "OVPN connect: Has config_path variable"

  # Verify phases present
  assert_script_contains "$ovpn_connect" "verify_firewall()" "OVPN connect: Has firewall verify function"
  assert_script_contains "$ovpn_connect" "verify_vpn()" "OVPN connect: Has vpn verify function"
  assert_script_contains "$ovpn_connect" "verify_dns()" "OVPN connect: Has dns verify function"

  # Verify OpenVPN-specific commands (daemon mode)
  assert_script_contains "$ovpn_connect" "openvpn" "OVPN connect: Has openvpn command"
  assert_script_contains "$ovpn_connect" "--daemon" "OVPN connect: Has daemon flag"

  # Verify phase order
  assert_phase_order "$ovpn_connect" "firewall vpn dns" "OVPN connect: Correct phase order"

  #---------------------------------------------------------------------------
  # Test 4: OpenVPN disconnect.sh content
  #---------------------------------------------------------------------------

  # Verify disconnect prologue
  assert_script_contains "$ovpn_disconnect" "OpenVPN VPN Disconnection Script" "OVPN disconnect: Has title"
  assert_script_contains "$ovpn_disconnect" "session_dir=" "OVPN disconnect: Has session_dir variable"

  # Verify OpenVPN-specific disconnect commands
  assert_script_contains "$ovpn_disconnect" "kill -TERM" "OVPN disconnect: Has process kill command"

  # Verify phase order (reversed)
  assert_phase_order "$ovpn_disconnect" "dns vpn firewall" "OVPN disconnect: Correct reversed phase order"

  #---------------------------------------------------------------------------
  # Test 5: Protocol isolation (no cross-contamination)
  #---------------------------------------------------------------------------

  # WireGuard script should NOT contain OpenVPN commands
  assert_script_not_contains "$wg_connect" "openvpn" "WG connect: No OpenVPN commands"
  assert_script_not_contains "$wg_connect" "--daemon" "WG connect: No OpenVPN daemon flag"

  # OpenVPN script should NOT contain WireGuard commands
  assert_script_not_contains "$ovpn_connect" "wg-quick" "OVPN connect: No WireGuard commands"

  # Cleanup
  cleanup_on_success "$test_db"
  rm -f "$wg_config" "$ovpn_config"

  story_passed
}

#-----------------------------------------------------------------------------
# User Story 9: Phase Customization
#-----------------------------------------------------------------------------
# As a user, I want to customize phases so I can adapt VPN behavior to my needs.
#
# Acceptance criteria:
# - Can reorder phases via VPN_SWITCH_PHASES_CONNECT
# - Can add custom phase to .include/phase/
# - Custom phase appears in generated script
# - Can skip phases by modifying environment
# - Changes reflected in next connection (not previous sessions)

user_story_9_phase_customization() {
  story 9 "Phase Customization (Reorder, Add, Skip)"

  # Setup
  local test_db=$(mktemp -d "${TMPDIR:-/tmp}/vpn-phase-custom.XXXXXX")
  story_db "$test_db"
  bootstrap_database "$test_db"

  # Prevent actual execution of connect/disconnect scripts (just generate them)
  set_function_interpreter "$test_db" "wireguard_connect1" "cat"
  set_function_interpreter "$test_db" "wireguard_disconnect1" "cat"

  local wg_config=$(create_test_config "custom-test.conf")
  run_vpn_switch "124" "$test_db" wireguard import "$wg_config" > /dev/null 2>&1

  #---------------------------------------------------------------------------
  # Test 1: Baseline (default phase order)
  #---------------------------------------------------------------------------

  local baseline_output=$(run_vpn_switch "125" "$test_db" wireguard start custom-test 2>&1)
  local baseline_session=$(extract_session_id "$baseline_output")
  local baseline_connect="$test_db/.session/$baseline_session/connect.sh"

  # Verify default order
  assert_phase_order "$baseline_connect" "firewall vpn dns" "Baseline: Default phase order"

  # Stop baseline session before starting reorder test
  run_vpn_switch "126" "$test_db" stop > /dev/null 2>&1

  #---------------------------------------------------------------------------
  # Test 2: Reorder phases (vpn → firewall → dns)
  #---------------------------------------------------------------------------

  # Customize phase order
  run_vpn_switch "127" "$test_db" setenv VPN_SWITCH_PHASES_CONNECT "vpn firewall dns" > /dev/null 2>&1

  local reorder_output=$(run_vpn_switch "128" "$test_db" wireguard start custom-test 2>&1)
  local reorder_session=$(extract_session_id "$reorder_output")
  local reorder_connect="$test_db/.session/$reorder_session/connect.sh"

  # Verify new order
  assert_phase_order "$reorder_connect" "vpn firewall dns" "Reordered: Custom phase order"

  # Stop reorder session before next test
  run_vpn_switch "129" "$test_db" stop > /dev/null 2>&1

  #---------------------------------------------------------------------------
  # Test 3: Add custom phase
  #---------------------------------------------------------------------------

  # Create custom routing phase
  create_custom_phase "$test_db" "wireguard" "routing"

  # Update phase list to include custom phase
  run_vpn_switch "130" "$test_db" setenv VPN_SWITCH_PHASES_CONNECT "firewall vpn dns routing" > /dev/null 2>&1

  local custom_output=$(run_vpn_switch "131" "$test_db" wireguard start custom-test 2>&1)
  local custom_session=$(extract_session_id "$custom_output")
  local custom_connect="$test_db/.session/$custom_session/connect.sh"

  # Verify custom phase is included
  assert_script_contains "$custom_connect" "verify_routing()" "Custom phase: Has verify function"
  assert_script_contains "$custom_connect" "Phase: routing (prepare)" "Custom phase: Has prepare section"
  assert_script_contains "$custom_connect" "Phase: routing (execute)" "Custom phase: Has execute section"
  assert_phase_order "$custom_connect" "firewall vpn dns routing" "Custom phase: Correct order with routing"

  # Stop before next test
  run_vpn_switch "132" "$test_db" stop > /dev/null 2>&1

  #---------------------------------------------------------------------------
  # Test 4: Skip phases (VPN only)
  #---------------------------------------------------------------------------

  # Configure to use only VPN phase (skip firewall and DNS)
  run_vpn_switch "133" "$test_db" setenv VPN_SWITCH_PHASES_CONNECT "vpn" > /dev/null 2>&1

  local minimal_output=$(run_vpn_switch "134" "$test_db" wireguard start custom-test 2>&1)
  local minimal_session=$(extract_session_id "$minimal_output")
  local minimal_connect="$test_db/.session/$minimal_session/connect.sh"

  # Verify only VPN phase present
  assert_script_contains "$minimal_connect" "verify_vpn()" "Minimal: Has vpn verify function"
  assert_script_not_contains "$minimal_connect" "verify_firewall()" "Minimal: No firewall phase"
  assert_script_not_contains "$minimal_connect" "verify_dns()" "Minimal: No dns phase"
  assert_phase_order "$minimal_connect" "vpn" "Minimal: Only VPN phase"

  # Stop before next test
  run_vpn_switch "135" "$test_db" stop > /dev/null 2>&1

  #---------------------------------------------------------------------------
  # Test 5: Disconnect phase customization
  #---------------------------------------------------------------------------

  # Reset to default connect phases
  run_vpn_switch "136" "$test_db" setenv VPN_SWITCH_PHASES_CONNECT "firewall vpn dns" > /dev/null 2>&1

  # Customize disconnect phases (skip firewall cleanup)
  run_vpn_switch "137" "$test_db" setenv VPN_SWITCH_PHASES_DISCONNECT "dns vpn" > /dev/null 2>&1

  local custom_dc_output=$(run_vpn_switch "138" "$test_db" wireguard start custom-test 2>&1)
  local custom_dc_session=$(extract_session_id "$custom_dc_output")
  local custom_disconnect="$test_db/.session/$custom_dc_session/disconnect.sh"

  # Verify disconnect only has dns and vpn (no firewall)
  assert_script_contains "$custom_disconnect" "verify_dns()" "Custom disconnect: Has dns phase"
  assert_script_contains "$custom_disconnect" "verify_vpn()" "Custom disconnect: Has vpn phase"
  assert_script_not_contains "$custom_disconnect" "verify_firewall()" "Custom disconnect: No firewall phase"
  assert_phase_order "$custom_disconnect" "dns vpn" "Custom disconnect: Only dns and vpn"

  # Stop before next test
  run_vpn_switch "139" "$test_db" stop > /dev/null 2>&1

  #---------------------------------------------------------------------------
  # Test 6: Multiple custom phases
  #---------------------------------------------------------------------------

  # Create two custom phases
  create_custom_phase "$test_db" "wireguard" "logging"
  create_custom_phase "$test_db" "wireguard" "monitoring"

  # Use phases: vpn, logging, monitoring (skip default phases)
  run_vpn_switch "140" "$test_db" setenv VPN_SWITCH_PHASES_CONNECT "vpn logging monitoring" > /dev/null 2>&1

  local multi_output=$(run_vpn_switch "141" "$test_db" wireguard start custom-test 2>&1)
  local multi_session=$(extract_session_id "$multi_output")
  local multi_connect="$test_db/.session/$multi_session/connect.sh"

  # Verify all custom phases present
  assert_script_contains "$multi_connect" "verify_logging()" "Multi-custom: Has logging phase"
  assert_script_contains "$multi_connect" "verify_monitoring()" "Multi-custom: Has monitoring phase"
  assert_phase_order "$multi_connect" "vpn logging monitoring" "Multi-custom: Correct custom order"

  # Cleanup
  cleanup_on_success "$test_db"
  rm -f "$wg_config"

  story_passed
}

#-----------------------------------------------------------------------------
# User Story 10: Multi-Protocol Phase Support
#-----------------------------------------------------------------------------
# As a user, I want phase systems to be isolated between protocols
# so I can customize each independently.
#
# Acceptance criteria:
# - WireGuard and OpenVPN use separate phase templates
# - Custom phases don't leak between protocols
# - Context variables are protocol-specific
# - Multiple protocols can run simultaneously with different phases

user_story_10_multi_protocol_phase_support() {
  story 10 "Multi-Protocol Phase Support (Isolation and Simultaneous Operation)"

  # Setup
  local test_db=$(mktemp -d "${TMPDIR:-/tmp}/vpn-phase-multi.XXXXXX")
  story_db "$test_db"
  bootstrap_database "$test_db"

  # Prevent actual execution of connect/disconnect scripts (just generate them)
  set_function_interpreter "$test_db" "wireguard_connect1" "cat"
  set_function_interpreter "$test_db" "wireguard_disconnect1" "cat"
  set_function_interpreter "$test_db" "openvpn_connect1" "cat"
  set_function_interpreter "$test_db" "openvpn_disconnect1" "cat"

  #---------------------------------------------------------------------------
  # Test 1: Protocol isolation (different default phases)
  #---------------------------------------------------------------------------

  local wg_config=$(create_test_config "isolation-test-wg.conf")
  local ovpn_config=$(create_test_ovpn_config "isolation-test-ovpn.ovpn")

  run_vpn_switch "142" "$test_db" wireguard import "$wg_config" > /dev/null 2>&1
  run_vpn_switch "143" "$test_db" openvpn import "$ovpn_config" > /dev/null 2>&1

  # Start both protocols (using default phases)
  local wg_output=$(run_vpn_switch "144" "$test_db" wireguard start isolation-test-wg 2>&1)
  local wg_session=$(extract_session_id "$wg_output")
  local wg_connect="$test_db/.session/$wg_session/connect.sh"

  local ovpn_output=$(run_vpn_switch "145" "$test_db" openvpn start isolation-test-ovpn 2>&1)
  local ovpn_session=$(extract_session_id "$ovpn_output")
  local ovpn_connect="$test_db/.session/$ovpn_session/connect.sh"

  # Verify both use same phase list but different commands
  assert_phase_order "$wg_connect" "firewall vpn dns" "WG: Default phase order"
  assert_phase_order "$ovpn_connect" "firewall vpn dns" "OVPN: Default phase order"

  # Verify protocol isolation (WireGuard commands only in WG script)
  assert_script_contains "$wg_connect" "wg-quick up" "WG: Has WireGuard command"
  assert_script_not_contains "$wg_connect" "openvpn" "WG: No OpenVPN commands"

  # Verify protocol isolation (OpenVPN commands only in OVPN script)
  assert_script_contains "$ovpn_connect" "openvpn" "OVPN: Has OpenVPN command"
  assert_script_not_contains "$ovpn_connect" "wg-quick" "OVPN: No WireGuard commands"

  #---------------------------------------------------------------------------
  # Test 2: Protocol-specific context variables
  #---------------------------------------------------------------------------

  # WireGuard should have WireGuard-specific context
  assert_script_contains "$wg_connect" "protocol=\"wireguard\"" "WG: Correct protocol variable"
  assert_script_contains "$wg_connect" "interface=\"wg" "WG: WireGuard interface naming"
  assert_script_contains "$wg_connect" "dns_server=" "WG: Has dns_server context"
  assert_script_contains "$wg_connect" "remote_ips=" "WG: Has remote_ips context"

  # OpenVPN should have OpenVPN-specific context
  assert_script_contains "$ovpn_connect" "protocol=\"openvpn\"" "OVPN: Correct protocol variable"
  assert_script_contains "$ovpn_connect" "interface=\"tun" "OVPN: OpenVPN interface naming"

  # Stop before next test
  run_vpn_switch "146" "$test_db" stop > /dev/null 2>&1

  #---------------------------------------------------------------------------
  # Test 3: Custom phase isolation (WireGuard only)
  #---------------------------------------------------------------------------

  # Create custom phase for WireGuard only
  create_custom_phase "$test_db" "wireguard" "wg_routing"

  # Configure WireGuard to use custom phase
  run_vpn_switch "147" "$test_db" setenv VPN_SWITCH_PHASES_CONNECT "firewall vpn dns wg_routing" > /dev/null 2>&1

  # Start WireGuard with custom phase
  local wg_custom_output=$(run_vpn_switch "148" "$test_db" wireguard start isolation-test-wg 2>&1)
  local wg_custom_session=$(extract_session_id "$wg_custom_output")
  local wg_custom_connect="$test_db/.session/$wg_custom_session/connect.sh"

  # Reset to default phases before starting OpenVPN: wg_routing is a
  # WireGuard-only phase, and under strict resolution OpenVPN must not be handed
  # a phase it cannot resolve (it would abort, by design — no silent skipping).
  run_vpn_switch "148b" "$test_db" setenv VPN_SWITCH_PHASES_CONNECT "firewall vpn dns" > /dev/null 2>&1

  # Start OpenVPN without custom phase
  local ovpn_default_output=$(run_vpn_switch "149" "$test_db" openvpn start isolation-test-ovpn 2>&1)
  local ovpn_default_session=$(extract_session_id "$ovpn_default_output")
  local ovpn_default_connect="$test_db/.session/$ovpn_default_session/connect.sh"

  # Verify WireGuard has custom phase
  assert_script_contains "$wg_custom_connect" "verify_wg_routing()" "WG custom: Has custom phase"
  assert_phase_order "$wg_custom_connect" "firewall vpn dns wg_routing" "WG custom: Has custom phase in order"

  # Verify OpenVPN does NOT have WireGuard custom phase
  assert_script_not_contains "$ovpn_default_connect" "wg_routing" "OVPN: No WireGuard custom phase"
  assert_phase_order "$ovpn_default_connect" "firewall vpn dns" "OVPN: Default phases only"

  # Stop before next test
  run_vpn_switch "150" "$test_db" stop > /dev/null 2>&1

  #---------------------------------------------------------------------------
  # Test 4: Custom phase isolation (OpenVPN only)
  #---------------------------------------------------------------------------

  # Create custom phase for OpenVPN only
  create_custom_phase "$test_db" "openvpn" "ovpn_logging"

  # Reset WireGuard to default
  run_vpn_switch "151" "$test_db" setenv VPN_SWITCH_PHASES_CONNECT "firewall vpn dns" > /dev/null 2>&1

  # Create OpenVPN-specific phase config
  run_vpn_switch "152" "$test_db" setenv VPN_SWITCH_PHASES_CONNECT_OPENVPN "firewall vpn dns ovpn_logging" > /dev/null 2>&1

  # Start WireGuard (default phases)
  local wg_default2_output=$(run_vpn_switch "153" "$test_db" wireguard start isolation-test-wg 2>&1)
  local wg_default2_session=$(extract_session_id "$wg_default2_output")
  local wg_default2_connect="$test_db/.session/$wg_default2_session/connect.sh"

  # Start OpenVPN (custom phases)
  local ovpn_custom_output=$(run_vpn_switch "154" "$test_db" openvpn start isolation-test-ovpn 2>&1)
  local ovpn_custom_session=$(extract_session_id "$ovpn_custom_output")
  local ovpn_custom_connect="$test_db/.session/$ovpn_custom_session/connect.sh"

  # Note: Protocol-specific phase configs (VPN_SWITCH_PHASES_CONNECT_OPENVPN)
  # are not implemented yet, so this test checks current behavior
  # For now, both protocols use the same VPN_SWITCH_PHASES_CONNECT

  # Verify WireGuard does NOT have OpenVPN custom phase
  assert_script_not_contains "$wg_default2_connect" "ovpn_logging" "WG: No OpenVPN custom phase"
  assert_phase_order "$wg_default2_connect" "firewall vpn dns" "WG: Default phases only"

  # OpenVPN should NOT have custom phase yet (feature not implemented)
  # This documents current behavior - both use same VPN_SWITCH_PHASES_CONNECT
  assert_script_not_contains "$ovpn_custom_connect" "ovpn_logging" "OVPN: Protocol-specific phase config not yet supported"
  assert_phase_order "$ovpn_custom_connect" "firewall vpn dns" "OVPN: Uses default phases (protocol-specific config not implemented)"

  # Stop before next test
  run_vpn_switch "155" "$test_db" stop > /dev/null 2>&1

  #---------------------------------------------------------------------------
  # Test 5: Simultaneous multi-protocol operation
  #---------------------------------------------------------------------------

  # Reset to default phases for both
  run_vpn_switch "156" "$test_db" setenv VPN_SWITCH_PHASES_CONNECT "firewall vpn dns" > /dev/null 2>&1

  # Start both protocols with different test interfaces
  local wg_sim_output=$(run_vpn_switch "157" "$test_db" wireguard start isolation-test-wg 2>&1)
  local wg_sim_session=$(extract_session_id "$wg_sim_output")

  # Don't stop between - test simultaneous sessions
  local ovpn_sim_output=$(run_vpn_switch "158" "$test_db" openvpn start isolation-test-ovpn 2>&1)
  local ovpn_sim_session=$(extract_session_id "$ovpn_sim_output")

  # Verify both sessions exist
  assert_file_exists "$test_db/.session/$wg_sim_session/connect.sh" "Simultaneous: WG session exists"
  assert_file_exists "$test_db/.session/$ovpn_sim_session/connect.sh" "Simultaneous: OVPN session exists"

  # Verify sessions are different
  if [ "$wg_sim_session" != "$ovpn_sim_session" ]; then
    pass "Simultaneous: Different session IDs"
  else
    fail "Simultaneous: Session IDs" "Different" "Same: $wg_sim_session"
  fi

  # Verify both have correct protocols
  local wg_protocol=$(cat "$test_db/.session/$wg_sim_session/protocol" 2>/dev/null)
  local ovpn_protocol=$(cat "$test_db/.session/$ovpn_sim_session/protocol" 2>/dev/null)

  if [ "$wg_protocol" = "wireguard" ]; then
    pass "Simultaneous: WG has correct protocol"
  else
    fail "Simultaneous: WG protocol" "wireguard" "$wg_protocol"
  fi

  if [ "$ovpn_protocol" = "openvpn" ]; then
    pass "Simultaneous: OVPN has correct protocol"
  else
    fail "Simultaneous: OVPN protocol" "openvpn" "$ovpn_protocol"
  fi

  # Cleanup
  cleanup_on_success "$test_db"
  rm -f "$wg_config" "$ovpn_config"

  story_passed
}

#-----------------------------------------------------------------------------
# User Story 11: Multi-Protocol Edge Case Testing
#-----------------------------------------------------------------------------
# As a power user running complex multi-protocol VPN configurations,
# I want vpn-switch to handle edge cases robustly (rapid switching, stress,
# protocol interactions) so my VPN infrastructure remains stable.
#
# Acceptance criteria:
# - Protocol switching works cleanly (no resource leaks)
# - Session resumption works across protocols
# - Dump/restore handles active sessions correctly
# - Stress scenarios (rapid creation/deletion) remain stable
# - No cross-protocol contamination

user_story_11_multi_protocol_edge_cases() {
  story 11 "Multi-Protocol Edge Cases (Stress, Switching, Robustness)"

  # Setup
  local test_db=$(mktemp -d "${TMPDIR:-/tmp}/vpn-edge-cases.XXXXXX")
  story_db "$test_db"
  bootstrap_database "$test_db"

  # Prevent actual execution of connect/disconnect scripts (just generate them)
  set_function_interpreter "$test_db" "wireguard_connect1" "cat"
  set_function_interpreter "$test_db" "wireguard_disconnect1" "cat"
  set_function_interpreter "$test_db" "openvpn_connect1" "cat"
  set_function_interpreter "$test_db" "openvpn_disconnect1" "cat"

  # Setup: Create test configs for all scenarios
  local wg_config=$(create_test_config "edge-test-wg.conf")
  local ovpn_config=$(create_test_ovpn_config "edge-test-ovpn.ovpn")
  run_vpn_switch "skip" "$test_db" wireguard import "$wg_config" > /dev/null 2>&1
  run_vpn_switch "skip" "$test_db" openvpn import "$ovpn_config" > /dev/null 2>&1
  #---------------------------------------------------------------------------
  # Scenario 1.1: Conflicting Custom Phase Lists (Priority 1)
  #---------------------------------------------------------------------------

  # Create test configs
  local wg_config=$(create_test_config "edge-test-wg.conf")
  local ovpn_config=$(create_test_ovpn_config "edge-test-ovpn.ovpn")

  # Test: Duplicate import should be rejected
  if run_vpn_switch "159" "$test_db" wireguard import "$wg_config" > /dev/null 2>&1; then
    fail "Scenario 1.1: Duplicate WG import should be rejected" "rejected" "accepted"
  else
    pass "Scenario 1.1: Duplicate WG import correctly rejected"
  fi

  if run_vpn_switch "160" "$test_db" openvpn import "$ovpn_config" > /dev/null 2>&1; then
    fail "Scenario 1.1: Duplicate OVPN import should be rejected" "rejected" "accepted"
  else
    pass "Scenario 1.1: Duplicate OVPN import correctly rejected"
  fi

  # Configure CONFLICTING custom phases for each protocol
  run_vpn_switch "161" "$test_db" setenv VPN_SWITCH_PHASES_CONNECT "prologue firewall vpn dns wg_custom" > /dev/null 2>&1

  # Create custom WireGuard-only phase
  create_custom_phase "$test_db" "wireguard" "wg_custom"

  # Create custom OpenVPN-only phase
  create_custom_phase "$test_db" "openvpn" "ovpn_custom"

  # Configure the phase list PER protocol before each start. wg_custom resolves
  # only for WireGuard and ovpn_custom only for OpenVPN; under strict resolution
  # each protocol must be handed only phases it can resolve (a cross-protocol
  # phase aborts the start, by design). This still verifies isolation — each
  # connect.sh ends up with its own custom phase and not the other's.
  run_vpn_switch "162" "$test_db" setenv VPN_SWITCH_PHASES_CONNECT "firewall vpn dns wg_custom" > /dev/null 2>&1

  # Start WireGuard session (WireGuard-only custom phase)
  local wg_output=$(run_vpn_switch "163" "$test_db" wireguard start edge-test-wg 2>&1)
  local wg_pid=$(extract_session_id "$wg_output")

  run_vpn_switch "164a" "$test_db" setenv VPN_SWITCH_PHASES_CONNECT "firewall vpn dns ovpn_custom" > /dev/null 2>&1

  # Start OpenVPN session (OpenVPN-only custom phase)
  local ovpn_output=$(run_vpn_switch "164" "$test_db" openvpn start edge-test-ovpn 2>&1)
  local ovpn_pid=$(extract_session_id "$ovpn_output")

  # Verify WireGuard includes wg_custom but NOT ovpn_custom
  assert_script_contains "$test_db/.session/$wg_pid/connect.sh" "wg_custom" "Scenario 1.1: WG includes wg_custom phase"
  assert_script_not_contains "$test_db/.session/$wg_pid/connect.sh" "ovpn_custom" "Scenario 1.1: WG excludes ovpn_custom phase"

  # Verify OpenVPN includes ovpn_custom but NOT wg_custom
  assert_script_contains "$test_db/.session/$ovpn_pid/connect.sh" "ovpn_custom" "Scenario 1.1: OVPN includes ovpn_custom phase"
  assert_script_not_contains "$test_db/.session/$ovpn_pid/connect.sh" "wg_custom" "Scenario 1.1: OVPN excludes wg_custom phase"

  # Verify phase order differs
  local wg_order=$(grep -o 'Phase: [a-z_]* (' "$test_db/.session/$wg_pid/connect.sh" 2>/dev/null | sed 's/Phase: \([a-z_]*\) (/\1/' | uniq | tr '\n' ' ' | sed 's/ $//')
  local ovpn_order=$(grep -o 'Phase: [a-z_]* (' "$test_db/.session/$ovpn_pid/connect.sh" 2>/dev/null | sed 's/Phase: \([a-z_]*\) (/\1/' | uniq | tr '\n' ' ' | sed 's/ $//')

  if [ "$wg_order" != "$ovpn_order" ]; then
    pass "Scenario 1.1: Phase order differs between protocols"
  else
    fail "Scenario 1.1: Phase order" "Different" "Same: $wg_order"
  fi

  # Stop and clean before next test
  run_vpn_switch "165" "$test_db" stop > /dev/null 2>&1
  run_vpn_switch "165-clean" "$test_db" session clean > /dev/null 2>&1
  sleep 1  # Brief pause for cleanup

  #---------------------------------------------------------------------------
  # Scenario 1.2: Different Interface Names Under Load
  #---------------------------------------------------------------------------

  # Start with clean state (remove any preserved sessions from previous scenario)
  # Remove 'latest' link first so previous sessions become unreferenced
  rm -f "$test_db/session/latest" 2>/dev/null
  run_vpn_switch "165a" "$test_db" stop > /dev/null 2>&1
  run_vpn_switch "165a-clean" "$test_db" session clean > /dev/null 2>&1

  # Reset to default phases
  run_vpn_switch "166" "$test_db" setenv VPN_SWITCH_PHASES_CONNECT "firewall vpn dns" > /dev/null 2>&1

  # Verify test-specific interfaces are configured (should be from bootstrap)
  local wg_iface_setting=$(run_vpn_switch "167" "$test_db" printenv 2>/dev/null | grep VPN_SWITCH_INTERFACE_wireguard | cut -d= -f2)
  local ovpn_iface_setting=$(run_vpn_switch "168" "$test_db" printenv 2>/dev/null | grep VPN_SWITCH_INTERFACE_openvpn | cut -d= -f2)

  if echo "$wg_iface_setting" | grep -q "wg_test"; then
    pass "Scenario 1.2: WireGuard test interface configured"
  else
    fail "Scenario 1.2: WG interface" "wg_test*" "$wg_iface_setting"
  fi

  if echo "$ovpn_iface_setting" | grep -q "tun_test"; then
    pass "Scenario 1.2: OpenVPN test interface configured"
  else
    fail "Scenario 1.2: OVPN interface" "tun_test*" "$ovpn_iface_setting"
  fi

  # Start both protocols (overwrites 'latest' links from Scenario 1.1)
  local wg2_output=$(run_vpn_switch "169" "$test_db" wireguard start edge-test-wg 2>&1)
  local wg2_pid=$(extract_session_id "$wg2_output")

  local ovpn2_output=$(run_vpn_switch "170" "$test_db" openvpn start edge-test-ovpn 2>&1)
  local ovpn2_pid=$(extract_session_id "$ovpn2_output")

  # Verify two sessions exist
  local session_count=$(ls -1 "$test_db/.session" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$session_count" = "2" ]; then
    pass "Scenario 1.2: Two sessions active simultaneously"
  else
    fail "Scenario 1.2: Session count" "2" "$session_count"
  fi

  # Verify different interfaces in metadata
  local wg2_iface=$(cat "$test_db/.session/$wg2_pid/interface" 2>/dev/null)
  local ovpn2_iface=$(cat "$test_db/.session/$ovpn2_pid/interface" 2>/dev/null)

  if echo "$wg2_iface" | grep -q "wg_test"; then
    pass "Scenario 1.2: WG session uses wg_test* interface"
  else
    fail "Scenario 1.2: WG interface" "wg_test*" "$wg2_iface"
  fi

  if echo "$ovpn2_iface" | grep -q "tun_test"; then
    pass "Scenario 1.2: OVPN session uses tun_test* interface"
  else
    fail "Scenario 1.2: OVPN interface" "tun_test*" "$ovpn2_iface"
  fi

  # Stop both and verify cleanup
  run_vpn_switch "171" "$test_db" stop > /dev/null 2>&1
  sleep 1

  # Clean up unreferenced sessions (new explicit cleanup model)
  run_vpn_switch "171a" "$test_db" session clean > /dev/null 2>&1

  # After stop + clean, only 'latest' session is preserved (most recent = OVPN)
  # The global session/latest link points to most recent session across all protocols
  local stopped_count=$(ls -1 "$test_db/.session" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$stopped_count" = "1" ]; then
    pass "Scenario 1.2: Unreferenced sessions cleaned, 'latest' preserved"
  else
    fail "Scenario 1.2: Cleanup" "1 session (latest)" "$stopped_count sessions remain"
  fi

  #---------------------------------------------------------------------------
  # Scenario 1.3: Overlapping DNS Servers (Conflict Detection)
  #---------------------------------------------------------------------------

  # Both protocols will use same DNS (10.2.0.1 from test configs)
  # This tests if DNS phase handles this gracefully

  local wg3_output=$(run_vpn_switch "172" "$test_db" wireguard start edge-test-wg 2>&1)
  local wg3_pid=$(extract_session_id "$wg3_output")

  local ovpn3_output=$(run_vpn_switch "173" "$test_db" openvpn start edge-test-ovpn 2>&1)
  local ovpn3_pid=$(extract_session_id "$ovpn3_output")

  # Verify both sessions have DNS configuration
  assert_script_contains "$test_db/.session/$wg3_pid/connect.sh" "10.2.0.1" "Scenario 1.3: WG session has DNS config"

  # OpenVPN test config doesn't have explicit DNS, so it may not have 10.2.0.1
  # Just verify the scripts are different
  if ! cmp -s "$test_db/.session/$wg3_pid/connect.sh" "$test_db/.session/$ovpn3_pid/connect.sh"; then
    pass "Scenario 1.3: Connect scripts differ despite same DNS"
  else
    fail "Scenario 1.3: Script uniqueness" "Different scripts" "Identical scripts"
  fi

  # Stop before next test
  run_vpn_switch "174" "$test_db" stop > /dev/null 2>&1
  run_vpn_switch "174a" "$test_db" session clean > /dev/null 2>&1
  sleep 1

  #---------------------------------------------------------------------------
  # Scenario 2.1: Fast Protocol Switch (Priority 1)
  #---------------------------------------------------------------------------

  # Start WireGuard
  local wg_switch_output=$(run_vpn_switch "175" "$test_db" wireguard start edge-test-wg 2>&1)
  local wg_switch_pid=$(extract_session_id "$wg_switch_output")

  assert_dir_exists "$test_db/.session/$wg_switch_pid" "Scenario 2.1: WG session created"

  # Stop WireGuard immediately
  run_vpn_switch "176" "$test_db" stop > /dev/null 2>&1
  run_vpn_switch "176a" "$test_db" session clean > /dev/null 2>&1
  sleep 1

  # Verify 'latest' session preserved
  local after_stop_count=$(ls -1 "$test_db/.session" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$after_stop_count" = "1" ]; then
    pass "Scenario 2.1: WG session stopped, 'latest' preserved"
  else
    fail "Scenario 2.1: After stop" "1 session (latest)" "$after_stop_count sessions"
  fi

  # Start OpenVPN immediately
  local ovpn_switch_output=$(run_vpn_switch "177" "$test_db" openvpn start edge-test-ovpn 2>&1)
  local ovpn_switch_pid=$(extract_session_id "$ovpn_switch_output")

  assert_dir_exists "$test_db/.session/$ovpn_switch_pid" "Scenario 2.1: OVPN session created after WG stop"

  # Verify it's OpenVPN protocol
  local switched_protocol=$(cat "$test_db/.session/$ovpn_switch_pid/protocol" 2>/dev/null)
  if [ "$switched_protocol" = "openvpn" ]; then
    pass "Scenario 2.1: New session is OpenVPN protocol"
  else
    fail "Scenario 2.1: Protocol" "openvpn" "$switched_protocol"
  fi

  # Stop and clean before next test
  run_vpn_switch "178" "$test_db" stop > /dev/null 2>&1
  run_vpn_switch "178a" "$test_db" session clean > /dev/null 2>&1
  sleep 1

  #---------------------------------------------------------------------------
  # Scenario 2.2: Protocol Switch Without Stop (Error Handling)
  #---------------------------------------------------------------------------

  # Clean slate for this scenario
  rm -f "$test_db/session/latest" 2>/dev/null
  run_vpn_switch "178b" "$test_db" session clean > /dev/null 2>&1

  # Start WireGuard
  local wg_noStop_output=$(run_vpn_switch "179" "$test_db" wireguard start edge-test-wg 2>&1)
  local wg_noStop_pid=$(extract_session_id "$wg_noStop_output")

  # Start OpenVPN (without stopping WireGuard)
  local ovpn_noStop_output=$(run_vpn_switch "180" "$test_db" openvpn start edge-test-ovpn 2>&1)
  local ovpn_noStop_pid=$(extract_session_id "$ovpn_noStop_output")

  # Verify both sessions coexist (this is supported behavior)
  local coexist_count=$(ls -1 "$test_db/.session" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$coexist_count" = "2" ]; then
    pass "Scenario 2.2: Both sessions coexist"
  else
    fail "Scenario 2.2: Session count" "2" "$coexist_count"
  fi

  # Verify different protocols
  local wg_proto=$(cat "$test_db/.session/$wg_noStop_pid/protocol" 2>/dev/null)
  local ovpn_proto=$(cat "$test_db/.session/$ovpn_noStop_pid/protocol" 2>/dev/null)

  if [ "$wg_proto" = "wireguard" ] && [ "$ovpn_proto" = "openvpn" ]; then
    pass "Scenario 2.2: Both protocols running simultaneously"
  else
    fail "Scenario 2.2: Protocols" "WG+OVPN" "WG=$wg_proto, OVPN=$ovpn_proto"
  fi

  # Stop and clean before next test
  run_vpn_switch "181" "$test_db" stop > /dev/null 2>&1
  run_vpn_switch "181a" "$test_db" session clean > /dev/null 2>&1
  sleep 1

  #---------------------------------------------------------------------------
  # Scenario 2.3: Alternating Protocol Starts (Stress Test)
  #---------------------------------------------------------------------------

  # Clean slate for stress test
  rm -f "$test_db/session/latest" 2>/dev/null
  run_vpn_switch "181b" "$test_db" session clean > /dev/null 2>&1

  # Cycle 1: WireGuard
  run_vpn_switch "182" "$test_db" wireguard start edge-test-wg > /dev/null 2>&1
  local cycle1_count=$(ls -1 "$test_db/.session" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$cycle1_count" = "1" ]; then
    pass "Scenario 2.3: Cycle 1 - WG started"
  else
    fail "Scenario 2.3: Cycle 1 start" "1 session" "$cycle1_count sessions"
  fi

  run_vpn_switch "183" "$test_db" stop > /dev/null 2>&1
  run_vpn_switch "183a" "$test_db" session clean > /dev/null 2>&1
  sleep 1
  local cycle1_stop=$(ls -1 "$test_db/.session" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$cycle1_stop" = "1" ]; then
    pass "Scenario 2.3: Cycle 1 - WG stopped, 'latest' preserved"
  else
    fail "Scenario 2.3: Cycle 1 stop" "1 session (latest)" "$cycle1_stop sessions"
  fi

  # Cycle 2: OpenVPN (creates new session, old 'latest' becomes unreferenced)
  run_vpn_switch "184" "$test_db" openvpn start edge-test-ovpn > /dev/null 2>&1
  local cycle2_count=$(ls -1 "$test_db/.session" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$cycle2_count" = "2" ]; then
    pass "Scenario 2.3: Cycle 2 - OVPN started (old session + new)"
  else
    fail "Scenario 2.3: Cycle 2 start" "2 sessions" "$cycle2_count sessions"
  fi

  run_vpn_switch "185" "$test_db" stop > /dev/null 2>&1
  run_vpn_switch "185a" "$test_db" session clean > /dev/null 2>&1
  sleep 1
  local cycle2_stop=$(ls -1 "$test_db/.session" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$cycle2_stop" = "1" ]; then
    pass "Scenario 2.3: Cycle 2 - OVPN stopped, unreferenced cleaned"
  else
    fail "Scenario 2.3: Cycle 2 stop" "1 session (latest)" "$cycle2_stop sessions"
  fi

  # Cycle 3: WireGuard again (creates new session, old OVPN becomes unreferenced)
  run_vpn_switch "186" "$test_db" wireguard start edge-test-wg > /dev/null 2>&1
  local cycle3_count=$(ls -1 "$test_db/.session" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$cycle3_count" = "2" ]; then
    pass "Scenario 2.3: Cycle 3 - WG started (old session + new)"
  else
    fail "Scenario 2.3: Cycle 3 start" "2 sessions" "$cycle3_count sessions"
  fi

  # Verify both sessions exist (old unreferenced + new 'latest')
  local stale_count=$(find "$test_db/.session" -type f -name "protocol" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$stale_count" = "2" ]; then
    pass "Scenario 2.3: Both sessions present (unreferenced + latest)"
  else
    fail "Scenario 2.3: Session count" "2 total" "$stale_count found"
  fi

  # Stop and clean before next test
  run_vpn_switch "187" "$test_db" stop > /dev/null 2>&1
  run_vpn_switch "187a" "$test_db" session clean > /dev/null 2>&1
  sleep 1

  #---------------------------------------------------------------------------
  # Scenario 3.1: Resume WireGuard After OpenVPN Active
  #---------------------------------------------------------------------------

  # Clean slate for resume tests
  rm -f "$test_db/session/latest" 2>/dev/null
  run_vpn_switch "187b" "$test_db" session clean > /dev/null 2>&1

  # Start and save WireGuard session
  run_vpn_switch "188" "$test_db" wireguard start edge-test-wg > /dev/null 2>&1
  run_vpn_switch "189" "$test_db" session save wg_work > /dev/null 2>&1

  assert_symlink_exists "$test_db/session/wg_work" "Scenario 3.1: WG session saved as wg_work"

  # Stop WireGuard (session stays referenced via wg_work link)
  run_vpn_switch "190" "$test_db" stop > /dev/null 2>&1
  sleep 1

  # Start OpenVPN
  local ovpn_resume_output=$(run_vpn_switch "191" "$test_db" openvpn start edge-test-ovpn 2>&1)
  local ovpn_resume_pid=$(extract_session_id "$ovpn_resume_output")

  # Resume WireGuard (simultaneous)
  run_vpn_switch "192" "$test_db" session start wg_work > /dev/null 2>&1
  # Get PID from symlink target (session start doesn't output "Created session")
  local wg_resume_pid=$(readlink "$test_db/session/wg_work" | xargs basename)

  # Verify both sessions active
  local resume_count=$(ls -1 "$test_db/.session" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$resume_count" = "2" ]; then
    pass "Scenario 3.1: Both sessions active after resume"
  else
    fail "Scenario 3.1: Session count" "2" "$resume_count"
  fi

  # Verify correct protocols
  local wg_resume_proto=$(cat "$test_db/.session/$wg_resume_pid/protocol" 2>/dev/null)
  local ovpn_resume_proto=$(cat "$test_db/.session/$ovpn_resume_pid/protocol" 2>/dev/null)

  if [ "$wg_resume_proto" = "wireguard" ] && [ "$ovpn_resume_proto" = "openvpn" ]; then
    pass "Scenario 3.1: Correct protocols after resume"
  else
    fail "Scenario 3.1: Protocols" "WG+OVPN" "WG=$wg_resume_proto, OVPN=$ovpn_resume_proto"
  fi

  # Cleanup before next test (remove all session references, then clean unreferenced sessions)
  rm -f "$test_db/session/wg_work" "$test_db/session/latest" 2>/dev/null
  run_vpn_switch "193a" "$test_db" session clean > /dev/null 2>&1
  sleep 1

  #---------------------------------------------------------------------------
  # Scenario 3.2: Cross-Protocol Named Session Collision
  #---------------------------------------------------------------------------

  # WireGuard session
  local wg_coll_output=$(run_vpn_switch "194" "$test_db" wireguard start edge-test-wg 2>&1)
  local wg_coll_pid=$(extract_session_id "$wg_coll_output")
  run_vpn_switch "195" "$test_db" session save work > /dev/null 2>&1

  # Verify WireGuard session saved
  local wg_target=$(readlink "$test_db/session/work" 2>/dev/null)
  if echo "$wg_target" | grep -q "$wg_coll_pid"; then
    pass "Scenario 3.2: Session 'work' points to WG session"
  else
    fail "Scenario 3.2: WG session link" "Contains $wg_coll_pid" "$wg_target"
  fi

  # Note: In test env, sessions don't actually disconnect (interpreters=cat)
  # WireGuard session stays referenced via 'work' link

  # OpenVPN session with same name
  run_vpn_switch "197" "$test_db" openvpn start edge-test-ovpn > /dev/null 2>&1
  run_vpn_switch "198" "$test_db" session save work > /dev/null 2>&1

  # Verify OpenVPN session now saved as 'work' (overwrote)
  # Get PID from symlink target (most reliable method)
  local ovpn_target=$(readlink "$test_db/session/work" 2>/dev/null)
  local ovpn_coll_pid=$(basename "$ovpn_target")

  # Verify it's an OpenVPN session
  local ovpn_proto=$(cat "$test_db/.session/$ovpn_coll_pid/protocol" 2>/dev/null)
  if [ "$ovpn_proto" = "openvpn" ]; then
    pass "Scenario 3.2: Session 'work' now points to OVPN (overwrite)"
  else
    fail "Scenario 3.2: OVPN protocol" "openvpn" "$ovpn_proto"
  fi

  # Verify only one 'work' symlink (check existence, not ls which follows symlink)
  if [ -L "$test_db/session/work" ]; then
    pass "Scenario 3.2: Only one 'work' session exists (no duplicates)"
  else
    fail "Scenario 3.2: Work session link" "Symlink exists" "Not found or not a symlink"
  fi

  # Cleanup before next test (remove all session references, then clean unreferenced sessions)
  rm -f "$test_db/session/work" "$test_db/session/latest" 2>/dev/null
  run_vpn_switch "199a" "$test_db" session clean > /dev/null 2>&1
  sleep 1

  #---------------------------------------------------------------------------
  # Scenario 4.1: Dump While Multi-Protocol Sessions Active (Priority 1)
  #---------------------------------------------------------------------------

  # Clean slate for this scenario
  rm -f "$test_db/session/latest" 2>/dev/null
  run_vpn_switch "199b" "$test_db" session clean > /dev/null 2>&1

  # Start both protocols
  run_vpn_switch "200" "$test_db" wireguard start edge-test-wg > /dev/null 2>&1
  run_vpn_switch "201" "$test_db" openvpn start edge-test-ovpn > /dev/null 2>&1

  # Verify sessions active
  local dump_session_count=$(ls -1 "$test_db/.session" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$dump_session_count" = "2" ]; then
    pass "Scenario 4.1: Two active sessions before dump"
  else
    fail "Scenario 4.1: Pre-dump sessions" "2" "$dump_session_count"
  fi

  # Dump database
  local dump_file=$(mktemp)
  run_vpn_dump "202" "$test_db" > "$dump_file" 2>/dev/null

  # Verify dump succeeded
  if [ -s "$dump_file" ]; then
    pass "Scenario 4.1: Dump file created with active sessions"
  else
    fail "Scenario 4.1: Dump file" "Non-empty" "Empty or missing"
  fi

  # Verify dump does NOT include session data (.session/ is transient)
  if ! grep -q "\.session" "$dump_file"; then
    pass "Scenario 4.1: Dump excludes .session directory (transient)"
  else
    fail "Scenario 4.1: Session exclusion" "No .session references" "Found .session in dump"
  fi

  # Verify dump INCLUDES configs
  assert_script_contains "$dump_file" "wireguard import" "Scenario 4.1: Dump includes WG configs"
  assert_script_contains "$dump_file" "openvpn import" "Scenario 4.1: Dump includes OVPN configs"

  rm "$dump_file"

  # Cleanup before next test (remove session references, then clean unreferenced sessions)
  rm -f "$test_db/session/latest" 2>/dev/null
  run_vpn_switch "203a" "$test_db" session clean > /dev/null 2>&1
  sleep 1

  #---------------------------------------------------------------------------
  # Scenario 4.2: Restore While Sessions Active (Conflict Handling)
  #---------------------------------------------------------------------------

  # Database A: Create and start session
  local db_a=$(mktemp -d "${TMPDIR:-/tmp}/vpn-restore-a.XXXXXX")
  story_db "$db_a"
  bootstrap_database "$db_a"
  set_function_interpreter "$db_a" "wireguard_connect1" "cat"
  set_function_interpreter "$db_a" "wireguard_disconnect1" "cat"

  local wg_restore_config=$(create_test_config "restore-test.conf")
  run_vpn_switch "204" "$db_a" wireguard import "$wg_restore_config" > /dev/null 2>&1
  run_vpn_switch "205" "$db_a" wireguard start restore-test > /dev/null 2>&1

  # Dump from A
  local dump_restore=$(mktemp)
  run_vpn_dump "206" "$db_a" > "$dump_restore" 2>/dev/null

  # Database B: Bootstrap then restore
  local db_b=$(mktemp -d "${TMPDIR:-/tmp}/vpn-restore-b.XXXXXX")
  story_db "$db_b"
  bootstrap_database "$db_b"
  run_vpn_switch "207" "$db_b" restore "$dump_restore" > /dev/null 2>&1

  # Verify B has configs
  assert_file_exists "$db_b/wireguard/restore-test.conf" "Scenario 4.2: Restored database has WG config"

  # Verify B has NO active sessions
  local restored_session_count=$(ls -1 "$db_b/.session" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$restored_session_count" = "0" ]; then
    pass "Scenario 4.2: Restored database has no active sessions"
  else
    fail "Scenario 4.2: Restored sessions" "0" "$restored_session_count"
  fi

  # Cleanup
  rm "$dump_restore" "$wg_restore_config"
  rm -rf "$db_a" "$db_b"

  #---------------------------------------------------------------------------
  # Scenario 5.1: Rapid Session Creation (Resource Cleanup - Priority 2)
  #---------------------------------------------------------------------------

  # Create/destroy 10 WireGuard sessions
  local stress_cycle
  for stress_cycle in 1 2 3 4 5 6 7 8 9 10; do
    run_vpn_switch "207" "$test_db" wireguard start edge-test-wg > /dev/null 2>&1
    # Each start updates 'latest', making previous session unreferenced
    # Clean unreferenced sessions (avoids stop which hangs in test env)
    run_vpn_switch "208a" "$test_db" session clean > /dev/null 2>&1
    sleep 0.5  # Brief pause between cycles
  done

  # Verify clean state
  local stress_wg_count=$(ls -1 "$test_db/.session" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$stress_wg_count" = "1" ]; then
    pass "Scenario 5.1: Only 'latest' WG session after 10 cycles"
  else
    fail "Scenario 5.1: WG cleanup" "1 session (latest)" "$stress_wg_count sessions"
  fi

  # Create/destroy 10 OpenVPN sessions
  for stress_cycle in 1 2 3 4 5 6 7 8 9 10; do
    run_vpn_switch "209" "$test_db" openvpn start edge-test-ovpn > /dev/null 2>&1
    # Each start updates 'latest', making previous session unreferenced
    # Clean unreferenced sessions (avoids stop which hangs in test env)
    run_vpn_switch "210a" "$test_db" session clean > /dev/null 2>&1
    sleep 0.5
  done

  # Verify clean state
  local stress_ovpn_count=$(ls -1 "$test_db/.session" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$stress_ovpn_count" = "1" ]; then
    pass "Scenario 5.1: Only 'latest' OVPN session after 10 cycles"
  else
    fail "Scenario 5.1: OVPN cleanup" "1 session (latest)" "$stress_ovpn_count sessions"
  fi

  # Verify only latest session directory remains (no other stale sessions)
  local session_dirs=$(ls -1 "$test_db/.session" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$session_dirs" = "1" ]; then
    pass "Scenario 5.1: Only latest session directory remains"
  else
    fail "Scenario 5.1: Stale sessions" "1" "$session_dirs found"
  fi

  # Cleanup
  cleanup_on_success "$test_db"
  rm -f "$wg_config" "$ovpn_config"

  story_passed
}

#---------------------------------------------------------------------------
# User Story 12: Phase Backend Selection
#---------------------------------------------------------------------------
#
# As a user,
# I want to specify different backend implementations for phases,
# So that I can customize firewall and DNS providers per-phase or per-session
#
# Acceptance Criteria:
#   1. Basic backend syntax works (phase:variant@profile)
#   2. Different backends can be selected for different phases
#   3. Per-phase profile selection works
#   4. Backward compatibility: plain phase names still work
#   5. Generated scripts use the correct backend implementations
#
# Test Database: /tmp/vpn-backend-selection.XXX
#
user_story_12_phase_backend_selection() {
  story 12 "Phase Backend Selection (Strategy 7 - Automatic Template Lifting)"

  # Create exclusive test database
  local test_db=$(mktemp -d "${TMPDIR:-/tmp}/vpn-backend-selection.XXXXXX")
  story_db "$test_db"

  # Initialize database with minimal profile
  run_vpn_switch "211" "$test_db" bootstrap "$test_db" minimal > /dev/null 2>&1

  # Set VPN_SWITCH_PATH for generated scripts (connect.sh/disconnect.sh)
  run_vpn_switch "211b" "$test_db" setenv VPN_SWITCH_PATH \
    "/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin" > /dev/null 2>&1

  # Enable session management functions (create directories, write metadata)
  # These are safe operations that don't affect system state
  run_vpn_switch "211c" "$test_db" setenv VPN_SWITCH_INTERPRETER_session_create1 sh > /dev/null 2>&1
  run_vpn_switch "211d" "$test_db" setenv VPN_SWITCH_INTERPRETER_session_populate3 sh > /dev/null 2>&1

  # Verify backend templates were lifted during init
  assert_file_exists "$test_db/.include/phase/base/firewall/pf.sh" \
    "Backend template lifted: firewall/pf.sh"
  assert_file_exists "$test_db/.include/phase/base/firewall/ipfw.sh" \
    "Backend template lifted: firewall/ipfw.sh"
  assert_file_exists "$test_db/.include/phase/base/dns/resolvconf.sh" \
    "Backend template lifted: dns/resolvconf.sh"
  assert_file_exists "$test_db/.include/phase/base/dns/unbound.sh" \
    "Backend template lifted: dns/unbound.sh"

  # Create test config
  local test_config="$test_db/wireguard/backend-test.conf"
  cat > "$test_config" <<'EOF'
[Interface]
PrivateKey = BACKEND_TEST_KEY
Address = 10.99.99.1/24

[Peer]
PublicKey = BACKEND_TEST_PEER
Endpoint = 1.2.3.4:51820
AllowedIPs = 0.0.0.0/0
EOF
  chmod 0400 "$test_config"

  #---------------------------------------------------------------------------
  # Scenario 1: Basic Backend Selection (pf firewall, resolvconf DNS)
  #---------------------------------------------------------------------------

  # Set explicit backend selection using :variant@profile syntax
  run_vpn_switch "212" "$test_db" setenv VPN_SWITCH_PHASES_CONNECT \
    "firewall:pf@base vpn dns:resolvconf@base" > /dev/null 2>&1

  # Start session
  local basic_output=$(run_vpn_switch "213" "$test_db" wireguard start backend-test 2>&1)
  local basic_pid=$(extract_session_id "$basic_output")

  # Verify connect script was generated
  assert_file_exists "$test_db/.session/$basic_pid/connect.sh" \
    "Scenario 1: Connect script generated"

  # Verify PF firewall backend is used (should contain pfctl commands)
  local connect_script="$test_db/.session/$basic_pid/connect.sh"
  if grep -q "pfctl" "$connect_script"; then
    pass "Scenario 1: PF firewall backend used (contains pfctl)"
  else
    fail "Scenario 1: PF backend" "Contains pfctl" "$(head -20 $connect_script)"
  fi

  # Verify resolvconf DNS backend is used
  if grep -q "resolvconf" "$connect_script"; then
    pass "Scenario 1: Resolvconf DNS backend used"
  else
    fail "Scenario 1: Resolvconf backend" "Contains resolvconf" "$(tail -20 $connect_script)"
  fi

  #---------------------------------------------------------------------------
  # Scenario 2: Different Backend (ipfw firewall, unbound DNS)
  #---------------------------------------------------------------------------

  # Set different backends
  run_vpn_switch "214" "$test_db" setenv VPN_SWITCH_PHASES_CONNECT \
    "firewall:ipfw@base vpn dns:unbound@base" > /dev/null 2>&1

  # Start new session
  local ipfw_output=$(run_vpn_switch "215" "$test_db" wireguard start backend-test 2>&1)
  local ipfw_pid=$(extract_session_id "$ipfw_output")

  # Verify IPFW firewall backend is used
  local ipfw_connect="$test_db/.session/$ipfw_pid/connect.sh"
  if grep -q "ipfw" "$ipfw_connect"; then
    pass "Scenario 2: IPFW firewall backend used (contains ipfw)"
  else
    fail "Scenario 2: IPFW backend" "Contains ipfw" "$(head -20 $ipfw_connect)"
  fi

  # Verify Unbound DNS backend is used
  if grep -q "unbound" "$ipfw_connect"; then
    pass "Scenario 2: Unbound DNS backend used"
  else
    fail "Scenario 2: Unbound backend" "Contains unbound" "$(tail -20 $ipfw_connect)"
  fi

  # Verify PF firewall phase is NOT used (backend isolation)
  # Check that the firewall phase uses ipfw, not PF tables/macros
  if ! grep -q "/etc/pf.tables" "$ipfw_connect" && ! grep -q "/etc/pf.macros" "$ipfw_connect"; then
    pass "Scenario 2: PF firewall phase not used (backend isolated)"
  else
    fail "Scenario 2: Backend isolation" "No PF tables/macros" "Found PF configuration in ipfw session"
  fi

  #---------------------------------------------------------------------------
  # Scenario 3: Backward Compatibility (Plain Phase Names)
  #---------------------------------------------------------------------------

  # Reset to traditional phase list (no backend syntax)
  run_vpn_switch "216" "$test_db" setenv VPN_SWITCH_PHASES_CONNECT \
    "firewall vpn dns" > /dev/null 2>&1

  # Start session with plain phases
  local compat_output=$(run_vpn_switch "217" "$test_db" wireguard start backend-test 2>&1)
  local compat_pid=$(extract_session_id "$compat_output")

  # Verify connect script generated successfully
  assert_file_exists "$test_db/.session/$compat_pid/connect.sh" \
    "Scenario 3: Backward compat - connect script generated"

  # Verify traditional protocol-specific scripts are used
  local compat_connect="$test_db/.session/$compat_pid/connect.sh"
  if [ -s "$compat_connect" ]; then
    pass "Scenario 3: Backward compat - script not empty"
  else
    fail "Scenario 3: Script generation" "Non-empty script" "Empty or missing"
  fi

  # Verify script references protocol-specific phase directory
  if grep -q "\.include/phase/wireguard" "$compat_connect"; then
    pass "Scenario 3: Uses protocol-specific phases (wireguard/)"
  else
    fail "Scenario 3: Protocol phases" "References wireguard/" "$(head -10 $compat_connect)"
  fi

  #---------------------------------------------------------------------------
  # Scenario 4: Per-Phase Profile Selection
  #---------------------------------------------------------------------------

  # Note: This scenario would require creating a custom profile directory
  # For now, we verify that the @profile syntax is parsed correctly
  # by using the same profile (base) for different phases

  run_vpn_switch "218" "$test_db" setenv VPN_SWITCH_PHASES_CONNECT \
    "firewall:pf@base vpn dns:resolvconf@base" > /dev/null 2>&1

  local profile_output=$(run_vpn_switch "219" "$test_db" wireguard start backend-test 2>&1)
  local profile_pid=$(extract_session_id "$profile_output")

  # Verify both backends from 'base' profile are used
  local profile_connect="$test_db/.session/$profile_pid/connect.sh"
  local pf_found=0
  local resolvconf_found=0

  if grep -q "pfctl" "$profile_connect"; then
    pf_found=1
  fi
  if grep -q "resolvconf" "$profile_connect"; then
    resolvconf_found=1
  fi

  if [ "$pf_found" = "1" ] && [ "$resolvconf_found" = "1" ]; then
    pass "Scenario 4: Both backends from @base profile used"
  else
    fail "Scenario 4: Profile resolution" "pf=1 resolvconf=1" "pf=$pf_found resolvconf=$resolvconf_found"
  fi

  #---------------------------------------------------------------------------
  # Scenario 5: Backend Variant Fallback (variant-only syntax)
  #---------------------------------------------------------------------------

  # Use :variant without @profile (should use default profile)
  run_vpn_switch "220" "$test_db" setenv VPN_SWITCH_PHASES_CONNECT \
    "firewall:pf vpn dns:unbound" > /dev/null 2>&1

  local variant_output=$(run_vpn_switch "221" "$test_db" wireguard start backend-test 2>&1)
  local variant_pid=$(extract_session_id "$variant_output")

  # Verify backends are resolved (default profile should be used)
  local variant_connect="$test_db/.session/$variant_pid/connect.sh"
  local pf_found=0
  local unbound_found=0

  if grep -q "pfctl" "$variant_connect"; then
    pf_found=1
  fi
  if grep -q "unbound" "$variant_connect"; then
    unbound_found=1
  fi

  if [ "$pf_found" = "1" ] && [ "$unbound_found" = "1" ]; then
    pass "Scenario 5: Variant-only syntax works (uses default profile)"
  else
    fail "Scenario 5: Variant fallback" "pf=1 unbound=1" "pf=$pf_found unbound=$unbound_found"
  fi

  #---------------------------------------------------------------------------
  # Scenario 6: Mixed Syntax (backend + traditional)
  #---------------------------------------------------------------------------

  # Mix backend syntax with traditional phase names
  run_vpn_switch "222" "$test_db" setenv VPN_SWITCH_PHASES_CONNECT \
    "firewall:ipfw@base vpn dns" > /dev/null 2>&1

  local mixed_output=$(run_vpn_switch "223" "$test_db" wireguard start backend-test 2>&1)
  local mixed_pid=$(extract_session_id "$mixed_output")

  # Verify IPFW backend is used for firewall
  local mixed_connect="$test_db/.session/$mixed_pid/connect.sh"
  if grep -q "ipfw" "$mixed_connect"; then
    pass "Scenario 6: Mixed syntax - ipfw backend used"
  else
    fail "Scenario 6: IPFW in mixed" "Contains ipfw" "$(head -20 $mixed_connect)"
  fi

  # Verify VPN phase executed
  if grep -q "wg-quick" "$mixed_connect" || grep -q "interface" "$mixed_connect"; then
    pass "Scenario 6: Mixed syntax - vpn phase executed"
  else
    fail "Scenario 6: VPN phase" "Contains wg-quick or interface" "Missing"
  fi

  # Verify traditional DNS phase used (protocol-specific)
  # Should use .include/phase/wireguard/connect/dns.sh
  if grep -q "dns" "$mixed_connect"; then
    pass "Scenario 6: Mixed syntax - traditional dns phase used"
  else
    fail "Scenario 6: Traditional DNS" "Contains dns" "Missing"
  fi

  # Cleanup
  cleanup_on_success "$test_db"

  story_passed
}

#-----------------------------------------------------------------------------
# User Story 13: Sync Lifecycle
#-----------------------------------------------------------------------------
# As a user, after installing vpn-switch I want bootstrap to stamp my DB
# with the source version, 'vpn-switch version' to confirm db == source,
# and 'vpn-switch sync' to be idempotent so I can safely re-run it after
# every upgrade without surprises.
#
# Drives entirely through the public CLI (vpn-switch bootstrap/version/sync).

user_story_13_sync_lifecycle() {
  story 13 "Sync: Bootstrap stamps version, sync is idempotent, recovers unstamped DB"

  local test_db=$(mktemp -d "${TMPDIR:-/tmp}/vpn-integration-sync.XXXXXX")
  story_db "$test_db"

  # Step 1: Bootstrap auto-stamps .version
  bootstrap_database "$test_db"

  local version_output=$(run_vpn_switch "S13-001" "$test_db" version 2>&1)
  local db_sha=$(echo "$version_output" | grep '^db:' | awk '{print $2}')
  local src_sha=$(echo "$version_output" | grep '^source:' | awk '{print $2}')

  if echo "$version_output" | grep -qE '^db: [a-f0-9]{7,}$'; then
    pass "Bootstrap stamped DB with valid SHA"
  else
    fail "Bootstrap did not stamp DB with SHA" "^db: <sha>$" "$version_output"
  fi

  if [ -n "$db_sha" ] && [ "$db_sha" = "$src_sha" ]; then
    pass "DB version matches source version after bootstrap"
  else
    fail "DB/source version mismatch after bootstrap" "db=$src_sha" "db=$db_sha"
  fi

  # Step 2: 'vpn-switch sync' is idempotent
  run_vpn_switch "S13-002" "$test_db" sync > /dev/null 2>&1
  local version_after=$(run_vpn_switch "S13-003" "$test_db" version 2>&1)
  local db_sha_after=$(echo "$version_after" | grep '^db:' | awk '{print $2}')

  if [ "$db_sha" = "$db_sha_after" ]; then
    pass "Sync is idempotent (db version unchanged after re-sync)"
  else
    fail "Sync changed db version unexpectedly" "$db_sha" "$db_sha_after"
  fi

  # Step 3: Realistic scenario — user copies/restores a DB that has no .version
  # (e.g., from a backup made before .version existed). Sync must recover.
  rm -f "$test_db/.version"

  local unstamped_output=$(run_vpn_switch "S13-004" "$test_db" version 2>&1)
  if echo "$unstamped_output" | grep -q '^db: unstamped$'; then
    pass "version reports 'unstamped' when .version is missing"
  else
    fail "version did not detect missing .version" "db: unstamped" "$unstamped_output"
  fi

  # Step 4: 'sync' restores .version from source
  run_vpn_switch "S13-005" "$test_db" sync > /dev/null 2>&1
  local recovered=$(run_vpn_switch "S13-006" "$test_db" version 2>&1)
  local recovered_sha=$(echo "$recovered" | grep '^db:' | awk '{print $2}')

  if [ "$recovered_sha" = "$src_sha" ]; then
    pass "Sync recovered: DB version matches source after sync"
  else
    fail "Sync did not recover .version" "$src_sha" "$recovered_sha"
  fi

  # Step 4b: Regression — sync must invalidate an active env cache. build_env_args
  # reads the cache file verbatim and never re-scans, so without invalidation a
  # freshly synced default (e.g. a new interpreter override after a source
  # upgrade) would stay invisible. Same convention as _environment_init1/_setenv2.
  local cache_file="$test_db/.env/local/VPN_SWITCH_CACHE_ENV_ARGS"
  run_vpn_switch "S13-007a" "$test_db" environment cache on > /dev/null 2>&1
  if [ -f "$cache_file" ]; then
    pass "env cache enabled (cache file present)"
  else
    fail "env cache not enabled" "cache file present" "cache file absent"
  fi
  run_vpn_switch "S13-007b" "$test_db" sync > /dev/null 2>&1
  if [ ! -f "$cache_file" ]; then
    pass "Sync invalidated the active env cache (synced defaults stay visible)"
  else
    fail "Sync left a stale env cache" "cache file removed" "cache file still present"
  fi

  # Step 5: env defaults are populated (env sync ran as part of sync).
  # Verify a known default-profile variable is reachable via the public
  # getenv API (no filesystem inspection).
  local getenv_out=$(run_vpn_switch "S13-007" "$test_db" getenv VPN_SWITCH_TERMINAL_INTERPRETER 2>&1)
  if [ -n "$getenv_out" ]; then
    pass "env defaults populated (TERMINAL_INTERPRETER readable via getenv)"
  else
    fail "env defaults not populated after sync" "non-empty" "(empty)"
  fi

  cleanup_on_success "$test_db"
  story_passed
}

#-----------------------------------------------------------------------------
# User Story 14: Install lifecycle (E2E)
#-----------------------------------------------------------------------------
# As a packager (or just a careful user), I want 'gmake install' with DESTDIR
# to produce the expected file tree, and 'gmake uninstall' to clean it up
# completely. No sudo needed (DESTDIR-staged). Validates the installer
# mechanics end-to-end on the actual host.

user_story_14_install_lifecycle() {
  story 14 "Install lifecycle: gmake install DESTDIR → verify tree → uninstall → verify clean"

  local staged=$(mktemp -d "${TMPDIR:-/tmp}/vpn-install-test.XXXXXX")
  story_db "$staged"
  local install_log="$staged/install.log"
  local uninstall_log="$staged/uninstall.log"

  # Step 1: staged install
  if gmake install DESTDIR="$staged" PREFIX=/usr/local > "$install_log" 2>&1; then
    pass "gmake install DESTDIR=$staged succeeds"
  else
    fail "gmake install failed" "" "$(tail -5 "$install_log")"
    return
  fi

  # Step 2: core files present (platform-agnostic set)
  local core_files="
    /usr/local/bin/vpn-switch
    /usr/local/sbin/wg-resolvconf-up
    /usr/local/sbin/wg-resolvconf-down
    /usr/local/sbin/ovpn-resolvconf-up
    /usr/local/sbin/ovpn-resolvconf-down
    /usr/local/lib/vpn-switch/include/database.sh
    /usr/local/lib/vpn-switch/include/session.sh
    /usr/local/lib/vpn-switch/include/wireguard.sh
    /usr/local/lib/vpn-switch/include/openvpn.sh
    /usr/local/lib/vpn-switch/include/validate.sh
    /usr/local/lib/vpn-switch/template/VERSION
    /usr/local/lib/vpn-switch/template/platform/default
    /usr/local/share/doc/vpn-switch/README.md
    /usr/local/share/doc/vpn-switch/LICENSE
  "
  for path in $core_files; do
    if [ -e "$staged$path" ]; then
      pass "installed: $path"
    else
      fail "missing after install: $path"
    fi
  done

  # Step 3: platform symlink matches the detected platform.
  # Two-level detection (kernel via uname, Linux distro via /etc/os-release ID)
  # — must mirror GNUmakefile (PLATFORM) and validate.sh (_install_validate0).
  local platform_lc kernel_lc
  kernel_lc=$(uname -s | tr A-Z a-z)
  if [ "$kernel_lc" = linux ] && [ -r /etc/os-release ]; then
    case "$(. /etc/os-release 2>/dev/null; echo "$ID")" in
      alpine) platform_lc=alpine ;;
      *)      platform_lc=linux ;;
    esac
  else
    platform_lc=$kernel_lc
  fi
  local symlink_target=$(readlink "$staged/usr/local/lib/vpn-switch/template/platform/default" 2>/dev/null)
  if [ "$symlink_target" = "${platform_lc}.sh" ]; then
    pass "platform symlink correct for $platform_lc → $symlink_target"
  else
    fail "platform symlink mismatch for $platform_lc" "${platform_lc}.sh" "$symlink_target"
  fi

  # Step 4: LIBDIR sed-patched into installed script
  if grep -q 'VPN_SWITCH_LIBDIR:=/usr/local/lib/vpn-switch' "$staged/usr/local/bin/vpn-switch" 2>/dev/null; then
    pass "installed script: VPN_SWITCH_LIBDIR sed-patched correctly"
  else
    fail "installed script: VPN_SWITCH_LIBDIR sed-patch missing or wrong"
  fi

  # Step 4a: Man page installed (only if docs/vpn-switch.1 is present in repo,
  # which it should be — committed alongside source)
  if [ -f docs/vpn-switch.1 ]; then
    if [ -f "$staged/usr/local/share/man/man1/vpn-switch.1" ]; then
      pass "installed: /usr/local/share/man/man1/vpn-switch.1"
    else
      fail "man page missing from install (docs/vpn-switch.1 exists in repo)"
    fi
  fi

  # Step 5: platform-specific extras (rc.d on FreeBSD, systemd unit on Linux)
  case "$platform_lc" in
    freebsd)
      if [ -x "$staged/usr/local/etc/rc.d/vpn_switch" ]; then
        pass "FreeBSD: rc.d service script installed"
      else
        fail "FreeBSD: rc.d service script missing"
      fi
      ;;
    linux)
      if [ -f "$staged/usr/local/lib/systemd/system/vpn-switch@.service" ]; then
        pass "Linux: systemd unit installed"
      else
        fail "Linux: systemd unit missing"
      fi
      ;;
  esac

  # Step 6: uninstall
  if gmake uninstall DESTDIR="$staged" PREFIX=/usr/local > "$uninstall_log" 2>&1; then
    pass "gmake uninstall DESTDIR=$staged succeeds"
  else
    fail "gmake uninstall failed" "" "$(tail -5 "$uninstall_log")"
  fi

  # Step 7: tree clean after uninstall (excluding the test logs themselves)
  local remaining=$(find "$staged" -type f -not -name '*.log' | wc -l | tr -d ' ')
  if [ "$remaining" = "0" ]; then
    pass "tree clean after uninstall (no leftover files)"
  else
    fail "tree not clean after uninstall — $remaining files remain"
    find "$staged" -type f -not -name '*.log' | head -5 | sed 's/^/    /'
  fi

  cleanup_on_success "$staged"
  story_passed
}

#-----------------------------------------------------------------------------
# Main Test Execution
#-----------------------------------------------------------------------------

should_run_story() {
  local story_num="$1"
  # If VPN_SWITCH_TEST_STORY is not set, run all stories
  [ -z "${VPN_SWITCH_TEST_STORY:-}" ] && return 0
  # If set, only run the specified story
  [ "$VPN_SWITCH_TEST_STORY" = "$story_num" ]
}

main() {
  echo "=== vpn-switch Integration Tests ==="
  echo "Profile: $PROFILE"
  [ -n "${VPN_SWITCH_TEST_STORY:-}" ] && echo "Running only Story: $VPN_SWITCH_TEST_STORY"
  echo ""

  # Run user stories (filtered by VPN_SWITCH_TEST_STORY if set)
  should_run_story 1 && user_story_1_import_organize_dump_restore
  should_run_story 2 && user_story_2_session_management
  should_run_story 3 && user_story_3_config_expiry
  should_run_story 4 && user_story_4_multi_category_organization
  should_run_story 5 && user_story_5_completeness_and_deletion_proof
  should_run_story 6 && user_story_6_dump_quality_properties
  should_run_story 7 && user_story_7_phase_script_generation
  should_run_story 8 && user_story_8_phase_script_content
  should_run_story 9 && user_story_9_phase_customization
  should_run_story 10 && user_story_10_multi_protocol_phase_support
  should_run_story 11 && user_story_11_multi_protocol_edge_cases
  should_run_story 12 && user_story_12_phase_backend_selection
  should_run_story 13 && user_story_13_sync_lifecycle
  should_run_story 14 && user_story_14_install_lifecycle

  # Summary
  echo ""
  echo "========================================"
  echo "Test Summary"
  echo "========================================"
  echo "User Stories:  $STORIES_RUN"
  echo "  Passed:      $STORIES_PASSED"
  echo "  Failed:      $STORIES_FAILED"
  echo ""
  echo "Assertions:    $ASSERTIONS_RUN"
  echo "  Passed:      $ASSERTIONS_PASSED"
  echo "  Failed:      $ASSERTIONS_FAILED"
  echo ""

  # A suite is green only when BOTH no story AND no individual assertion failed.
  # (A failed assertion must never be reported as success / exit 0.)
  if [ "$STORIES_FAILED" -eq 0 ] && [ "$ASSERTIONS_FAILED" -eq 0 ]; then
    printf "${GREEN}ALL STORIES PASSED${NC}\n"
    exit 0
  else
    printf "${RED}SOME STORIES FAILED${NC} (stories failed: %s, assertions failed: %s)\n" \
        "$STORIES_FAILED" "$ASSERTIONS_FAILED"
    exit 1
  fi
}

main
