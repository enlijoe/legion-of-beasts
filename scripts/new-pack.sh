#!/usr/bin/env bash
set -euo pipefail

PACK_NAME="${1:-}"
if [[ -z "$PACK_NAME" ]]; then
	echo "Usage: $0 <PackName>"
	exit 1
fi

PACK_DIR="mods/bedrock/$PACK_NAME"
if [[ -e "$PACK_DIR" ]]; then
	echo "Error: $PACK_DIR already exists"
	exit 1
fi

UUID1=$(python3 - <<'PY'
import uuid; print(str(uuid.uuid4()))
PY
)
UUID2=$(python3 - <<'PY'
import uuid; print(str(uuid.uuid4()))
PY
)

mkdir -p "$PACK_DIR/scripts"

cat > "$PACK_DIR/manifest.json" <<JSON
{
	"format_version": 2,
	"header": {
		"name": "$PACK_NAME",
		"description": "$PACK_NAME behavior pack",
		"uuid": "$UUID1",
		"version": [1, 0, 0],
		"min_engine_version": [1, 21, 0]
	},
	"modules": [
		{
			"type": "script",
			"uuid": "$UUID2",
			"entry": "scripts/main.js"
		}
	]
}
JSON
