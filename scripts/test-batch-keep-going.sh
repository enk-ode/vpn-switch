#!/bin/sh
#
# test-batch-keep-going.sh - Architecture tests for batch combinator KEEP_GOING behavior
#
# Tests that batch combinators properly respect VPN_SWITCH_BATCH_KEEP_GOING flag
#

set -e

# Colors for output
COLOR_RED="\033[0;31m"
COLOR_GREEN="\033[0;32m"
COLOR_YELLOW="\033[0;33m"
COLOR_BLUE="\033[0;34m"
COLOR_RESET="\033[0m"

# Test state
TEST_SCRIPT="./vpn-switch.sh"
TEST_DIR=""
TEST_BASE_DIR=""

# Test counters
TESTS_PASSED=0
TESTS_FAILED=0

# Function lists (loaded from vpn-switch.sh metadata)
ANCHOR_FUNCTIONS=""

#-----------------------------------------------------------------------------
# Test Infrastructure
#-----------------------------------------------------------------------------

# test_setup - Create clean test database
test_setup() {
  TEST_BASE_DIR=$(mktemp -d /tmp/vpn-batch-test-XXXXXX)
  TEST_DIR="$TEST_BASE_DIR/vpn"

  # Initialize database using vpn-switch API
  VPN_SWITCH_BASE="$TEST_DIR" "$TEST_SCRIPT" bootstrap "$TEST_DIR" minimal >/dev/null 2>&1
}

# test_cleanup - Remove test database
test_cleanup() {
  if [ -n "$TEST_BASE_DIR" ] && [ -d "$TEST_BASE_DIR" ]; then
    rm -rf "$TEST_BASE_DIR"
  fi
}

# run_vpn_switch - Execute vpn-switch in test database
run_vpn_switch() {
  VPN_SWITCH_BASE="$TEST_DIR" \
  VPN_SWITCH_DISPLAY_ANSI=0 \
  "$TEST_SCRIPT" "$@" 2>&1
}

# pass - Record test pass
pass() {
  TESTS_PASSED=$((TESTS_PASSED + 1))
  echo "  ${COLOR_GREEN}✓${COLOR_RESET} $1"
}

# fail - Record test failure
fail() {
  TESTS_FAILED=$((TESTS_FAILED + 1))
  echo "  ${COLOR_RED}✗${COLOR_RESET} $1"
}

# test_header - Print test section header
test_header() {
  echo ""
  echo "${COLOR_BLUE}$1${COLOR_RESET}"
}

#-----------------------------------------------------------------------------
# Configuration Tables
#-----------------------------------------------------------------------------

# get_keep_going_mode - Determine what KEEP_GOING mode(s) to test
#
# Arguments: $1 - function name (without ___ prefix, e.g., "inspect0", "stop0")
# Returns: "0" (test KEEP_GOING=0), "1" (test KEEP_GOING=1), "BOTH", or "SKIP"
#
get_keep_going_mode() {
  local func="$1"

  case "$func" in
    # inspect0 - Should continue to show all inspections even if one fails
    inspect0)
      echo "1"
      ;;

    # stop0 - Continues to stop all protocols
    stop0)
      echo "1"
      ;;

    # list0 - Should continue to list all protocols
    list0)
      echo "1"
      ;;

    # validate0 - Should continue to validate all protocols
    validate0)
      echo "1"
      ;;

    # clean0 - Should continue to clean all protocols
    clean0)
      echo "1"
      ;;

    # Default: skip unknown functions
    *)
      echo "SKIP"
      ;;
  esac
}

#-----------------------------------------------------------------------------
# Helper Functions
#-----------------------------------------------------------------------------

# pick_random_lines - Pick N random lines from input
#
# Arguments:
#   $1 - multi-line string (filtered output)
#   $2 - number of lines to pick (optional, default: random between 1 and total)
# Output: Selected lines (one per line)
#
pick_random_lines() {
  local input="$1"
  local count="$2"

  # Count total lines
  local total_lines=$(echo "$input" | wc -l | tr -d ' ')

  if [ "$total_lines" -eq 0 ]; then
    return 1
  fi

  # If count not specified, pick random number between 1 and total_lines
  if [ -z "$count" ]; then
    count=$(awk -v max="$total_lines" 'BEGIN { srand(); print int(rand() * max) + 1 }')
  fi

  # Ensure count is at least 1 and at most total_lines
  if [ "$count" -lt 1 ]; then
    count=1
  fi
  if [ "$count" -gt "$total_lines" ]; then
    count="$total_lines"
  fi

  # Pick random lines using shuf (or fallback to awk if shuf not available)
  if command -v shuf >/dev/null 2>&1; then
    echo "$input" | shuf | head -n "$count"
  else
    # Fallback: use awk to shuffle lines
    echo "$input" | awk -v count="$count" '
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

# create_failing_interpreter - Create type-appropriate failing interpreter
#
# Arguments:
#   $1 - Function name (with underscores, e.g., "___list0", "__stop1", "_log1")
# Output: Interpreter string that consumes input properly and exits with 1
#
# Different function types need different failing interpreters:
# - Terminal (_):    "sh -c 'exit 1'" (just exit)
# - Combinator (__):  "head -n1 | xargs sh -c 'exit 1' --" (consume 1 line, exit)
# - Batch (___):     "cat >/dev/null; exit 1" (consume all lines, exit)
#
create_failing_interpreter() {
  local func_name="$1"

  case "$func_name" in
    ___*)
      # Batch combinator: consume all input, then exit
      echo "cat >/dev/null; exit 1"
      ;;
    __*)
      # Combinator: consume one line via xargs, then exit
      echo "head -n1 | xargs sh -c 'exit 1' --"
      ;;
    _*)
      # Terminal: just exit immediately
      echo "sh -c 'exit 1'"
      ;;
    *)
      # Unknown type - fallback
      echo "sh -c 'exit 1'"
      ;;
  esac
}

# set_function_interpreter - Set interpreter for a specific function
#
# Arguments:
#   $1 - Function name (mangled, e.g., "summary_inspect1")
#   $2 - Interpreter value (e.g., "cat", "sh", or failing interpreter)
#
set_function_interpreter() {
  local func_name="$1"
  local interpreter="$2"

  run_vpn_switch setenv "VPN_SWITCH_INTERPRETER_${func_name}" "$interpreter" > /dev/null 2>&1
}

# unset_function_interpreter - Unset interpreter for a specific function
#
# Arguments:
#   $1 - Function name (mangled, e.g., "summary_inspect1")
#
unset_function_interpreter() {
  local func_name="$1"

  run_vpn_switch unsetenv "VPN_SWITCH_INTERPRETER_${func_name}" > /dev/null 2>&1
}

#-----------------------------------------------------------------------------
# Batch Combinator KEEP_GOING Test
#-----------------------------------------------------------------------------

# test_keep_going_iterations - Run KEEP_GOING test multiple times
#
# Arguments:
#   $1 - function name (without ___ prefix, e.g., "inspect0", "stop0")
#   $2 - number of iterations (default: 1)
#
test_keep_going_iterations() {
  local func="$1"
  local iterations="${2:-1}"

  # Check if function should be skipped
  local mode=$(get_keep_going_mode "$func")
  if [ "$mode" = "SKIP" ]; then
    echo "  ${COLOR_YELLOW}Skipped: ___${func} (not in KEEP_GOING test table)${COLOR_RESET}"
    return 0
  fi

  echo ""
  echo "${COLOR_BLUE}Testing ___${func} with $iterations iteration(s)${COLOR_RESET}"
  echo ""

  local i=1
  while [ $i -le $iterations ]; do
    echo "${COLOR_BLUE}  Iteration $i/$iterations${COLOR_RESET}"
    test_keep_going "$func"
    i=$((i + 1))
  done
}

# test_keep_going - Test KEEP_GOING behavior for a batch combinator (single iteration)
#
# Arguments: $1 - function name (without ___ prefix, e.g., "inspect0", "stop0")
#
test_keep_going() {
  local func="$1"

  # Determine what KEEP_GOING mode to test
  local mode=$(get_keep_going_mode "$func")

  test_header "  ___${func} (mode: $mode)"
  test_setup

  # Enable trace logging
  run_vpn_switch setenv VPN_SWITCH_RETENTION_DAYS_TRACE 1 >/dev/null 2>&1

  # Step 1: Capture batch combinator output with cat interpreter
  # Set arity-specific interpreter to cat
  run_vpn_switch setenv "VPN_SWITCH_INTERPRETER_${func}" "cat" > /dev/null 2>&1

  # Execute and capture output
  local output=$(run_vpn_switch $func 2>&1)

  # Restore interpreter
  run_vpn_switch unsetenv "VPN_SWITCH_INTERPRETER_${func}" > /dev/null 2>&1

  # Validate we got output
  local line_count=$(echo "$output" | wc -l | tr -d ' ')
  if [ "$line_count" -gt 0 ]; then
    pass "Captured $line_count lines from ___${func}"
  else
    fail "No output captured from ___${func}"
    test_cleanup
    return 1
  fi

  # Step 2: Filter output - remove comments and empty lines
  local filtered_output=$(echo "$output" | grep -v '^[[:space:]]*#' | grep -v '^[[:space:]]*$')

  # Validate all lines start with "$VPN_SWITCH_CONTEXT_SCRIPT"
  local filtered_count=$(echo "$filtered_output" | wc -l | tr -d ' ')
  if [ "$filtered_count" -gt 0 ]; then
    pass "Filtered to $filtered_count command lines"
  else
    fail "No command lines after filtering"
    test_cleanup
    return 1
  fi

  # Step 3: Pick random lines (arbitrary number: 1 to all)
  local random_lines=$(pick_random_lines "$filtered_output")
  local selected_count=$(echo "$random_lines" | wc -l | tr -d ' ')

  if [ "$selected_count" -gt 0 ]; then
    pass "Picked $selected_count random line(s) to inject failures"
  else
    fail "Failed to pick random lines"
    test_cleanup
    return 1
  fi

  # Step 4: Build lists of selected and non-selected lines
  # Save selected lines to temp file
  echo "$random_lines" > "$TEST_BASE_DIR/selected_lines.txt"

  # Find non-selected lines (all lines minus selected lines)
  local non_selected_lines=$(echo "$filtered_output" | grep -Fvxf "$TEST_BASE_DIR/selected_lines.txt")
  local non_selected_count=$(echo "$non_selected_lines" | wc -l | tr -d ' ')

  pass "Selected: $selected_count lines for failure, Non-selected: $non_selected_count lines for cat"

  # Step 5: Set failing interpreters for selected lines
  echo "$random_lines" | while IFS= read -r line; do
    local cmd=$(extract_command_from_output "$line")
    [ -z "$cmd" ] && continue

    local func_name=$(resolve_function $cmd)
    [ -z "$func_name" ] && continue

    local failing_interp=$(create_failing_interpreter "$func_name")
    local mangled_name=$(echo "$func_name" | sed 's/^_*//')

    set_function_interpreter "$mangled_name" "$failing_interp"
    echo "$mangled_name" >> "$TEST_BASE_DIR/failing_functions.txt"
  done

  # Step 6: Set cat interpreters for non-selected lines
  echo "$non_selected_lines" | while IFS= read -r line; do
    [ -z "$line" ] && continue
    local cmd=$(extract_command_from_output "$line")
    [ -z "$cmd" ] && continue

    local func_name=$(resolve_function $cmd)
    [ -z "$func_name" ] && continue

    local mangled_name=$(echo "$func_name" | sed 's/^_*//')

    set_function_interpreter "$mangled_name" "cat"
    echo "$mangled_name" >> "$TEST_BASE_DIR/cat_functions.txt"
  done

  # Read back counts (for logging/debugging)
  if [ -f "$TEST_BASE_DIR/failing_functions.txt" ]; then
    local interpreter_fail_count=$(wc -l < "$TEST_BASE_DIR/failing_functions.txt" | tr -d ' ')
  fi
  if [ -f "$TEST_BASE_DIR/cat_functions.txt" ]; then
    local interpreter_cat_count=$(wc -l < "$TEST_BASE_DIR/cat_functions.txt" | tr -d ' ')
  fi

  pass "Interpreter setup complete: ${interpreter_fail_count:-0} failing, ${interpreter_cat_count:-0} cat"

  # Step 7: Execute with default interpreter (KEEP_GOING is hardcoded in batch combinator)
  local output=$(run_vpn_switch $func 2>&1 || true)
  local output_lines=$(echo "$output" | wc -l | tr -d ' ')
  pass "Executed with default interpreter: Captured $output_lines lines of output"

  # Step 8: Architectural analysis
  echo ""
  echo "  ${COLOR_BLUE}Architectural Analysis (mode=$mode):${COLOR_RESET}"

  # Count how many commands from each list were executed
  # Look for "# Executing: ..." lines in output
  local executed_failures=0
  if [ -f "$TEST_BASE_DIR/selected_lines.txt" ]; then
    while IFS= read -r line; do
      # Extract command from line (remove "$VPN_SWITCH_CONTEXT_SCRIPT" prefix)
      local cmd=$(extract_command_from_output "$line")
      # Check if this command was executed (appears in "# Executing:" line)
      if echo "$output" | grep -q "# Executing.*$cmd"; then
        executed_failures=$((executed_failures + 1))
      fi
    done < "$TEST_BASE_DIR/selected_lines.txt"
  fi

  echo "  ${COLOR_YELLOW}Commands with failing interpreters:${COLOR_RESET} $executed_failures/$selected_count executed"

  # Count how many non-selected commands were executed
  local executed_cats=0
  local non_selected_count=$(echo "$non_selected_lines" | grep -v "^$" | wc -l | tr -d ' ')
  echo "$non_selected_lines" | while IFS= read -r line; do
    [ -z "$line" ] && continue
    local cmd=$(extract_command_from_output "$line")
    if echo "$output" | grep -q "# Executing.*$cmd"; then
      echo "EXECUTED" >> "$TEST_BASE_DIR/cat_executed.txt"
    fi
  done

  if [ -f "$TEST_BASE_DIR/cat_executed.txt" ]; then
    executed_cats=$(wc -l < "$TEST_BASE_DIR/cat_executed.txt" | tr -d ' ')
  fi

  echo "  ${COLOR_YELLOW}Commands with cat interpreters:${COLOR_RESET} $executed_cats/$non_selected_count executed"

  # Architectural validation based on mode
  if [ "$mode" = "1" ]; then
    # KEEP_GOING=1: All functions should be attempted
    local total_expected=$((selected_count + non_selected_count))
    local total_executed=$((executed_failures + executed_cats))

    if [ "$total_executed" -ge "$total_expected" ]; then
      pass "KEEP_GOING=1: All commands attempted ($total_executed/$total_expected)"
    else
      fail "KEEP_GOING=1: Not all commands attempted ($total_executed/$total_expected)"
    fi
  elif [ "$mode" = "0" ]; then
    # KEEP_GOING=0: Should stop at first failure
    # Find position of first failing command in filtered_output
    local first_failure_pos=999999
    local line_num=0

    echo "$filtered_output" | while IFS= read -r cmd_line; do
      line_num=$((line_num + 1))
      # Check if this line is in selected_lines (has failing interpreter)
      if grep -Fqx "$cmd_line" "$TEST_BASE_DIR/selected_lines.txt"; then
        echo "$line_num" >> "$TEST_BASE_DIR/failure_positions.txt"
      fi
    done

    # Find minimum position (first failure)
    if [ -f "$TEST_BASE_DIR/failure_positions.txt" ]; then
      first_failure_pos=$(sort -n "$TEST_BASE_DIR/failure_positions.txt" | head -1)
    fi

    echo "  ${COLOR_YELLOW}First failure at position:${COLOR_RESET} $first_failure_pos/$filtered_count"

    # Validate: commands BEFORE first failure should execute, AFTER should not
    local before_count=0
    local after_count=0
    line_num=0

    echo "$filtered_output" | while IFS= read -r cmd_line; do
      line_num=$((line_num + 1))
      local cmd=$(extract_command_from_output "$cmd_line")
      local executed=0

      if echo "$output" | grep -q "# Executing.*$cmd"; then
        executed=1
      fi

      if [ "$line_num" -le "$first_failure_pos" ]; then
        # Before or at first failure - should be executed
        if [ "$executed" -eq 1 ]; then
          echo "BEFORE_OK" >> "$TEST_BASE_DIR/keepgoing0_before.txt"
        fi
      else
        # After first failure - should NOT be executed
        if [ "$executed" -eq 1 ]; then
          echo "AFTER_BAD" >> "$TEST_BASE_DIR/keepgoing0_after.txt"
        fi
      fi
    done

    # Count results
    if [ -f "$TEST_BASE_DIR/keepgoing0_before.txt" ]; then
      before_count=$(wc -l < "$TEST_BASE_DIR/keepgoing0_before.txt" | tr -d ' ')
    fi
    if [ -f "$TEST_BASE_DIR/keepgoing0_after.txt" ]; then
      after_count=$(wc -l < "$TEST_BASE_DIR/keepgoing0_after.txt" | tr -d ' ')
    fi

    echo "  ${COLOR_YELLOW}Commands before first failure:${COLOR_RESET} $before_count/$first_failure_pos executed"
    echo "  ${COLOR_YELLOW}Commands after first failure:${COLOR_RESET} $after_count executed (should be 0)"

    if [ "$after_count" -eq 0 ]; then
      pass "KEEP_GOING=0: Execution stopped at first failure"
    else
      fail "KEEP_GOING=0: $after_count commands executed after first failure"
    fi
  fi

  # Step 10: Cleanup - restore all interpreters
  if [ -f "$TEST_BASE_DIR/failing_functions.txt" ]; then
    while IFS= read -r mangled_name; do
      unset_function_interpreter "$mangled_name"
    done < "$TEST_BASE_DIR/failing_functions.txt"
  fi

  if [ -f "$TEST_BASE_DIR/cat_functions.txt" ]; then
    while IFS= read -r mangled_name; do
      unset_function_interpreter "$mangled_name"
    done < "$TEST_BASE_DIR/cat_functions.txt"
  fi

  pass "Restored all interpreters"

  # Cleanup only if all assertions passed
  if [ "$TESTS_FAILED" -eq 0 ]; then
    test_cleanup
  else
    # Preserve database for inspection on failure
    echo ""
    echo "  ${COLOR_RED}Tests failed - database preserved for inspection${COLOR_RESET}"
    echo "  ${COLOR_BLUE}Database at: $TEST_DIR${COLOR_RESET}"
    echo "  ${COLOR_BLUE}Logs at: $TEST_DIR/.log/$(date +%Y-%m-%d)/${COLOR_RESET}"
  fi
}

#-----------------------------------------------------------------------------
# Main Test Runner
#-----------------------------------------------------------------------------

main() {
  echo "${COLOR_BLUE}========================================${COLOR_RESET}"
  echo "${COLOR_BLUE}Batch Combinator KEEP_GOING Tests${COLOR_RESET}"
  echo "${COLOR_BLUE}========================================${COLOR_RESET}"

  # Check prerequisites
  if [ ! -f "$TEST_SCRIPT" ]; then
    echo "${COLOR_RED}ERROR:${COLOR_RESET} $TEST_SCRIPT not found"
    echo "Run this script from the repository root"
    exit 1
  fi

  # Load metadata from vpn-switch.sh (embedded by make metadata)
  eval "$(grep '^ANCHOR_FUNCTIONS=' "$TEST_SCRIPT")"

  if [ -z "$ANCHOR_FUNCTIONS" ]; then
    echo "${COLOR_RED}ERROR:${COLOR_RESET} Metadata not found in $TEST_SCRIPT (run 'make metadata' first)"
    exit 1
  fi

  # Run tests with configurable iterations
  test_keep_going_iterations "inspect0" 3
  test_keep_going_iterations "stop0" 3

  # Uncomment to test failure preservation:
  # fail "Test failure preservation"

  # Summary
  echo ""
  echo "${COLOR_BLUE}========================================${COLOR_RESET}"
  echo "Tests passed: ${COLOR_GREEN}$TESTS_PASSED${COLOR_RESET}"
  echo "Tests failed: ${COLOR_RED}$TESTS_FAILED${COLOR_RESET}"
  echo "${COLOR_BLUE}========================================${COLOR_RESET}"

  if [ "$TESTS_FAILED" -gt 0 ]; then
    exit 1
  fi

  exit 0
}

# Run main
main
