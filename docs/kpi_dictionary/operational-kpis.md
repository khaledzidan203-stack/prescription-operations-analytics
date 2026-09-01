# Operational KPI Dictionary

All KPIs are evaluated inside the authorized date, Pharmacy, city, workflow, and
section filter context. Record counts use the workflow's business grain rather
than item-row count.

| KPI | Definition / grain | Formula | Interpretation | Limitations |
|---|---|---|---|---|
| Total Prescriptions | WL dispense records | `COUNT(PrescriptionId)` | WL workload volume | A group with multiple dispenses contributes multiple records |
| WL Records | Incoming/final WL workflow population for the selected report | Count records using WL workflow type | WL channel activity | Report must state whether it counts incoming or created dispenses |
| Run-X Records | Final Run-X records | `COUNT(RunXRecordId)` | Processed Run-X volume | Unprocessed incoming rows are a separate queue |
| Pick-up Records | Final Pick-up records | `COUNT(PickUpRecordId)` | Processed Pick-up volume | Unprocessed incoming rows are a separate queue |
| Upcoming Prescriptions | Active WL `Not Yet` with future Next Fill instant | Count where `NextFillAtUtc > nowUtc` | Future refill workload | May overlap Due for future times in the Due window |
| Due Prescriptions | Active WL `Not Yet` with Saudi date Today through Today+5 | Count in `[todayStartUtc, todayPlus6StartUtc)` | Six-calendar-day action window | Today remains Due after its scheduled time |
| Overdue Prescriptions | Active WL `Not Yet` before Saudi Today | Count where `NextFillAtUtc < todayStartUtc` | Past-date refill workload | Excludes Today and records without Next Fill |
| Missing Item Prescriptions | Distinct active WL prescriptions with Missing Items | `DISTINCTCOUNT(PrescriptionId)` | Affected workload | Not the same as missing line count |
| Missing Item Quantity | Active missing quantity | `SUM(RequiredQty)` | Total item demand | Must be grouped by item and Pharmacy for action |
| Procurement Requirements | Unpulled active requirement groups | Count grouped requirement key | Admin work awaiting batch pull | Excludes items already snapshotted in a batch |
| Delivery Requests | Current Delivery Request rows in scope | Count request IDs by state | Delivery coordination workload | A request is not equivalent to a delivered prescription |
| Transferred Prescriptions | Transfer hops or distinct source prescriptions, as labeled | Count TransferId or distinct SourcePrescriptionId | Network redistribution | Report must disclose hop versus prescription grain |
| Completed Dispenses | WL dispenses with completed delivery workflow | Count eligible completed Prescription IDs | End-to-end WL completion | Not a count of Prescription Groups |
| Wasfaty Completion Rate | Completed WL decision population divided by relevant WL population | `Done / Total × 100` | WL decision performance | Denominator must be fixed and documented per dashboard |
| Run-X Completion Rate | Run-X `Done` divided by final Run-X records | `Done / (Done + Not Yet) × 100` | Run-X final-decision mix | Does not include unprocessed incoming rows unless explicitly added |
| Pick-up Completion Rate | Pick-up `Done` divided by final Pick-up records | `Done / (Done + Not Yet) × 100` | Pick-up final-decision mix | Same denominator caveat as Run-X |
| Known Prescription Value | Sum of totals only where item set/value is known | `SUM(Quantity × UnitPriceSnapshot)` over known rows | Historical value represented by items | Never replace unknown with zero |
| Value N/A Count | Records without any value-defining items | Count where item set is empty | Data availability/workflow characteristic | N/A is not a low-value classification |
| Run-X SAR 200 or Less | Run-X records with items and known total `<= 200` | Count where `Items.Any` and total `<= 200` | Ineligible/low-value Run-X population | Excludes empty item sets; exactly 200 belongs here |
| Active Pharmacies | Enabled Pharmacy master rows | Count where `IsActive = true` | Current operational network | Does not imply recent prescription activity |

## KPI governance rules

1. Use Saudi business-date boundaries for operational dates.
2. Preserve nullable values through SQL, Python, and Power BI.
3. Separate incoming queue volume from completed workflow record volume.
4. Apply Pharmacy isolation before aggregation.
5. Reuse page/query predicates for counters and drilldowns.
6. Label transfer grain and completion denominator explicitly.
