Apply the /excalidraw skill. I need an architecture diagram for the Q3 deck.

Our system: a React web client and an iOS app both talk to an API gateway. The
gateway fans out to three services, auth, catalog, and orders. Auth and orders
share a Postgres cluster. Catalog reads from Elasticsearch, which a nightly
indexer populates from the same Postgres. Orders publishes to an SQS queue that
a fulfilment worker consumes.

Save it as `architecture.excalidraw`.
