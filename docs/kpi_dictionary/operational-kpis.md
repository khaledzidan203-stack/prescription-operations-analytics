# Operational KPI Dictionary

All KPIs are evaluated inside the authorized date, site, region, workflow, and report filter context. Record counts use the declared business grain rather than line-item count.

| KPI | Definition / grain | Formula | Interpretation |
|---|---|---|---|
| Total Records | Distinct operational records | `DISTINCTCOUNT(RecordId)` | Overall workload volume |
| Workflow Alpha Records | Records categorized as Workflow Alpha | Count Alpha records | Multi-stage workflow volume |
| Workflow Beta Records | Records categorized as Workflow Beta | Count Beta records | Decision-oriented workflow volume |
| Workflow Gamma Records | Records categorized as Workflow Gamma | Count Gamma records | Simplified workflow volume |
| Open Records | Records in an open state | Count open records | Current workload |
| Completed Records | Records in completed state | Count completed records | Completed workload |
| Completion Rate | Completed divided by relevant population | `Completed / Total × 100` | Completion performance |
| Future Records | Scheduled after the configured due window | Count future records | Future workload |
| Due Records | Scheduled inside a configurable demo window | Count inside configured window | Near-term workload |
| Overdue Records | Scheduled before current business date | Count overdue records | Past-due workload |
| Exception Records | Distinct records with open exceptions | Distinct count | Affected workload |
| Exception Quantity | Open synthetic required quantity | `SUM(RequiredQty)` | Aggregate unresolved requirement |
| Known Record Value | Sum where value is known | `SUM(KnownValue)` | Represented historical value |
| Value N/A Count | Records where value is unknown | Count blank values | Data availability characteristic |
| Transfers Created | Transfer events created | Count transfer IDs | Movement activity |
| Transfers Received | Transfer events received | Count received transfers | Completed movement activity |
| Active Sites | Enabled synthetic site master rows | Count active sites | Current demo network footprint |

## Configurable Demo Threshold

If value-band analysis is required, use a fictional parameter such as `DemoThreshold = 150`. This number is arbitrary and is not a real operational threshold.

## KPI Governance Rules

1. Declare the grain of every KPI.
2. Preserve nullable values through SQL, Python, and Power BI.
3. Separate record counts from line-item counts.
4. Apply site authorization before aggregation in application examples.
5. Use one shared definition for dashboard cards and drilldowns.
6. Keep scheduling windows configurable.
7. Do not encode employer-specific statuses, thresholds, timing rules, or workflow names.