#!/usr/bin/env bash
set -euo pipefail

# Resolve project root relative to this script's directory
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_root="$(cd "$script_dir/.." && pwd)"

# Defaults (can be overridden via env)
SESSION="${SESSION:-redis-cluster}"
BASE="${BASE:-$project_root/clusters}"
PORTS="${PORTS:-7000 7001 7002 7003 7004 7005}"
REDIS_SERVER="${REDIS_SERVER:-$(command -v redis-server || echo /usr/local/bin/redis-server)}"
REDIS_CLI="${REDIS_CLI:-$(command -v redis-cli || echo /usr/local/bin/redis-cli)}"

log() { printf "%s\n" "$*"; }
