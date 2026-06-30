# Constructing a feedback loop

Ways to build a tight, red-capable loop for a hard bug, try them in roughly this
order, cheapest and tightest first. Adapted from mattpocock/skills `diagnosing-bugs` (MIT).

1. **Failing test** at whatever seam reaches the bug, unit, integration, e2e.
2. **Curl / HTTP script** against a running dev server.
3. **CLI invocation** with a fixture input, diffing stdout against a known-good snapshot.
4. **Headless browser script** (Playwright / Puppeteer), drives the UI, asserts on DOM/console/network.
5. **Replay a captured trace.** Save a real request / payload / event log to disk; replay it through the code path in isolation.
6. **Throwaway harness.** Spin up a minimal subset of the system (one service, mocked deps) that exercises the bug path with a single call.
7. **Property / fuzz loop.** For "sometimes wrong output", run 1000 random inputs and look for the failure mode.
8. **Bisection harness.** If the bug appeared between two known states (commit, dataset, version), automate "boot at state X, check, repeat" so you can `git bisect run` it.
9. **Differential loop.** Run the same input through old-version vs new-version (or two configs) and diff outputs.
10. **HITL bash script.** Last resort. If a human must click, drive _them_ with a structured loop so captured output still feeds back to you.

## Tighten the loop

Treat the loop as a product. Once you have _a_ loop, make it tight:

- **Faster**, cache setup, skip unrelated init, narrow the test scope.
- **Sharper**, assert on the specific symptom, not "didn't crash".
- **More deterministic**, pin time, seed RNG, isolate filesystem, freeze network.

A 30-second flaky loop is barely better than no loop; a 2-second deterministic one is a debugging superpower.

## Non-deterministic bugs

The goal is not a clean repro but a **higher reproduction rate**. Loop the trigger
100×, parallelise, add stress, narrow timing windows, inject sleeps. A 50%-flake bug
is debuggable; 1% is not, keep raising the rate until it is.

## When you genuinely cannot build a loop

Stop and say so explicitly. List what you tried. Ask the user for: (a) access to an
environment that reproduces it, (b) a captured artifact (HAR, log dump, core dump,
timestamped screen recording), or (c) permission to add temporary instrumentation.
Do **not** proceed to hypothesise without a loop.
