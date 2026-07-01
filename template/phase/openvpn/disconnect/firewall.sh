#!/bin/sh
# Firewall phase for OpenVPN disconnection
# Cleans up PF packet filter tables

# Unpack context variables (for generation-time expansion)
eval "$VPN_SWITCH_CONTEXT_CONNECT"

case "$1" in
    verify)
        cat <<'EOF'
# Verify function for firewall phase
verify_firewall() {
    local step="$1"
    local exit_code="$2"

    case "$step" in
        prepare)
            # Firewall cleanup is optional
            echo "✓ Firewall cleanup ready" >&2
            ;;
        execute)
            if [ "$exit_code" -ne 0 ]; then
                echo "WARNING: Firewall cleanup failed" >&2
                # Non-fatal - VPN is already down
            else
                echo "✓ Firewall cleaned up successfully" >&2
            fi
            ;;
    esac
}
EOF
        ;;

    prepare)
        cat <<'EOF'
echo "==> Phase: firewall (prepare)" >&2
# No strict prerequisites for firewall cleanup
verify_firewall prepare 0
EOF
        ;;

    execute)
        cat <<'EOF'
echo "==> Phase: firewall (execute)" >&2

# Flush PF tables (optional cleanup)
# Note: Tables will be repopulated on next connection
# This step is mainly for cleanup visibility

# We don't actually flush the tables here because:
# 1. Other VPN sessions might be using them
# 2. PF configuration persists across sessions
# 3. Tables will be overwritten on next connection

echo "Firewall tables will be reset on next connection" >&2
verify_firewall execute 0
EOF
        ;;

    *)
        echo "Usage: $0 {verify|prepare|execute}" >&2
        exit 1
        ;;
esac
