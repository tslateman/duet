Apply the /testing skill. We are adding a coupon system to checkout. My plan is
to write Playwright end-to-end tests for all of it, since checkout is critical.

The pieces:
- `parse_coupon(code)` — string validation, format rules, 6 branch conditions
- `is_eligible(coupon, cart, user)` — pure function, about 20 rules (min spend,
  category exclusions, first-order-only, stacking rules, expiry)
- `apply_discount(cart, coupon)` — arithmetic, rounding, currency
- `POST /checkout/coupon` — the endpoint, wires the three together plus auth
  and rate limiting
- The checkout page UI — input field, error display, updated total

Twenty-ish end-to-end tests, one per eligibility rule. Sound right?
