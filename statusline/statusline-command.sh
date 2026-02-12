#!/usr/bin/env bash
# Duet StatusLine for Claude Code
# Lean prompt inspired by Powerlevel10k

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name')
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
output_style=$(echo "$input" | jq -r '.output_style.name // empty')
context_remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')
vim_mode=$(echo "$input" | jq -r '.vim.mode // empty')
agent_name=$(echo "$input" | jq -r '.agent.name // empty')

dir_name=$(basename "$cwd")

git_info=""
if git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
  branch=$(git -C "$cwd" branch --show-current 2>/dev/null || echo "detached")
  if ! git -C "$cwd" diff --quiet 2>/dev/null || ! git -C "$cwd" diff --cached --quiet 2>/dev/null; then
    git_status="*"
  else
    git_status=""
  fi
  git_info=" \033[36m${branch}${git_status}\033[0m"
fi

components=()
components+=("\033[36m${dir_name}\033[0m")
[ -n "$git_info" ] && components+=("${git_info}")
components+=("\033[32m${model}\033[0m")
[ -n "$output_style" ] && components+=("\033[33m${output_style}\033[0m")
[ -n "$context_remaining" ] && components+=("\033[35mctx:${context_remaining}%\033[0m")
[ -n "$vim_mode" ] && components+=("\033[31m${vim_mode}\033[0m")
[ -n "$agent_name" ] && components+=("\033[34magent:${agent_name}\033[0m")

IFS=' | '
printf '%b\n' "${components[*]}"
