#!/usr/bin/env bash
# duet eval runner — executes skill scenarios and grades results
# Usage: ./evals/run.sh [skill-name] [scenario-name]
#   ./evals/run.sh                     # run all
#   ./evals/run.sh vibe-check          # run all vibe-check scenarios
#   ./evals/run.sh vibe-check api-handler  # run one scenario
set -euo pipefail

# Allow running from inside a Claude Code session
unset CLAUDECODE 2>/dev/null || true

EVALS_DIR="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_DIR="$(dirname "$EVALS_DIR")"
RESULTS_DIR="$EVALS_DIR/results/$(date +%Y%m%d-%H%M%S)"
SKILL_FILTER="${1:-}"
SCENARIO_FILTER="${2:-}"
MODEL="${EVAL_MODEL:-claude-sonnet-4-6}"

mkdir -p "$RESULTS_DIR"

run_scenario() {
  local skill="$1"
  local scenario="$2"
  local scenario_dir="$EVALS_DIR/$skill/$scenario"
  local result_dir="$RESULTS_DIR/$skill/$scenario"

  mkdir -p "$result_dir/with_skill" "$result_dir/without_skill"

  local task criteria
  task=$(<"$scenario_dir/task.md")
  criteria=$(<"$scenario_dir/criteria.json")

  # Run with skill
  echo "  [$skill/$scenario] with skill..."
  cat <<PROMPT | claude -p --model "$MODEL" --dangerously-skip-permissions --plugin-dir "$PLUGIN_DIR" > "$result_dir/with_skill/output.md" 2>"$result_dir/with_skill/stderr.log" || true
You have the /duet:$skill skill loaded. Use it to complete this task.

$task
PROMPT

  # Run without skill
  echo "  [$skill/$scenario] without skill..."
  echo "$task" | claude -p --model "$MODEL" --dangerously-skip-permissions --disable-slash-commands > "$result_dir/without_skill/output.md" 2>"$result_dir/without_skill/stderr.log" || true

  # Grade with-skill output
  echo "  [$skill/$scenario] grading..."
  local with_output without_output
  with_output=$(<"$result_dir/with_skill/output.md") || with_output="(empty)"
  without_output=$(<"$result_dir/without_skill/output.md") || without_output="(empty)"

  cat <<PROMPT | claude -p --model "$MODEL" --dangerously-skip-permissions > "$result_dir/with_skill/grading.json" 2>/dev/null || true
You are a strict eval grader. Grade the following output against each assertion.

## Task
$task

## Output to Grade
$with_output

## Assertions
$criteria

For each assertion, respond with a JSON array. Each element must have:
- "id": the assertion id
- "passed": true or false
- "evidence": quote or explanation of why it passed/failed

Respond with ONLY the JSON array, no markdown fences, no other text.
PROMPT

  cat <<PROMPT | claude -p --model "$MODEL" --dangerously-skip-permissions > "$result_dir/without_skill/grading.json" 2>/dev/null || true
You are a strict eval grader. Grade the following output against each assertion.

## Task
$task

## Output to Grade
$without_output

## Assertions
$criteria

For each assertion, respond with a JSON array. Each element must have:
- "id": the assertion id
- "passed": true or false
- "evidence": quote or explanation of why it passed/failed

Respond with ONLY the JSON array, no markdown fences, no other text.
PROMPT
}

summarize_results() {
  echo ""
  echo "=== Eval Results ==="
  echo ""

  local total_with=0 passed_with=0 total_without=0 passed_without=0

  for skill_dir in "$RESULTS_DIR"/*/; do
    [ -d "$skill_dir" ] || continue
    local skill
    skill=$(basename "$skill_dir")

    for scenario_dir in "$skill_dir"*/; do
      [ -d "$scenario_dir" ] || continue
      local scenario
      scenario=$(basename "$scenario_dir")

      local with_pass with_total without_pass without_total
      with_pass=$(python3 -c "
import json
try:
    data = json.load(open('$scenario_dir/with_skill/grading.json'))
    print(sum(1 for a in data if a.get('passed')))
except: print(0)
" 2>/dev/null)
      with_total=$(python3 -c "
import json
try:
    data = json.load(open('$scenario_dir/with_skill/grading.json'))
    print(len(data))
except: print(0)
" 2>/dev/null)
      without_pass=$(python3 -c "
import json
try:
    data = json.load(open('$scenario_dir/without_skill/grading.json'))
    print(sum(1 for a in data if a.get('passed')))
except: print(0)
" 2>/dev/null)
      without_total=$(python3 -c "
import json
try:
    data = json.load(open('$scenario_dir/without_skill/grading.json'))
    print(len(data))
except: print(0)
" 2>/dev/null)

      printf "  %-20s %-25s  with: %s/%s  without: %s/%s\n" \
        "$skill" "$scenario" "$with_pass" "$with_total" "$without_pass" "$without_total"

      total_with=$((total_with + with_total))
      passed_with=$((passed_with + with_pass))
      total_without=$((total_without + without_total))
      passed_without=$((passed_without + without_pass))
    done
  done

  echo ""
  echo "  Totals:  with_skill: $passed_with/$total_with  without_skill: $passed_without/$total_without"

  if [ "$total_with" -gt 0 ] && [ "$total_without" -gt 0 ]; then
    local pct_with pct_without
    pct_with=$(python3 -c "print(f'{$passed_with/$total_with*100:.0f}%')")
    pct_without=$(python3 -c "print(f'{$passed_without/$total_without*100:.0f}%')")
    echo "  Pass rate:  with_skill: $pct_with  without_skill: $pct_without"
  fi

  echo ""
  echo "  Results saved to: $RESULTS_DIR"
}

# Main
echo "Duet Eval Runner"
echo "Model: $MODEL"
echo "Results: $RESULTS_DIR"
echo ""

for skill_dir in "$EVALS_DIR"/*/; do
  [ -d "$skill_dir" ] || continue
  skill=$(basename "$skill_dir")
  [ "$skill" = "results" ] && continue
  [ -n "$SKILL_FILTER" ] && [ "$skill" != "$SKILL_FILTER" ] && continue

  echo "[$skill]"
  for scenario_dir in "$skill_dir"*/; do
    [ -d "$scenario_dir" ] || continue
    scenario=$(basename "$scenario_dir")
    [ -f "$scenario_dir/task.md" ] || continue
    [ -n "$SCENARIO_FILTER" ] && [ "$scenario" != "$SCENARIO_FILTER" ] && continue

    run_scenario "$skill" "$scenario"
  done
done

summarize_results
