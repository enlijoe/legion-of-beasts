#!/usr/bin/env bash
set -euo pipefail

ROOT="${ROOT:-$(git rev-parse --show-toplevel)}"
SRC_DIR="${SRC_DIR:-$ROOT/assets/blender/src}"
BUILD_DIR="${BUILD_DIR:-$ROOT/assets/blender/build}"
BLENDER_BIN="${BLENDER_BIN:-blender}"   # override if needed, e.g., /c/Program\ Files/Blender\ Foundation/Blender/blender.exe

mkdir -p "$BUILD_DIR"

shopt -s nullglob
count=0
for blend in "$SRC_DIR"/*.blend; do
  echo ">> Building $(basename "$blend")"
  "$BLENDER_BIN" -b "$blend" --python "$ROOT/scripts/blender_export.py" -- --outdir "$BUILD_DIR"
  ((count++))
done
echo "Done. Built $count file(s) into $BUILD_DIR"
