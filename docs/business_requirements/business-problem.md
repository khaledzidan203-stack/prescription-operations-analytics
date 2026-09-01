# Business Problem and Operational Objectives

## Context

A multi-pharmacy healthcare network receives electronic prescription records
through several channels. Pharmacy teams must dispense items, manage future fills,
identify shortages, coordinate delivery, transfer work between branches, and
communicate with central administration. Administrators need network visibility
without weakening each pharmacy's data boundary.

## Problems with fragmented manual workflows

When records are distributed across spreadsheets, messages, and local notes, the
network can experience:

- Duplicate active records created by repeated or concurrent imports.
- Unclear prescription state and inconsistent status terminology.
- Missed or inconsistently calculated refill dates.
- Cross-pharmacy exposure when ownership is trusted from browser input.
- Missing-item demand that cannot be aggregated by item and pharmacy.
- Procurement decisions without a stable historical record of what was pulled.
- Delivery requests that are difficult to reconcile with central batches.
- Transfers without clear original, source, and destination lineage.
- Limited auditability of important state changes.
- Management reports whose totals do not reconcile with operational queues.
- Historical values that change when current item prices are updated.

## Required operational capabilities

The platform must centralize:

1. Incoming electronic prescription routing.
2. WL dispensing and refill scheduling.
3. Independent Run-X and Pick-up decisions.
4. Prescription items and historical unit-price snapshots.
5. Missing Items and pharmacy Item Summary.
6. Network Procurement requirements and historical batches.
7. Pharmacy Delivery Requests and Admin pull batches.
8. Pre-dispense, delivery, and return transfers.
9. Recipient-specific notifications.
10. Authorized internal collaboration and private attachments.
11. Pharmacy and network analytics using consistent KPI definitions.

## Stakeholders

| Actor | Primary need |
|---|---|
| Pharmacy user | Process only the authenticated pharmacy's records and queues |
| Admin user | Route imports, manage network operations, and review global analytics |
| Operations management | Reliable workload, completion, shortage, delivery, and transfer KPIs |
| IT/security | Controlled identity, database integrity, private storage, and auditability |

## Success criteria

- SQL Server remains the authoritative business store.
- Pharmacy ownership is enforced server-side for every owned query and mutation.
- Workflow-specific rules cannot be bypassed through URLs or posted identifiers.
- Historical values and batch snapshots remain stable.
- Active duplicates are blocked by application checks and SQL constraints.
- Queue counters and dashboards use the same business predicates as their pages.
- Unknown value is modeled as `N/A`, not converted to zero.
- Public portfolio assets use synthetic data and disclose their limitations.

## Scope boundary

This repository documents the engineering design and supplies sanitized examples.
It does not include the private transactional application, real data, environment
configuration, or evidence of deployment to a hospital or production network.
