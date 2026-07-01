#!/bin/sh
# WireGuard disconnection prologue generator
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
wg_quick="$VPN_SWITCH_BINARY_wireguard"
install="${VPN_SWITCH_INSTALL:-/usr/bin/install}"

# Standard context
session_dir="$VPN_SESSION_DIR"
protocol="wireguard"
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
# WireGuard VPN Disconnection Script (Self-Contained)
# =============================================================================
# Generated: $(date '+%Y-%m-%d %H:%M:%S')
# Session: $VPN_SESSION_PID
# Interface: $VPN_INTERFACE
#
# This script is self-contained and can be executed standalone.
# All paths and commands are hardcoded at generation time.
#
# CUSTOMIZATION:
#   - Edit phase scripts: .include/phase/wireguard/disconnect/
#   - Edit phase list: .env/local/VPN_SWITCH_PHASES_DISCONNECT
#   - Edit this prologue: .include/phase/wireguard/disconnect/prologue.sh
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
#
# Two-layer heredoc design:
#   - Outer EOF: this script's generation-time heredoc. Unquoted, so
#     $VPN_SESSION_PID expands here (becomes the literal session pid in
#     the emitted runtime script). Anything intended for runtime
#     expansion must be escaped with a leading backslash.
#   - Inner DISCONNECT_MSG: a runtime heredoc embedded in the emitted
#     script. Unquoted at runtime so \$interface (literal "$interface"
#     in the emitted file) expands when the disconnect script actually
#     runs. Distinct marker name to avoid collision with EOF.
#
# Output line keeps the defensive "# " prefix so the cut -b3- interpreter
# strips it cleanly to the user-visible "Disconnecting ... (session: N)".
#
# The previous attempt nested two EOF heredocs which the shell parsed as
# a single unterminated quoted string, producing garbled output through
# cut -b3-:
#   sconnecting WireGuard interface: wg0 (session: EOF
#   t <<EOF
#   94)
cat <<EOF
# Inform user about disconnection
cat <<DISCONNECT_MSG
# Disconnecting WireGuard interface: \$interface (session: $VPN_SESSION_PID)
DISCONNECT_MSG

# =============================================================================
# Phase Execution
# =============================================================================

EOF
