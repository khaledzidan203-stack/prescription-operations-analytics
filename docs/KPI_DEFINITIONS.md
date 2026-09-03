# KPI Definitions

> Original analytics-companion definitions. See the expanded
> [`operational-kpis.md`](kpi_dictionary/operational-kpis.md) for workflow KPIs and
> their grains/limitations.

| KPI | Definition | Notes |
|---|---|---|
| Total Records | COUNT(record_id) | current filter context |
| Done Records | records where `final_status = Done` | |
| Not Yet Records | records where `final_status = Not Yet` | |
| Completion Rate | Done Records / Total Records | safe divide |
| Known Record Value | SUM(`known_value_sar`) excluding null | never convert null to zero for classification |
| Value N/A Records | COUNT where `known_value_sar` is null | explicit data-completeness KPI |
| Delivered Records | COUNT where `delivery_status = Delivered` | mainly Standard channel |
| Open Shortage Qty | SUM(`required_qty`) for open shortages | grouped by Item + Branch for action |
| Records Affected | DISTINCTCOUNT(`record_id`) in shortages | avoids item-line double counting |

## Edge cases

- A record with no items is **N/A**, not zero-value.
- Completion rate uses record count, not item count.
- Historical value uses item-line snapshots, not current master price.
- Shortage quantity and shortage record count are different metrics.
