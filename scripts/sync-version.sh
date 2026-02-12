#!/usr/bin/env bash
set -euo pipefail

# Sync plugin.json version with the latest git tag.
# Usage: ./scripts/sync-version.sh
#   - Reads the latest semver tag (e.g. v1.2.0)
#   - Updates .claude-plugin/plugin.json version field
#   - Exits 0 if updated, 1 if no tags found

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PLUGIN_JSON="$ROOT/.claude-plugin/plugin.json"

tag=$(git -C "$ROOT" describe --tags --abbrev=0 2>/dev/null || true)

if [ -z "$tag" ]; then
  echo "No git tags found. Tag a release first: git tag v1.0.0"
  exit 1
fi

# Strip leading 'v' if present
version="${tag#v}"

current=$(jq -r '.version' "$PLUGIN_JSON")

if [ "$current" = "$version" ]; then
  echo "plugin.json already at $version"
  exit 0
fi

jq --arg v "$version" '.version = $v' "$PLUGIN_JSON" > "$PLUGIN_JSON.tmp"
mv "$PLUGIN_JSON.tmp" "$PLUGIN_JSON"
echo "plugin.json updated: $current → $version"
