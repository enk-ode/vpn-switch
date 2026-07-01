#!/bin/sh
# WireGuard connection prologue generator
# Outputs the header and context for connect.sh (or variable definitions for inspect)
#
# Usage:
#   prologue.sh           - Generate full connect.sh header (default)
#   prologue.sh inspect   - Generate only variable definitions for inspect mode

# Unpack context from environment
eval "$VPN_SWITCH_CONTEXT_CONNECT"

# Check mode
mode="${1:-connect}"

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

# WireGuard-specific context
dns_server="$VPN_DNS_SERVER"
remote_ips="$VPN_REMOTE_IPS"
EOF
}

if [ "$mode" = "inspect" ]; then
  # Inspect mode: output only variable definitions
  output_variables
  exit 0
fi

# Connect mode: generate full connect.sh header
# Resolve shell path for shebang (supports both relative and absolute paths)
script_shell=$(command -v "${VPN_SWITCH_SCRIPT_SHELL:-sh}" 2>/dev/null || echo "${VPN_SWITCH_SCRIPT_SHELL:-sh}")
connect_script="$VPN_SESSION_DIR/connect.sh"

cat <<EOF
#!${script_shell}
# =============================================================================
# WireGuard VPN Connection Script (Self-Contained)
# =============================================================================
# Generated: $(date '+%Y-%m-%d %H:%M:%S')
# Session: $VPN_SESSION_PID
# Original config: $VPN_ORIGINAL_CONFIG_RELATIVE
#
# This script is self-contained and can be executed standalone.
# All paths and commands are hardcoded at generation time.
#
# CONTEXT VARIABLES:
#
#   Standard (all protocols):
#     session_dir    - Session metadata directory
#     protocol       - Protocol name (wireguard)
#     interface      - Network interface ($VPN_INTERFACE)
#     config_path    - VPN configuration file
#
#   WireGuard-specific:
#     dns_server     - DNS server IP (see variable below)
#     remote_ips     - Remote server IPs (see variable below)
#
# PHASES: $VPN_PHASES_CONNECT
#
# Each phase executes: prepare → execute → verify
#   - Typically: firewall → vpn → dns
#
# CUSTOMIZATION:
#   - Edit phase scripts: .include/phase/wireguard/connect/
#   - Edit phase list: .env/local/VPN_SWITCH_PHASES_CONNECT
#   - Edit this prologue: .include/phase/wireguard/connect/prologue.sh
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
    ${script_shell} -c '[ "\$0" = "--" ] && exec "\$@" || exec "\$0" "\$@"' -- "${connect_script}" "\$@"
fi

# Now running in curated minimal environment
# Commands use absolute paths, child processes inherit minimal environment

# PATH (hardcoded from VPN_SWITCH_PATH at generation time)
PATH="${VPN_SWITCH_PATH}"
export PATH

EOF

# Output variable definitions
output_variables

cat <<'EOF'

# =============================================================================
# Phase Execution
# =============================================================================

EOF
