#!/usr/bin/env bash
set -euo pipefail
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$script_dir/common.sh"

sleep 1
NODES=""
for p in $PORTS; do NODES="$NODES 127.0.0.1:$p"; done
echo "Creating cluster with:$NODES"
yes yes | "$REDIS_CLI" --cluster create $NODES --cluster-replicas 1