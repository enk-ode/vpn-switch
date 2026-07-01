#!/bin/sh
# markdown-formatter.sh - Format output as markdown elements
# Each function reads from stdin and outputs formatted markdown

# Usage: command | markdown-formatter.sh element [args...]

# Parse command-line arguments
ELEMENT="${1:-paragraph}"
shift

# Parse key=value arguments
DEPTH=""
TITLE=""
LANG=""
CAPTION=""
LABEL=""

while [ $# -gt 0 ]; do
  case "$1" in
    depth=*) DEPTH="${1#depth=}" ;;
    title=*) TITLE="${1#title=}" ;;
    lang=*) LANG="${1#lang=}" ;;
    caption=*) CAPTION="${1#caption=}" ;;
    label=*) LABEL="${1#label=}" ;;
    *) echo "Unknown argument: $1" >&2 ;;
  esac
  shift
done

# Read all input
INPUT=$(cat)

# Format based on element type
case "$ELEMENT" in
  section)
    # Create markdown section with heading
    # depth determines heading level (1-6)
    heading_level=${DEPTH:-1}
    [ "$heading_level" -gt 6 ] && heading_level=6
    heading=$(printf '#%.0s' $(seq 1 $heading_level))

    echo ""
    echo "$heading ${TITLE:-Section}"
    echo ""
    if [ -n "$LABEL" ]; then
      echo "{#$LABEL}"
      echo ""
    fi
    echo "$INPUT"
    echo ""
    ;;

  codeblock)
    # Create fenced code block
    echo ""
    if [ -n "$CAPTION" ]; then
      echo "**${CAPTION}:**"
      echo ""
    fi
    echo "\`\`\`${LANG}"
    echo "$INPUT"
    echo "\`\`\`"
    if [ -n "$LABEL" ]; then
      echo "{#$LABEL}"
    fi
    echo ""
    ;;

  paragraph)
    # Simple paragraph
    echo ""
    echo "$INPUT"
    echo ""
    ;;

  list)
    # Bullet list (each line becomes a bullet)
    echo ""
    echo "$INPUT" | while IFS= read -r line; do
      [ -z "$line" ] && continue
      echo "- $line"
    done
    echo ""
    ;;

  *)
    # Unknown element - just pass through
    echo "$INPUT"
    ;;
esac
