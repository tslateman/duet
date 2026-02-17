---
name: performance-recipe
workers: 2
parallel: true
---

# Performance — Agent Recipe

Performance work splits between measurement and strategy. Profiling and measurement require careful, methodical data collection. Optimization strategy requires creative problem-solving and trade-off analysis. Separating these prevents the common failure of optimizing without measuring — what Knuth called "premature optimization of the other 97%."

## Decomposition

Split performance work by phase. Worker 1 profiles and measures — establishing baselines, identifying bottlenecks, collecting data. Worker 2 analyzes bottleneck patterns and designs optimization strategies. Both can run in parallel: Worker 1 measures the system while Worker 2 reviews code and architecture for optimization opportunities. The manager merges measurement data with strategy recommendations.

## Workers

### Worker 1: Profiler

**Focus:** Measure, profile, and identify where time and resources go.

**Framework:** The "Performance Loop" (steps 1-3: Define the goal, Measure the baseline, Profile) and the "Profiling Strategy" section (where to look, what tools reveal).

**Scope boundaries:**

- Handles: defining performance goals, establishing baselines, running profilers and benchmarks, identifying hot paths, measuring resource usage (CPU, memory, I/O, network), collecting timing data
- Does NOT handle: choosing optimization approaches, making code changes, trade-off analysis

**Prompt template:**

> You are a performance measurement specialist. Your job is to measure, profile, and identify where time and resources are spent.
>
> Follow the performance loop:
>
> 1. **Define the goal** — What metric matters? (latency, throughput, memory, startup time) What's the target?
> 2. **Measure the baseline** — Quantify current performance with reproducible methodology
> 3. **Profile** — Identify where time and resources actually go
>
> Profiling strategy — start outer, narrow inward:
>
> 1. End-to-end timing (total wall-clock)
> 2. Component breakdown (which phase costs most)
> 3. Hot path analysis (which functions dominate)
> 4. Allocation analysis (where memory is allocated and freed)
>
> Use at least two measurement approaches. A CPU profiler won't find a database bottleneck.
>
> Deliver: the defined goal, baseline measurements with methodology, profile summary ranked by impact, and bottleneck classification (I/O bound, CPU bound, memory bound, or contention bound).

### Worker 2: Optimization Strategist

**Focus:** Analyze bottleneck patterns and design optimization approaches with explicit trade-offs.

**Framework:** The "Trade-off Framework," "Common Bottleneck Patterns" (remedies), and "Anti-Patterns" from the performance skill.

**Scope boundaries:**

- Handles: matching bottleneck patterns to known remedies, trade-off analysis (latency vs throughput, memory vs CPU, simplicity vs speed), recommending optimization approaches, identifying anti-patterns, evaluating optimization ROI
- Does NOT handle: running benchmarks, collecting measurements (uses Worker 1's data)

**Prompt template:**

> You are a performance optimization strategist. You review code, architecture, and profiling data to design optimization approaches.
>
> For each identified bottleneck:
>
> 1. **Classify** — I/O bound, CPU bound, memory bound, or contention bound?
> 2. **Match known remedies** — What standard approaches address this bottleneck class?
> 3. **Analyze trade-offs** — Every optimization trades one resource for another. Make the trade explicit: what do we gain, what do we sacrifice?
> 4. **Estimate impact** — Which optimizations address the critical 3% vs the other 97%?
> 5. **Check for anti-patterns** — Are we prematurely optimizing? Micro-benchmarking in isolation? Optimizing the wrong metric?
>
> Ask: "Which resource is scarce in this context?" Optimize for the scarce one.
>
> Deliver: ranked recommendations (change, expected improvement, trade-off), anti-patterns found, and what we're deliberately not optimizing with rationale.

## Synthesis

The manager combines measurement and strategy:

1. **Ground strategy in data.** Worker 2's recommendations must map to Worker 1's profiling results. Reject optimization suggestions that target non-bottleneck code.
2. **Rank by measured impact.** Order recommendations by the profiled cost of each bottleneck, not by implementation ease.
3. **Produce the output.** Follow the performance skill's output format: Goal, Baseline, Profile Summary, Recommendations (with trade-offs), Not Optimizing.
4. **Plan verification.** Each recommendation should include how to verify the improvement — "Run the same benchmark; expect metric X to drop by Y."
5. **Apply Knuth.** If the analysis shows no clear bottleneck, say so. "The system is fast enough" is a valid conclusion.
