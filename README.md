# Distributed Operations Analytics Platform

> A privacy-safe portfolio project demonstrating operational analytics, workflow modeling, data quality, security patterns, synthetic data, SQL, Python, and Power BI concepts.

This repository is intentionally **generic and synthetic**. It is designed to demonstrate transferable analytics and software-engineering skills without representing, reproducing, or documenting any specific employer, company, customer, internal system, operating model, business rule, or production workflow.

## Executive Summary

The project models a fictional distributed service network where local sites process operational records through several independent workflow categories. A central analytics layer measures throughput, completion, backlog, value, exceptions, shortages, transfers, and service performance.

The public implementation focuses on reusable technical patterns rather than any real organization’s process.

## Business Problem

Distributed operations often create fragmented data, inconsistent status definitions, duplicated records, incomplete handoffs, and limited visibility across sites. The objective of this portfolio project is to demonstrate how structured data models, validation rules, analytics, and governed workflows can improve visibility while preserving site-level access boundaries.

## Project Objectives

- Build a clean synthetic operational dataset.
- Model multiple independent workflow categories.
- Demonstrate role-based and site-scoped access concepts.
- Preserve historical values through immutable snapshots.
- Detect duplicates and data-quality exceptions.
- Measure backlog, throughput, completion, value, and exception trends.
- Demonstrate SQL, Python, Power BI, and secure application patterns.
- Keep all public examples independent from real company terminology or operating procedures.

## Fictional Scenario

The demo environment represents a fictional network of service locations handling three unrelated record categories:

- **Workflow Alpha** — general multi-stage records.
- **Workflow Beta** — decision-oriented records with configurable analytical rules.
- **Workflow Gamma** — simplified completion-oriented records.

These labels are arbitrary portfolio terminology. They do **not** correspond to any real company channel, service, product, prescription type, internal acronym, or production workflow.

## Technology Stack

| Layer | Technologies and patterns |
|---|---|
| Application concepts | ASP.NET Core, Razor Pages, service-layer patterns |
| Persistence | SQL Server concepts, EF Core, indexes, constraints |
| Security | Identity, RBAC, site-scoped authorization, secure cookies |
| Analytics | Python, pandas, Streamlit, Plotly |
| BI | Power BI modeling and DAX documentation |
| SQL | Analytical queries, data-quality checks, aggregation |
| Validation | pytest, publication-safety checks, GitHub Actions |

## High-Level Architecture

```text
Synthetic Source Data
        |
        v
Validation & Transformation
        |
        v
Structured Operational Model
        |
        +--> SQL Analytics
        +--> Python Analytics
        +--> Power BI Semantic Model
        +--> Data Quality Monitoring
```

## Analytical Domains

| Domain | Portfolio purpose |
|---|---|
| Record Intake | Demonstrate validated ingestion and duplicate controls |
| Workflow Alpha | Demonstrate multi-stage status analytics |
| Workflow Beta | Demonstrate configurable rule-based analysis |
| Workflow Gamma | Demonstrate simplified completion analysis |
| Exceptions | Demonstrate missing-data and exception monitoring |
| Resource Requirements | Demonstrate aggregated demand analysis |
| Fulfilment | Demonstrate generic service-completion analytics |
| Transfers | Demonstrate generic record movement and lineage concepts |
| Analytics | Demonstrate site-level and network-level KPIs |

## Workflow Design

The repository uses fictional state transitions to demonstrate reusable concepts such as:

- explicit status models;
- historical snapshots;
- duplicate prevention;
- site ownership;
- configurable thresholds;
- configurable due-date windows;
- exception handling;
- transfer lineage;
- auditability.

No workflow in this repository should be interpreted as documentation of a real organization’s operating method.

## Scheduling Analytics

Scheduling examples use **configurable parameters** rather than real business timing rules. Typical analytical categories are:

- Future
- Due
- Overdue

The example implementation is intended to teach date modeling and KPI design only.

## Resource & Exception Analytics

Synthetic record lines can contain missing or unresolved requirements. The analytics layer demonstrates how to aggregate these exceptions by site, item, category, and period without reproducing any real procurement or operational process.

## Transfer Analytics

The project includes a generic transfer concept to demonstrate lineage, source/destination relationships, status tracking, and concurrency-safe design. Transfer states and examples are fictional.

## Security Architecture

The documented security patterns are intentionally generic:

- authenticated users;
- role-based authorization;
- site-scoped data access;
- backend ownership validation;
- secure file handling concepts;
- audit logging;
- optimistic concurrency;
- database constraints.

These are standard software-engineering practices and are not descriptions of any employer-specific security architecture.

## Data Quality

The project demonstrates reusable validation controls including:

- duplicate detection;
- positive quantity validation;
- non-negative numeric values;
- required-field checks;
- blank-vs-zero semantics;
- invalid status transitions;
- inconsistent dates;
- orphan records;
- duplicate transaction references.

## Analytics & KPIs

The portfolio includes generic KPIs such as:

- total records;
- completed records;
- open records;
- completion rate;
- average processing time;
- backlog;
- exception count;
- known value;
- missing quantity;
- site performance;
- trend analysis.

Any threshold used in demonstrations should be treated as a fictional configurable parameter.

## Synthetic Demo Data

All public datasets are synthetic. Identifiers, names, locations, values, dates, statuses, and distributions are generated for demonstration purposes and are not production exports.

## Dashboard Preview

The screenshots in `screenshots/` are synthetic portfolio visuals. They are intended to demonstrate dashboard design rather than reproduce a private dashboard.

## Power BI

The `powerbi/` folder documents a reproducible semantic-model approach using only synthetic data. No PBIX or production model is included.

Recommended public pages include:

1. Executive Overview
2. Workflow Alpha Analysis
3. Workflow Beta Analysis
4. Workflow Gamma Analysis
5. Exceptions & Data Quality
6. Resource Requirements
7. Site Performance
8. Trends & Throughput

## Repository Structure

```text
docs/          Generic architecture, analytics, security, modeling, and validation documentation
diagrams/      Generic diagrams
examples/      Reusable code-pattern examples
sql/           Generic analytical SQL
sample-data/   Small synthetic datasets
data/sample/   Synthetic analytics datasets
src/           Python analytics code
powerbi/       Power BI modeling documentation
tests/         Analytics and publication-safety tests
scripts/       Validation and privacy-scan utilities
.github/       CI validation workflows
```

## How to Explore

1. Review the documentation in `docs/`.
2. Inspect the synthetic datasets.
3. Review the SQL examples.
4. Run the Python analytics companion.
5. Review the Power BI modeling guide.
6. Run the publication-safety tests before publishing changes.

## Privacy & Publication Safety

This repository must not contain:

- real customer, patient, employee, or transaction data;
- real company names, brands, branch identifiers, internal acronyms, or product names;
- mappings between public demo labels and private terminology;
- proprietary workflow sequences;
- real eligibility thresholds or timing windows;
- internal server names, IP addresses, paths, credentials, or connection strings;
- production screenshots, exports, attachments, or database files.

The project should remain understandable as a standalone fictional analytics case study even if the reader has no knowledge of the source organization.

## Limitations

- This is not a deployable production system.
- It does not reproduce a specific company’s operating model.
- All datasets and screenshots are synthetic.
- Workflow parameters are illustrative and configurable.
- Power BI is documented without publishing a production PBIX/PBIT model.

## Portfolio Disclaimer

This repository is a **fictionalized, privacy-safe portfolio implementation** built to demonstrate analytics, data modeling, dashboarding, validation, and software-engineering skills. It is not documentation of a real employer, healthcare organization, customer environment, operational workflow, or proprietary business process.