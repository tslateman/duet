Apply the /mermaid skill. Draw our refund lifecycle for the ops runbook.

A refund starts as `requested`. An ops reviewer either approves it (to
`approved`) or rejects it (to `rejected`, terminal). Approved refunds are
submitted to the payment processor, moving to `submitted`. The processor
webhook moves it to `settled` (terminal) or `failed`. A `failed` refund can be
resubmitted, going back to `submitted`, up to 3 times; after the third failure
it moves to `abandoned` (terminal). A `requested` refund the reviewer never
touches for 30 days auto-expires to `abandoned`.
