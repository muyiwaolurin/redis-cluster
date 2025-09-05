#!/usr/bin/env bash
set -euo pipefail
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$script_dir/common.sh"

mkdir -p "$BASE"
for p in $PORTS; do
  d="$BASE/$p"
  mkdir -p "$d"
  cat > "$d/redis.conf" <<EOF
port $p
bind 127.0.0.1
protected-mode no

cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
cluster-announce-ip 127.0.0.1

appendonly yes
daemonize no
pidfile "$BASE/$p/redis.pid"
EOF
  echo "✅ wrote configs for Port: $p"
done
