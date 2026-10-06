# Analytics Dataset and Governance Model Boundary

The repository intentionally contains **two separate synthetic layers**.

## Layer A — Analytics Companion

Location:

`data/sample/`

Used directly by:

- `src/analytics.py`
- `src/data_quality.py`
- `app.py`
- SQL analytical companion
- analytics regression tests
- current Power BI design blueprint

Files:

- `records.csv`
- `record_items.csv`
- `shortages.csv`
- `branches.csv`
- `items.csv`

This layer uses Branch / Channel / Done / Not Yet / Shortage terminology and supports the current executable analytics application.

## Layer B — Generic Governance Model

Location:

`sample-data/`

Used by the broader documentation and publication-governance examples.

It demonstrates:

- fictional Workflow Alpha / Beta / Gamma categories;
- synthetic sites;
- synthetic subjects;
- generic exceptions;
- transfer lineage;
- configurable workflow concepts;
- security and site-isolation patterns.

This layer is hand-constructed synthetic reference data and is not loaded by `app.py`.

## Why they remain separate

Combining them would imply relationships and workflow mappings that the public project does not claim.

The separation protects three things:

1. **Analytical clarity** — the Streamlit/SQL companion has one coherent schema.
2. **Governance clarity** — the broader software-engineering examples remain generic.
3. **Publication safety** — no reverse mapping from fictional governance labels to any private operating terminology is introduced.

## Rule for future changes

A new feature must state which layer it belongs to.

Do not silently join the two datasets or imply that their labels represent the same process.
