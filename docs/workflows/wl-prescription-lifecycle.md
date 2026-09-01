# WL Prescription Lifecycle

## Scope

WL e-RXs use the full prescription lifecycle. Run-X and Pick-up are deliberately
excluded from Solver, Preparation, Missing Items, delivery requests, and refill
scheduling.

## Lifecycle

```text
Incoming Record
-> PrescriptionGroup
-> Prescription / DispenseSequence
-> Wasfaty Decision
-> Prescription Items
-> Missing Items when applicable
-> Solver
-> Preparation
-> Delivery Request
-> Admin Pull
-> Delivery / Transfer / Return
-> Completion
```

## PrescriptionGroup and DispenseSequence

`PrescriptionGroup` represents the logical prescription across multiple
dispenses. Each `Prescription` is a workflow occurrence in that group, and
`DispenseSequence` defines its order. This separates longitudinal identity from
the mutable state of one dispense.

## Duplicate / New Dispense

A new dispense is created from an eligible delivered prescription. The server:

1. Resolves the source within the authenticated Pharmacy.
2. Revalidates delivery and transfer eligibility.
3. Resolves the next sequence inside the same group.
4. Copies item rows as new editable rows.
5. Preserves each source `UnitPriceSnapshot`.
6. Starts a fresh workflow rather than copying completion state.

Delivery-only/return destinations and sources with an active outgoing transfer
cannot bypass these guards through a duplicate URL.

## Active Not Yet prevention

Before creating or resuming a dispense, the server checks whether the logical
prescription already has an active `Not Yet` record. Ambiguous active state is
rejected for review rather than creating another competing workflow.

## Items and historical price

- Quantities must be positive.
- Sort order must be non-negative.
- A retained existing item keeps its historical `UnitPriceSnapshot`.
- A new or replaced Item Master item resolves its current price server-side.
- Updating Item Master later does not restate a historical prescription.
- `LineTotal = DispensedQty × UnitPriceSnapshot`.

## NextFillAtUtc

Future scheduling is stored in UTC and interpreted through Saudi calendar
boundaries. `NextFillAtUtc` powers Upcoming, Due, and Overdue views only for
active WL `Not Yet` prescriptions.

## Workflow integrity

The original delivered record is read-only. State-changing handlers reload
server state, apply Pharmacy ownership, enforce `RowVersion`, and write related
events/audits inside the appropriate transaction.
