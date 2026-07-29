Apply the /adr skill. Write the ADR for this decision. Our repo already has `docs/adr/0001-use-postgres.md` and `docs/adr/0002-monorepo-layout.md`.

Here is the Slack thread the decision came out of:

> **maya**: we need something between the API and the billing worker. right now billing runs inline in the request and P99 is 4s
> **dev**: RabbitMQ? we all know it
> **maya**: we're already on AWS. SQS is zero ops for us, no broker to babysit
> **dev**: SQS has no priority queues though. and the 15min visibility timeout cap is real, our reconciliation job runs 40min
> **maya**: we can chunk reconciliation. or run that one on its own path
> **priya**: Kafka? we'll want an event log eventually anyway
> **dev**: nobody here has run Kafka. that's a whole platform team
> **priya**: fair. and we'd be using 5% of it
> **maya**: so SQS + chunk the long job. we accept no-priority-queues, if we need priority we add a second queue
> **dev**: ok. and if we outgrow it we revisit, migration is a worker-side change not an API change
> **priya**: agreed. maya to write it up. decision is ours (maya, dev, priya), Tom signed off async
