Vibe check this data import script.

```python
# scripts/import_transactions.py
import csv
import sqlite3
import os
import logging
from datetime import datetime

logger = logging.getLogger(__name__)

DB_PATH = os.environ.get("DB_PATH", "/tmp/transactions.db")


def process_row(row):
    amount = float(row["amount"])
    if amount > 10000:
        category = "high"
    elif amount > 1000:
        category = "medium"
    else:
        category = "low"

    date = datetime.strptime(row["date"], "%Y-%m-%d")
    description = row["description"][:255]

    return {
        "amount": amount,
        "category": category,
        "date": date.isoformat(),
        "description": description,
        "account": row["account_id"],
        "type": row.get("type", "debit"),
    }


def handle_data(filepath):
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS items (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            amount REAL, category TEXT, date TEXT,
            description TEXT, account TEXT, type TEXT
        )
    """)

    with open(filepath, "r") as f:
        reader = csv.DictReader(f)
        count = 0
        for row in reader:
            try:
                processed = process_row(row)
                cursor.execute(
                    "INSERT INTO items VALUES (NULL, ?, ?, ?, ?, ?, ?)",
                    (
                        processed["amount"],
                        processed["category"],
                        processed["date"],
                        processed["description"],
                        processed["account"],
                        processed["type"],
                    ),
                )
                count += 1
            except Exception:
                logger.warning("Skipped row")
                continue

    conn.commit()
    conn.close()
    print(f"Imported {count} items")


if __name__ == "__main__":
    import sys

    handle_data(sys.argv[1])
```
