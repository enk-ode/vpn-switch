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
# @env     VPN_SWITCH_RETENTION_DAYS_LOG  retention window checked against
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
# @env     VPN_SWITCH_RETENTION_DAYS_LOG  files older than this many days are removed
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
  local errors=0
  local warnings=0

  echo "# === Phase System Validation ==="

  if [ ! -d "$VPN_SWITCH_BASE/.include/phase" ]; then
    echo "# [ERROR] Phase directory not found"
    return 1
  fi

  # Default phase-profile symlink is load-bearing: phase specs without an explicit
  # @profile resolve against .include/phase/default (-> base). If it is missing,
  # every ':variant'/'@default' phase silently failed before strict resolution and
  # now aborts connect/disconnect generation.
  if [ ! -L "$VPN_SWITCH_BASE/.include/phase/default" ]; then
    echo "# [ERROR] Missing phase 'default' profile symlink: .include/phase/default"
    echo "#         Restore with 'vpn-switch sync' (or re-bootstrap the database)"
    errors=$((errors + 1))
  elif [ ! -d "$VPN_SWITCH_BASE/.include/phase/default" ]; then
    echo "# [ERROR] Phase 'default' symlink does not resolve to a directory"
    errors=$((errors + 1))
  fi

  local dir proto direction phases phase phase_file
  for dir in "$VPN_SWITCH_BASE"/*; do
    [ -L "$dir" ] && continue
    [ -d "$dir" ] || continue
    proto=$(basename "$dir")
    is_pseudo_protocol "$proto" && continue
    for direction in connect disconnect; do
      if [ "$direction" = "connect" ]; then
        phases="$VPN_SWITCH_PHASES_CONNECT"
      else
        phases="$VPN_SWITCH_PHASES_DISCONNECT"
      fi
      for phase in $phases; do
        phase_file="$VPN_SWITCH_BASE/.include/phase/$proto/$direction/$phase.sh"
        if [ -f "$phase_file" ] && [ ! -x "$phase_file" ]; then
          echo "# [ERROR] Not executable: $proto/$direction/$phase.sh"
          errors=$((errors + 1))
        fi
      done
    done
  done

  echo "# Checking undefined variables..."
  # All VPN_SWITCH_* variables from the effective environment (.env/default
  # and .env/local are loaded by the time terminals run), plus standard shell
  # variables and the connection context variables set in phase prologues.
  local std_vars vars var relative_path
  std_vars=$(printenv | grep '^VPN_SWITCH_' | sed 's/=.*//' | tr '\n' ' ')
  std_vars="$std_vars PATH HOME USER PWD SHELL TERM"
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
      warnings=$((warnings + 1))
    done
  done

  if [ "$errors" -gt 0 ]; then
    echo "# ✗ Found $errors issue(s)"
    return 1
  fi
  if [ "$warnings" -gt 0 ]; then
    echo "# ⚠ Found $warnings warning(s)"
    return 0
  fi
  echo "# ✓ Phase system OK"
  return 0
}

#@help _database_validate0
# @internal sub-check of 'validate' (runnable alone: database validate)
#@end
_database_validate0() {
  local errors=0
  local warnings=0

  echo "# === Database Structure Validation ==="

  if [ ! -d "$VPN_SWITCH_BASE" ]; then
    echo "# [ERROR] Base directory not found: $VPN_SWITCH_BASE"
    return 1
  fi

  # Check required directories from VPN_SWITCH_INIT_DIR_CONFIG.
  # Here-document redirect (not a pipe) so the counters survive the loop.
  local dir mode exec_flag content_policy
  while IFS=: read -r dir mode exec_flag content_policy; do
    [ -z "$dir" ] && continue
    if [ ! -d "$VPN_SWITCH_BASE/$dir" ]; then
      echo "# [ERROR] Missing directory: $dir"
      errors=$((errors + 1))
    fi
  done <<EOF
$VPN_SWITCH_INIT_DIR_CONFIG
EOF

  # Check protocol extension symlinks
  local link
  for link in conf ovpn; do
    if [ ! -L "$VPN_SWITCH_BASE/$link" ]; then
      echo "# [WARNING] Missing symlink: $link"
      warnings=$((warnings + 1))
    fi
  done

  if [ "$errors" -gt 0 ]; then
    echo "# ✗ Found $errors issue(s)"
    return 1
  fi
  if [ "$warnings" -gt 0 ]; then
    echo "# ⚠ Found $warnings warning(s)"
    return 0
  fi
  echo "# ✓ Database structure OK"
  return 0
}

#@help _binaries_validate0
# @internal sub-check of 'validate' (runnable alone: binaries validate)
#@end
_binaries_validate0() {
  local errors=0
  local warnings=0

  echo "# === Binary Availability Validation ==="

  # Essential POSIX utilities
  local binary
  for binary in sh cat grep sed; do
    if ! command -v "$binary" >/dev/null 2>&1; then
      echo "# [ERROR] Missing essential binary: $binary"
      errors=$((errors + 1))
    fi
  done

  # VPN binaries (only checked when configured)
  local var
  for var in VPN_SWITCH_WG VPN_SWITCH_BINARY_wireguard VPN_SWITCH_BINARY_openvpn VPN_SWITCH_PFCTL; do
    eval "binary=\${$var:-}"
    if [ -n "$binary" ] && ! command -v "$binary" >/dev/null 2>&1; then
      echo "# [WARNING] Binary not found: $binary ($var)"
      warnings=$((warnings + 1))
    fi
  done

  # Resolvconf helpers (only checked when configured)
  local helper suffix
  for helper in "${VPN_SWITCH_RESOLVCONF_wireguard:-}" "${VPN_SWITCH_RESOLVCONF_openvpn:-}"; do
    [ -z "$helper" ] && continue
    for suffix in up down; do
      if ! command -v "$helper-$suffix" >/dev/null 2>&1; then
        echo "# [WARNING] Helper not found: $helper-$suffix"
        warnings=$((warnings + 1))
      fi
    done
  done

  if [ "$errors" -gt 0 ]; then
    echo "# ✗ Found $errors issue(s)"
    return 1
  fi
  if [ "$warnings" -gt 0 ]; then
    echo "# ⚠ Found $warnings warning(s)"
    return 0
  fi
  echo "# ✓ Required binaries OK"
  return 0
}

#@help _network_validate0
# @internal sub-check of 'validate' (runnable alone: network validate)
#@end
_network_validate0() {
  local errors=0
  local warnings=0

  echo "# === Network Prerequisites Validation ==="

  local ext_if="${VPN_SWITCH_EXT_IF:-}"
  local wg_if="${VPN_SWITCH_INTERFACE_wireguard:-}"
  local ovpn_if="${VPN_SWITCH_INTERFACE_openvpn:-}"

  # Interface collisions
  if [ -n "$ext_if" ] && [ -n "$wg_if" ] && [ "$ext_if" = "$wg_if" ]; then
    echo "# [ERROR] Interface collision: VPN_SWITCH_EXT_IF == VPN_SWITCH_INTERFACE_wireguard ($ext_if)"
    errors=$((errors + 1))
  fi

  if [ -n "$ext_if" ] && [ -n "$ovpn_if" ] && [ "$ext_if" = "$ovpn_if" ]; then
    echo "# [ERROR] Interface collision: VPN_SWITCH_EXT_IF == VPN_SWITCH_INTERFACE_openvpn ($ext_if)"
    errors=$((errors + 1))
  fi

  if [ -n "$wg_if" ] && [ -n "$ovpn_if" ] && [ "$wg_if" = "$ovpn_if" ]; then
    echo "# [ERROR] Interface collision: VPN_SWITCH_INTERFACE_wireguard == VPN_SWITCH_INTERFACE_openvpn ($wg_if)"
    errors=$((errors + 1))
  fi

  # External interface should exist (if configured)
  if [ -n "$ext_if" ] && ! $EXAMINE_NETWORK_INTERFACES "$ext_if" >/dev/null 2>&1; then
    echo "# [WARNING] External interface not found: $ext_if"
    warnings=$((warnings + 1))
  fi

  # VPN interfaces should not already exist
  if [ -n "$wg_if" ] && $EXAMINE_NETWORK_INTERFACES "$wg_if" >/dev/null 2>&1; then
    echo "# [WARNING] VPN interface already exists: $wg_if (stale session?)"
    warnings=$((warnings + 1))
  fi

  if [ -n "$ovpn_if" ] && $EXAMINE_NETWORK_INTERFACES "$ovpn_if" >/dev/null 2>&1; then
    echo "# [WARNING] VPN interface already exists: $ovpn_if (stale session?)"
    warnings=$((warnings + 1))
  fi

  if [ "$errors" -gt 0 ]; then
    echo "# ✗ Found $errors issue(s)"
    return 1
  fi
  if [ "$warnings" -gt 0 ]; then
    echo "# ⚠ Found $warnings warning(s)"
    return 0
  fi
  echo "# ✓ Network prerequisites OK"
  return 0
}

#@help _permissions_validate0
# @internal sub-check of 'validate' (runnable alone: permissions validate)
#@end
_permissions_validate0() {
  local errors=0
  local warnings=0
  local perms

  echo "# === Permissions Validation ==="

  # Database root permissions (should be 0700)
  if [ -d "$VPN_SWITCH_BASE" ]; then
    perms=$($EXAMINE_FILE_PERMS "$VPN_SWITCH_BASE" 2>/dev/null)
    if [ "$perms" != "700" ] && [ "$perms" != "40700" ]; then
      echo "# [WARNING] Database directory permissions: $perms (should be 0700)"
      warnings=$((warnings + 1))
    fi
  fi

  # Directories from VPN_SWITCH_INIT_DIR_CONFIG.
  # Here-document redirect (not a pipe) so the counters survive the loop.
  local dir expected_mode exec_flag content_policy path expected_short
  while IFS=: read -r dir expected_mode exec_flag content_policy; do
    [ -z "$dir" ] && continue
    path="$VPN_SWITCH_BASE/$dir"
    [ ! -d "$path" ] && continue

    perms=$($EXAMINE_FILE_PERMS "$path" 2>/dev/null)

    # Extract numeric part (e.g., "0700" -> "700"; stat may report "40700")
    expected_short="${expected_mode#0}"

    if [ "$perms" != "$expected_short" ] && [ "$perms" != "40$expected_short" ]; then
      echo "# [WARNING] Directory $dir permissions: $perms (should be $expected_mode)"
      warnings=$((warnings + 1))
    fi

    if [ "$exec_flag" = "exec" ] && [ ! -x "$path" ]; then
      echo "# [WARNING] Directory $dir should be executable but isn't"
      warnings=$((warnings + 1))
    fi
  done <<EOF
$VPN_SWITCH_INIT_DIR_CONFIG
EOF

  # Session config files (0640 since permission standardization,
  # 3b0161d: group-readable for inspection; stricter legacy 0400 also OK)
  local session_dir conf
  for session_dir in "$VPN_SWITCH_BASE"/.session/*/; do
    [ ! -d "$session_dir" ] && continue
    for conf in "$session_dir"*.conf "$session_dir"*.ovpn; do
      [ ! -f "$conf" ] && continue
      perms=$($EXAMINE_FILE_PERMS "$conf" 2>/dev/null)
      case "$perms" in
        640|100640|400|100400) ;;
        *)
          echo "# [WARNING] Session config ${conf#"$VPN_SWITCH_BASE"/} permissions: $perms (should be 0640)"
          warnings=$((warnings + 1))
          ;;
      esac
    done
  done

  # Phase scripts must be executable
  local phase
  for phase in "$VPN_SWITCH_BASE"/.include/phase/*/*/*.sh; do
    [ ! -f "$phase" ] && continue
    if [ ! -x "$phase" ]; then
      echo "# [ERROR] Phase script not executable: $(echo "$phase" | sed "s|$VPN_SWITCH_BASE/.include/phase/||")"
      errors=$((errors + 1))
    fi
  done

  if [ "$errors" -gt 0 ]; then
    echo "# ✗ Found $errors permission issue(s)"
    return 1
  fi
  if [ "$warnings" -gt 0 ]; then
    echo "# ⚠ Found $warnings permission warning(s)"
    return 0
  fi
  echo "# ✓ Permissions OK"
  return 0
}

#@help _environment_validate0
# @internal sub-check of 'validate' (runnable alone: environment validate)
#@end
_environment_validate0() {
  local errors=0
  local warnings=0

  echo "# === Environment Configuration Validation ==="

  # Required base directory
  if [ -z "$VPN_SWITCH_BASE" ]; then
    echo "# [ERROR] VPN_SWITCH_BASE not set"
    errors=$((errors + 1))
  elif [ ! -d "$VPN_SWITCH_BASE" ]; then
    echo "# [ERROR] VPN_SWITCH_BASE directory does not exist: $VPN_SWITCH_BASE"
    errors=$((errors + 1))
  fi

  # Interface names
  if [ -z "$VPN_SWITCH_INTERFACE_wireguard" ]; then
    echo "# [WARNING] VPN_SWITCH_INTERFACE_wireguard not set (using default: wg0)"
    warnings=$((warnings + 1))
  fi

  if [ -z "$VPN_SWITCH_INTERFACE_openvpn" ]; then
    echo "# [WARNING] VPN_SWITCH_INTERFACE_openvpn not set (using default: tun0)"
    warnings=$((warnings + 1))
  fi

  # Context script must be executable
  if [ -n "$VPN_SWITCH_CONTEXT_SCRIPT" ] && [ ! -x "$VPN_SWITCH_CONTEXT_SCRIPT" ]; then
    echo "# [ERROR] Context script not executable: $VPN_SWITCH_CONTEXT_SCRIPT"
    errors=$((errors + 1))
  fi

  # Phase lists
  if [ -z "$VPN_SWITCH_PHASES_CONNECT" ]; then
    echo "# [WARNING] VPN_SWITCH_PHASES_CONNECT not set"
    warnings=$((warnings + 1))
  fi

  if [ -z "$VPN_SWITCH_PHASES_DISCONNECT" ]; then
    echo "# [WARNING] VPN_SWITCH_PHASES_DISCONNECT not set"
    warnings=$((warnings + 1))
  fi

  # .env directories
  if [ -n "$VPN_SWITCH_BASE" ] && [ ! -d "$VPN_SWITCH_BASE/.env/default" ]; then
    echo "# [WARNING] Default environment templates missing (.env/default)"
    warnings=$((warnings + 1))
  fi

  if [ "$errors" -gt 0 ]; then
    echo "# ✗ Found $errors configuration issue(s)"
    return 1
  fi
  if [ "$warnings" -gt 0 ]; then
    echo "# ⚠ Found $warnings configuration warning(s)"
    return 0
  fi
  echo "# ✓ Environment configuration OK"
  return 0
}

#@help _install_validate0
# @internal sub-check of 'validate' (runnable alone: install validate)
#@end
_install_validate0() {
  # Validate the system-wide install layout: $LIBDIR contents, platform
  # symlink correctness vs uname -s, template/VERSION presence, and the
  # resolvconf helpers at the path the phase scripts hardcode.

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

  local errors=0
  local warnings=0

  echo "# === Install Layout Validation ==="
  echo "# LIBDIR:   $libdir"
  echo "# Platform: $platform_detected (kernel $kernel_lc, refined via /etc/os-release)"

  # 1. LIBDIR exists
  if [ ! -d "$libdir" ]; then
    echo "# [ERROR] VPN_SWITCH_LIBDIR not found: $libdir"
    errors=$((errors + 1))
  fi

  # 2. include/ has shell modules
  if [ -d "$libdir/include" ]; then
    local module_count
    module_count=$(ls "$libdir"/include/*.sh 2>/dev/null | wc -l)
    if [ "$module_count" -lt 1 ]; then
      echo "# [ERROR] No shell modules found in $libdir/include"
      errors=$((errors + 1))
    fi
  else
    echo "# [ERROR] Missing directory: $libdir/include"
    errors=$((errors + 1))
  fi

  # 3. template/ exists
  if [ ! -d "$libdir/template" ]; then
    echo "# [ERROR] Missing directory: $libdir/template"
    errors=$((errors + 1))
  fi

  # 4. Platform symlink valid + correct for this OS
  local platform_default="$libdir/template/platform/default"
  if [ ! -e "$platform_default" ]; then
    echo "# [ERROR] Platform symlink missing: $platform_default"
    errors=$((errors + 1))
  elif [ ! -L "$platform_default" ]; then
    echo "# [WARNING] Platform 'default' is not a symlink: $platform_default"
    warnings=$((warnings + 1))
  else
    local target
    target=$(readlink "$platform_default")
    if [ "$target" != "$platform_detected.sh" ]; then
      echo "# [WARNING] Platform symlink → $target but detected platform is $platform_detected (expected $platform_detected.sh)"
      warnings=$((warnings + 1))
    fi
  fi

  # 5. template/VERSION present (needed by 'sync' / 'version')
  if [ ! -f "$libdir/template/VERSION" ]; then
    echo "# [WARNING] template/VERSION missing — install is incomplete or 'gmake metadata' never ran"
    warnings=$((warnings + 1))
  fi

  # 6. Resolvconf helpers at the hardcoded /usr/local/sbin/ path that
  # the wireguard/openvpn DNS phase scripts call. This path is a contract
  # (not the configurable VPN_SWITCH_RESOLVCONF_* variables), so we check
  # the literal path here.
  local helper
  for helper in wg-resolvconf-up wg-resolvconf-down ovpn-resolvconf-up ovpn-resolvconf-down; do
    if [ ! -x "/usr/local/sbin/$helper" ]; then
      echo "# [WARNING] Resolvconf helper missing or not executable: /usr/local/sbin/$helper"
      warnings=$((warnings + 1))
    fi
  done

  if [ "$errors" -gt 0 ]; then
    echo "# ✗ Found $errors install issue(s)"
    return 1
  fi
  if [ "$warnings" -gt 0 ]; then
    echo "# ⚠ Found $warnings install warning(s)"
    return 0
  fi
  echo "# ✓ Install layout OK"
  return 0
}

#@help _version_validate0
# @internal sub-check of 'validate' (runnable alone: version validate)
#@end
_version_validate0() {
  # Compare DB .version against source template/VERSION; warn on drift.

  local libdir="$VPN_SWITCH_LIBDIR"
  local base="$VPN_SWITCH_BASE"
  local source_v="missing"
  local db_v="unstamped"

  [ -f "$libdir/template/VERSION" ] && source_v=$(cat "$libdir/template/VERSION")
  [ -f "$base/.version" ] && db_v=$(cat "$base/.version")

  echo "# === Version Drift Validation ==="
  echo "# DB version:     $db_v"
  echo "# Source version: $source_v"

  if [ "$source_v" = "missing" ]; then
    echo "# [WARNING] Source VERSION missing — install incomplete or fresh checkout without 'gmake metadata'"
  elif [ "$db_v" = "unstamped" ]; then
    echo "# [WARNING] DB never synced — run 'vpn-switch sync' to stamp .version"
  elif [ "$source_v" != "$db_v" ]; then
    echo "# [WARNING] Version drift: db=$db_v source=$source_v — run 'vpn-switch sync' to refresh DB against source"
  else
    echo "# ✓ Version in sync (db == source)"
  fi
  return 0
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

  echo "# === Sudo Setup Validation ==="

  if [ -z "$sudo_vars" ]; then
    echo "# No interpreters use sudo — nothing to verify."
    echo "# ✓ Sudo check N/A"
    return 0
  fi

  # Trim leading space for prettier output
  sudo_vars=$(echo "$sudo_vars" | sed 's/^ //')

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
  return 0
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

