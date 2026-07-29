Apply the /mermaid skill. Put our entire order pipeline in one diagram for the architecture doc.

The pieces: web checkout, mobile checkout, and the partner API all create orders.
Orders go through validation, fraud scoring, inventory reservation, payment
authorization, payment capture, warehouse dispatch, carrier handoff, tracking
sync, delivery confirmation, and settlement. Fraud scoring can route to manual
review. Inventory reservation can fail to backorder. Payment authorization can
soft-decline into a retry queue. Warehouse dispatch splits into three fulfilment
centers. Returns re-enter at the settlement stage. There is also a nightly
reconciliation job that touches settlement and a webhook consumer that touches
tracking sync.

One diagram, everything on it.
