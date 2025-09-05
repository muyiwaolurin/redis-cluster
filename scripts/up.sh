#!/usr/bin/env bash
set -euo pipefail
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$script_dir/common.sh"

# Start tmux session (skip if it exists)
if tmux has-session -t "$SESSION" 2>/dev/null; then
  echo "tmux session '$SESSION' already exists"
else
  tmux new-session -d -s "$SESSION" -x 200 -y 60 "echo 'Starting redis cluster in tmux session \"$SESSION\"'; bash"
  echo "✅ created tmux session '$SESSION'"
fi

# Ensure pane count matches number of ports
needed=$(echo $PORTS | wc -w | xargs)
current=$(tmux list-panes -t "$SESSION":0 2>/dev/null | wc -l | xargs || echo 0)
while [ "$current" -lt "$needed" ]; do
  tmux split-window -t "$SESSION":0 -v
  tmux select-layout -t "$SESSION":0 tiled
  current=$((current+1))
done

# Collect pane indexes
mapfile -t pane_indexes < <(tmux list-panes -t "$SESSION":0 -F '#{pane_index}')

# Launch one redis-server per pane, sending output to the pane (stdout)
i=0
for p in $PORTS; do
  pane_id=${pane_indexes[$i]}
  tmux select-pane -t "$SESSION":0.$pane_id
  tmux send-keys  -t "$SESSION":0.$pane_id "cd '$BASE/$p' && '$REDIS_SERVER' ./redis.conf" C-m
  i=$((i+1))
done
echo "✅ started $(echo $PORTS | wc -w | xargs) redis-server instances (logs visible in panes)"
echo "👉 attach with: tmux attach -t $SESSION"
