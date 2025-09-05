#!/usr/bin/env bash
set -euo pipefail
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$script_dir/common.sh"

first_port=$(echo $PORTS | awk '{print $1}')
"$REDIS_CLI" -p "$first_port" cluster nodes || true
ps aux | grep redis-server || true
echo "Tip: '$REDIS_CLI' -p $first_port -c"
