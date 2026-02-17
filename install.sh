#!/usr/bin/env bash
set -euo pipefail

DEST="${HOME}/.claude/plugins/duet"
REPO="https://github.com/tslateman/duet.git"
PLUGINS_JSON="${HOME}/.claude/plugins/installed_plugins.json"

if [ -d "$DEST" ]; then
  git -C "$DEST" pull --ff-only
  echo "duet updated."
else
  mkdir -p "$(dirname "$DEST")"
  git clone "$REPO" "$DEST"
  echo "duet installed to $DEST"
fi

# Register plugin
mkdir -p "$(dirname "$PLUGINS_JSON")"
if [ ! -f "$PLUGINS_JSON" ]; then
  echo '{"version":2,"plugins":{}}' > "$PLUGINS_JSON"
fi

if command -v jq &>/dev/null; then
  jq --arg path "$DEST" '.plugins.duet = {path: $path, enabled: true}' "$PLUGINS_JSON" > "$PLUGINS_JSON.tmp" \
    && mv "$PLUGINS_JSON.tmp" "$PLUGINS_JSON"
else
  # Fallback without jq
  cat > "$PLUGINS_JSON" <<EOF
{
  "version": 2,
  "plugins": {
    "duet": {
      "path": "$DEST",
      "enabled": true
    }
  }
}
EOF
fi

echo "duet registered. Restart Claude to load."
