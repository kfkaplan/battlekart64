#!/bin/sh
set -eu
cd "$(dirname "$0")/.."
temp_dir=$(mktemp -d)
trap 'rm -f "$temp_dir/pathfinding_core.c" "$temp_dir/pathfinding_test"; rmdir "$temp_dir"' EXIT HUP INT TERM
# Compile the actual navigation functions without the N64-only steering/rendering code.
sed '1d; /^void ResetLaneDefaultOffset/,$d' Library/Player/Pathfinding.c > "$temp_dir/pathfinding_core.c"
cc -O2 -std=c99 -Wall -Wextra -Wno-unused-parameter -fsanitize=address,undefined \
    -I "$temp_dir" tests/pathfinding_test.c -lm -o "$temp_dir/pathfinding_test"
"$temp_dir/pathfinding_test"
