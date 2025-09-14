#!/usr/bin/env bash
set -euo pipefail

PACK_DIR="${1:-}"
if [[ -z "$PACK_DIR" || ! -d "$PACK_DIR" ]]; then
	echo "Usage: $0 mods/bedrock/<PackDir>"
	exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
	echo "jq not found; install for best validation (apt-get install jq)."
fi

MAN="$PACK_DIR/manifest.json"
[ -f "$MAN" ] || { echo "Missing $MAN"; exit 1; }

echo "Validating $MAN"
if command -v jq >/dev/null 2>&1; then
	jq . "$MAN" >/dev/null || { echo "Invalid JSON in manifest"; exit 1; }
	HEADER_UUID=$(jq -r '.header.uuid' "$MAN")
	MODULE_UUID=$(jq -r '.modules[0].uuid' "$MAN")
	ENTRY=$(jq -r '.modules[0].entry' "$MAN")
	echo "Header UUID: $HEADER_UUID"
	echo "Module UUID: $MODULE_UUID"
	echo "Entry: $ENTRY"
	[ -f "$PACK_DIR/$ENTRY" ] || { echo "Missing entry script: $ENTRY"; exit 1; }
else
	echo "jq not installed; skipping deep checks."
fi
echo "OK."
