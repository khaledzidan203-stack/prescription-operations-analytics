# Testing Strategy

## Automated analytical tests

Run:

```bash
python -m pytest -q
```

The suite validates:

- KPI behavior and N/A-versus-zero semantics;
- committed analytics sample row counts;
- record uniqueness;
- current KPI baseline;
- channel totals;
- monthly trend reconciliation;
- shortage aggregation;
- required columns and controlled statuses;
- positive quantities and valid references in the generic synthetic governance sample;
- publication-safety rules;
- relative Markdown links.

## Current analytics baseline

The committed `data/sample/` fixtures are validated against:

- 500 records;
- 1,185 item lines;
- 49 shortage rows;
- 8 branches;
- 12 items;
- 372 Done;
- 128 Not Yet;
- 74.4% completion;
- SAR 82,760.75 known value;
- 47 N/A-value records;
- 158 Delivered;
- 126 shortage units;
- 24 affected shortage records.

## Reproducibility statement

The current `data/sample/` files are committed synthetic fixtures.

No generator for this specific dataset is retained in the repository, so the project does **not** claim fixed-seed regeneration of these files.

The separate `sample-data/` governance examples are hand-constructed synthetic fixtures with their own publication-safety tests.
