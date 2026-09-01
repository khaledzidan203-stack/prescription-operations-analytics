# Missing Items and Procurement

## Workflow

```text
Prescription Missing Items
-> Pharmacy Missing Items Center
-> Pharmacy Item Summary
-> Admin Item Requirements
-> Select Unpulled Requirement Groups
-> Procurement Batch Snapshot
-> Excel Export and History
```

## Pharmacy Missing Items Center

The center starts from active prescriptions owned by the authenticated Pharmacy.
It exposes searchable item-level gaps and optional Next Fill date filters without
allowing a route or query Pharmacy identifier to change ownership.

## Item Summary

Individual missing rows are aggregated into action-oriented requirements. Item
identity, Pharmacy, required quantity, affected prescriptions, and timing remain
available for operational prioritization.

## Admin Item Requirements

Admin can review unpulled active requirements across the network and filter by
Pharmacy. Selected requirement keys are resolved against current server queries;
the browser does not submit authoritative quantities.

## Procurement batch

Creating a batch:

1. Re-resolves selected requirement groups.
2. Excludes rows already linked to a prior pull.
3. Creates one batch header and historical line snapshots.
4. Records item, Pharmacy, quantity, affected-record, and scheduling context.
5. Writes an audit event and notifies affected pharmacies.
6. Produces an Excel export and retains batch history.

## Why snapshots matter

A procurement batch represents the decision made at one point in time. Later
changes to prescriptions, item names, or Pharmacy metadata must not rewrite what
the batch contained. Snapshot fields keep the export and history reconcilable.

## Duplicate-pull prevention

Active Missing Items already represented by procurement batch lines are excluded
from the unpulled query. The create handler rechecks this condition, so stale UI
selection cannot silently pull the same requirement twice.
