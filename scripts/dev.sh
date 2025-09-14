#!/usr/bin/env bash
# Launch a subshell with dev environment configured

ROOT="$(git rev-parse --show-toplevel)"
source "$ROOT/scripts/dev_env.sh"

echo "Entering dev shell (type 'exit' to leave)"
exec "$SHELL" -i
