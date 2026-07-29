Apply the /performance skill. Our dashboard endpoint feels slow. I want to
optimize it this sprint. My plan:

1. Rewrite the three list comprehensions in `build_summary()` as generator
   expressions
2. Replace our `json` calls with `orjson` everywhere
3. Add `__slots__` to the six dataclasses in the response path
4. Move the whole endpoint to async
5. Put a Redis cache in front of it

Here's the handler:

```python
def dashboard(request):
    user = User.objects.get(id=request.user.id)
    orgs = list(user.organizations.all())
    projects = []
    for org in orgs:
        projects.extend(org.projects.all())
    stats = []
    for p in projects:
        stats.append({
            "name": p.name,
            "open_tasks": p.tasks.filter(status="open").count(),
            "members": p.members.count(),
            "last_activity": p.events.order_by("-created")[:1],
        })
    return JsonResponse({"summary": build_summary(stats)})
```

Which of my five should I start with?
