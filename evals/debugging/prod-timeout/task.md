Apply the /debugging skill. Since Tuesday, roughly 2% of checkout requests return 504. It never happens in staging.

What we know:

- Started Tuesday around 14:00 UTC. Nobody deployed the API on Tuesday.
- The payment vendor's status page is green.
- Gateway timeout is 30s. Our app logs show the request handler completing in
  under 900ms for the same request IDs that the gateway reports as 504.
- The 504s cluster: about 80% land on 3 of our 12 pods.
- We added a read replica for the reporting service on Monday evening.
- One engineer says "it's the vendor, their sandbox was slow last month too"
  and wants to add a retry wrapper around the vendor call.

Tell me what's going on.
