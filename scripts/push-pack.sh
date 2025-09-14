#!/usr/bin/env bash
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$HERE/../.." && pwd)"
ENV_FILE="$HERE/.env"
[ -f "$ENV_FILE" ] && source "$ENV_FILE"

TARGET="${1:-dev}"                 # dev | test | prod
PACK_NAME="${2:-}"                 # e.g., BP_Hello
if [[ -z "$PACK_NAME" ]]; then
	echo "Usage: $0 <dev|test|prod> <PackName>"
	exit 1
fi

PACK_DIR="$ROOT/mods/behavior_packs/$PACK_NAME"
[ -d "$PACK_DIR" ] || { echo "No such pack: $PACK_DIR"; exit 1; }

# pick env vars
case "$TARGET" in
	dev)  DATA="$BDS_DEV_DATA";  WORLD="$DEV_WORLD";  CON="$DEV_CONTAINER"  ;;
	test) DATA="$BDS_TEST_DATA"; WORLD="$TEST_WORLD"; CON="$TEST_CONTAINER" ;;
	prod) DATA="$BDS_PROD_DATA"; WORLD="$PROD_WORLD"; CON="$PROD_CONTAINER" ;;
	*) echo "Unknown target: $TARGET"; exit 1 ;;
esac

[ -n "${DATA:-}" ]  || { echo "DATA root not set for $TARGET in .env"; exit 1; }
[ -n "${WORLD:-}" ] || { echo "WORLD not set for $TARGET in .env"; exit 1; }

DEST="$DATA/worlds/$WORLD/behavior_packs/$PACK_NAME"
BASE_JSON="$ROOT/mods/worlds/world_behavior_packs.base.json"

# 1) validate
"$HERE/validate-pack.sh" "$PACK_DIR"

# 2) sync the pack folder
mkdir -p "$(dirname "$DEST")"
rsync -av --delete "$PACK_DIR/" "$DEST/"

# 3) extract UUID + version
if command -v jq >/dev/null 2>&1; then
