# Delivery Workflow

## Flow

```text
Eligible Pharmacy Prescription
-> Pharmacy Delivery Request
-> Admin Delivery Queue
-> Admin Pull Batch
-> Excel Export
-> Delivery Processing
-> Done or Delivery Transfer
```

## Pharmacy request

The authenticated Pharmacy can select only owned, server-eligible prescriptions.
The handler reloads selected IDs and excludes records already requested or blocked
by transfer state. A database uniqueness guard protects against double submission.

## Admin queue and pull batch

Admin sees a network action queue, selects current pending requests, and creates a
pull batch. The batch records request membership and produces a controlled Excel
file for operational coordination. Audit and notification records connect the
central action back to affected pharmacies.

## Delivery processing

Delivery state changes remain server-side and are validated against current
workflow and transfer state. A delivered record becomes read-only for normal
editing. When the work moves to another branch, the transfer workflow records
lineage rather than changing ownership from a client value.

## Integrity characteristics

- Pharmacy and Admin roles have different responsibilities.
- Pull/export does not redefine prescription truth; SQL workflow entities do.
- Existing requests cannot be pulled repeatedly as new work.
- Audit events capture critical state transitions.
- Historical item price snapshots remain unchanged throughout delivery.
