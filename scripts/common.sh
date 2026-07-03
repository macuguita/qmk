#!/usr/bin/env bash
set -euo pipefail

KEYBOARD="keychron/q1_he/iso_encoder"
KEYMAP="macuguita"

WORKDIR="$(mktemp -d)"
trap 'rm -rf "$WORKDIR"' EXIT

cp -r "$QMK_SRC" "$WORKDIR/qmk"
chmod -R +w "$WORKDIR/qmk"

TARGET="$WORKDIR/qmk/keyboards/keychron/q1_he/iso_encoder/keymaps/$KEYMAP"

mkdir -p "$TARGET"
cp -r "firmware/$KEYMAP/." "$TARGET"

cd "$WORKDIR/qmk"
