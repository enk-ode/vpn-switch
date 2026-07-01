#!/bin/sh
# Architecture Violation Scanner (Enhanced)
# Automatically detects violations of the combinator pattern
#
# Phase 1 Enhancements:
# - Fixed grep pattern for misnamed combinator detection
# - State modification detection in combinators/batch combinators
# - Configuration-based exclusions
# - Improved reporting with severity levels and fix suggestions

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
VPN_SWITCH_DIR="${1:-$(dirname "$SCRIPT_DIR")}"

# Colors for output
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Temporary file for counting (avoid subshell counter issues)
COUNT_FILE=$(mktemp)
trap "rm -f $COUNT_FILE" EXIT

echo "0 0 0 0 0 0 0 0 0" > "$COUNT_FILE"
# Format: critical high medium low misnamed state_mod errors logs output_purity

increment_count() {
  local index="$1"
  local current=$(awk "{print \$$index}" "$COUNT_FILE")
  local new=$((current + 1))
  awk -v idx="$index" -v val="$new" '{$idx=val; print}' "$COUNT_FILE" > "$COUNT_FILE.tmp"
  mv "$COUNT_FILE.tmp" "$COUNT_FILE"
}

echo "========================================"
echo "Architecture Violation Scanner"
echo "========================================"
echo "Scanning: $VPN_SWITCH_DIR"
echo ""

# Check for exclusion config
EXCLUSION_CONFIG="$SCRIPT_DIR/architecture-violations-exclusions.conf"
if [ ! -f "$EXCLUSION_CONFIG" ]; then
  # Create default exclusion config
  cat > "$EXCLUSION_CONFIG" <<'EOF'
# Architecture Violation Exclusions
# Format: function_pattern:reason=explanation

_bootstrap*:reason=bootstrap special case
_init*:reason=database initialization
_help*:reason=help system
_validate*:reason=validation framework (reads state then delegates)
_batch2:reason=batch executor meta-function
_lift*:reason=init infrastructure (copies phase templates)
_dumpenv*:reason=environment dump special case
EOF
fi

# Helper function to check exclusions
is_excluded() {
  local func="$1"
  grep -qE "^${func}[*:]" "$EXCLUSION_CONFIG" 2>/dev/null
}

# =============================================================================
# VIOLATION TYPE 1: Terminal functions outputting vpn-switch commands
# (Should be combinators __ or batch combinators ___)
# =============================================================================

echo "${BLUE}[1] Scanning for MISNAMED COMBINATORS...${NC}"
echo "    (Terminal functions that output vpn-switch commands)"
echo ""

for file in "$VPN_SWITCH_DIR"/include/*.sh "$VPN_SWITCH_DIR"/vpn-switch.sh; do
  [ ! -f "$file" ] && continue

  # Find terminal functions (_func)
  grep -n "^_[^_][a-z_]*[0-9]() {" "$file" 2>/dev/null | while IFS=: read -r line_num func_line; do
    func_name=$(echo "$func_line" | sed 's/() {.*//')

    # Skip excluded functions
    if is_excluded "$func_name"; then
      continue
    fi

    # Extract function body and check for vpn-switch commands
    func_body=$(awk "NR==$line_num,/^}/" "$file")

    # Pattern: echo "\"$VPN_SWITCH_CONTEXT_SCRIPT\"" (actual command output)
    # This excludes mere variable references like [ -x "$VPN_SWITCH_CONTEXT_SCRIPT" ]
    if echo "$func_body" | grep -q 'echo ".*\$VPN_SWITCH_CONTEXT_SCRIPT'; then
      # Count how many commands it outputs
      cmd_count=$(echo "$func_body" | grep -c 'echo ".*\$VPN_SWITCH_CONTEXT_SCRIPT') || cmd_count=0

      if [ "$cmd_count" -eq 1 ]; then
        echo "  ${RED}✗ CRITICAL${NC}: $(basename "$file"):$line_num"
        echo "    Function: ${YELLOW}$func_name${NC}"
        echo "    Issue: Outputs 1 vpn-switch command (COMBINATOR behavior)"
        echo "    Impact: Breaks inspectability, exit code propagation fails"
        echo "    Fix: Rename to ${GREEN}__${func_name#_}${NC}"
        echo ""
        increment_count 1  # critical
        increment_count 5  # misnamed
      elif [ "$cmd_count" -gt 1 ]; then
        echo "  ${RED}✗ CRITICAL${NC}: $(basename "$file"):$line_num"
        echo "    Function: ${YELLOW}$func_name${NC}"
        echo "    Issue: Outputs $cmd_count vpn-switch commands (BATCH COMBINATOR behavior)"
        echo "    Impact: Breaks inspectability, batch operations can't detect failures"
        echo "    Fix: Rename to ${GREEN}___${func_name#_}${NC}"
        echo ""
        increment_count 1  # critical
        increment_count 5  # misnamed
      fi
    fi
  done
done

misnamed=$(awk '{print $5}' "$COUNT_FILE")
echo "${BLUE}Found $misnamed misnamed function(s)${NC}"
echo ""

# =============================================================================
# VIOLATION TYPE 2: State Modification in Combinators/Batch Combinators
# (Only terminal functions can modify system state)
# =============================================================================

echo "${BLUE}[2] Scanning for STATE MODIFICATION in combinators...${NC}"
echo "    (Combinators/batch combinators must NOT modify system state)"
echo ""

for file in "$VPN_SWITCH_DIR"/include/*.sh "$VPN_SWITCH_DIR"/vpn-switch.sh; do
  [ ! -f "$file" ] && continue

  # Find combinator and batch combinator functions
  grep -n "^__[_a-z]*[0-9]() {" "$file" 2>/dev/null | while IFS=: read -r line_num func_line; do
    func_name=$(echo "$func_line" | sed 's/() {.*//')

    # Skip excluded functions
    if is_excluded "$func_name"; then
      continue
    fi

    # Extract function body
    func_body=$(awk "NR==$line_num,/^}/" "$file")

    # Check for state-modifying operations
    # Two detection methods:
    # 1. MODIFY_* variables (new convention - preferred)
    # 2. Direct command usage (legacy - to be refactored)

    # Method 1: MODIFY_* variable usage (violations once refactoring complete)
    modify_vars=$(echo "$func_body" | grep -n '\$MODIFY_\|${MODIFY_' | \
                  grep -v '^[[:space:]]*#' || true)

    # Method 2: Direct state-modifying commands (legacy detection)
    # Categories:
    #   - Filesystem: mkdir, touch, chmod, chown, ln, rm, mv, cp, install
    #   - Firewall: pfctl, ipfw, iptables, nft
    #   - DNS: resolvconf
    #   - Network: ifconfig (create/destroy), route (add/delete)
    #   - VPN: wg-quick, wg setconf, openvpn --daemon
    #   - Process: kill, pkill
    #   - Service: service, systemctl, rc-service
    direct_cmds=$(echo "$func_body" | \
                  grep -nE '\<(mkdir|touch|chmod|chown|ln|rm|mv|cp|install|pfctl|ipfw|iptables|nft|resolvconf|wg-quick|kill|pkill|service|systemctl|rc-service)\>' | \
                  grep -v '\.tmp' | grep -v '^[[:space:]]*#' | grep -v 'echo "' || true)

    violations="${modify_vars}${direct_cmds}"

    if [ -n "$violations" ]; then
      echo "  ${RED}✗ CRITICAL${NC}: $(basename "$file"):$line_num"
      echo "    Function: ${YELLOW}$func_name${NC}"
      echo "    Issue: Modifies system state (only terminal functions can do this)"
      echo "    Impact: Breaks composability, side effects in dry-run mode"
      echo "    Fix: Remove state modification, delegate to terminal function or init"
      echo ""
      increment_count 1  # critical
      increment_count 6  # state_mod
    fi
  done
done

state_mods=$(awk '{print $6}' "$COUNT_FILE")
echo "${BLUE}Found $state_mods state modification violation(s)${NC}"
echo ""

# =============================================================================
# VIOLATION TYPE 3: Direct error() calls
# =============================================================================

echo "${BLUE}[3] Scanning for DIRECT error() CALLS...${NC}"
echo "    (Functions calling error() instead of outputting error commands)"
echo ""

error_count=0
for file in "$VPN_SWITCH_DIR"/include/*.sh "$VPN_SWITCH_DIR"/vpn-switch.sh; do
  [ ! -f "$file" ] && continue

  # Find all error() calls (exclude display error and comments)
  grep -n '\<error "' "$file" 2>/dev/null | grep -v 'display error' | grep -v '^[0-9]*:[[:space:]]*#' | while IFS=: read -r line_num error_line; do
    # Determine which function this belongs to
    # Pattern: 1-3 underscores, then letters/underscores, then digit, then ()
    func_name=$(awk "NR<=$line_num" "$file" | grep -E "^_{1,3}[a-z_]+[0-9]\(\)" | tail -1 | sed 's/() {.*//')

    if [ -z "$func_name" ]; then
      continue
    fi

    # Check if there's a non-anchor function (main, usage, etc.) between the anchor and error line
    # If so, the error is in the non-anchor function, not the anchor - skip it
    func_line=$(awk "NR<=$line_num" "$file" | grep -nE "^_{1,3}[a-z_]+[0-9]\(\)" | tail -1 | cut -d: -f1)
    non_anchor_between=$(awk "NR>$func_line && NR<=$line_num" "$file" | grep -E "^[a-z_]+\(\) \{" | head -1)
    if [ -n "$non_anchor_between" ]; then
      continue
    fi

    # Skip excluded functions
    if is_excluded "$func_name"; then
      continue
    fi

    # Categorize by function type
    case "$func_name" in
      ___*)
        severity="CRITICAL"
        priority="CRITICAL (batch combinator)"
        increment_count 1  # critical
        ;;
      __*)
        severity="HIGH"
        priority="HIGH (combinator)"
        increment_count 2  # high
        ;;
      _*)
        severity="MEDIUM"
        priority="MEDIUM (terminal)"
        increment_count 3  # medium
        ;;
    esac

    increment_count 7  # errors total

    # Show first 15 to avoid spam
    error_count=$((error_count + 1))
    if [ $error_count -le 15 ]; then
      echo "  ${RED}✗ ${severity}${NC}: $(basename "$file"):$line_num"
      echo "    Function: ${YELLOW}$func_name${NC} ($priority)"
      echo "    Fix: Output error command: echo \"error \\\"message\\\"; exit 1\""
      echo ""
    fi
  done
done

# Read final count
errors=$(awk '{print $7}' "$COUNT_FILE")
if [ "$error_count" -gt 15 ]; then
  echo "  ${YELLOW}... and $((errors - 15)) more error() calls${NC}"
  echo ""
fi

echo "${BLUE}Found $errors direct error() call(s)${NC}"
echo ""

# =============================================================================
# VIOLATION TYPE 4: Direct log() calls
# =============================================================================

echo "${BLUE}[4] Scanning for DIRECT log() CALLS...${NC}"
echo "    (Architectural purity - should output log commands)"
echo ""

for file in "$VPN_SWITCH_DIR"/include/*.sh "$VPN_SWITCH_DIR"/vpn-switch.sh; do
  [ ! -f "$file" ] && continue
  # Count actual log() calls, excluding:
  # - Comments (lines starting with #, or # Usage: patterns)
  # - display_log function definition
  # - display log helper calls
  log_count=$(grep '\<log "' "$file" 2>/dev/null | \
              grep -v '^[[:space:]]*#' | \
              grep -v 'display_log' | \
              grep -v 'display log' | \
              wc -l | tr -d ' ') || log_count=0
  if [ "$log_count" -gt 0 ]; then
    i=1
    while [ $i -le "$log_count" ]; do
      increment_count 4  # low
      increment_count 8  # logs
      i=$((i + 1))
    done
  fi
done

logs=$(awk '{print $8}' "$COUNT_FILE")
echo "${BLUE}Found $logs direct log() call(s)${NC}"
echo ""

# =============================================================================
# VIOLATION TYPE 5: Hardcoded Platform Commands
# (Should use EXAMINE_*/MODIFY_* variables for platform independence)
# =============================================================================

echo "${BLUE}[5] Scanning for HARDCODED PLATFORM COMMANDS...${NC}"
echo "    (Should use EXAMINE_*/MODIFY_* variables for platform independence)"
echo ""

# Commands that should be replaced with platform variables
# Format: command|variable_prefix
PLATFORM_COMMANDS="chmod|MODIFY_FILE_PERMS
mkdir -p|MODIFY_DIR_CREATE
ln -s|MODIFY_LINK_CREATE
ln -sfn|MODIFY_LINK_FORCE
rm -rf|MODIFY_DIR_REMOVE
rm -f|MODIFY_FILE_REMOVE
cp |MODIFY_FILE_COPY
mv |MODIFY_FILE_MOVE
ifconfig|EXAMINE_NETWORK_INTERFACES"

platform_violations=0
for file in "$VPN_SWITCH_DIR"/include/*.sh "$VPN_SWITCH_DIR"/vpn-switch.sh; do
  [ ! -f "$file" ] && continue

  echo "$PLATFORM_COMMANDS" | while IFS='|' read -r cmd var_prefix; do
    [ -z "$cmd" ] && continue

    # Search for hardcoded commands (exclude lines with MODIFY_/EXAMINE_ variables)
    # Also exclude comment lines, help text, and fallback definitions
    matches=$(grep -n "$cmd" "$file" 2>/dev/null | \
              grep -v "MODIFY_\|EXAMINE_\|^[0-9]*:[[:space:]]*#\|#.*$cmd" | \
              grep -v "'$cmd\|\\\\$cmd" | \
              grep -v ':-'"$cmd"'\}' || true)

    if [ -n "$matches" ]; then
      echo "$matches" | while IFS=: read -r line_num line_content; do
        # Skip if it's in a user-facing message (instructional text)
        if echo "$line_content" | grep -q 'error ".*'"$cmd"'\|error '\''.*'"$cmd"'\|"Please.*'"$cmd"'\|"Create link:'; then
          continue
        fi

        # Skip if it's a comment
        if echo "$line_content" | grep -qE '^[[:space:]]*#'; then
          continue
        fi

        echo "  ${YELLOW}✗ LOW${NC}: $(basename "$file"):$line_num"
        echo "    Command: $cmd"
        echo "    Replace with: \$${var_prefix}* variable"
        echo "    Line: $(echo "$line_content" | sed 's/^[[:space:]]*//' | cut -c1-60)..."
        echo ""
        increment_count 4  # low
      done
    fi
  done
done

platform_count=$(awk '{print $4}' "$COUNT_FILE")
# Subtract the initial log count to get just platform violations
platform_violations=$((platform_count - logs))
echo "${BLUE}Found hardcoded platform command(s) (check above for details)${NC}"
echo ""

# =============================================================================
# SUMMARY
# =============================================================================

# Read counts
read critical high medium low misnamed state_mod errors logs output_purity < "$COUNT_FILE"

total=$((critical + high + medium + low))

echo "========================================"
echo "SUMMARY"
echo "========================================"
echo ""
echo "Total violations found: ${RED}$total${NC}"
echo ""
echo "By Severity:"
echo "  ${RED}CRITICAL:${NC} $critical  (blocks inspectability, exit code propagation)"
echo "  ${YELLOW}HIGH:${NC}     $high  (architectural violations, partial breakage)"
echo "  ${YELLOW}MEDIUM:${NC}   $medium  (inspectability issues)"
echo "  ${BLUE}LOW:${NC}      $low  (architectural purity)"
echo ""
platform_cmds=$((low - logs))
echo "By Type:"
echo "  - Misnamed functions (should be combinators):    ${RED}$misnamed${NC}"
echo "  - State modification in combinators:             ${RED}$state_mod${NC}"
echo "  - Direct error() calls:                          ${RED}$errors${NC}"
echo "  - Direct log() calls (architectural purity):     ${BLUE}$logs${NC}"
echo "  - Hardcoded platform commands:                   ${BLUE}$platform_cmds${NC}"
echo ""

if [ "$total" -gt 0 ]; then
  echo "${RED}Architecture violations detected!${NC}"
  echo ""
  echo "Priority actions:"
  if [ "$critical" -gt 0 ]; then
    echo "  1. ${RED}Fix $critical CRITICAL violations first${NC}"
  fi
  if [ "$high" -gt 0 ]; then
    echo "  2. ${YELLOW}Address $high HIGH priority violations${NC}"
  fi
  if [ "$medium" -gt 0 ]; then
    echo "  3. ${YELLOW}Resolve $medium MEDIUM priority violations${NC}"
  fi
  echo ""
  echo "See docs/ARCHITECTURE.md for details."
  echo "Use 'scripts/architecture-violations-exclusions.conf' to configure exclusions."
  exit 1
else
  echo "${GREEN}✓ No violations found${NC}"
  exit 0
fi
