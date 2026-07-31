#!/bin/sh
# run-all-tests.sh - Run the test suites against this host or any SSH host.
#
# Usage:
#   ./scripts/run-all-tests.sh local                     # this host (FreeBSD)
#   HOST=<ssh-target>  ./scripts/run-all-tests.sh remote # one remote host
#   HOSTS="h1 h2 ..."  ./scripts/run-all-tests.sh all    # local + each host
#
# A host is just DATA: HOST (and each word of HOSTS) is passed verbatim to ssh,
# so it may be an ~/.ssh/config alias or include options (e.g.
# "-p 2222 root@host"). There are deliberately NO per-host branches and NO
# per-host variables — the identical path runs every host, whatever its OS.
# The current working tree is bundled and shipped to the host (no git clone
# there); 'gmake platform' auto-detects the OS on the target (uname + os-release).

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
OUTPUT_DIR="/tmp/vpn-switch-test-results-$TIMESTAMP"

# Where the bundle is extracted on a remote (under $HOME, which is exec-mounted).
REMOTE_DIR="vpn-switch-test-run"

# host_label <ssh-target> -> filename-safe label for the log files.
# Takes the last word (the host token; options precede it), strips any "user@",
# and sanitises. Works for an alias ("vpn-host") or a full target
# ("-p 2222 root@192.0.2.10" -> "192.0.2.10").
host_label() {
  local last="${1##* }"   # last whitespace-separated word = the host
  last="${last##*@}"      # strip user@
  printf '%s' "$last" | tr -c 'A-Za-z0-9._-' '_'
}

# Test suites and profiles
TEST_SUITES="vpn-switch-unit-test.sh vpn-switch-ownership-test.sh vpn-switch-integration-test.sh vpn-switch-architecture-test.sh"
PROFILES="minimal all"

# Colors (disabled if not a terminal)
if [ -t 1 ]; then
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[0;33m'
    BLUE='\033[0;34m'
    BOLD='\033[1m'
    RESET='\033[0m'
else
    RED='' GREEN='' YELLOW='' BLUE='' BOLD='' RESET=''
fi

# Results tracking
TOTAL_TESTS=0
TOTAL_PASSED=0
TOTAL_FAILED=0
SUITE_FAILS=0
RESULTS=""

mkdir -p "$OUTPUT_DIR"
echo "Logs directory: $OUTPUT_DIR"
echo ""

log() {
    printf "${BLUE}==>${RESET} %s\n" "$1"
}

log_result() {
    local platform="$1"
    local suite="$2"
    local profile="$3"
    local status="$4"
    local tests="$5"
    local assertions="$6"
    local passed="$7"
    local failed="$8"

    TOTAL_TESTS=$((TOTAL_TESTS + tests))
    TOTAL_PASSED=$((TOTAL_PASSED + passed))
    TOTAL_FAILED=$((TOTAL_FAILED + failed))

    if [ "$status" = "PASS" ]; then
        RESULTS="${RESULTS}${GREEN}PASS${RESET}|$platform|$suite|$profile|$tests|$assertions|$passed|$failed\n"
    else
        # A suite can exit non-zero with zero *parsed* failed assertions (e.g. it
        # died before any test ran — disk full, missing binary, parse error). Track
        # suite-level failures separately so the overall verdict can't be masked by
        # the per-assertion counters alone.
        SUITE_FAILS=$((SUITE_FAILS + 1))
        RESULTS="${RESULTS}${RED}FAIL${RESET}|$platform|$suite|$profile|$tests|$assertions|$passed|$failed\n"
    fi
}

parse_test_output() {
    local output_file="$1"
    local tests=0
    local assertions=0
    local passed=0
    local failed=0

    # Strip ANSI codes first, then extract numbers (codes contain digits, e.g.
    # \033[1;32m). \x1b in a sed pattern is a GNU extension — BSD/OpenBSD sed
    # read it literally and fail to strip, leaving a coloured number like
    # "388\033[0m" that aborts the later $(()) arithmetic. Build the real ESC
    # byte with printf so the substitution is portable (GNU/BSD/busybox), and
    # also drop any literal "\033m" form just in case.
    strip_ansi() {
        sed "s/$(printf '\033')\[[0-9;]*m//g; s/\\\\033\[[0-9;]*m//g"
    }

    # Extract summary from test output
    # Support both unit test format (Test Functions:) and integration test format (User Stories:)
    if grep -q "Test Functions:" "$output_file" 2>/dev/null; then
        # Unit test / Architecture test format
        tests=$(grep "Test Functions:" "$output_file" | tail -1 | strip_ansi | awk -F':' '{print $2}' | awk '{print $1}')
        assertions=$(grep "Total Assertions:" "$output_file" | tail -1 | strip_ansi | awk -F':' '{print $2}' | awk '{print $1}')
        passed=$(grep "Passed Assertions:" "$output_file" | tail -1 | strip_ansi | awk -F':' '{print $2}' | awk '{print $1}')
        failed=$(grep "Failed Assertions:" "$output_file" | tail -1 | strip_ansi | awk -F':' '{print $2}' | awk '{print $1}')
    elif grep -q "User Stories:" "$output_file" 2>/dev/null; then
        # Integration test format
        tests=$(grep "User Stories:" "$output_file" | tail -1 | strip_ansi | awk -F':' '{print $2}' | awk '{print $1}')
        assertions=$(grep "^Assertions:" "$output_file" | tail -1 | strip_ansi | awk -F':' '{print $2}' | awk '{print $1}')
        passed=$(grep "^  Passed:" "$output_file" | tail -1 | strip_ansi | awk -F':' '{print $2}' | awk '{print $1}')
        failed=$(grep "^  Failed:" "$output_file" | tail -1 | strip_ansi | awk -F':' '{print $2}' | awk '{print $1}')
    fi

    # Ensure we have valid numbers (default to 0 if extraction failed)
    [ -z "$tests" ] && tests=0
    [ -z "$assertions" ] && assertions=0
    [ -z "$passed" ] && passed=0
    [ -z "$failed" ] && failed=0

    echo "$tests $assertions $passed $failed"
}

run_local_tests() {
    local platform="FreeBSD"
    log "Running tests on $platform (local)"

    cd "$PROJECT_DIR"

    # Ensure the platform symlink + generated metadata are correct for this
    # host (template/VERSION is gitignored; metadata/platform are idempotent).
    log "  Regenerating metadata + platform symlink (gmake metadata platform)..."
    if ! gmake metadata platform > "$OUTPUT_DIR/local-metadata.log" 2>&1; then
        echo "${RED}ERROR:${RESET} gmake metadata/platform failed (local)"
        echo "Check $OUTPUT_DIR/local-metadata.log for details"
        return 1
    fi

    for suite in $TEST_SUITES; do
        for profile in $PROFILES; do
            local output_file="$OUTPUT_DIR/${platform}-${suite%.sh}-${profile}.log"
            log "  $suite ($profile profile)"

            if ./"$suite" "$profile" > "$output_file" 2>&1; then
                local status="PASS"
            else
                local status="FAIL"
            fi

            local results=$(parse_test_output "$output_file")
            local tests=$(echo "$results" | awk '{print $1}')
            local assertions=$(echo "$results" | awk '{print $2}')
            local passed=$(echo "$results" | awk '{print $3}')
            local failed=$(echo "$results" | awk '{print $4}')

            log_result "$platform" "$suite" "$profile" "$status" "$tests" "$assertions" "$passed" "$failed"
        done
    done
}

# run_remote_tests <platform-label> <ssh-target>
#
# Ships the current working tree to the target, regenerates metadata, sets the
# platform symlink via auto-detection, and runs every suite/profile there.
run_remote_tests() {
    local platform="$1"
    local target="$2"

    if [ -z "$target" ]; then
        log "Skipping $platform (no SSH target configured)"
        return 0
    fi

    log "Running tests on $platform ($target)"

    # Bundle the exact working tree under test (no git clone needed remotely).
    log "  Bundling + syncing code..."
    local bundle="$OUTPUT_DIR/bundle-${platform}.tar.gz"
    # Bundle the FULL working tree, including .git (so 'version' reports a real
    # SHA instead of "unknown") and docs/README/LICENSE (so the install-layout
    # test finds them). Only logs are excluded. These files reach the test hosts
    # only — never enk-ode, which is published separately as a curated snapshot.
    tar czf "$bundle" --exclude='*.log' -C "$PROJECT_DIR" .

    # Pick the roomiest writable base dir on the remote: some OSes split the disk
    # into small partitions (e.g. OpenBSD's 1G /) that the test databases would
    # overflow. Fall back to a $HOME-relative dir if detection yields nothing.
    # shellcheck disable=SC2086
    # Retry: a single ssh to a small VM can fail transiently (MaxStartups,
    # momentary load). Without '|| true' a failed substitution would abort the
    # whole run under 'set -e' — silently, since stdout-to-file is block-buffered.
    local rbase="" _try
    for _try in 1 2 3; do
      rbase=$(printf '%s\n' 'for d in "$HOME" /home /usr/local /var/tmp; do [ -d "$d" ] && [ -w "$d" ] && printf "%s %s\n" "$(df -k "$d" 2>/dev/null | awk "END{print \$4+0}")" "$d"; done | sort -rn | head -1 | cut -d" " -f2' | ssh $target 'sh -s' 2>/dev/null || true)
      [ -n "$rbase" ] && break
      sleep 2
    done
    local rdir
    if [ -n "$rbase" ]; then rdir="$rbase/$REMOTE_DIR"; else rdir="$REMOTE_DIR"; fi
    log "  Remote work dir: $rdir"

    # Normalise ownership to the remote *login* user (root -> 0:0, user -> user).
    # The bundle carries the bundling host's uid, which on the remote is a
    # stranger -> git refuses the repo ("dubious ownership") and 'version'
    # degrades to "unknown". Deriving the target from `id` (evaluated remotely)
    # works for a non-root login too: chowning files to the user that already
    # owns them (tar extracted as that user) is permitted and a no-op, whereas a
    # hardcoded `0:0` would fail with EPERM for anyone but root.
    # shellcheck disable=SC2086
    # Retry the sync too: same transient-ssh risk, plus a previous run that was
    # killed mid-test can leave artifacts that a first 'rm -rf' races against.
    local _synced=0
    for _try in 1 2 3; do
        if cat "$bundle" | ssh $target "rm -rf '$rdir' && mkdir -p '$rdir' && tar xzf - -C '$rdir' && chown -R \$(id -u):\$(id -g) '$rdir'" \
                > "$OUTPUT_DIR/${platform}-sync.log" 2>&1; then
            _synced=1; break
        fi
        sleep 2
    done
    if [ "$_synced" -ne 1 ]; then
        echo "${RED}ERROR:${RESET} Failed to sync code to $platform (after retries)"
        echo "Check $OUTPUT_DIR/${platform}-sync.log for details"
        SUITE_FAILS=$((SUITE_FAILS + 1))
        return 1
    fi

    # Prefer gmake; fall back to make. metadata + platform are idempotent.
    local make_cmd="gmake"
    # shellcheck disable=SC2086
    ssh $target "command -v gmake >/dev/null 2>&1" 2>/dev/null || make_cmd="make"
    # shellcheck disable=SC2086
    if ! ssh $target "cd '$rdir' && mkdir -p tmp && $make_cmd metadata && $make_cmd platform" \
            >> "$OUTPUT_DIR/${platform}-sync.log" 2>&1; then
        echo "${RED}ERROR:${RESET} '$make_cmd metadata/platform' failed on $platform"
        echo "Check $OUTPUT_DIR/${platform}-sync.log for details"
        return 1
    fi

    for suite in $TEST_SUITES; do
        for profile in $PROFILES; do
            local output_file="$OUTPUT_DIR/${platform}-${suite%.sh}-${profile}.log"
            log "  $suite ($profile profile)"

            # TMPDIR on disk: some hosts (e.g. Alpine) mount /tmp as a small
            # tmpfs, and the architecture suite builds many test databases —
            # keep them on disk to avoid exhausting RAM-backed /tmp.
            # shellcheck disable=SC2086
            if ssh $target "cd '$rdir' && TMPDIR=\$PWD/tmp ./$suite $profile" > "$output_file" 2>&1; then
                local status="PASS"
            else
                local status="FAIL"
            fi

            local results=$(parse_test_output "$output_file")
            local tests=$(echo "$results" | awk '{print $1}')
            local assertions=$(echo "$results" | awk '{print $2}')
            local passed=$(echo "$results" | awk '{print $3}')
            local failed=$(echo "$results" | awk '{print $4}')

            log_result "$platform" "$suite" "$profile" "$status" "$tests" "$assertions" "$passed" "$failed"
        done
    done
}

print_summary() {
    echo ""
    echo "================================================================================"
    printf "${BOLD}Test Results Summary${RESET} - %s\n" "$(date)"
    echo "================================================================================"
    echo ""
    printf "%-6s | %-8s | %-35s | %-7s | %5s | %6s | %6s | %6s\n" \
        "Status" "Platform" "Test Suite" "Profile" "Tests" "Assert" "Passed" "Failed"
    echo "-------|----------|-------------------------------------|---------|-------|--------|--------|-------"

    printf "$RESULTS" | while IFS='|' read -r status platform suite profile tests assertions passed failed; do
        [ -z "$status" ] && continue
        # %s (not %b): after `printf "$RESULTS"` above, $status already carries
        # real ESC bytes — %b (a GNU/POSIX-optional directive; OpenBSD ksh's
        # builtin rejects it as "invalid directive") is unnecessary and blows
        # up the whole summary print, exiting non-zero even on all-green runs.
        printf "%-6s | %-8s | %-35s | %-7s | %5s | %6s | %6s | %6s\n" \
            "$status" "$platform" "$suite" "$profile" "$tests" "$assertions" "$passed" "$failed"
    done

    echo "================================================================================"
    echo ""

    if [ "$TOTAL_FAILED" -eq 0 ] && [ "$SUITE_FAILS" -eq 0 ]; then
        printf "${GREEN}${BOLD}ALL TESTS PASSED${RESET}\n"
    else
        printf "${RED}${BOLD}SOME TESTS FAILED${RESET}\n"
        if [ "$SUITE_FAILS" -gt 0 ]; then
            printf "${RED}  %d suite(s) exited non-zero${RESET} (see FAIL rows above; a suite can fail with 0 parsed assertions)\n" "$SUITE_FAILS"
        fi
    fi

    echo ""
    printf "Total: %d tests, %d assertions (%d passed, %d failed), %d suite(s) failed\n" \
        "$TOTAL_TESTS" "$((TOTAL_PASSED + TOTAL_FAILED))" "$TOTAL_PASSED" "$TOTAL_FAILED" "$SUITE_FAILS"
    echo ""
    echo "Detailed logs saved to: $OUTPUT_DIR"
    echo ""

    # Return appropriate exit code: fail if any assertion failed OR any suite
    # exited non-zero (the latter catches suites that never produced assertions).
    [ "$TOTAL_FAILED" -eq 0 ] && [ "$SUITE_FAILS" -eq 0 ]
}

# Main
case "${1:-}" in
    local)
        run_local_tests
        ;;
    remote)
        [ -n "$HOST" ] || { echo "Usage: HOST=<ssh-target> $0 remote" >&2; exit 1; }
        run_remote_tests "$(host_label "$HOST")" "$HOST"
        ;;
    all)
        run_local_tests
        for _h in $HOSTS; do
            run_remote_tests "$(host_label "$_h")" "$_h"
        done
        ;;
    *)
        echo "Usage: $0 local" >&2
        echo "       HOST=<ssh-target>  $0 remote" >&2
        echo "       HOSTS=\"h1 h2 ...\" $0 all" >&2
        exit 1
        ;;
esac

print_summary
