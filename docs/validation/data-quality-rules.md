# Data Quality and Validation Rules

## Incoming Records

- Required Prescription Number and National ID values.
- Pharmacy is selected for Single Pharmacy import or resolved from each Bulk row.
- RecordType is normalized to a controlled canonical value.
- Same-file duplicates are rejected.
- Existing active logical duplicates are reported as `Already Waiting`.
- SQL unique index is the final defense against concurrent duplicate imports.
- Model-length limits are validated before persistence.
- Rejected rows retain a reason and can be exported for review.

## Active incoming uniqueness

The active logical key is:

```text
Pharmacy + RecordType + NormalizedNationalId + NormalizedPrescriptionNumber
```

Only `New` and `In Progress` collide. Historical statuses use a row-specific
discriminator so a valid later cycle can be imported.

## Item integrity

- WL `DispensedQty > 0`.
- Operational `Quantity > 0` and whole-number.
- Unit price snapshot is non-negative.
- Sort order is non-negative.
- Item Master-backed code/name/price values are resolved server-side.
- Historical snapshots are not recalculated from current price.

Application validation is reinforced by SQL check constraints.

## Workflow completion

- Run-X `Done`: at least one item and known total strictly greater than SAR 200.
- Pick-up `Done`: at least one item; no SAR threshold.
- Both `Not Yet` decisions may have no items.
- No items means `N/A`, not zero.
- Completed/delivered records cannot be edited through a direct backend request.

## Solver invoices

Invoice values are normalized and checked for duplicates within the submitted
set and against existing invoices in the same Pharmacy. Duplicate protection is
server-side, not only a browser validation message.

## Procurement

- Only active, unpulled Missing Items are eligible.
- Submitted selection keys are parsed and re-resolved against current queries.
- Previously batched Missing Items are excluded.
- Batch lines snapshot the accepted requirement.

## Transfers

- Transfer status and intended destination are loaded from SQL.
- Only the authenticated destination Pharmacy can accept.
- Cancelled/received/stale transfers are rejected.
- `RowVersion` handles simultaneous acceptance or return.
- Active outgoing transfers block incompatible Duplicate/Delivery actions.

## Attachments

- File count, per-file size, total size, extension, Content-Type, signature, and
  path containment are validated.
- Download requires chat participant authorization.
- Database failure triggers cleanup of newly stored bytes.

## Time and analytics

- UTC persistence with centralized Saudi business boundaries.
- Upcoming/Due/Overdue reuse shared query logic.
- Queue counters and dashboard drilldowns should reconcile with their pages.
- Nullable totals remain nullable across SQL, C#, Python, and Power BI.
