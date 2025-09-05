#!/usr/bin/env bash
set -euo pipefail
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$script_dir/common.sh"

"$script_dir/init.sh"
"$script_dir/up.sh"
"$script_dir/create_cluster.sh"

echo "✅ cluster started"
