# Profiling Checklist

A quick-reference companion to the performance SKILL.md.
Follow these steps in order. Skipping straight to optimization
is the most common mistake.

## Step 1: Define the Metric

Pick one metric. Write it down.

- **Latency:** P50, P95, P99 — which percentile matters?
- **Throughput:** Requests/sec, rows/sec, messages/sec
- **Memory:** Peak RSS, allocation rate, GC pause duration
- **Startup:** Time to first response, cold start cost

**Pitfall:** Optimizing "speed" without specifying a metric.
You'll chase the wrong bottleneck.

## Step 2: Establish a Baseline

Measure before changing anything. Record the number.

```bash
# Wall-clock timing
time ./your-command

# HTTP endpoint (repeat for stability)
hyperfine 'curl -s http://localhost:8080/endpoint'

# Benchmark suite
go test -bench=. -benchmem ./...
pytest --benchmark-only
```

**Pitfall:** Measuring once. Run at least three times. Discard
outliers. Report the median.

**Pitfall:** Measuring in a different environment than
production. Local SSD != network-attached storage.

## Step 3: Profile — Find Where Time Goes

Use the right profiler for the bottleneck type.

### CPU Profiling

```bash
# Go
go tool pprof -http=:8080 cpu.prof

# Node.js
node --prof app.js
node --prof-process isolate-*.log

# Python
python -m cProfile -s cumtime script.py
py-spy record -o profile.svg -- python script.py

# General (Linux)
perf record -g ./your-binary
perf report
```

### Memory Profiling

```bash
# Go
go tool pprof -http=:8080 mem.prof

# Node.js
node --inspect  # then Chrome DevTools → Memory tab

# Python
python -m tracemalloc
memray run script.py && memray flamegraph output.bin
```

### I/O and System Calls

```bash
# Linux
strace -c ./your-binary        # syscall summary
strace -e trace=network ./cmd  # network calls only

# macOS
dtruss -c ./your-binary
```

**Pitfall:** Using only a CPU profiler when the problem is I/O.
Low CPU usage + slow execution = I/O or contention bottleneck.

## Step 4: Read the Profile

Focus on the top of the list, not the bottom.

- **Flame graphs:** Wide bars are where time goes. Narrow
  bars are noise. Read top-down for call hierarchy,
  bottom-up for hot functions.
- **Flat profiles:** Sort by cumulative time first, then
  by self time. The function at the top of cumulative is
  the entry point; the top of self is the actual work.
- **Allocation profiles:** High allocation rate causes GC
  pressure even if peak memory is low.

**Pitfall:** Optimizing a function that takes 2% of total
time. Even a 10x improvement saves 1.8%. Find the 40%
function first.

## Step 5: Hypothesize One Change

State what you expect to happen and why.

Good: "Batching these N+1 queries into one query should
reduce latency by ~60% because the profile shows 65% of
wall time in database round-trips."

Bad: "I'll try caching and see if it helps."

**Pitfall:** Changing multiple things at once. If performance
improves, you won't know which change mattered.

## Step 6: Measure Again

Compare against the baseline from Step 2. Same conditions,
same methodology.

```bash
# Side-by-side benchmark comparison (Go)
benchstat before.txt after.txt

# hyperfine with comparison
hyperfine './old-binary' './new-binary'
```

**Pitfall:** Declaring victory on a single run. Use
statistical comparison. Look for P-values or confidence
intervals.

**Pitfall:** Ignoring regressions elsewhere. Faster P50
but worse P99 is often a bad trade.

## Step 7: Decide — Ship or Iterate

- **Meets the goal from Step 1?** Ship it.
- **Improved but not enough?** Return to Step 3.
- **No improvement?** Revert. Return to Step 3 with a
  different hypothesis.
- **Made it worse?** Revert immediately. Understand why
  before trying again.

## Common Tool Reference

| Language | CPU Profiler               | Memory Profiler          | Flame Graph        |
| -------- | -------------------------- | ------------------------ | ------------------ |
| Go       | `pprof`                    | `pprof` (allocs)         | `go tool pprof`    |
| Python   | `cProfile`, `py-spy`       | `tracemalloc`, `memray`  | `py-spy`           |
| Node.js  | `--prof`, `clinic`         | Chrome DevTools          | `clinic flame`     |
| Rust     | `perf`, `cargo-flamegraph` | `heaptrack`, DHAT        | `cargo flamegraph` |
| Java     | `async-profiler`, JFR      | JFR, VisualVM            | `async-profiler`   |
| C/C++    | `perf`, `valgrind`         | `valgrind --tool=massif` | `perf`             |

## Checklist Summary

1. Define one metric and a target value
2. Measure the baseline (three+ runs, median)
3. Profile with the right tool for the bottleneck type
4. Read the profile — find the biggest contributor
5. Hypothesize one change with an expected outcome
6. Measure again — same conditions, statistical comparison
7. Ship, iterate, or revert
