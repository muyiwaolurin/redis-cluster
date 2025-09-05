#!/usr/bin/env bash
set -euo pipefail
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$script_dir/common.sh"

"$script_dir/down.sh" || true
rm -rf "$BASE"
echo "✅ cleaned"
