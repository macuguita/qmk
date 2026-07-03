#!/usr/bin/env bash
source "$(dirname "$0")/common.sh"

make "$KEYBOARD:$KEYMAP:flash"
