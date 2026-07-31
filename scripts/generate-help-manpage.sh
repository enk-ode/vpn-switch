#!/bin/sh
# generate-help-manpage.sh - Regenerate the COMMANDS region of docs/vpn-switch.1.md
# from the #@help doc-block corpus, via help_render's "manpage" back-end.
#
# One model, many back-ends: terminal help and this man-page COMMANDS section are
# rendered from the same doc-blocks (see docs/HELP_TEMPLATE_SPEC.md sec.8). Only the
# region between the markers is rewritten; all curated sections stay hand-written.
# Build-time only (contributor step); the committed .1/.html still ship without it.
set -eu

here=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
md="$here/docs/vpn-switch.1.md"
start='<!-- @generated commands (from vpn-switch help corpus) - do not edit by hand -->'
end='<!-- @end generated commands -->'

[ -f "$md" ] || { echo "generate-help-manpage: missing $md" >&2; exit 1; }
grep -qF "$start" "$md" || {
  echo "generate-help-manpage: start marker not found in $md" >&2
  echo "  expected: $start" >&2
  exit 1
}

# Render the COMMANDS body from the corpus. Run with source-tree paths so the
# parser scans this checkout (not an installed copy).
VPN_SWITCH_CONTEXT_SCRIPT="$here/vpn-switch.sh"
VPN_SWITCH_LIBDIR="$here"
LOG_FILE=/dev/null
export VPN_SWITCH_CONTEXT_SCRIPT VPN_SWITCH_LIBDIR LOG_FILE

genfile=$(mktemp 2>/dev/null || echo "/tmp/vpnsw-manpage.$$")
# shellcheck disable=SC1090
. "$here/include/help.sh"
help_render manpage > "$genfile"

tmp="$here/docs/.vpn-switch.1.md.tmp.$$"
awk -v s="$start" -v e="$end" -v gf="$genfile" '
  $0==s { print; print ""; while ((getline line < gf) > 0) print line; print e; skip=1; next }
  $0==e { skip=0; next }
  !skip { print }
' "$md" > "$tmp"

cat "$tmp" > "$md"
rm -f "$tmp" "$genfile"
echo "  -> regenerated COMMANDS region in docs/vpn-switch.1.md"
