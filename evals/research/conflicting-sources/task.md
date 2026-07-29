Apply the /research skill. Settle this: can we rely on Postgres `LISTEN`/`NOTIFY` for our worker wakeups, or do we need polling as well?

Sources gathered, do not search further:

**A.** Stack Overflow answer, 412 upvotes, posted 2016, no edits: "NOTIFY is
fully reliable, the payload is delivered to every listener in the transaction.
You do not need polling."

**B.** Postgres official docs, current: notifications are delivered to listening
sessions; a session that is not connected at NOTIFY time never receives it.
There is a queue size limit (8GB default) and NOTIFY can fail if it fills.

**C.** Blog post, undated, no author, heavy affiliate links to a hosted Postgres
vendor: "LISTEN/NOTIFY is the fastest queue in the world, 10x Redis."

**D.** GitHub issue thread on a Postgres-backed job library, 2025, maintainer
replying: "We keep a low-frequency poll alongside LISTEN specifically because
listeners miss notifications across reconnects, failover, and connection pool
recycling. LISTEN is the latency optimization, the poll is the correctness
guarantee."

**E.** AWS RDS documentation, current: notes that during a failover, all existing
connections are dropped.
