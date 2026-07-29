Apply the /ia skill. Review our docs tree for findability problems.

```
docs/
  index.md              links to: getting-started, api, misc
  getting-started.md    links to: api
  api.md                links to: index
  misc.md               (grab bag: rate limits, SLAs, deprecation policy)
  stuff/
    notes.md            (production runbook for the payments outage playbook)
    old.md              (v1 migration guide, still accurate, still needed)
    tmp-2.md            (webhook signature verification reference)
  advanced/
    index.md            not linked from anywhere
    tuning.md
    internals.md
```

Support says the top three tickets are "how do I verify a webhook signature",
"what are the rate limits", and "how do I migrate from v1".
