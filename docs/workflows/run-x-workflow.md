# Run-X Workflow

## Purpose

Run-X is an independent incoming-record workflow used for item review and a
final `Done` or `Not Yet` decision. It does not create a WL Prescription and does
not enter Solver, Preparation, Missing Items, Delivery Requests, or schedule
queues.

```text
Incoming RUN-X
-> Start / Resume
-> Review, Add, or Edit Items
-> Validate Final Decision
-> Create Run-X Record
-> Mark Incoming Record Processed
```

## Confirmed rules

| Decision | Items | Value rule |
|---|---|---|
| `Done` | At least one valid item required | Known total must be strictly greater than SAR 200 |
| `Not Yet` | Optional | No total required |

- Exactly SAR 200 is not eligible for `Done`.
- The eligibility comparison is `Total > 200`, not `Total >= 200`.
- A `Not Yet` record may use the reason `Prescription value does not exceed SAR 200`.
- Item quantity is a whole number greater than zero.
- Unit price and sort order cannot be negative.
- Item names and unit prices are captured as historical snapshots.

## Empty-item semantics

When no items exist, total value is unknown and displayed as `N/A`. It is not
classified as SAR 0 and does not enter either the above-200 or at-or-below-200
value bands.

## Completion and audit

Completion creates one Run-X record, records the final decision/reason, marks the
incoming record `Processed`, and writes an audit entry inside the same transaction.
