# Business Requirements

## BR-01 Centralized operational view
The solution shall provide a governed record model that supports both branch-level and network-level analysis.

**Acceptance criteria:** records are attributable to one branch; global filters can be applied by city/branch/channel; totals reconcile to detail rows.

## BR-02 Multiple operational channels
The model shall support Standard, Call-Back, and Pickup channels without mixing channel-specific calculations.

## BR-03 Status tracking
Every record shall have a final status of Done or Not Yet. Not Yet records may carry a reason and next-action date.

## BR-04 Unknown values
Records without item/value detail shall be classified as Value N/A, not SAR 0.

## BR-05 Historical value preservation
Record line values shall use a unit-price snapshot captured at record time. Changing the current item price must not restate historical record value.

## BR-06 Item requirements
Open shortages shall be aggregatable by Item + Branch, with both required quantity and records affected.

## BR-07 Delivery visibility
For the Standard channel, the model shall support Pending, Delivered, and Transferred delivery states.

## BR-08 Data quality
The solution shall detect duplicate record IDs, missing required columns, invalid status values, and negative known values.

## BR-09 Privacy
Public/demo data must be synthetic and must not contain production identifiers or confidential infrastructure details.
