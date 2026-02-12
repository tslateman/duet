#!/usr/bin/env bash
set -euo pipefail

DEST="${HOME}/.claude/plugins/duet"
REPO="https://github.com/tslateman/duet.git"

if [ -d "$DEST" ]; then
  git -C "$DEST" pull --ff-only
  echo "duet updated."
else
  mkdir -p "$(dirname "$DEST")"
  git clone "$REPO" "$DEST"
  echo "duet installed to $DEST"
fi
