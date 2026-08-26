# Prescription Operations Analytics & Workflow Tracker

> **Portfolio Edition — synthetic data only.** This repository is a confidentiality-safe demonstration of a multi-branch prescription-operations analytics and workflow solution. It intentionally contains no production source code, real patient/customer data, internal credentials, private infrastructure details, or proprietary datasets.

## Executive summary

This project demonstrates how operational records from multiple branches can be centralized, validated, modeled, and analyzed to support day-to-day decisions. The portfolio edition focuses on the **Data Analyst / Business Analyst** aspects of the solution: requirements definition, data modeling, KPI design, workflow-state analysis, shortage aggregation, branch-level controls, dashboard design, SQL analysis, data quality, and reproducible synthetic data.

The original business context has been deliberately generalized. Three operational channels are represented as **Standard**, **Call-Back**, and **Pickup**. All identifiers and values are synthetic.

## Business problem

A distributed branch network may receive operational records through multiple channels. Without a centralized model, teams can struggle to answer basic questions consistently: what is complete, what still needs action, what is due next, which branches have item shortages, where values are unknown, and which records have reached delivery.

The analytical challenge is to create one governed model that separates operational state from reporting logic, preserves historical values, prevents double counting, and supports both branch-level and network-level views.

## Project objectives

- Standardize multi-branch operational data into a single analytical model.
- Define clear, auditable status and KPI logic.
- Separate **unknown / N/A values from true zero values**.
- Provide branch and network views with consistent filters.
- Aggregate item requirements by item and branch for action-oriented reporting.
- Demonstrate SQL, Python, dashboard, data-quality, and business-analysis skills.
- Provide a safe public portfolio version with reproducible synthetic data.

## Dataset description

The repository ships with deterministic synthetic sample data:

| File | Grain | Purpose |
|---|---|---|
| `data/sample/records.csv` | one row per operational record | status, branch, channel, dates, known value |
| `data/sample/record_items.csv` | one row per record item | quantity and historical unit-price snapshot |
| `data/sample/shortages.csv` | one row per item shortage | quantity needed and affected branch |
| `data/sample/branches.csv` | one row per branch | branch and city dimensions |
| `data/sample/items.csv` | one row per item | synthetic item master |

No row represents a real person, branch, prescription, employee, or company transaction.

## Tools and technologies

- **Python:** pandas, Streamlit, Plotly
- **SQL:** SQL Server-compatible schema, views, and KPI queries
- **Power BI:** model design, DAX measure definitions, report build guide
- **Analytics engineering:** dimensional modeling, KPI definitions, data validation, testable calculation logic
- **Business analysis:** requirements, workflows, acceptance criteria, privacy controls, data dictionary

## Data preparation

The portfolio workflow is:

`Synthetic generation → schema validation → type normalization → status logic → analytical aggregates → dashboard/report outputs`

Important rules include stable record IDs, branch ownership, channel classification, historical price snapshots, positive quantities, and explicit treatment of blank values as N/A rather than zero.

## Data model

The analytical model uses a central record fact with supporting dimensions and line-level facts:

```text
DimBranch ───────┐
                 ├── FactRecord ─── FactRecordItem ─── DimItem
DimDate ─────────┤        │
DimChannel ──────┘        └── FactShortage ─── DimItem
```

See `docs/DATA_MODEL.md` and `powerbi/DATA_MODEL.md`.

## KPIs

Core KPIs demonstrated:

- Total Records
- Done Records
- Not Yet Records
- Completion Rate
- Known Record Value
- Value N/A Records
- Delivered Records
- Open Shortage Quantity
- Records Affected by Shortages
- Channel Mix
- Branch / City / Monthly Trends

See `docs/KPI_DEFINITIONS.md` for formulas and edge cases.

## Analytical methodology

The analysis follows five principles:

1. **Model first, visualize second** — visuals never define business logic.
2. **One calculation definition per KPI** — Python, SQL, and Power BI definitions are aligned.
3. **N/A is not zero** — unknown values are excluded from known-value sums and counted separately.
4. **Actionable aggregation** — shortage demand is grouped by both item and branch.
5. **Scoped views** — branch-level analysis can be filtered without changing the global definition of a metric.

## Dashboard / report structure

The demo dashboard includes:

- Executive KPI strip
- Channel performance
- Monthly trend
- Open item requirements
- Operational detail table
- Global filters for city, branch, and channel

Power BI documentation also proposes an **Executive Overview**, **Channel Analysis**, **Item Requirements**, **Branch Performance**, and **Data Quality** report structure.

## Key insights demonstrated by the project

The repository demonstrates *how* to derive defensible insights rather than claiming real-world performance results. With the included synthetic dataset, a reviewer can reproduce examples such as channel completion differences, records with unknown values, workload trends over time, and item requirements by branch.

## Screenshots

![Admin dashboard](screenshots/admin_dashboard.png)
![Branch dashboard](screenshots/branch_dashboard.png)

Screenshots are generated from the synthetic dataset and are illustrative portfolio visuals, not production screenshots.

## Repository structure

```text
prescription-operations-analytics-portfolio/
├── README.md
├── PORTFOLIO_NOTES.md
├── LICENSE
├── SECURITY.md
├── CONTRIBUTING.md
├── CHANGELOG.md
├── requirements.txt
├── app.py
├── src/
├── tests/
├── data/sample/
├── sql/
├── powerbi/
├── docs/
├── examples/
└── screenshots/
```

## Installation / setup

```bash
python -m venv .venv
# Windows: .venv\Scripts\activate
# macOS/Linux: source .venv/bin/activate
pip install -r requirements.txt
```

## How to use

Run the dashboard:

```bash
streamlit run app.py
```

Run tests:

```bash
pytest -q
```

The CSV files can also be loaded directly into Power BI or SQL Server using the documentation in `powerbi/` and `sql/`.

## Skills demonstrated

- Business requirements and acceptance criteria
- Operational workflow modeling
- Data modeling and data dictionary design
- KPI governance and edge-case handling
- SQL schema / views / analytical queries
- Python analytics and reusable calculation functions
- Power BI modeling and DAX design
- Data quality and unit testing
- Dashboard UX and filter design
- Privacy-by-design and portfolio sanitization
- Technical documentation and GitHub project packaging

## Future improvements

- Add automated CI for Python tests and SQL linting.
- Add a Dockerized demo deployment.
- Add a true semantic model export / `.pbit` template once built in Power BI Desktop.
- Add role-based demo views and richer drill-through pages.
- Add synthetic anomaly scenarios and a formal data-quality score.
- Add automated screenshot generation from the running dashboard.

## Confidentiality statement

This is a reconstructed, generalized portfolio edition. It does **not** contain the original production application source, private business identifiers, real customer/patient information, passwords, credentials, connection strings, server names, or proprietary data. The repository is intended to demonstrate analytical and business-analysis capability only.
