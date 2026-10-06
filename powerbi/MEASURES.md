# Suggested DAX Measures

> Design reference only. These measures mirror the current pandas/SQL analytics definitions and have not been executed in a committed Power BI runtime model.

```DAX
Total Records =
DISTINCTCOUNT(FactRecord[record_id])

Done Records =
CALCULATE(
    [Total Records],
    FactRecord[final_status] = "Done"
)

Not Yet Records =
CALCULATE(
    [Total Records],
    FactRecord[final_status] = "Not Yet"
)

Completion Rate =
DIVIDE([Done Records], [Total Records])

Known Record Value =
SUM(FactRecord[known_value_sar])

Value N/A Records =
CALCULATE(
    [Total Records],
    ISBLANK(FactRecord[known_value_sar])
)

Delivered Records =
CALCULATE(
    [Total Records],
    FactRecord[delivery_status] = "Delivered"
)

Open Shortage Qty =
CALCULATE(
    SUM(FactShortage[required_qty]),
    FactShortage[status] = "Open"
)

Records Affected by Shortages =
CALCULATE(
    DISTINCTCOUNT(FactShortage[record_id]),
    FactShortage[status] = "Open"
)
```

## Channel measures

```DAX
Standard Records =
CALCULATE([Total Records], FactRecord[channel] = "Standard")

Call-Back Records =
CALCULATE([Total Records], FactRecord[channel] = "Call-Back")

Pickup Records =
CALCULATE([Total Records], FactRecord[channel] = "Pickup")
```

## Current synthetic reconciliation baseline

Expected totals from the committed analytics sample:

- Total Records = 500
- Done Records = 372
- Not Yet Records = 128
- Completion Rate = 74.4%
- Known Record Value = SAR 82,760.75
- Value N/A Records = 47
- Delivered Records = 158
- Open Shortage Qty = 126
- Records Affected by Shortages = 24

## Important semantic rule

Do not replace blank `known_value_sar` with zero when the distinction between unknown value and true zero is analytically meaningful.
