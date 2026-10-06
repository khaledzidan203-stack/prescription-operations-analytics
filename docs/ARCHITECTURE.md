# Analytics Architecture

## Purpose

This document describes the **implemented analytics companion** built from the synthetic files in `data/sample/`.

The broader fictional governance architecture is documented separately under `docs/architecture/`.

## Logical layers

```text
Committed Synthetic Analytics CSV
        ↓
Data Quality & Type Handling
        ↓
Record / Item / Shortage Model
        ↓
pandas Analytical Functions
        ↓
┌──────────────────┬──────────────────┐
│ Streamlit/Plotly │ SQL Server Model │
│ interactive app  │ views + queries  │
└──────────────────┴──────────────────┘
        ↓
Power BI Design Blueprint
        ↓
KPI / Data Quality / Resource-Requirement Analysis
```

## Analytics components

- `FactRecord` — one operational record.
- `FactRecordItem` — one item line within a record.
- `FactShortage` — one shortage requirement for a record/branch/item.
- `DimBranch` — one fictional branch.
- `DimItem` — one synthetic item.

## Shared design rules

- Keep fact grains explicit.
- Preserve unknown numeric values as N/A.
- Do not inflate record counts through item-line joins.
- Use historical item-line price snapshots for historical line value.
- Aggregate shortage demand by Item + Branch.
- Count affected records distinctly.
- Reconcile Python, SQL and any future Power BI runtime against the same KPI definitions.

## Governance model boundary

The separate `sample-data/` and detailed workflow/security documents demonstrate generic synthetic governance patterns such as fictional workflow categories, site isolation, transfer lineage and release gates.

They are not loaded by the analytics application.

See [Analytics Dataset Boundary](ANALYTICS_DATASET_BOUNDARY.md).
