#!/usr/bin/env bash
set -euo pipefail

KEYBOARD="keychron/q1_he/iso_encoder"
KEYMAP="macuguita"

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

WORKDIR="$(mktemp -d)"
trap 'rm -rf "$WORKDIR"' EXIT

cp -r "$QMK_SRC" "$WORKDIR/qmk"
chmod -R +w "$WORKDIR/qmk"

KEYMAP_DST="$WORKDIR/qmk/keyboards/$KEYBOARD/keymaps/$KEYMAP"

mkdir -p "$KEYMAP_DST"
cp -r "$PROJECT_ROOT/firmware/$KEYMAP/." "$KEYMAP_DST"

cd "$WORKDIR/qmk"
