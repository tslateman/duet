---
name: diagnose
description: Systematic debugging that applies the scientific method to failures. Use when the user says "debug this", "why is this failing", "help me find the bug", "this doesn't work", "track down the issue", or is stuck on a problem and thrashing without progress.
---

# Systematic Debugging

## Overview

Apply the scientific method to software failures. Observe before theorizing. Form hypotheses, design experiments, narrow the cause. Refuse to jump to fixes until the cause is isolated.

## The Scientific Debugging Loop

1. **Observe** — What exactly happens? What did you expect?
2. **Hypothesize** — What could cause this specific discrepancy?
3. **Predict** — If the hypothesis is true, what else must be true?
4. **Test** — Design the smallest experiment that confirms or refutes
5. **Conclude** — Update understanding, repeat from step 2 if refuted

Never skip from Observe to Fix. The loop exists because human intuition about bug causes is wrong more often than right.

## Agans' 9 Rules

Apply these rules in order. Most debugging failures trace to violating one of the first three.

1. **Understand the System** — Read the docs, read the code, know what it's _supposed_ to do before deciding what's wrong
2. **Make It Fail** — Reproduce consistently. If you can't reproduce it, you can't confirm you fixed it
3. **Quit Thinking and Look** — Observe actual behavior. Print statements, debuggers, logs. Stop guessing
4. **Divide and Conquer** — Binary search the problem space. Narrow where the failure starts
5. **Change One Thing at a Time** — One variable per experiment. Otherwise you learn nothing
6. **Keep an Audit Trail** — Write down what you tried and what happened. Memory lies
7. **Check the Plug** — Verify the obvious. Wrong environment? Stale build? Wrong branch?
8. **Get a Fresh View** — Explain the problem aloud. The explanation often reveals the assumption
9. **If You Didn't Fix It, It Ain't Fixed** — Coincidence is not causation. Verify the fix addresses the root cause

See `references/nine-rules.md` for detailed application of each rule.

## Debugging Workflow

### 1. Gather Facts

Before forming any hypothesis:

```
- What is the exact error message or unexpected behavior?
- When did it start? What changed?
- Does it reproduce consistently?
- What is the smallest reproduction case?
```

### 2. Form Hypotheses

List every plausible cause. Rank by:

- **Likelihood** — What usually causes this class of failure?
- **Testability** — Which hypothesis can you disprove fastest?

Start with the most testable, not the most likely. Fast elimination beats slow confirmation.

### 3. Design Experiments

Each experiment should:

- Test exactly one hypothesis
- Have a clear pass/fail criterion _before_ running it
- Be the smallest possible change

### 4. Narrow with Delta Debugging

When the cause lives in a large change:

1. Find a known-good state and a known-bad state
2. Binary search the difference (commits, config changes, code blocks)
3. Reduce to the minimal change that introduces the failure

### 5. Document the Diagnosis

```markdown
## Bug

[What happened vs what was expected]

## Root Cause

[The specific defect and why it produced this symptom]

## Evidence

[What experiments confirmed this, what was ruled out]

## Fix

[The change and why it addresses the root cause]

## Prevention

[What would catch this earlier next time]
```

## Anti-Patterns

**Shotgun debugging** — Changing multiple things at once hoping something works. You'll never know what fixed it, or if it's actually fixed.

**Debugging by coincidence** — "It works now" without understanding why. The bug is still there.

**The usual suspects** — Blaming the framework, the OS, the compiler. It's almost always your code.

**Rubber ducking without listening** — Explaining the problem but not hearing your own assumptions. Slow down at the part that feels obvious.

**Fix and forget** — Fixing the symptom without asking why the system allowed this failure in the first place.

## Output Quality

A good diagnosis:

- Identifies the root cause, not just the symptom
- Explains the causal chain from defect to failure
- Provides evidence that eliminates alternatives
- Suggests how to prevent recurrence

## See Also

- `/testing` — Test failures trigger debugging; debugging reveals missing tests
- `/performance` — Performance regressions are bugs; profiling is debugging for speed
- `/review` — Reviews catch bugs before they need debugging
- `skills/FRAMEWORKS.md` — Full framework index
- `RECIPE.md` — Agent recipe for parallel decomposition (2 workers)
