#!/usr/bin/env bash
source "$(dirname "$0")/common.sh"

make "$KEYBOARD:$KEYMAP"

mkdir -p "$PROJECT_ROOT/build"

find . -maxdepth 1 \
    \( -name '*.bin' -o -name '*.uf2' -o -name '*.hex' \) \
    -exec cp {} "$PROJECT_ROOT/build/" \;

echo
echo "Build complete."
