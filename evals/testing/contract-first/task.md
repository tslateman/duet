Apply the /testing skill. How should I test this? It is the only thing standing between a customer and a double charge.

```python
def capture_payment(order_id: str, amount_cents: int, idempotency_key: str) -> Capture:
    existing = captures.find_by_key(idempotency_key)
    if existing:
        return existing
    order = orders.get(order_id)
    if order.status != "authorized":
        raise InvalidOrderState(order.status)
    if amount_cents > order.authorized_cents:
        raise AmountExceedsAuthorization(amount_cents, order.authorized_cents)
    result = gateway.capture(order.auth_token, amount_cents)
    capture = captures.insert(
        order_id=order_id, amount=amount_cents,
        key=idempotency_key, gateway_ref=result.reference,
    )
    orders.mark_captured(order_id)
    return capture
```

`gateway.capture` is a third-party HTTP call. It can time out after having
actually succeeded on their side.
