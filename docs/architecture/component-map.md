# Component Map

This document describes a fictional portfolio architecture.

| Component | Portfolio responsibility |
|---|---|
| Synthetic Intake | Load and validate demonstration records |
| Workflow Service | Apply generic status transitions |
| Site Authorization | Restrict demo records by authenticated site |
| Record Line Service | Validate quantities and preserve value snapshots |
| Exception Service | Track unresolved synthetic requirements |
| Scheduling Service | Classify Future, Due, and Overdue using configurable parameters |
| Fulfilment Service | Track generic request/completion events |
| Transfer Service | Preserve source/destination lineage |
| Notification Service | Demonstrate recipient-scoped event messages |
| Audit Service | Record important synthetic mutations |
| Analytics Layer | Produce SQL, Python, and Power BI KPIs |

## Workflow Categories

The demo uses only `Workflow Alpha`, `Workflow Beta`, and `Workflow Gamma`. These names are fictional and intentionally unrelated to any private system.

## Design Goal

Keep application responsibilities separated enough that validation, authorization, analytics, and data quality can be tested independently.

## Publication Boundary

The component map is conceptual. It must not reproduce a real company's module names, queue names, roles, integration points, or workflow sequence.