Apply the /debugging skill. This test fails maybe 1 in 20 CI runs and never locally.

```python
# tests/test_export.py
import pytest
from app.export import build_export, EXPORT_CACHE


@pytest.fixture
def sample_rows():
    return [{"id": 1, "name": "a"}, {"id": 2, "name": "b"}]


def test_export_includes_all_rows(sample_rows):
    result = build_export(sample_rows)
    assert len(result["rows"]) == 2
    assert result["generated_at"] is not None


def test_export_caches_by_signature(sample_rows):
    first = build_export(sample_rows)
    second = build_export(sample_rows)
    assert first is second
    assert len(EXPORT_CACHE) == 1
```

```python
# app/export.py
import datetime

EXPORT_CACHE = {}


def build_export(rows):
    signature = f"{len(rows)}-{datetime.date.today()}"
    if signature in EXPORT_CACHE:
        return EXPORT_CACHE[signature]
    export = {"rows": list(rows), "generated_at": datetime.datetime.now()}
    EXPORT_CACHE[signature] = export
    return export
```

CI runs pytest with `-n 4` (pytest-xdist). Someone already suggested adding
`@pytest.mark.flaky(reruns=3)`. Should we?
