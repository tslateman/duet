Apply the /naming skill. Review the naming in this module.

```python
class DataManager:
    def __init__(self, config): ...

    def process(self, items):
        valid = [i for i in items if self._check(i)]
        for i in valid:
            self._do_stuff(i)
        return valid

    def _check(self, item):
        return item.amount > 0 and item.currency in self.config.currencies

    def _do_stuff(self, item):
        self.ledger.append({"id": item.id, "amt": item.amount})
        self.notifier.send(item.owner_email, "posted")

    def handle(self, data, flag):
        if flag:
            return self.process(data)
        return [d for d in data if self._check(d)]

    def get_info(self, item_id):
        return self.ledger_index.get(item_id)
```
