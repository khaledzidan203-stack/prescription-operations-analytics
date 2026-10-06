# Prescription Operations Analytics

## Synthetic Multi-Branch Operations Intelligence & Publication-Safe Governance

[![Analytical Validation](https://github.com/khaledzidan203-stack/prescription-operations-analytics/actions/workflows/docs-validation.yml/badge.svg)](https://github.com/khaledzidan203-stack/prescription-operations-analytics/actions/workflows/docs-validation.yml)
[![Publication Safety](https://github.com/khaledzidan203-stack/prescription-operations-analytics/actions/workflows/security-scan.yml/badge.svg)](https://github.com/khaledzidan203-stack/prescription-operations-analytics/actions/workflows/security-scan.yml)

Prescription Operations Analytics is a synthetic operational-analytics project for measuring record throughput, completion, backlog, channel performance, known-versus-unknown value, monthly trends and open shortage/resource requirements across a fictional multi-branch network.

The repository also contains a **separate generic workflow-governance model** that demonstrates site isolation, security, transfer lineage, historical snapshots, configurable workflow concepts and publication-safety controls.

> **Privacy boundary:** all records, identifiers, branches, items, customer keys, values, dates and workflow examples are synthetic. No real patient, customer, employee, company, prescription, production-system or confidential operational data is included.

<img src="docs/assets/Prescription%20Operations%20Analytics%20Dashboard.png" alt="Prescription Operations Analytics overview" width="100%">

> **Visual evidence note:** the image above is a presentation schematic, not a captured Streamlit session. Exact tool status and KPI values are governed by the source files, automated tests and evidence map.

**Start here:** [Case study](docs/CASE_STUDY.md) · [Technical walkthrough](docs/TECHNICAL_WALKTHROUGH.md) · [Evidence map](docs/PROJECT_EVIDENCE_MAP.md) · [Project index](docs/PROJECT_INDEX.md) · [Final validation](docs/FINAL_RELEASE_VALIDATION.md)

## Project at a glance

| Area | Current implementation |
|---|---|
| Primary analytics dataset | `data/sample/` committed synthetic fixtures |
| Records | 500 |
| Record-item lines | 1,185 |
| Shortage rows | 49 |
| Branches | 8 fictional branches |
| Items | 12 synthetic items |
| Synthetic customer keys | 253 |
| Done / Not Yet | 372 / 128 |
| Completion rate | 74.4% |
| Known record value | SAR 82,760.75 |
| Value N/A records | 47 |
| Delivered records | 158 |
| Open shortage quantity | 126 units |
| Records affected by shortages | 24 |
| Python analytics | pandas analytical functions + data-quality checks |
| Interactive application | Streamlit + Plotly source implementation |
| SQL | SQL Server-compatible schema, views and KPI queries |
| Power BI | design blueprint only; no PBIP/PBIR/TMDL/PBIX runtime artifact |
| Governance layer | separate `sample-data/` fictional workflow model |
| Validation | pytest + publication-safety tests + PowerShell scan + GitHub Actions |

## The two-layer design

This repository intentionally contains **two synthetic layers**. They serve different purposes and should not be interpreted as one physical model.

### Layer A — Operational Analytics Companion

Location:

`data/sample/`

Used by:

- `src/analytics.py`
- `src/data_quality.py`
- `app.py`
- `sql/`
- current analytical regression tests
- current Power BI design blueprint

Files:

- `records.csv`
- `record_items.csv`
- `shortages.csv`
- `branches.csv`
- `items.csv`

This layer uses Branch / Channel / Done / Not Yet / Shortage terminology and powers the implemented analytics application.

### Layer B — Generic Workflow Governance Model

Location:

`sample-data/`

This separate hand-constructed synthetic layer demonstrates:

- fictional Workflow Alpha / Beta / Gamma categories;
- site-scoped governance concepts;
- generic exceptions;
- transfer lineage;
- security and authorization patterns;
- configurable workflow examples;
- publication release gates.

It is **not** loaded by `app.py`.

See [Analytics Dataset and Governance Model Boundary](docs/ANALYTICS_DATASET_BOUNDARY.md).

## Business problem

Distributed operations can produce fragmented visibility across branches, channels and item requirements. A useful analytical layer needs to answer:

- How many records were received?
- How many are Done versus Not Yet?
- What is the completion rate?
- How does workload vary by channel and month?
- How much record value is known?
- How many records have value recorded as N/A?
- Which shortage requirements need action by item and branch?
- How many records are affected by shortages?
- Are analytical totals being inflated by item-line joins?
- Can the public repository remain useful without exposing private operational information?

## Analytics architecture

```text
Committed Synthetic Analytics CSV
        ↓
Data Quality & Type Handling
        ↓
Record / Item-Line / Shortage Model
        ↓
pandas Analytical Functions
        ↓
┌──────────────────┬────────────────────┐
│ Streamlit/Plotly │ SQL Server Source  │
│ Interactive App  │ Views + KPI Query  │
└──────────────────┴────────────────────┘
        ↓
Power BI Design Blueprint
        ↓
KPI / Trend / Shortage / Data-Quality Analysis
```

The broader workflow/security/governance design remains a separate synthetic layer.

## Analytical grains

| Dataset | Grain |
|---|---|
| `records.csv` | one operational record |
| `record_items.csv` | one item line within a record |
| `shortages.csv` | one shortage requirement for one record, branch and item |
| `branches.csv` | one branch |
| `items.csv` | one item |

Keeping those grains explicit prevents record-level KPIs from being multiplied by item-line joins.

## KPI framework

| KPI | Definition |
|---|---|
| Total Records | record count |
| Done Records | records where `final_status = Done` |
| Not Yet Records | records where `final_status = Not Yet` |
| Completion Rate | Done Records / Total Records |
| Known Record Value | sum of non-null `known_value_sar` |
| Value N/A Records | count where `known_value_sar` is null |
| Delivered Records | records where `delivery_status = Delivered` |
| Open Shortage Qty | sum of open `required_qty` |
| Records Affected by Shortages | distinct record count in shortage rows |

### Critical missing-value rule

**N/A is not zero.**

A missing `known_value_sar` is an explicit data-completeness state and must not be silently converted to zero for classification or KPI interpretation.

## Current synthetic baseline

The committed analytics sample reconciles to:

| KPI | Value |
|---|---:|
| Total Records | 500 |
| Done Records | 372 |
| Not Yet Records | 128 |
| Completion Rate | 74.4% |
| Known Record Value | SAR 82,760.75 |
| Value N/A Records | 47 |
| Delivered Records | 158 |
| Open Shortage Qty | 126 |
| Records Affected by Shortages | 24 |

### Channel distribution

| Channel | Records | Done |
|---|---:|---:|
| Standard | 310 | 236 |
| Call-Back | 109 | 73 |
| Pickup | 81 | 63 |

The analytical sample covers May–August 2026.

## Streamlit application

`app.py` implements an interactive synthetic analytics companion with:

- City filter;
- Branch filter;
- Channel filter;
- KPI cards;
- Channel Performance table and chart;
- Monthly Trend;
- Open Item Requirements;
- Operational Detail.

Run locally with:

```bash
pip install -r requirements.txt
streamlit run app.py
```

The application is implemented as source code. This repository does not claim a hosted Streamlit deployment.

## Python analytics layer

`src/analytics.py` provides reusable functions for:

- loading the synthetic analytics fixtures;
- overall KPI calculation;
- channel-level performance;
- monthly record trends;
- shortage/resource-requirement aggregation.

`src/data_quality.py` checks required columns, record uniqueness, controlled final status and non-negative known values.

## SQL Server analytical layer

The SQL implementation mirrors the same analytics-companion model:

- `sql/01_schema.sql` — Branch, Item, Record, RecordItem and Shortage tables
- `sql/02_views.sql` — record analytics and open item requirements
- `sql/03_kpi_queries.sql` — overall KPIs, channel performance and shortage action list

SQL Server is **not provisioned by GitHub Actions**, so the committed SQL source is implementation evidence rather than a fresh CI runtime execution claim.

## Power BI boundary

The `powerbi/` folder is aligned with `data/sample/` and contains:

- recommended model design;
- suggested DAX measures;
- report-page guidance.

There is currently **no committed PBIP, PBIR, TMDL, PBIX or PBIT runtime implementation**.

Power BI is therefore a **design blueprint only**.

## Publication governance

A major part of this project is safe public engineering practice.

Automated controls include:

- prohibited database/archive/key file detection;
- forbidden directory checks;
- artifact-size limits;
- explicit approval for the synthetic presentation image only;
- identity-like number detection;
- phone-like pattern checks;
- internal-host checks;
- secret-assignment checks;
- private-terminology checks;
- synthetic identifier rules;
- reference integrity;
- positive-quantity checks;
- relative Markdown-link validation.

The repository also retains:

- `PUBLICATION_ALLOWLIST.md`
- `PUBLICATION_DENYLIST.md`
- `SANITIZATION_MANIFEST.md`
- `PRIVACY_SCAN_REPORT.txt`
- documented release gates.

## Validation

Current automated validation covers:

- committed analytics-sample baseline;
- N/A-versus-zero semantics;
- channel reconciliation;
- monthly trend reconciliation;
- shortage quantity and distinct affected-record logic;
- generic synthetic governance references;
- publication safety;
- repository documentation/evidence contract;
- Python syntax compilation.

Run:

```bash
python -m pytest -q
python scripts/validate_repository.py
```

The current `data/sample/` files are treated as committed synthetic fixtures. The repository does **not** claim fixed-seed regeneration for that specific dataset because no generator for it is retained.

## Presentation evidence

The image under `docs/assets/` is a synthetic presentation schematic.

No real operational screenshot is included or required.

Future screenshots must follow [the synthetic screenshot plan](docs/screenshots/SCREENSHOT_PLAN.md).

## Repository structure

```text
app.py                  Streamlit analytical application
data/sample/            implemented analytics-companion fixtures
src/                    pandas analytics + data-quality logic
sql/                    SQL Server-compatible analytical layer
powerbi/                Power BI design blueprint
tests/                  analytics + synthetic-data + publication-safety tests
scripts/                publication scans and repository validator
sample-data/            separate generic workflow-governance fixtures
docs/                   analytics, architecture, governance and evidence
docs/assets/            presentation assets
diagrams/               generic architecture diagrams
.github/workflows/      analytical validation + publication-safety CI
```

## Documentation

- [Project Index](docs/PROJECT_INDEX.md)
- [Case Study](docs/CASE_STUDY.md)
- [Technical Walkthrough](docs/TECHNICAL_WALKTHROUGH.md)
- [Project Evidence Map](docs/PROJECT_EVIDENCE_MAP.md)
- [Analytics Dataset Boundary](docs/ANALYTICS_DATASET_BOUNDARY.md)
- [Analytics Architecture](docs/ARCHITECTURE.md)
- [Analytics Data Model](docs/DATA_MODEL.md)
- [KPI Definitions](docs/KPI_DEFINITIONS.md)
- [Testing](docs/TESTING.md)
- [Power BI Blueprint](powerbi/README.md)
- [Release Gates](docs/validation/release-gates.md)
- [Final Release Validation](docs/FINAL_RELEASE_VALIDATION.md)

## Limitations

- All data is synthetic.
- The analytics companion is a compact demonstration dataset rather than a production-scale event store.
- The current sample is a committed fixture, not a reproducibly generated fixed-seed dataset.
- Streamlit source is implemented but no hosted runtime is claimed.
- SQL runtime execution is not part of CI.
- Power BI is design-only.
- No real operational dashboard screenshots are published.
- The generic workflow-governance model is intentionally separate from the analytics companion and must not be reverse-mapped to private terminology.

Licensed under the [MIT License](LICENSE).
