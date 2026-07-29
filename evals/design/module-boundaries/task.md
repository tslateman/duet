Apply the /design skill. Our `orders` module has become the thing everyone
is afraid to touch. Here is its shape:

```
orders/
  service.py       # 2,100 lines. imports from billing, inventory, notifications,
                   # analytics, and admin. also imported BY all five of those.
  models.py        # Order, OrderLine, and also Customer and Invoice
  globals.py       # CURRENT_TENANT, PRICING_RULES, FEATURE_FLAGS
                   # (module-level dicts, mutated at request time by middleware)
  utils.py         # 40 functions, no theme
  legacy_v1.py     # still called by the mobile API, "do not touch" comment from 2022
```

Facts:
- `billing` calls `orders.service.recalculate()`, which calls back into
  `billing.apply_discount()`.
- Anything reading `PRICING_RULES` breaks in tests unless middleware ran first.
- Two teams own parts of this. Neither owns `utils.py`.

How should this be structured?
