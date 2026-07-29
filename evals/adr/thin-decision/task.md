Apply the /adr skill. Turn this into an ADR.

Commit message from last week:

```
feat: switch session storage to Redis

Moved sessions out of the Postgres sessions table into Redis.
Sessions now expire via TTL instead of the nightly cleanup job.
```

That's all I have. The engineer who did it left the company.
