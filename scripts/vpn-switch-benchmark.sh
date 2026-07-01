#!/bin/sh
#
# vpn-switch Performance Benchmark Script
#
# Usage: ./vpn-switch-benchmark.sh <profile> <iterations>
#   profile: minimal or all
#   iterations: number of test cycles to run
#
# Measures end-to-end performance of typical vpn-switch workflows:
#   - Database bootstrap
#   - Config import (20+ configs per protocol)
#   - Database management (add, link, validate, clean, info)
#   - Safe user commands (start, stop, save, session with cat interpreter)
#   - Dump and restore operations
#
# Output: Timing results for each iteration and summary statistics
#

set -e
set -u

#-----------------------------------------------------------------------------
# Configuration
#-----------------------------------------------------------------------------

SCRIPT="./vpn-switch.sh"
PROFILE="${1:-minimal}"
ITERATIONS="${2:-5}"

# Validate profile
case "$PROFILE" in
  minimal|all) ;;
  *)
    echo "Error: Invalid profile '$PROFILE' (must be 'minimal' or 'all')" >&2
    echo "Usage: $0 <profile> <iterations>" >&2
    exit 1
    ;;
esac

# Validate iterations
if ! expr "$ITERATIONS" : '^[0-9][0-9]*$' >/dev/null 2>&1; then
  echo "Error: Invalid iterations '$ITERATIONS' (must be a positive number)" >&2
  echo "Usage: $0 <profile> <iterations>" >&2
  exit 1
fi

# Test base directory
BENCHMARK_BASE="${TMPDIR:-/tmp}/vpn-switch-benchmark.$$"

# Timing results storage
TIMING_RESULTS=""

#-----------------------------------------------------------------------------
# Helper Functions
#-----------------------------------------------------------------------------

# get_time - Get current time in seconds (with millisecond precision if available)
get_time() {
  # Try date with nanoseconds (Linux/FreeBSD)
  if date +%s.%N >/dev/null 2>&1; then
    date +%s.%N
  else
    # Fallback to seconds only
    date +%s
  fi
}

# time_diff - Calculate time difference in seconds
time_diff() {
  local start="$1"
  local end="$2"
  echo "$end - $start" | bc 2>/dev/null || awk "BEGIN { printf \"%.3f\", $end - $start }"
}

# log_step - Log benchmark step with timing
log_step() {
  local step="$1"
  local duration="$2"
  printf "  %-30s %8.3f s\n" "$step:" "$duration"
}

# run_timed - Run command and return elapsed time
run_timed() {
  local start=$(get_time)
  "$@" >/dev/null 2>&1
  local end=$(get_time)
  time_diff "$start" "$end"
}

# generate_wireguard_config - Create a sample WireGuard config
generate_wireguard_config() {
  local name="$1"
  cat <<EOF
[Interface]
PrivateKey = $(printf '%s' "$name" | sha256sum 2>/dev/null | cut -d' ' -f1 || echo "fake-key-$name")
Address = 10.2.0.2/32
DNS = 10.2.0.1

[Peer]
PublicKey = $(printf '%s' "peer-$name" | sha256sum 2>/dev/null | cut -d' ' -f1 || echo "fake-peer-$name")
AllowedIPs = 0.0.0.0/0
Endpoint = 1.2.3.4:51820
EOF
}

# generate_openvpn_config - Create a sample OpenVPN config
generate_openvpn_config() {
  local name="$1"
  cat <<EOF
client
dev tun
proto udp
remote 1.2.3.4 1194
nobind
persist-key
persist-tun
remote-cert-tls server
verb 3
<ca>
# Fake CA certificate for testing
</ca>
<cert>
# Fake client certificate for testing
</cert>
<key>
# Fake private key for testing - $name
</key>
EOF
}

#-----------------------------------------------------------------------------
# Benchmark Iteration
#-----------------------------------------------------------------------------

run_benchmark_iteration() {
  local iter="$1"
  local db_dir="$BENCHMARK_BASE/iter-$iter"

  echo ""
  echo "==================================================================="
  echo "Iteration $iter/$ITERATIONS (Profile: $PROFILE)"
  echo "==================================================================="

  local iter_start=$(get_time)

  # Step 1: Bootstrap database
  local duration=$(run_timed env VPN_SWITCH_BASE="$db_dir" $SCRIPT bootstrap "$db_dir" "$PROFILE")
  log_step "Bootstrap" "$duration"

  # Step 2: Configure environment (interpreter overrides + cache enablement)
  # Minimal profile uses TERMINAL_INTERPRETER=cat for safety, but dump needs sh
  # CRITICAL: Set TERMINAL_INTERPRETER=sh for dump to work, but override connect/disconnect interpreters to cat for safety
  local setup_start=$(get_time)
  env VPN_SWITCH_BASE="$db_dir" $SCRIPT setenv VPN_SWITCH_TERMINAL_INTERPRETER sh >/dev/null 2>&1
  env VPN_SWITCH_BASE="$db_dir" $SCRIPT setenv VPN_SWITCH_INTERPRETER_wireguard_connect cat >/dev/null 2>&1
  env VPN_SWITCH_BASE="$db_dir" $SCRIPT setenv VPN_SWITCH_INTERPRETER_openvpn_connect cat >/dev/null 2>&1
  env VPN_SWITCH_BASE="$db_dir" $SCRIPT setenv VPN_SWITCH_INTERPRETER_session_connect cat >/dev/null 2>&1
  env VPN_SWITCH_BASE="$db_dir" $SCRIPT setenv VPN_SWITCH_INTERPRETER_wireguard_disconnect cat >/dev/null 2>&1
  env VPN_SWITCH_BASE="$db_dir" $SCRIPT setenv VPN_SWITCH_INTERPRETER_openvpn_disconnect cat >/dev/null 2>&1
  env VPN_SWITCH_BASE="$db_dir" $SCRIPT environment cache on >/dev/null 2>&1
  local setup_end=$(get_time)
  local setup_duration=$(echo "$setup_end - $setup_start" | bc -l)
  log_step "Setup environment + cache" "$(printf '%.3f' $setup_duration)"

  # Create sample config files for import (outside database to avoid confusing dump)
  local import_dir="$BENCHMARK_BASE/iter-$iter-import"
  mkdir -p "$import_dir/wireguard" "$import_dir/openvpn"

  # Generate 25 WireGuard configs
  local i=1
  while [ $i -le 25 ]; do
    generate_wireguard_config "wg-server-$i" > "$import_dir/wireguard/server-$i.conf"
    i=$((i + 1))
  done

  # Generate 25 OpenVPN configs
  i=1
  while [ $i -le 25 ]; do
    generate_openvpn_config "ovpn-server-$i" > "$import_dir/openvpn/server-$i.ovpn"
    i=$((i + 1))
  done

  # Step 3: Import WireGuard configs
  local import_start=$(get_time)
  for conf in "$import_dir/wireguard"/*.conf; do
    env VPN_SWITCH_BASE="$db_dir" $SCRIPT wireguard import "$conf" >/dev/null 2>&1
  done
  local import_end=$(get_time)
  duration=$(time_diff "$import_start" "$import_end")
  log_step "Import WireGuard (25 configs)" "$duration"

  # Step 4: Import OpenVPN configs
  import_start=$(get_time)
  for conf in "$import_dir/openvpn"/*.ovpn; do
    env VPN_SWITCH_BASE="$db_dir" $SCRIPT openvpn import "$conf" >/dev/null 2>&1
  done
  import_end=$(get_time)
  duration=$(time_diff "$import_start" "$import_end")
  log_step "Import OpenVPN (25 configs)" "$duration"

  # Step 5: Database management - add categories/groups
  duration=$(run_timed env VPN_SWITCH_BASE="$db_dir" $SCRIPT wireguard add streaming)
  log_step "Add WireGuard category" "$duration"

  duration=$(run_timed env VPN_SWITCH_BASE="$db_dir" $SCRIPT openvpn add premium)
  log_step "Add OpenVPN group" "$duration"

  # Step 6: Database management - create links
  duration=$(run_timed env VPN_SWITCH_BASE="$db_dir" $SCRIPT wireguard link streaming/fast server-1.conf)
  log_step "WireGuard link" "$duration"

  duration=$(run_timed env VPN_SWITCH_BASE="$db_dir" $SCRIPT openvpn link premium fast-server server-1.ovpn)
  log_step "OpenVPN link" "$duration"

  # Step 7: List operations
  duration=$(run_timed env VPN_SWITCH_BASE="$db_dir" $SCRIPT wireguard list)
  log_step "WireGuard list" "$duration"

  duration=$(run_timed env VPN_SWITCH_BASE="$db_dir" $SCRIPT openvpn list)
  log_step "OpenVPN list" "$duration"

  # Step 8: Validate operations
  duration=$(run_timed env VPN_SWITCH_BASE="$db_dir" $SCRIPT wireguard validate)
  log_step "WireGuard validate" "$duration"

  duration=$(run_timed env VPN_SWITCH_BASE="$db_dir" $SCRIPT openvpn validate)
  log_step "OpenVPN validate" "$duration"

  # Step 9: Info operations
  duration=$(run_timed env VPN_SWITCH_BASE="$db_dir" $SCRIPT wireguard info streaming)
  log_step "WireGuard info" "$duration"

  duration=$(run_timed env VPN_SWITCH_BASE="$db_dir" $SCRIPT openvpn info premium)
  log_step "OpenVPN info" "$duration"

  # Step 10: Safe user commands (interpreters already set to cat in database)
  # Start WireGuard (safe mode)
  duration=$(run_timed env VPN_SWITCH_BASE="$db_dir" $SCRIPT wireguard start server-1.conf)
  log_step "Start WireGuard (safe)" "$duration"

  # Session list
  duration=$(run_timed env VPN_SWITCH_BASE="$db_dir" $SCRIPT session list)
  log_step "Session list" "$duration"

  # Session save
  duration=$(run_timed env VPN_SWITCH_BASE="$db_dir" $SCRIPT session save test-session)
  log_step "Session save" "$duration"

  # Stop (safe mode)
  duration=$(run_timed env VPN_SWITCH_BASE="$db_dir" $SCRIPT stop)
  log_step "Stop (safe)" "$duration"

  # Step 10: Dump operation
  local dump_file="$db_dir/database-dump.sh"
  local start=$(get_time)
  env VPN_SWITCH_BASE="$db_dir" $SCRIPT dump > "$dump_file" 2>&1
  local end=$(get_time)
  duration=$(time_diff "$start" "$end")
  log_step "Dump database" "$duration"

  # Step 11: Restore operation (requires initialized database first)
  local restore_dir="$BENCHMARK_BASE/iter-$iter-restored"

  # Bootstrap restore target (restore requires existing database)
  local bootstrap_time=$(run_timed env VPN_SWITCH_BASE="$restore_dir" $SCRIPT bootstrap "$restore_dir" "$PROFILE")

  # Restore from dump
  local restore_time=$(run_timed env VPN_SWITCH_BASE="$restore_dir" $SCRIPT restore "$dump_file")

  # Total restore time includes bootstrap + restore
  duration=$(awk "BEGIN { printf \"%.3f\", $bootstrap_time + $restore_time }")
  log_step "Restore database" "$duration"

  # Step 12: Verify restored database
  duration=$(run_timed env VPN_SWITCH_BASE="$restore_dir" $SCRIPT validate)
  log_step "Validate restored" "$duration"

  # Calculate iteration total
  local iter_end=$(get_time)
  local iter_total=$(time_diff "$iter_start" "$iter_end")

  echo "  -----------------------------------------------------------"
  printf "  %-30s %8.3f s\n" "ITERATION TOTAL:" "$iter_total"

  # Store result
  TIMING_RESULTS="$TIMING_RESULTS$iter_total "

  # Note: No cleanup during iterations - dump files contain absolute paths
  # to config files in source database, so we must keep them all
  if [ "$iter" -eq "$ITERATIONS" ]; then
    echo ""
    echo "All iterations preserved in: $BENCHMARK_BASE"
    echo "Last iteration database: $db_dir"
    echo "Last restored database: $restore_dir"
  fi

  return 0
}

#-----------------------------------------------------------------------------
# Main Benchmark Loop
#-----------------------------------------------------------------------------

main() {
  echo "==========================================================================="
  echo "VPN-Switch Performance Benchmark"
  echo "==========================================================================="
  echo "Profile:    $PROFILE"
  echo "Iterations: $ITERATIONS"
  echo "Script:     $SCRIPT"
  echo "==========================================================================="

  # Create benchmark base directory
  mkdir -p "$BENCHMARK_BASE"

  # Run iterations
  local i=1
  while [ $i -le "$ITERATIONS" ]; do
    run_benchmark_iteration $i
    i=$((i + 1))
  done

  # Calculate statistics
  echo ""
  echo "==========================================================================="
  echo "Summary Statistics"
  echo "==========================================================================="

  # Parse timing results
  local sum=0
  local count=0
  local min=""
  local max=""

  for time in $TIMING_RESULTS; do
    count=$((count + 1))
    sum=$(echo "$sum + $time" | bc 2>/dev/null || awk "BEGIN { print $sum + $time }")

    if [ -z "$min" ] || [ "$(echo "$time < $min" | bc 2>/dev/null || awk "BEGIN { print ($time < $min) }")" -eq 1 ]; then
      min=$time
    fi

    if [ -z "$max" ] || [ "$(echo "$time > $max" | bc 2>/dev/null || awk "BEGIN { print ($time > $max) }")" -eq 1 ]; then
      max=$time
    fi
  done

  local avg=$(echo "$sum / $count" | bc -l 2>/dev/null || awk "BEGIN { printf \"%.3f\", $sum / $count }")

  printf "Iterations:     %d\n" "$count"
  printf "Total time:     %.3f s\n" "$sum"
  printf "Average:        %.3f s\n" "$avg"
  printf "Min:            %.3f s\n" "$min"
  printf "Max:            %.3f s\n" "$max"
  printf "Profile:        %s\n" "$PROFILE"

  # Per-iteration breakdown
  echo ""
  echo "Per-iteration times:"
  i=1
  for time in $TIMING_RESULTS; do
    printf "  Iteration %2d:  %.3f s\n" "$i" "$time"
    i=$((i + 1))
  done

  echo ""
  echo "==========================================================================="
  echo "Benchmark complete!"
  echo "==========================================================================="
  echo ""
  echo "Note: Benchmark databases preserved in $BENCHMARK_BASE"
  echo "To clean up: rm -rf $BENCHMARK_BASE"
}

# Run benchmark
main "$@"
