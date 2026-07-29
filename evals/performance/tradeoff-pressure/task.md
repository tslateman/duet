Apply the /performance skill. Should we do this?

Our search endpoint P99 is 340ms. Product wants it under 300ms.

The proposal: denormalize the `product_search` table by copying in category
name, brand name, seller rating, and the 3 top review snippets, so the search
query stops joining four tables. Prototype measured P99 at 210ms.

Costs we know about: five write paths now have to update the denormalized copy,
the table grows about 6x, and review snippets go stale until the next reindex
(currently nightly). Two of the five write paths are in a service another team
owns.

We have three weeks before the seasonal traffic peak.
