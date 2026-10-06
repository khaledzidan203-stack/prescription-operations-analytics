# KPI Definitions

These definitions apply to the implemented analytics companion under `data/sample/`.

| KPI | Definition | Notes |
|---|---|---|
| Total Records | COUNT(record_id) | current filter context |
| Done Records | records where `final_status = Done` | record grain |
| Not Yet Records | records where `final_status = Not Yet` | record grain |
| Completion Rate | Done Records / Total Records | safe divide |
| Known Record Value | SUM(`known_value_sar`) excluding null | null is not zero |
| Value N/A Records | COUNT where `known_value_sar` is null | explicit completeness KPI |
| Delivered Records | COUNT where `delivery_status = Delivered` | record grain |
| Open Shortage Qty | SUM(`required_qty`) for open shortage rows | shortage grain |
| Records Affected | DISTINCTCOUNT(`record_id`) in shortages | avoids line double counting |

## Current committed baseline

- Total Records: 500
- Done Records: 372
- Not Yet Records: 128
- Completion Rate: 74.4%
- Known Record Value: SAR 82,760.75
- Value N/A Records: 47
- Delivered Records: 158
- Open Shortage Qty: 126
- Records Affected: 24

## Edge cases

- Unknown value is N/A, not zero.
- Completion rate uses record count, not item count.
- Historical item-line analysis uses `unit_price_snapshot`.
- Shortage quantity and shortage-record count are different metrics.
- Record-level totals must not be multiplied by record-item joins.
