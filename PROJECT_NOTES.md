# Project Notes

## Purpose

Prescription Operations Analytics demonstrates a privacy-safe, synthetic operational analytics companion alongside a separate generic workflow-governance model.

## Two-layer design

### Analytics companion

The executable analytical layer uses `data/sample/` and focuses on:

- record throughput;
- Done / Not Yet status;
- completion rate;
- channel and branch context;
- known versus unknown value;
- monthly trends;
- shortage / resource requirements;
- operational detail.

Implemented technologies include pandas, Streamlit, Plotly and SQL Server-compatible analytical scripts.

### Generic governance model

The separate `sample-data/` layer demonstrates:

- fictional workflow categories;
- site-scoped concepts;
- security patterns;
- transfer lineage;
- historical snapshots;
- data-quality rules;
- publication release gates.

It is intentionally independent from the analytics companion dataset.

## Design principles

1. **Synthetic data only** — no real customer, patient, employee or operational records.
2. **N/A is not zero** — unknown numeric value remains analytically distinct.
3. **Explicit grain** — record, item-line and shortage facts are not collapsed into one table.
4. **Action-oriented shortage aggregation** — Item + Branch with distinct affected-record count.
5. **Historical value preservation** — item-line price snapshots remain separate from current item-master price.
6. **Publication safety by design** — automated scans, allow/deny lists, sanitization guidance and release gates.
7. **No reverse mapping** — fictional governance terminology must never be mapped back to private terminology.
8. **Evidence-aware presentation** — Power BI is a blueprint only, and no real dashboard screenshots are claimed.

## Current implementation boundary

The Streamlit source is implemented but is not deployed from this repository.

SQL Server-compatible source is committed but SQL runtime execution is not performed in GitHub Actions.

Power BI is documentation/design only.
