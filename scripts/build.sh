#!/usr/bin/env bash
source "$(dirname "$0")/common.sh"

make "$KEYBOARD:$KEYMAP"

mkdir -p "$OLDPWD/build"
find . -maxdepth 1 \( -name "*.bin" -o -name "*.uf2" -o -name "*.hex" \) \
    -exec cp {} "$OLDPWD/build/" \;
