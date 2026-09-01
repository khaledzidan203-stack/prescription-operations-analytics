# Pick-up Workflow

## Purpose

Pick-up is a separate incoming-record workflow for reviewing prescription items
and recording a final decision. It does not use the WL Solver, Preparation,
Missing Items, Delivery Request, or scheduling lifecycle.

```text
Incoming Pick-up
-> Start / Resume
-> Review, Add, or Edit Items
-> Validate Final Decision
-> Create Pick-up Record
-> Mark Incoming Record Processed
```

## Confirmed rules

| Decision | Items | Value rule |
|---|---|---|
| `Done` | At least one valid item required | No SAR threshold |
| `Not Yet` | Optional | No total required |

- Pick-up must not inherit the Run-X SAR 200 rule.
- An empty item set has value `N/A`, not zero.
- When items exist, total is the sum of quantity multiplied by historical unit
  price snapshot.
- Item quantity must be a positive whole number.
- Completion writes the Pick-up record, incoming status, and audit entry in one
  transaction.

## Separation from Run-X

The two workflows can share item preparation and history presentation patterns,
but decision reasons and eligibility stay type-specific. Reuse must not turn a
Run-X rule into a Pick-up rule.
