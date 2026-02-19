#!/usr/bin/env bash
set -euo pipefail

# Generate the Commands, Skills, and Agents tables for README.md
# Usage: ./scripts/generate-readme.sh > /dev/null  (updates README.md in place)

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
README="$ROOT/README.md"

# --- Collect commands ---
cmd_table="| Command | Description |\n| --- | --- |"
for f in "$ROOT"/commands/*.md; do
  [ -f "$f" ] || continue
  name=$(basename "$f" .md)
  desc=$(grep '^description:' "$f" | head -1 | sed 's/^description: *//')
  # ponder takes an argument
  if [ "$name" = "ponder" ]; then
    cmd_table="$cmd_table\n| \`/ponder [n]\` | $desc |"
  else
    cmd_table="$cmd_table\n| \`/$name\` | $desc |"
  fi
done

# --- Collect skills ---
skill_table="| Skill | Description |\n| --- | --- |"
for d in "$ROOT"/skills/*/; do
  [ -f "$d/SKILL.md" ] || continue
  skill_md="$d/SKILL.md"
  name=$(grep '^name:' "$skill_md" | head -1 | sed 's/^name: *//')
  desc=$(grep '^description:' "$skill_md" | head -1 | sed 's/^description: *//')
  # Truncate long descriptions at word boundary before 80 characters
  if [ ${#desc} -gt 80 ]; then
    desc="${desc:0:80}"
    desc="${desc% *}..."
  fi
  skill_table="$skill_table\n| \`/$name\` | $desc |"
done

# --- Collect agents ---
agent_table="| Agent | Description |\n| --- | --- |"
for f in "$ROOT"/agents/*.md; do
  [ -f "$f" ] || continue
  name=$(basename "$f" .md)
  desc=$(grep '^description:' "$f" | head -1 | sed 's/^description: *//')
  agent_table="$agent_table\n| \`$name\` | $desc |"
done

# --- Update README sections ---
# Use awk to replace content between ## Commands/## Skills/## Agents headers and the next ## header
tmpfile=$(mktemp)

awk -v cmd_table="$cmd_table" \
    -v skill_table="$skill_table" \
    -v agent_table="$agent_table" '
  /^## Commands$/ {
    print; print "";
    cmd = cmd_table
    gsub(/\\n/, "\n", cmd)
    print cmd
    print ""
    skip = 1; next
  }
  /^## Skills$/ {
    print; print "";
    cmd = skill_table
    gsub(/\\n/, "\n", cmd)
    print cmd
    print ""
    skip = 1; next
  }
  /^## Agents$/ {
    print; print "";
    cmd = agent_table
    gsub(/\\n/, "\n", cmd)
    print cmd
    print ""
    skip = 1; next
  }
  /^## / && skip { skip = 0 }
  !skip { print }
' "$README" > "$tmpfile"

mv "$tmpfile" "$README"
echo "README.md updated."
