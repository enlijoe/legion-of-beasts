#!/usr/bin/env bash
set -euo pipefail

DATA_ROOT="${1:-}"        # e.g., /opt/minecraft/dev/data
WORLD_NAME="${2:-}"       # e.g., Bedrock level
PACK_UUID="${3:-}"        # manifest.header.uuid
PACK_VERSION_CSV="${4:-1,0,0}"  # e.g., 1,0,0
BASE_JSON="${5:-}"        # optional: repo base file

if [[ -z "$DATA_ROOT" || -z "$WORLD_NAME" || -z "$PACK_UUID" ]]; then
	echo "Usage: $0 <DATA_ROOT> <WORLD_NAME> <PACK_UUID> [version as 1,0,0] [base_json]" >&2
	exit 1
fi

# Require jq
if ! command -v jq >/dev/null 2>&1; then
	echo "Error: jq is required" >&2
	exit 1
fi

# Build the target path
WBP="$DATA_ROOT/worlds/$WORLD_NAME/world_behavior_packs.json"
mkdir -p "$(dirname "$WBP")"

# Start from base JSON if provided, else existing world file, else empty array
if [[ -n "$BASE_JSON" && -f "$BASE_JSON" ]]; then
	cp "$BASE_JSON" "$WBP.tmp"
elif [[ -f "$WBP" ]]; then
	cp "$WBP" "$WBP.tmp"
else
	echo "[]" > "$WBP.tmp"
fi

# Convert "1,0,0" -> [1,0,0] robustly via jq
VER_JSON="$(jq -cn --arg csv "$PACK_VERSION_CSV" '($csv | split(",") | map(tonumber))')"

# Idempotently add or update the pack entry
jq --arg id "$PACK_UUID" --argjson ver "$VER_JSON" '
	(map(select(.pack_id == $id)) | length) as $exists
	| if $exists == 0 then
