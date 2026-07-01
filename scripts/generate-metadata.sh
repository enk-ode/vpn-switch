#!/bin/sh
# Generate function metadata for vpn-switch.sh
# Extracts terminal and combinator functions and injects into script
#
# Usage:
#   scripts/generate-metadata.sh                    # Inject into vpn-switch.sh (default)
#   scripts/generate-metadata.sh --target <file>    # Inject into specified file
#   scripts/generate-metadata.sh --help             # Show usage

set -e

# Parse arguments
TARGET_FILE=""
while [ $# -gt 0 ]; do
  case "$1" in
    --target)
      TARGET_FILE="$2"
      shift 2
      ;;
    --help|-h)
      echo "Usage: $0 [--target <file>]"
      echo ""
      echo "Generate function metadata and inject into target file."
      echo ""
      echo "Options:"
      echo "  --target <file>    Target file to inject metadata into (default: vpn-switch.sh)"
      echo "  --help, -h         Show this help message"
      echo ""
      echo "The metadata block is delimited by:"
      echo "  # === AUTO-GENERATED METADATA (make metadata) ==="
      echo "  # === END AUTO-GENERATED ==="
      exit 0
      ;;
    *)
      echo "Error: Unknown argument: $1" >&2
      echo "Use --help for usage information" >&2
      exit 1
      ;;
  esac
done

# Default to vpn-switch.sh if no target specified
SCRIPT="${TARGET_FILE:-vpn-switch.sh}"
INCLUDE_DIR="include"
TEMP_FILE="/tmp/vpn-switch-metadata.$$"
MAIN_SCRIPT="vpn-switch.sh"

# Extract functions from main script (always vpn-switch.sh, not target)
# This ensures all scripts get the complete function list
MAIN_BATCH_COMBINATORS=$(grep -o '^___[a-z][a-z_]*[0-9]()' "$MAIN_SCRIPT" 2>/dev/null | sed 's/().*//' | tr '\n' ' ' | sed 's/ $//')
MAIN_TERMINALS=$(grep -o '^_[a-z][a-z_]*[0-9]()' "$MAIN_SCRIPT" 2>/dev/null | grep -v '^___' | grep -v '^__' | sed 's/().*//' | tr '\n' ' ' | sed 's/ $//')
MAIN_COMBINATORS=$(grep -o '^__[a-z][a-z_]*[0-9]()' "$MAIN_SCRIPT" 2>/dev/null | grep -v '^___' | sed 's/().*//' | tr '\n' ' ' | sed 's/ $//')

# Extract functions from modules and build function-to-module mapping
# Format: "function:module function:module ..."
MODULE_MAPPING=""
MODULE_BATCH_COMBINATORS=""
MODULE_TERMINALS=""
MODULE_COMBINATORS=""

for module_file in "$INCLUDE_DIR"/*.sh; do
  [ -f "$module_file" ] || continue
  module_name=$(basename "$module_file")

  # Extract function names from this module (match all anchor functions: _, __, ___)
  funcs=$(grep -o '^_[a-z_]*[0-9]() {' "$module_file" 2>/dev/null | sed 's/() {.*//' || true)

  for func in $funcs; do
    # Add to mapping: function:module
    MODULE_MAPPING="$MODULE_MAPPING $func:$module_name"

    # Classify by underscore count
    case "$func" in
      ___*)
        MODULE_BATCH_COMBINATORS="$MODULE_BATCH_COMBINATORS $func" ;;
      __*)
        MODULE_COMBINATORS="$MODULE_COMBINATORS $func" ;;
      _*)
        MODULE_TERMINALS="$MODULE_TERMINALS $func" ;;
    esac
  done
done

# Combine main + module functions
BATCH_COMBINATORS="$MAIN_BATCH_COMBINATORS $MODULE_BATCH_COMBINATORS"
TERMINALS="$MAIN_TERMINALS $MODULE_TERMINALS"
COMBINATORS="$MAIN_COMBINATORS $MODULE_COMBINATORS"
ANCHORS="$TERMINALS $COMBINATORS $BATCH_COMBINATORS"

# Trim leading/trailing spaces
BATCH_COMBINATORS=$(echo "$BATCH_COMBINATORS" | sed 's/^ *//; s/ *$//')
TERMINALS=$(echo "$TERMINALS" | sed 's/^ *//; s/ *$//')
COMBINATORS=$(echo "$COMBINATORS" | sed 's/^ *//; s/ *$//')
ANCHORS=$(echo "$ANCHORS" | sed 's/^ *//; s/ *$//')
MODULE_MAPPING=$(echo "$MODULE_MAPPING" | sed 's/^ *//; s/ *$//')

# Generate metadata block
cat > "$TEMP_FILE" <<EOF
# === AUTO-GENERATED METADATA (make metadata) ===
# Generated: $(date '+%Y-%m-%d %H:%M:%S')
# Terminal functions (single underscore): output shell commands
# Combinator functions (double underscore): output single vpn-switch command
# Batch-combinator functions (triple underscore): output multiple vpn-switch commands
TERMINAL_FUNCTIONS="$TERMINALS"
COMBINATOR_FUNCTIONS="$COMBINATORS"
BATCH_COMBINATOR_FUNCTIONS="$BATCH_COMBINATORS"
ANCHOR_FUNCTIONS="$ANCHORS"
# Function-to-module mapping (format: "func:module.sh func:module.sh ...")
# Used by process_arguments() for deterministic module loading
FUNCTION_MODULES="$MODULE_MAPPING"
# === END AUTO-GENERATED ===
EOF

# Check if metadata block already exists in script
if grep -q '^# === AUTO-GENERATED METADATA' "$SCRIPT"; then
    # Replace existing metadata block
    sed -i.bak '/^# === AUTO-GENERATED METADATA/,/^# === END AUTO-GENERATED ===/d' "$SCRIPT"
fi

# Insert metadata after shebang (line 2)
# FreeBSD sed syntax: insert file after line 2
sed -i.bak "2r $TEMP_FILE" "$SCRIPT"

# Clean up
rm -f "$TEMP_FILE" "${SCRIPT}.bak"

# Report statistics
terminal_count=$(echo "$TERMINALS" | wc -w | tr -d ' ')
combinator_count=$(echo "$COMBINATORS" | wc -w | tr -d ' ')
batch_combinator_count=$(echo "$BATCH_COMBINATORS" | wc -w | tr -d ' ')
total_count=$(echo "$ANCHORS" | wc -w | tr -d ' ')
main_count=$(echo "$MAIN_TERMINALS $MAIN_COMBINATORS $MAIN_BATCH_COMBINATORS" | wc -w | tr -d ' ')
module_count=$(echo "$MODULE_TERMINALS $MODULE_COMBINATORS $MODULE_BATCH_COMBINATORS" | wc -w | tr -d ' ')
module_mapping_count=$(echo "$MODULE_MAPPING" | wc -w | tr -d ' ')

echo "Metadata generated:"
echo "  Target file: $SCRIPT"
echo "  Terminal functions: $terminal_count"
echo "  Combinator functions: $combinator_count"
echo "  Batch-combinator functions: $batch_combinator_count"
echo "  Total anchor functions: $total_count"
echo "  Main script functions: $main_count"
echo "  Module functions: $module_count"
echo "  Function-to-module mappings: $module_mapping_count"