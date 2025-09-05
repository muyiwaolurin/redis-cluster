#!/usr/bin/env bash
set -euo pipefail

if ! command -v brew >/dev/null 2>&1; then
  echo "Install Homebrew: https://brew.sh" >&2
  exit 1
fi

brew list --formula | grep -q '^tmux$'  || brew install tmux
brew list --formula | grep -q '^redis$' || brew install redis
brew list --formula | grep -q '^mapfile$' || brew install bash
echo "✅ deps ready"
