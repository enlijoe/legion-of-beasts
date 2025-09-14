#!/usr/bin/env bash
# Source this file to set up your dev environment
# Usage: source scripts/dev_env.sh

# Detect repo root
export REPO_ROOT="$(git rev-parse --show-toplevel)"
export SCRIPTS_DIR="$REPO_ROOT/scripts"

# Docker images root (adjust if your layout changes)
export DOCKER_ROOT="$REPO_ROOT/infra"

# Add scripts dir to PATH if not already present
case ":$PATH:" in
  *":$SCRIPTS_DIR:"*) ;;
  *) export PATH="$SCRIPTS_DIR:$PATH" ;;
esac

echo "Dev environment ready."
echo "REPO_ROOT=$REPO_ROOT"
echo "DOCKER_ROOT=$DOCKER_ROOT"
echo "Scripts in PATH from: $SCRIPTS_DIR"
