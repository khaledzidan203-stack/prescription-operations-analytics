# Suggested DAX Measures

```DAX
Total Records = DISTINCTCOUNT(FactRecord[record_id])

Done Records =
CALCULATE([Total Records], FactRecord[final_status] = "Done")

Not Yet Records =
CALCULATE([Total Records], FactRecord[final_status] = "Not Yet")

Completion Rate = DIVIDE([Done Records], [Total Records])

Known Record Value = SUM(FactRecord[known_value_sar])

Value N/A Records =
CALCULATE([Total Records], ISBLANK(FactRecord[known_value_sar]))

Delivered Records =
CALCULATE([Total Records], FactRecord[delivery_status] = "Delivered")

Open Shortage Qty =
CALCULATE(SUM(FactShortage[required_qty]), FactShortage[status] = "Open")

Shortage Records Affected = DISTINCTCOUNT(FactShortage[record_id])
```

Do not replace blank `known_value_sar` with zero in Power Query if you want the Value N/A KPI to remain valid.

## Expanded operational measures

The following patterns apply when the corresponding curated facts are built:

```DAX
WL Prescriptions = DISTINCTCOUNT(FactWlDispense[prescription_id])

Upcoming Prescriptions =
CALCULATE(
    [WL Prescriptions],
    FactWlDispense[wasfaty_status] = "Not Yet",
    FactWlDispense[next_fill_at_utc] > UTCNOW()
)

Run-X Records =
CALCULATE(
    DISTINCTCOUNT(FactOperationalDecision[record_id]),
    FactOperationalDecision[record_type] = "Run-X e-RXs"
)

Pick-up Records =
CALCULATE(
    DISTINCTCOUNT(FactOperationalDecision[record_id]),
    FactOperationalDecision[record_type] = "Pick-up e-RXs"
)

Run-X SAR 200 or Less =
CALCULATE(
    [Run-X Records],
    NOT ISBLANK(FactOperationalDecision[known_value_sar]),
    FactOperationalDecision[known_value_sar] <= 200
)

Operational Value N/A =
CALCULATE(
    DISTINCTCOUNT(FactOperationalDecision[record_id]),
    ISBLANK(FactOperationalDecision[known_value_sar])
)
```

Due and Overdue should use a Saudi business-date dimension/boundary rather than
the viewer workstation's local date.
