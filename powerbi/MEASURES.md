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
