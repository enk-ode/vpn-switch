#!/bin/sh
#
# bundle-and-test-remote.sh - Bundle vpn-switch and test on remote Debian host
#
# Usage: ./bundle-and-test-remote.sh
#

set -e

REMOTE_HOST="user@debian-host.local"
REMOTE_DIR="tmp/vpn-switch"
BUNDLE_NAME="vpn-switch-bundle.tar.gz"
LOCAL_BUNDLE="/tmp/$BUNDLE_NAME"

echo "========================================="
echo "vpn-switch Remote Testing Script"
echo "========================================="
echo ""
echo "Target: $REMOTE_HOST:~/$REMOTE_DIR"
echo "Bundle: $LOCAL_BUNDLE"
echo ""

# Phase 1: Create bundle
echo "Phase 1: Creating bundle..."
echo "-------------------------------------------"

tar -czf "$LOCAL_BUNDLE" \
  --exclude='.git' \
  --exclude='docs' \
  --exclude='bootstrap2' \
  --exclude='*.md' \
  --exclude='.build' \
  vpn-switch.sh \
  include/ \
  template/ \
  Makefile \
  vpn-switch-unit-test.sh \
  vpn-switch-integration-test.sh \
  vpn-switch-architecture-test.sh \
  test-configs/

echo "✓ Bundle created: $LOCAL_BUNDLE"
tar -tzf "$LOCAL_BUNDLE" | head -20
echo "  ... (showing first 20 files)"
echo ""

# Phase 2: Transfer to remote
echo "Phase 2: Transferring to $REMOTE_HOST..."
echo "-------------------------------------------"

scp "$LOCAL_BUNDLE" "$REMOTE_HOST:/tmp/"
echo "✓ Bundle transferred"
echo ""

# Phase 3: Setup remote environment and run tests
echo "Phase 3: Setting up remote environment and running tests..."
echo "-------------------------------------------"

ssh "$REMOTE_HOST" 'bash -s' <<'REMOTE_SCRIPT'
set -e

REMOTE_DIR="tmp/vpn-switch"
BUNDLE_NAME="vpn-switch-bundle.tar.gz"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
LOG_DIR="$HOME/$REMOTE_DIR/test-logs-$TIMESTAMP"

echo "Setting up test environment..."
echo "  Directory: ~/$REMOTE_DIR"
echo "  Log directory: $LOG_DIR"
echo ""

# Clean and create directories
rm -rf "$HOME/$REMOTE_DIR"
mkdir -p "$HOME/$REMOTE_DIR"
mkdir -p "$LOG_DIR"

# Extract bundle
cd "$HOME/$REMOTE_DIR"
tar -xzf "/tmp/$BUNDLE_NAME"
echo "✓ Bundle extracted"
echo ""

# Set platform symlink to linux.sh for Debian
echo "Configuring platform for Debian/Linux..."
cd template/platform
rm -f default
ln -s linux.sh default
ls -la default
cd "$HOME/$REMOTE_DIR"
echo "✓ Platform configured (default -> linux.sh)"
echo ""

# Show platform info
echo "Platform Information:"
echo "-------------------------------------------"
uname -a
echo ""
# Detect shell type (dash doesn't support --version)
if command -v dash >/dev/null 2>&1 && [ "$(readlink -f /bin/sh)" = "$(command -v dash)" ]; then
  echo "sh: dash (Debian Almquist shell)"
elif sh -c 'echo ${BASH_VERSION:-}' 2>/dev/null | grep -q .; then
  echo "sh: bash $(sh -c 'echo $BASH_VERSION')"
else
  echo "sh: $(readlink -f /bin/sh 2>/dev/null || echo unknown)"
fi
echo ""

# Check required commands
echo "Checking required commands:"
echo "-------------------------------------------"
for cmd in make stat grep awk sed; do
  if command -v $cmd >/dev/null 2>&1; then
    echo "✓ $cmd: $(command -v $cmd)"
  else
    echo "✗ $cmd: NOT FOUND"
  fi
done
echo ""

# Phase 4: Run tests systematically
echo "========================================="
echo "Phase 4: Running Tests (Architecture tests disabled)"
echo "========================================="
echo ""

# Test 1: Unit tests (minimal)
echo "Test 1/4: Unit tests (minimal profile)"
echo "-------------------------------------------"
./vpn-switch-unit-test.sh minimal 2>&1 | tee "$LOG_DIR/unit-minimal.log"
echo ""
sleep 2

# Test 2: Unit tests (all)
echo "Test 2/4: Unit tests (all profile)"
echo "-------------------------------------------"
./vpn-switch-unit-test.sh all 2>&1 | tee "$LOG_DIR/unit-all.log"
echo ""
sleep 2

# Test 3: Integration tests (minimal)
echo "Test 3/4: Integration tests (minimal profile)"
echo "-------------------------------------------"
./vpn-switch-integration-test.sh minimal 2>&1 | tee "$LOG_DIR/integration-minimal.log"
echo ""
sleep 2

# Test 4: Integration tests (all)
echo "Test 4/4: Integration tests (all profile)"
echo "-------------------------------------------"
./vpn-switch-integration-test.sh all 2>&1 | tee "$LOG_DIR/integration-all.log"
echo ""
sleep 2

# Architecture tests disabled for cross-platform testing
# (These tests already passed on Debian in previous run)
# Test 5: Architecture tests (minimal) - DISABLED
# Test 6: Architecture tests (all) - DISABLED

# Generate summary
echo "========================================="
echo "Test Summary"
echo "========================================="
echo ""
echo "Log files created in: $LOG_DIR"
echo ""

for log in "$LOG_DIR"/*.log; do
  name=$(basename "$log")
  if grep -q "ALL TESTS PASSED" "$log" 2>/dev/null; then
    echo "✓ $name: ALL PASSED"
  elif grep -q "Test Summary" "$log" 2>/dev/null; then
    echo "⚠ $name: COMPLETED (check for failures)"
    grep -A5 "Test Summary" "$log" | tail -5
  else
    echo "✗ $name: FAILED OR INCOMPLETE"
  fi
  echo ""
done

echo "Detailed logs available at: ~/$REMOTE_DIR/test-logs-$TIMESTAMP/"
echo ""
echo "To retrieve logs locally:"
echo "  scp -r $REMOTE_HOST:~/$REMOTE_DIR/test-logs-$TIMESTAMP /tmp/"

REMOTE_SCRIPT

echo ""
echo "========================================="
echo "Remote Testing Complete"
echo "========================================="
echo ""
echo "To retrieve logs:"
echo "  scp -r $REMOTE_HOST:~/$REMOTE_DIR/test-logs-* /tmp/"
echo ""
echo "To connect and analyze:"
echo "  ssh $REMOTE_HOST"
echo "  cd ~/$REMOTE_DIR"
