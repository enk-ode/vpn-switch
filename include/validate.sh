# validate.sh - Dynamically loaded validate module
# Source of truth (hand-edited). See docs/HELP_TEMPLATE_SPEC.md for #@help blocks.

#@help
# @topic Individual validate sub-checks
# @group diagnostics
#   Each check of 'validate' is also runnable alone for focused output, e.g.:
#   install validate, version validate, sudo validate, network validate,
#   database validate, binaries validate, permissions validate,
#   environment validate, phases validate.
#@end

#@help _logs_validate0
# @command logs validate
# @summary Check for old log files beyond the retention period
# @group   diagnostics
# @returns validation report
# @example vpn-switch logs validate
# @see     logs clean
#@end
_logs_validate0() {
  local log_dir="$VPN_SWITCH_BASE/.log"
  local retention_days=${VPN_SWITCH_RETENTION_DAYS_LOG:-7}

  echo "# === Log Retention Validation ==="
  echo "#"

  # Check if log directory exists
  if [ ! -d "$log_dir" ]; then
    echo "# No log directory found (logging may be disabled)"
    return 0
  fi

  # Skip if retention disabled
  if [ "$retention_days" -le 0 ]; then
    echo "# Log retention disabled (VPN_SWITCH_RETENTION_DAYS_LOG=$retention_days)"
    return 0
  fi

  echo "# Log retention period: $retention_days days"
  echo "#"

  # Find old log directories (date format: YYYY-MM-DD)
  local has_old_logs=0
  local current_time=$(date +%s)
  local retention_seconds=$((retention_days * 86400))

  for date_dir in "$log_dir"/*; do
    [ ! -d "$date_dir" ] && continue

    local date_name=$(basename "$date_dir")

    # Validate date format (YYYY-MM-DD)
    case "$date_name" in
      [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9])
        # Convert date to timestamp for comparison
        local dir_time=$(date -j -f "%Y-%m-%d" "$date_name" +%s 2>>"$LOG_FILE" || echo "0")

        if [ "$dir_time" != "0" ]; then
          local age_seconds=$((current_time - dir_time))

          if [ "$age_seconds" -gt "$retention_seconds" ]; then
            local age_days=$((age_seconds / 86400))
            echo "# [WARNING] Old logs: $date_name (${age_days} days old, retention: ${retention_days} days)"
            has_old_logs=1
          fi
        fi
        ;;
    esac
  done

  if [ "$has_old_logs" = "1" ]; then
    echo "#"
    echo "# To remove old logs, run: vpn-switch logs clean | sh"
  else
    echo "# No old logs found"
  fi

  return 0
}

#@help _logs_clean0
# @command logs clean
# @summary Generate rm commands for old logs (review, then pipe to sh)
# @group   diagnostics
# @returns shell commands (review, then pipe to sh)
# @example vpn-switch logs clean | sh
# @see     logs validate
#@end
_logs_clean0() {
  local log_dir="$VPN_SWITCH_BASE/.log"
  local retention_days=${VPN_SWITCH_RETENTION_DAYS_LOG:-7}

  echo "# Clean up old log directories"
  echo "#"
  echo "# This script will remove log directories older than $retention_days days."
  echo "# Review the commands below, then run: vpn-switch logs clean | sh"
  echo "#"

  # Check if log directory exists
  if [ ! -d "$log_dir" ]; then
    echo "# No log directory found"
    return 0
  fi

  # Skip if retention disabled
  if [ "$retention_days" -le 0 ]; then
    echo "# Log retention disabled (VPN_SWITCH_RETENTION_DAYS_LOG=$retention_days)"
    echo "# No cleanup needed"
    return 0
  fi

  local has_old_logs=0
  local current_time=$(date +%s)
  local retention_seconds=$((retention_days * 86400))

  for date_dir in "$log_dir"/*; do
    [ ! -d "$date_dir" ] && continue

    local date_name=$(basename "$date_dir")

    # Validate date format (YYYY-MM-DD)
    case "$date_name" in
      [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9])
        # Convert date to timestamp for comparison
        local dir_time=$(date -j -f "%Y-%m-%d" "$date_name" +%s 2>>"$LOG_FILE" || echo "0")

        if [ "$dir_time" != "0" ]; then
          local age_seconds=$((current_time - dir_time))

          if [ "$age_seconds" -gt "$retention_seconds" ]; then
            local age_days=$((age_seconds / 86400))
            echo "# Remove logs from $date_name (${age_days} days old)"
            echo "$MODIFY_DIR_REMOVE '$log_dir/$date_name'"
            has_old_logs=1
          fi
        fi
        ;;
    esac
  done

  if [ "$has_old_logs" = "0" ]; then
    echo "# No old logs to remove"
  fi
}

#@help _phases_validate0
# @internal sub-check of 'validate' (runnable alone: phases validate)
#@end
_phases_validate0() {
  cat <<'EOF'
echo "# === Phase System Validation ==="
issues=0

if [ ! -d "$VPN_SWITCH_BASE/.include/phase" ]; then
  echo "# [ERROR] Phase directory not found"
  exit 1
fi

# Default phase-profile symlink is load-bearing: phase specs without an explicit
# @profile resolve against .include/phase/default (-> base). If it is missing,
# every ':variant'/'@default' phase silently failed before strict resolution and
# now aborts connect/disconnect generation.
if [ ! -L "$VPN_SWITCH_BASE/.include/phase/default" ]; then
  echo "# [ERROR] Missing phase 'default' profile symlink: .include/phase/default"
  echo "#         Restore with 'vpn-switch sync' (or re-bootstrap the database)"
  issues=$((issues + 1))
elif [ ! -d "$VPN_SWITCH_BASE/.include/phase/default" ]; then
  echo "# [ERROR] Phase 'default' symlink does not resolve to a directory"
  issues=$((issues + 1))
fi
EOF

  for dir in "$VPN_SWITCH_BASE"/*; do
    [ -L "$dir" ] && continue
    [ -d "$dir" ] || continue
    proto=$(basename "$dir")
    is_pseudo_protocol "$proto" && continue
    validate_phases_for "$proto" "connect"
    validate_phases_for "$proto" "disconnect"
  done

  cat <<'EOF'
echo "# Checking undefined variables..."
EOF
  check_undefined_variables

  cat <<'EOF'
[ $issues -eq 0 ] && echo "# ✓ Phase system OK" && exit 0
echo "# ✗ Found $issues issue(s)" && exit $issues
EOF
}

#@help _database_validate0
# @internal sub-check of 'validate' (runnable alone: database validate)
#@end
_database_validate0() {
  cat <<'EOF'
echo "# === Database Structure Validation ==="
issues=0

if [ ! -d "$VPN_SWITCH_BASE" ]; then
  echo "# [ERROR] Base directory not found: $VPN_SWITCH_BASE"
  exit 1
fi

# Check required directories (unrolled at generation time from VPN_SWITCH_INIT_DIR_CONFIG)
EOF

  # Unroll loop at generation time - parse VPN_SWITCH_INIT_DIR_CONFIG now
  echo "$VPN_SWITCH_INIT_DIR_CONFIG" | while IFS=: read -r dir mode exec_flag; do
    # Skip empty lines
    [ -z "$dir" ] && continue

    # Generate concrete check for this specific directory
    echo "[ ! -d \"\$VPN_SWITCH_BASE/$dir\" ] && echo \"# [ERROR] Missing directory: $dir\" && issues=\$((issues + 1))"
  done

  cat <<'EOF'

# Check protocol extension symlinks (unrolled at generation time)
[ ! -L "$VPN_SWITCH_BASE/conf" ] && echo "# [WARNING] Missing symlink: conf"
[ ! -L "$VPN_SWITCH_BASE/ovpn" ] && echo "# [WARNING] Missing symlink: ovpn"

[ $issues -eq 0 ] && echo "# ✓ Database structure OK" && exit 0
echo "# ✗ Found $issues issue(s)" && exit $issues
EOF
}

#@help _binaries_validate0
# @internal sub-check of 'validate' (runnable alone: binaries validate)
#@end
_binaries_validate0() {
  cat <<'EOF'
echo "# === Binary Availability Validation ==="
issues=0

# Essential POSIX utilities (unrolled at generation time)
EOF

  # Unroll essential binaries loop at generation time
  for binary in sh cat grep sed; do
    echo "! command -v \"$binary\" >/dev/null 2>&1 && echo \"# [ERROR] Missing essential binary: $binary\" && issues=\$((issues + 1))"
  done

  cat <<'EOF'

# VPN binaries (unrolled at generation time)
EOF

  # Unroll VPN binaries loop at generation time
  for var in VPN_SWITCH_WG VPN_SWITCH_BINARY_wireguard VPN_SWITCH_BINARY_openvpn VPN_SWITCH_PFCTL; do
    cat <<EOF
eval "binary=\\\${${var}:-}"
[ -n "\$binary" ] && ! command -v "\$binary" >/dev/null 2>&1 && echo "# [WARNING] Binary not found: \$binary ($var)"
EOF
  done

  cat <<'EOF'

# Resolvconf helpers (unrolled at generation time)
EOF

  # Unroll resolvconf helpers loop at generation time
  for suffix in up down; do
    cat <<EOF
[ -n "\${VPN_SWITCH_RESOLVCONF_wireguard:-}" ] && \\
  ! command -v "\${VPN_SWITCH_RESOLVCONF_wireguard}-${suffix}" >/dev/null 2>&1 && \\
  echo "# [WARNING] Helper not found: \${VPN_SWITCH_RESOLVCONF_wireguard}-${suffix}"
[ -n "\${VPN_SWITCH_RESOLVCONF_openvpn:-}" ] && \\
  ! command -v "\${VPN_SWITCH_RESOLVCONF_openvpn}-${suffix}" >/dev/null 2>&1 && \\
  echo "# [WARNING] Helper not found: \${VPN_SWITCH_RESOLVCONF_openvpn}-${suffix}"
EOF
  done

  cat <<'EOF'

[ $issues -eq 0 ] && echo "# ✓ Required binaries OK" && exit 0
echo "# ✗ Found $issues issue(s)" && exit $issues
EOF
}

#@help _network_validate0
# @internal sub-check of 'validate' (runnable alone: network validate)
#@end
_network_validate0() {
  local issues=0
  local messages=""

  # Check interface collisions at generation time
  local ext_if="${VPN_SWITCH_EXT_IF:-}"
  local wg_if="${VPN_SWITCH_INTERFACE_wireguard:-}"
  local ovpn_if="${VPN_SWITCH_INTERFACE_openvpn:-}"

  if [ -n "$ext_if" ] && [ -n "$wg_if" ] && [ "$ext_if" = "$wg_if" ]; then
    messages="${messages}echo \"# [ERROR] Interface collision: VPN_SWITCH_EXT_IF == VPN_SWITCH_INTERFACE_wireguard ($ext_if)\"
"
    issues=$((issues + 1))
  fi

  if [ -n "$ext_if" ] && [ -n "$ovpn_if" ] && [ "$ext_if" = "$ovpn_if" ]; then
    messages="${messages}echo \"# [ERROR] Interface collision: VPN_SWITCH_EXT_IF == VPN_SWITCH_INTERFACE_openvpn ($ext_if)\"
"
    issues=$((issues + 1))
  fi

  if [ -n "$wg_if" ] && [ -n "$ovpn_if" ] && [ "$wg_if" = "$ovpn_if" ]; then
    messages="${messages}echo \"# [ERROR] Interface collision: VPN_SWITCH_INTERFACE_wireguard == VPN_SWITCH_INTERFACE_openvpn ($wg_if)\"
"
    issues=$((issues + 1))
  fi

  # Build runtime checks for interface existence
  local runtime_checks=""

  # Check external interface exists (if configured)
  if [ -n "$ext_if" ]; then
    runtime_checks="${runtime_checks}
# Check external interface exists
$EXAMINE_NETWORK_INTERFACES \"$ext_if\" >/dev/null 2>&1 || echo \"# [WARNING] External interface not found: $ext_if\""
  fi

  # Check VPN interfaces don't already exist
  if [ -n "$wg_if" ]; then
    runtime_checks="${runtime_checks}
# Check WireGuard interface doesn't already exist
$EXAMINE_NETWORK_INTERFACES \"$wg_if\" >/dev/null 2>&1 && echo \"# [WARNING] VPN interface already exists: $wg_if (stale session?)\""
  fi

  if [ -n "$ovpn_if" ]; then
    runtime_checks="${runtime_checks}
# Check OpenVPN interface doesn't already exist
$EXAMINE_NETWORK_INTERFACES \"$ovpn_if\" >/dev/null 2>&1 && echo \"# [WARNING] VPN interface already exists: $ovpn_if (stale session?)\""
  fi

  # Determine result
  local result
  if [ $issues -eq 0 ]; then
    result='echo "# ✓ Network prerequisites OK"'
  else
    result="echo \"# ✗ Found $issues issue(s)\"
exit $issues"
  fi

  cat <<EOF
echo "# === Network Prerequisites Validation ==="
${messages}${runtime_checks}
${result}
EOF
}

#@help _permissions_validate0
# @internal sub-check of 'validate' (runnable alone: permissions validate)
#@end
_permissions_validate0() {
  # Expand platform variable at generation time
  local examine_perms="$EXAMINE_FILE_PERMS"
  local base="$VPN_SWITCH_BASE"
  local dir_config="$VPN_SWITCH_INIT_DIR_CONFIG"

  cat <<EOF
echo "# === Permissions Validation ==="
issues=0

# Check database root permissions (should be 0700)
if [ -d "$base" ]; then
  perms=\$($examine_perms "$base" 2>/dev/null)
  [ "\$perms" != "700" ] && [ "\$perms" != "40700" ] && \\
    echo "# [WARNING] Database directory permissions: \$perms (should be 0700)" && issues=\$((issues + 1))
fi

# Check directories from VPN_SWITCH_INIT_DIR_CONFIG
echo "$dir_config" | while IFS=: read -r dir expected_mode exec_flag content_policy; do
  [ -z "\$dir" ] && continue
  path="$base/\$dir"
  [ ! -d "\$path" ] && continue

  # Get actual permissions
  perms=\$($examine_perms "\$path" 2>/dev/null)

  # Extract numeric part (e.g., "0700" -> "700", "40700" -> "700")
  expected_short=\$(echo "\$expected_mode" | sed 's/^0//')

  # Check mode matches (handle both short and long formats)
  if [ "\$perms" != "\$expected_short" ] && [ "\$perms" != "40\$expected_short" ]; then
    echo "# [WARNING] Directory \$dir permissions: \$perms (should be \$expected_mode)"
  fi

  # Check exec flag if directory should be executable
  if [ "\$exec_flag" = "exec" ] && [ ! -x "\$path" ]; then
    echo "# [WARNING] Directory \$dir should be executable but isn't"
  fi
done

# Check session config files (should be 0400)
for session_dir in "$base"/.session/*/; do
  [ ! -d "\$session_dir" ] && continue
  for conf in "\$session_dir"*.conf "\$session_dir"*.ovpn; do
    [ ! -f "\$conf" ] && continue
    perms=\$($examine_perms "\$conf" 2>/dev/null)
    [ "\$perms" != "400" ] && [ "\$perms" != "100400" ] && \\
      echo "# [WARNING] Session config \$(basename "\$conf") permissions: \$perms (should be 0400)" && issues=\$((issues + 1))
  done
done

# Check phase scripts are executable
for phase in "$base"/.include/phase/*/*/*.sh; do
  [ ! -f "\$phase" ] && continue
  [ ! -x "\$phase" ] && \\
    echo "# [ERROR] Phase script not executable: \$(echo "\$phase" | sed "s|$base/.include/phase/||")" && issues=\$((issues + 1))
done

[ \$issues -eq 0 ] && echo "# ✓ Permissions OK" && exit 0
echo "# ✗ Found \$issues permission issue(s)" && exit \$issues
EOF
}

#@help _environment_validate0
# @internal sub-check of 'validate' (runnable alone: environment validate)
#@end
_environment_validate0() {
  local issues=0
  local messages=""

  # Check required base directory
  if [ -z "$VPN_SWITCH_BASE" ]; then
    messages="${messages}echo \"# [ERROR] VPN_SWITCH_BASE not set\"
"
    issues=$((issues + 1))
  elif [ ! -d "$VPN_SWITCH_BASE" ]; then
    messages="${messages}echo \"# [ERROR] VPN_SWITCH_BASE directory does not exist: $VPN_SWITCH_BASE\"
"
    issues=$((issues + 1))
  fi

  # Check interface names are set
  if [ -z "$VPN_SWITCH_INTERFACE_wireguard" ]; then
    messages="${messages}echo \"# [WARNING] VPN_SWITCH_INTERFACE_wireguard not set (using default: wg0)\"
"
    issues=$((issues + 1))
  fi

  if [ -z "$VPN_SWITCH_INTERFACE_openvpn" ]; then
    messages="${messages}echo \"# [WARNING] VPN_SWITCH_INTERFACE_openvpn not set (using default: tun0)\"
"
    issues=$((issues + 1))
  fi

  # Check context script exists and is executable
  if [ -n "$VPN_SWITCH_CONTEXT_SCRIPT" ] && [ ! -x "$VPN_SWITCH_CONTEXT_SCRIPT" ]; then
    messages="${messages}echo \"# [ERROR] Context script not executable: $VPN_SWITCH_CONTEXT_SCRIPT\"
"
    issues=$((issues + 1))
  fi

  # Check phase lists are set
  if [ -z "$VPN_SWITCH_PHASES_CONNECT" ]; then
    messages="${messages}echo \"# [WARNING] VPN_SWITCH_PHASES_CONNECT not set\"
"
    issues=$((issues + 1))
  fi

  if [ -z "$VPN_SWITCH_PHASES_DISCONNECT" ]; then
    messages="${messages}echo \"# [WARNING] VPN_SWITCH_PHASES_DISCONNECT not set\"
"
    issues=$((issues + 1))
  fi

  # Check .env directories exist
  if [ -n "$VPN_SWITCH_BASE" ] && [ ! -d "$VPN_SWITCH_BASE/.env/default" ]; then
    messages="${messages}echo \"# [WARNING] Default environment templates missing (.env/default)\"
"
    issues=$((issues + 1))
  fi

  # Determine result
  local result
  if [ $issues -eq 0 ]; then
    result='echo "# ✓ Environment configuration OK"'
  else
    result="echo \"# ✗ Found $issues configuration issue(s)\"
exit $issues"
  fi

  cat <<EOF
echo "# === Environment Configuration Validation ==="
${messages}${result}
EOF
}

#@help _install_validate0
# @internal sub-check of 'validate' (runnable alone: install validate)
#@end
_install_validate0() {
  # Validate the system-wide install layout: $LIBDIR contents, platform
  # symlink correctness vs uname -s, template/VERSION presence, and the
  # resolvconf helpers at the path the phase scripts hardcode.
  #
  # Pure generation-time inspection — output is just echo statements +
  # an optional exit code.

  local libdir="$VPN_SWITCH_LIBDIR"

  # Detected platform: kernel name (uname), refined via /etc/os-release ID for
  # Linux distros that ship their own plugin. uname alone can't tell Alpine
  # (busybox/OpenRC) from Debian (coreutils/systemd) — both say "Linux". Keep
  # this in sync with GNUmakefile (PLATFORM) and the integration test.
  local platform_detected kernel_lc
  kernel_lc=$(uname -s | tr A-Z a-z)
  if [ "$kernel_lc" = linux ] && [ -r /etc/os-release ]; then
    case "$(. /etc/os-release 2>/dev/null; echo "$ID")" in
      alpine) platform_detected=alpine ;;
      *)      platform_detected=linux ;;
    esac
  else
    platform_detected=$kernel_lc
  fi

  local findings=""
  local issues=0

  # 1. LIBDIR exists
  if [ ! -d "$libdir" ]; then
    findings="${findings}echo \"# [ERROR] VPN_SWITCH_LIBDIR not found: $libdir\"
"
    issues=$((issues + 1))
  fi

  # 2. include/ has shell modules
  if [ -d "$libdir/include" ]; then
    local module_count
    module_count=$(ls "$libdir"/include/*.sh 2>/dev/null | wc -l)
    if [ "$module_count" -lt 1 ]; then
      findings="${findings}echo \"# [ERROR] No shell modules found in $libdir/include\"
"
      issues=$((issues + 1))
    fi
  else
    findings="${findings}echo \"# [ERROR] Missing directory: $libdir/include\"
"
    issues=$((issues + 1))
  fi

  # 3. template/ exists
  if [ ! -d "$libdir/template" ]; then
    findings="${findings}echo \"# [ERROR] Missing directory: $libdir/template\"
"
    issues=$((issues + 1))
  fi

  # 4. Platform symlink valid + correct for this OS
  local platform_default="$libdir/template/platform/default"
  if [ ! -e "$platform_default" ]; then
    findings="${findings}echo \"# [ERROR] Platform symlink missing: $platform_default\"
"
    issues=$((issues + 1))
  elif [ ! -L "$platform_default" ]; then
    findings="${findings}echo \"# [WARNING] Platform 'default' is not a symlink: $platform_default\"
"
  else
    local target
    target=$(readlink "$platform_default")
    if [ "$target" != "$platform_detected.sh" ]; then
      findings="${findings}echo \"# [WARNING] Platform symlink → $target but detected platform is $platform_detected (expected $platform_detected.sh)\"
"
    fi
  fi

  # 5. template/VERSION present (needed by 'sync' / 'version')
  if [ ! -f "$libdir/template/VERSION" ]; then
    findings="${findings}echo \"# [WARNING] template/VERSION missing — install is incomplete or 'gmake metadata' never ran\"
"
  fi

  # 6. Resolvconf helpers at the hardcoded /usr/local/sbin/ path that
  # the wireguard/openvpn DNS phase scripts call. This path is a contract
  # (not the configurable VPN_SWITCH_RESOLVCONF_* variables), so we check
  # the literal path here.
  for helper in wg-resolvconf-up wg-resolvconf-down ovpn-resolvconf-up ovpn-resolvconf-down; do
    if [ ! -x "/usr/local/sbin/$helper" ]; then
      findings="${findings}echo \"# [WARNING] Resolvconf helper missing or not executable: /usr/local/sbin/$helper\"
"
    fi
  done

  local result
  if [ "$issues" -eq 0 ]; then
    result='echo "# ✓ Install layout OK"'
  else
    result="echo \"# ✗ Found $issues install issue(s)\"
exit $issues"
  fi

  cat <<EOF
echo "# === Install Layout Validation ==="
echo "# LIBDIR:   $libdir"
echo "# Platform: $platform_detected (kernel $kernel_lc, refined via /etc/os-release)"
${findings}${result}
EOF
}

#@help _version_validate0
# @internal sub-check of 'validate' (runnable alone: version validate)
#@end
_version_validate0() {
  # Compare DB .version against source template/VERSION; warn on drift.
  # All filesystem inspection happens at generation time; output is the
  # final two-or-three-line report.

  local libdir="$VPN_SWITCH_LIBDIR"
  local base="$VPN_SWITCH_BASE"
  local source_v="missing"
  local db_v="unstamped"

  [ -f "$libdir/template/VERSION" ] && source_v=$(cat "$libdir/template/VERSION")
  [ -f "$base/.version" ] && db_v=$(cat "$base/.version")

  local result
  if [ "$source_v" = "missing" ]; then
    result='echo "# [WARNING] Source VERSION missing — install incomplete or fresh checkout without '\''gmake metadata'\''"'
  elif [ "$db_v" = "unstamped" ]; then
    result='echo "# [WARNING] DB never synced — run '\''vpn-switch sync'\'' to stamp .version"'
  elif [ "$source_v" != "$db_v" ]; then
    result="echo \"# [WARNING] Version drift: db=$db_v source=$source_v — run 'vpn-switch sync' to refresh DB against source\""
  else
    result='echo "# ✓ Version in sync (db == source)"'
  fi

  cat <<EOF
echo "# === Version Drift Validation ==="
echo "# DB version:     $db_v"
echo "# Source version: $source_v"
${result}
EOF
}

#@help _sudo_validate0
# @internal sub-check of 'validate' (runnable alone: sudo validate)
#@end
_sudo_validate0() {
  # If any VPN_SWITCH_INTERPRETER_* uses sudo, verify 'sudo -n true' works
  # (i.e. passwordless sudo is configured). If no interpreter uses sudo,
  # skip — there's nothing to check.

  local sudo_vars=""
  local var val
  for var in $(env | grep '^VPN_SWITCH_INTERPRETER_' | cut -d= -f1); do
    eval "val=\$$var"
    case "$val" in
      *sudo*) sudo_vars="$sudo_vars $var" ;;
    esac
  done

  if [ -z "$sudo_vars" ]; then
    cat <<'EOF'
echo "# === Sudo Setup Validation ==="
echo "# No interpreters use sudo — nothing to verify."
echo "# ✓ Sudo check N/A"
EOF
    return 0
  fi

  # Trim leading space for prettier output
  sudo_vars=$(echo "$sudo_vars" | sed 's/^ //')

  cat <<EOF
echo "# === Sudo Setup Validation ==="
echo "# Interpreters using sudo: $sudo_vars"
if sudo -n true 2>/dev/null; then
  echo "# ✓ 'sudo -n true' succeeds (passwordless sudo OK)"
else
  echo "# [WARNING] 'sudo -n true' failed — sudo requires password or is not configured."
  echo "#"
  echo "# Each VPN start/stop using these interpreters will prompt for your password."
  echo "# To make this seamless, add a sudoers rule for the specific binaries (wg-quick,"
  echo "# openvpn, pfctl, etc.) — see docs/TUTORIAL_SUDO.md."
fi
EOF
}

#@help ___validate0
# @command validate
# @summary Health check: run all sub-checks; non-zero exit on critical issues
# @group   diagnostics
# @returns validation report (exit non-zero if any critical issue)
# @example vpn-switch validate
# @see     inspect
#@end
___validate0() {
  # Discover protocols and delegate to each (Phase 3.4.1)
  for dir in "$VPN_SWITCH_BASE"/*; do
    # Skip symlinks (extension links like conf→wireguard/)
    [ -L "$dir" ] && continue
    [ -d "$dir" ] || continue
    proto=$(basename "$dir")

    # Skip pseudo-protocols
    is_pseudo_protocol "$proto" && continue

    # Delegate to protocol-specific validation
    echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" $proto validate"
  done

  # Special case: session validation (pseudo-protocol with validation)
  # Sessions are runtime state, not protocol configs, but still need validation
  echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" session validate"

  # Log retention validation - warn about old logs
  echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" logs validate"

  # Database structure validation - checks required directories exist (Feature 3)
  echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" database validate"

  # Binary availability validation - checks required binaries are available (Feature 3)
  echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" binaries validate"

  # Phase system validation - prevents offline lockout (Feature 3)
  echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" phases validate"

  # Network prerequisites validation - checks interfaces and network state (Feature 3)
  echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" network validate"

  # Permissions validation - checks file/directory permissions are secure (Feature 3)
  echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" permissions validate"

  # Environment validation - checks environment variables are properly configured (Feature 3)
  echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" environment validate"

  # Install layout - checks system-wide install integrity (Round 1 / Phase 5)
  echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" install validate"

  # Version drift - checks DB .version against source template/VERSION
  echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" version validate"

  # Sudo setup - if any interpreter uses sudo, verify passwordless setup
  echo "\"\$VPN_SWITCH_CONTEXT_SCRIPT\" sudo validate"
}

validate_phases_for() {
  proto="$1"
  direction="$2"
  phases=$([ "$direction" = "connect" ] && echo "$VPN_SWITCH_PHASES_CONNECT" || echo "$VPN_SWITCH_PHASES_DISCONNECT")

  for phase in $phases; do
    cat <<EOF
phase_file="$VPN_SWITCH_BASE/.include/phase/$proto/$direction/$phase.sh"
[ -f "\$phase_file" ] && [ ! -x "\$phase_file" ] && \\
  echo "# [ERROR] Not executable: $proto/$direction/$phase.sh" && issues=\$((issues + 1))
EOF
  done
}

