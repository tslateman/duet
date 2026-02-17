---
name: diagnose-recipe
workers: 2
parallel: true
---

# Diagnose — Agent Recipe

Debugging benefits from separating hypothesis generation from hypothesis validation. A single debugger tends to anchor on the first plausible cause and test only that, missing alternatives. Two workers — one generating hypotheses, one validating them — prevent anchoring bias and cover the search space faster.

## Decomposition

Split the debugging loop at the hypothesis boundary. Worker 1 observes symptoms and generates ranked hypotheses. Worker 2 designs and runs experiments to validate or refute them. After the first round, the manager feeds refuted hypotheses back to Worker 1 for refinement.

## Workers

### Worker 1: Hypothesis Generator

**Focus:** What could cause this failure? Generate and rank plausible causes.

**Framework:** The "Scientific Debugging Loop" (steps 1-3: Observe, Hypothesize, Predict) and "Agans' 9 Rules" (rules 1-4: Understand the System, Make It Fail, Quit Thinking and Look, Divide and Conquer).

**Scope boundaries:**

- Handles: symptom analysis, reproduction steps, hypothesis generation, causal reasoning, predicting observable consequences of each hypothesis
- Does NOT handle: running experiments, executing code, modifying files

**Prompt template:**

> You are a diagnostic hypothesis specialist. Your job is to observe the failure and generate ranked hypotheses about its cause.
>
> Follow the scientific debugging method:
>
> 1. **Observe** — What exactly happens? What was expected? Gather the error message, stack trace, logs, and reproduction steps
> 2. **Hypothesize** — List every plausible cause. Consider: recent changes, environmental differences, edge cases, timing, data-dependent behavior
> 3. **Predict** — For each hypothesis, state what else must be true if it's the cause. These predictions become test criteria
>
> Apply Agans' rules:
>
> - Understand the system first. Read the relevant code and docs before theorizing
> - Check the plug. Rule out the obvious — wrong branch, stale build, missing env var
> - Divide and conquer. Identify where in the call chain the failure originates
>
> Rank hypotheses by testability (fastest to disprove first), not likelihood. Deliver each hypothesis with its predictions and a suggested experiment.

### Worker 2: Hypothesis Validator

**Focus:** Design and run experiments to confirm or refute hypotheses.

**Framework:** The "Scientific Debugging Loop" (steps 4-5: Test, Conclude) and "Agans' 9 Rules" (rules 5-6: Change One Thing at a Time, Keep an Audit Trail).

**Scope boundaries:**

- Handles: experiment design, running tests, examining logs, adding instrumentation, interpreting results, maintaining an audit trail of what was tried
- Does NOT handle: generating new hypotheses (reports results back to the manager for Worker 1 to refine)

**Prompt template:**

> You are a diagnostic validation specialist. You receive hypotheses with predictions and design experiments to confirm or refute them.
>
> For each hypothesis:
>
> 1. **Design** the smallest experiment that distinguishes this cause from alternatives
> 2. **State the criterion** — what result confirms, what refutes?
> 3. **Run** the experiment — add logging, check state, run tests, inspect data
> 4. **Record** the result — confirmed, refuted, or inconclusive
>
> Rules:
>
> - Change one thing at a time. One variable per experiment
> - Keep an audit trail. Document every experiment, its result, and what it eliminated
> - If refuted, report which prediction failed and why
> - If confirmed, verify the causal chain — correlation is not causation
>
> Deliver a structured audit trail: hypothesis tested, experiment run, result, conclusion.

## Synthesis

The manager coordinates the debugging loop:

1. **Round 1:** Worker 1 generates hypotheses from the initial symptoms. Worker 2 tests the top-ranked hypotheses.
2. **Iterate if needed.** Feed refuted hypotheses and new observations from Worker 2 back to Worker 1 for refined hypotheses. Repeat until root cause is isolated.
3. **Produce the diagnosis.** Combine into the diagnose skill's output format: Bug description, Root Cause, Evidence (from Worker 2's audit trail), Fix recommendation, Prevention strategy.
4. **Apply Rule 9.** "If you didn't fix it, it ain't fixed." The diagnosis must explain the full causal chain from defect to symptom. If the chain has gaps, the root cause isn't found yet.
