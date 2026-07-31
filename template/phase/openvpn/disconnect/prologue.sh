#!/bin/sh
# OpenVPN disconnection prologue generator
# Outputs the header and context for disconnect.sh (or variable definitions for inspect)
#
# Usage:
#   prologue.sh           - Generate full disconnect.sh header (default)
#   prologue.sh inspect   - Generate only variable definitions for inspect mode

# Unpack context from environment (disconnect.sh is generated during connect phase)
eval "$VPN_SWITCH_CONTEXT_CONNECT"

# Check mode
mode="${1:-disconnect}"

# Helper function to output variable definitions (used by both modes)
output_variables() {
  cat <<'EOF'
# Commands (hardcoded from VPN_SWITCH_* variables at generation time)
EOF
  cat <<EOF
pfctl="${VPN_SWITCH_PFCTL:-pfctl}"
openvpn="$VPN_SWITCH_BINARY_openvpn"
install="${VPN_SWITCH_INSTALL:-/usr/bin/install}"

# Standard context
session_dir="$VPN_SESSION_DIR"
protocol="openvpn"
interface="$VPN_INTERFACE"
config_path="$VPN_CONFIG_FILE"
EOF
}

if [ "$mode" = "inspect" ]; then
  # Inspect mode: output only variable definitions
  output_variables
  exit 0
fi

# Disconnect mode: generate full disconnect.sh header
# Resolve shell path for shebang (supports both relative and absolute paths)
script_shell=$(command -v "${VPN_SWITCH_SCRIPT_SHELL:-sh}" 2>/dev/null || echo "${VPN_SWITCH_SCRIPT_SHELL:-sh}")

cat <<EOF
#!${script_shell}
# =============================================================================
# OpenVPN VPN Disconnection Script
# =============================================================================
# Generated: $(date '+%Y-%m-%d %H:%M:%S')
# Session: $VPN_SESSION_PID
# Interface: $VPN_INTERFACE
#
# CONTEXT VARIABLES:
#
#   Standard (all protocols):
#     session_dir    - Session metadata directory
#     protocol       - Protocol name (openvpn)
#     interface      - Network interface ($VPN_INTERFACE)
#     config_path    - VPN configuration file
#
# PHASES: $VPN_PHASES_DISCONNECT
#
# Each phase executes: prepare → execute → verify
#   - Phases run in reverse order of connection
#   - Typically: dns → vpn → firewall
#
# CUSTOMIZATION:
#   - Edit phase scripts: .include/phase/openvpn/disconnect/
#   - Edit phase list: .env/local/VPN_SWITCH_PHASES_DISCONNECT
#   - Edit this prologue: .include/phase/openvpn/disconnect/prologue.sh
#
# =============================================================================

# Isolation: Re-exec with clean environment (once)
if [ -z "\${ISOLATED:-}" ]; then
  exec env - \\
    ISOLATED=1 \\
    PATH="${VPN_SWITCH_PATH}" \\
    HOME="\${HOME}" \\
    USER="\${USER}" \\
    SHELL="\${SHELL:-/bin/sh}" \\
    ${script_shell} -c '[ "\$0" = "--" ] && exec "\$@" || exec "\$0" "\$@"' -- "$VPN_SESSION_DIR/disconnect.sh" "\$@"
fi

# Now running in curated minimal environment
# Commands use absolute paths, child processes inherit minimal environment

# PATH (hardcoded from VPN_SWITCH_PATH at generation time)
PATH="${VPN_SWITCH_PATH}"
export PATH

EOF

# Output variable definitions
output_variables

# Inform user about disconnection.
# See wireguard/disconnect/prologue.sh for the rationale on the
# two-layer heredoc design (outer EOF expands $VPN_SESSION_PID at
# generation time; inner DISCONNECT_MSG expands \$interface at runtime).
cat <<EOF
# Inform user about disconnection
cat <<DISCONNECT_MSG
# Disconnecting OpenVPN interface: \$interface (session: $VPN_SESSION_PID)
DISCONNECT_MSG

# =============================================================================
# Phase Execution
# =============================================================================

EOF
