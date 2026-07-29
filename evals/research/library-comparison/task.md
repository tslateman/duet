Apply the /research skill. Pick our job queue library. Python, Django, Postgres already in the stack, no Redis today. About 40k jobs/day, mostly emails and PDF generation, plus one nightly reconciliation job that runs 40 minutes.

Here is what our staff engineer collected. Do not search further, synthesize this.

**Celery** (docs, v5.4, updated 2025-11): mature, huge install base. Requires a
broker; Redis or RabbitMQ recommended, and the docs mark the database broker as
deprecated and unsupported since v5.0. Rich feature set: chains, chords, retries,
scheduled tasks via Beat. Known operational sharp edges: worker prefetch and
visibility timeout interact badly with long tasks, and the maintainers say
long-running tasks are "not what Celery optimizes for".

**RQ** (docs, v2.0, updated 2026-01): simple, Redis-only, no broker choice. Very
small API. No built-in scheduling, needs rq-scheduler. Maintained but small team.

**django-q2** (docs, v1.7, updated 2026-03): community fork of django-q after the
original went unmaintained in 2023. Supports the Django ORM as its broker, so no
new infrastructure. Built-in scheduler and admin integration. Smaller community;
GitHub shows about 40 open issues, median close time roughly 3 weeks.

**Procrastinate** (docs, v3.0, updated 2026-02): Postgres-native, uses LISTEN and
NOTIFY. No extra infrastructure. Supports async and sync workers, retries, and
periodic tasks. Younger project; the docs themselves note the API was unstable
until v2.

**Internal note from platform team, 2026-04:** "We have no Redis in production
and adding one means a new on-call surface. Prefer Postgres-backed options."
