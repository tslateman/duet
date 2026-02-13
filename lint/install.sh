#!/bin/bash
# Usage: ~/dev/cli/duet/lint/install.sh [target-dir]
# Copies .vale.ini to target, runs vale sync to download packages.

set -e

TARGET="${1:-.}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

cp "$SCRIPT_DIR/.vale.ini" "$TARGET/.vale.ini"
cd "$TARGET" && vale sync
echo "Vale configured. Run: vale *.md"
