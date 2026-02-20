---
name: performance
user-invocable: false
description: Profiling methodology and optimization strategy for performance work. Use when the user asks to "make this faster", "optimize", "profile", "reduce latency", "fix slow", "improve throughput", or when investigating performance regressions.
---

# Performance as Measurement

## Overview

Optimize what you've measured, not what you suspect. Performance work without profiling is superstition. Measure first, hypothesize second, optimize third, measure again.

## The Performance Loop

1. **Define the goal** — What metric matters? Latency, throughput, memory, startup time?
2. **Measure the baseline** — Quantify current performance with reproducible benchmarks
3. **Profile** — Identify where time and resources actually go
4. **Hypothesize** — What change would improve the bottleneck?
5. **Optimize** — Make one change
6. **Measure again** — Did it help? By how much? Any regressions elsewhere?

Never skip from step 1 to step 5.

## Trade-off Framework

Every optimization trades one resource for another. Make the trade explicit.

| Trade-off              | Example                                                  |
| ---------------------- | -------------------------------------------------------- |
| Latency vs. throughput | Batching increases throughput, raises individual latency |
| Memory vs. CPU         | Caching trades memory for fewer computations             |
| Simplicity vs. speed   | Hand-rolled loops beat abstractions but obscure intent   |
| Startup vs. runtime    | Lazy loading delays startup cost to first use            |
| Bandwidth vs. latency  | Compression saves bandwidth, costs CPU time              |
| Consistency vs. speed  | Eventual consistency is faster than strong consistency   |

Ask: "Which resource is scarce in this context?" Optimize for the scarce one.

## Profiling Strategy

### Where to Look

Start with the outermost measurement, narrow inward:

1. **End-to-end timing** — Total wall-clock time for the operation
2. **Component breakdown** — Which phase takes the most time?
3. **Hot path analysis** — Which functions dominate the profile?
4. **Allocation analysis** — Where is memory allocated and freed?

### What Tools Reveal

| Tool type        | Reveals               | Misses                     |
| ---------------- | --------------------- | -------------------------- |
| Wall-clock timer | Total duration        | Where time is spent        |
| CPU profiler     | Hot functions         | I/O waits, lock contention |
| Memory profiler  | Allocations, leaks    | Cache effects              |
| Flame graph      | Call hierarchy costs  | Inlined functions          |
| Tracing          | Request flow, latency | Aggregate behavior         |
| Load testing     | Throughput limits     | Root cause of limits       |

Use at least two tool types. A CPU profiler won't find a database bottleneck.

## Common Bottleneck Patterns

### I/O Bound

**Symptoms:** Low CPU usage, high wait times, slow under load.

**Causes:** Synchronous I/O, N+1 queries, unbatched requests, no connection pooling.

**Remedies:** Batch operations, add caching, use async I/O, pool connections.

### CPU Bound

**Symptoms:** High CPU usage, scales with input size, unaffected by I/O improvements.

**Causes:** Inefficient algorithms, unnecessary computation, poor data structures.

**Remedies:** Better algorithms first (O(n) beats optimized O(n^2)), then micro-optimize the hot path.

### Memory Bound

**Symptoms:** Growing memory usage, GC pauses, OOM errors, cache thrashing.

**Causes:** Unbounded caches, leaked references, large intermediate allocations, fragmentation.

**Remedies:** Bound caches (LRU), stream instead of buffer, pool allocations, reduce object size.

### Contention Bound

**Symptoms:** Low individual resource usage but poor throughput under concurrency.

**Causes:** Lock contention, shared mutable state, thread pool exhaustion, connection limits.

**Remedies:** Reduce critical section scope, use lock-free structures, partition state, increase pool size.

## Anti-Patterns

**Premature optimization** — Optimizing before measuring. The bottleneck is never where you think.

**Micro-benchmarking in isolation** — Benchmarking a function outside its real context misses cache effects, GC pressure, and contention.

**Optimizing the wrong metric** — Reducing P50 latency when users complain about P99. Improving throughput when the problem is startup time.

**Death by a thousand cuts** — No single bottleneck, just accumulated inefficiency. Profile holistically, not function-by-function.

**Caching without invalidation strategy** — Cache speeds reads but stale data causes correctness bugs. Define TTL and invalidation before adding a cache.

## Output Format

When analyzing performance:

```markdown
## Performance Analysis

### Goal

[Specific metric and target: "Reduce API P99 latency from 800ms to 200ms"]

### Baseline

[Current measurements with methodology]

### Profile Summary

[Where time/memory/resources go, ranked by impact]

### Recommendations

1. [Change] — [Expected improvement] — [Trade-off]
2. [Change] — [Expected improvement] — [Trade-off]

### Not Optimizing

[What was considered but rejected, and why]
```

## Knuth's Reminder

"Programmers waste enormous amounts of time thinking about, or worrying about, the speed of noncritical parts of their programs, and these attempts at efficiency actually have a strong negative impact when debugging and maintenance are considered."

Optimize the critical 3%, not the other 97%.

## See Also

- `/debugging` — Performance regressions are bugs; profiling is debugging for speed
- `skills/FRAMEWORKS.md` — Full framework index
- `RECIPE.md` — Agent recipe for parallel decomposition (2 workers)
