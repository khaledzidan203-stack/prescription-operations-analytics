# ADR-006: Operational Batch Snapshots

## Context

Procurement and delivery pulls represent a decision made from mutable workflow
data. Rebuilding old batches from current rows can change history.

## Decision

Persist batch headers and line/request membership with selected descriptive and
quantity snapshots.

## Why

- Reproduce what was exported.
- Preserve operational accountability.
- Decouple history from later item/Pharmacy/prescription changes.

## Alternatives

- Generate exports without storing a batch.
- Recompute batch history dynamically.
- Store only the generated workbook.

## Trade-offs

Snapshots duplicate data and require clear field ownership.

## Consequences

Batch creation must re-resolve eligibility, exclude already pulled rows, and write
the snapshot atomically before returning an export.
