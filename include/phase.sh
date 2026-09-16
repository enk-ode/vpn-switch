#!/bin/sh
#
# phase.sh -- the phase scripts of a connection: the spec, the backend and
# script resolution, the lifting of a simple phase into a verify/prepare/
# execute/inspect script, the copy and sync of the phase templates.
#
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
# @env VPN_SWITCH_TEMPLATE_DIR  source of the phase templates being synced
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
