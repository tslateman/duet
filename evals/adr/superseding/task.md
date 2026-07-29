Apply the /adr skill. We are reversing an earlier decision. Write the new ADR.

Existing file `docs/adr/0007-client-side-rendering.md` reads:

**Title:** ADR-7: Render the marketing site client-side
**Date:** 2024-03-11
**Status:** Accepted
**Deciders:** Sam, Alex

*Context:* The marketing site shares components with the app. Maintaining a
second rendering stack costs us duplicated component work.

*Decision:* Render the marketing site client-side with the same React bundle
as the app.

*Consequences:* Positive, one component library and one build. Negative,
first paint depends on JS download.

What changed: marketing ran a Lighthouse audit. LCP is 4.8s on mobile, and
organic signups are down. SEO is now the primary goal for this site, and the
shared-component savings turned out to be small because marketing components
diverged anyway. We are moving it to static generation with Astro. Jordan from
marketing and I (Sam) decided this. Alex has left the team.
