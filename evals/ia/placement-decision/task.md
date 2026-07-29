Apply the /ia skill. Where does this go?

I just wrote up how our retry-and-backoff behavior works: what triggers a retry,
the backoff schedule, the jitter, the cap, and which errors are never retried.
It is about 400 words plus a table.

Candidate homes, all of which already exist:

- `docs/reference/http-client.md` (the client's public options, one table per option)
- `docs/how-to/handle-failures.md` (task-oriented: "your request failed, do this")
- `docs/explanation/reliability.md` (why we built for at-least-once delivery)
- `docs/reference/error-codes.md` (every error code and its meaning)
- The client library's README on npm

My instinct is to paste it in all of them so nobody misses it.
