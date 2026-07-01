#!/bin/sh
# OpenVPN inspect prologue - Variable definitions for inspect mode
# Outputs only variable definitions (no shebang, no isolation in output)

# Unpack context from environment
eval "$VPN_SWITCH_CONTEXT_CONNECT"

# Output variable definitions
cat <<'EOF'
# Commands (hardcoded from VPN_SWITCH_* variables at generation time)
EOF
cat <<EOF
pfctl="${VPN_SWITCH_PFCTL:-pfctl}"
openvpn="$VPN_SWITCH_BINARY_openvpn"
install="${VPN_SWITCH_INSTALL:-/usr/bin/install}"
ifconfig_cmd="$EXAMINE_NETWORK_INTERFACE_EXISTS"

# Standard context
session_dir="$VPN_SESSION_DIR"
protocol="openvpn"
interface="$VPN_INTERFACE"
config_path="$VPN_CONFIG_FILE"

# OpenVPN-specific context
dns_server="$VPN_DNS_SERVER"
remote_ips="$VPN_REMOTE_IPS"
EOF
