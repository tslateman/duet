Apply the /debugging skill. PDF invoice totals are wrong: they render as `$1,234.00` when the value is `1234.5` (the cents get dropped). It was right in v2.14.0 and wrong in v2.15.0.

Between those tags there are 214 commits from 9 people. The diff touches:

- `billing/format.py` (currency formatting)
- `billing/pdf.py` (renderer)
- `requirements.txt` (12 dependency bumps, including `babel 2.12.1 -> 2.14.0`)
- 180-odd commits in unrelated areas (auth, admin UI, migrations)

I have a script `repro.sh` that renders one invoice and prints the total. It
exits 0 on the correct value and 1 on the wrong one. Where do I start?
