#!/usr/bin/env bash
# Fails if a scrubbed name (scripts/.scrub-names), a personal path or a memory link appears in anything that gets published.
set -uo pipefail

HUB="$(cd "$(dirname "$0")/.." && pwd)"
SCRUB_FILE="$HUB/scripts/.scrub-names"
TARGETS=("$HUB/.github" "$HUB/templates")
[[ -f "$HUB/README.md" ]] && TARGETS+=("$HUB/README.md")

found=$(grep -rnE '/Users/|\[\[(project|feedback)_' "${TARGETS[@]}")
if [[ -f "$SCRUB_FILE" ]]; then
  names=$(grep -vE '^\s*(#|$)|^section:' "$SCRUB_FILE" | cut -d'|' -f1)
  [[ -n "$names" ]] && found+=$(grep -rniF "$names" "${TARGETS[@]}")
else
  echo "WARNING: $SCRUB_FILE not found — only generic checks ran." >&2
fi

if [[ -n "$found" ]]; then
  echo "$found"
  echo "check-names: blocked names found above. Scrub them before publishing." >&2
  exit 1
fi
echo "check-names: clean"
