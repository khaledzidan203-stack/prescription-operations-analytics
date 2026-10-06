# Case Study — Prescription Operations Analytics

## Context

Distributed prescription operations can be difficult to monitor when records are spread across branches, channels, item lines and unresolved requirements.

This synthetic project models a compact analytical companion that measures completion, backlog, known versus unknown value, channel performance, monthly throughput and open shortage/resource requirements.

## Analytics dataset

The implemented analytics companion uses `data/sample/`:

- 500 operational records;
- 1,185 record-item lines;
- 49 shortage rows;
- 8 fictional branches;
- 12 synthetic items;
- 253 synthetic customer keys.

The current committed sample contains 372 Done records and 128 Not Yet records.

## KPI design

The central KPIs are:

- Total Records
- Done Records
- Not Yet Records
- Completion Rate
- Known Record Value
- Value N/A Records
- Delivered Records
- Open Shortage Quantity
- Records Affected by Shortages

Unknown value remains distinct from true zero.

## Current baseline

The committed synthetic analytics sample produces:

- Total Records: 500
- Done Records: 372
- Not Yet Records: 128
- Completion Rate: 74.4%
- Known Record Value: SAR 82,760.75
- Value N/A Records: 47
- Delivered Records: 158
- Open Shortage Quantity: 126 units
- Records Affected by Shortages: 24

Channel distribution:

- Standard: 310 records
- Call-Back: 109 records
- Pickup: 81 records

## Analytical architecture

The same analytics dataset is used by:

- pandas analytical functions;
- the Streamlit / Plotly application;
- SQL Server-compatible schema, views and KPI queries;
- the Power BI design blueprint.

This keeps the implemented analytical story separate from the broader generic governance model.

## Generic governance layer

The repository also contains a separate hand-constructed synthetic governance model under `sample-data/` and the detailed `docs/` architecture/workflow folders.

That layer demonstrates reusable concepts such as fictional workflow categories, site isolation, transfer lineage, security, historical snapshots and release governance.

It is not the dataset used by the Streamlit application.

## Publication-safety design

The repository treats privacy-safe publication as part of engineering quality.

Controls include:

- prohibited file-extension checks;
- private terminology checks;
- realistic identity-pattern checks;
- internal-host and secret-pattern checks;
- synthetic identifier validation;
- relationship validation;
- Markdown-link validation;
- release gates and manual-review guidance.

## Outcome

The project demonstrates a two-layer design:

**Operational Analytics Companion**
→ record throughput → completion/backlog → channel performance → shortage requirements → action-oriented reporting

**Generic Governance Model**
→ synthetic workflows → security → lineage → data quality → publication controls

The separation makes the project easier to understand without weakening its privacy boundary.
