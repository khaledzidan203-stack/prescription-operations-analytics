# Analytics Data Model

> This document describes the synthetic analytics companion under `data/sample/`. The broader generic governance/domain model is documented separately under [data_model/](data_model/).

## FactRecord — `records.csv`

Grain: one operational record.

Primary key: `record_id`.

Important fields:

- branch_id
- city
- channel
- received_date
- final_status
- not_yet_reason
- next_action_date
- delivery_status
- known_value_sar
- completed_date

## FactRecordItem — `record_items.csv`

Grain: one item line within a record.

Relationship: many item lines to one record.

`unit_price_snapshot` is a historical line-level value and should not be replaced by the current item-master price for historical reporting.

## FactShortage — `shortages.csv`

Grain: one missing-item requirement for one record, branch and item.

Action-oriented aggregation uses Item + Branch.

## DimBranch — `branches.csv`

Grain: one fictional branch.

## DimItem — `items.csv`

Grain: one synthetic item.

## Relationship diagram

```text
DimBranch (1) ───── (*) FactRecord (1) ───── (*) FactRecordItem (*) ───── (1) DimItem
   │                       │
   └──────────── (*) FactShortage (*) ────────────────────────────────── (1) DimItem
```

## Modeling notes

- `known_value_sar` is nullable; null means the value is unknown.
- Zero and unknown are not interchangeable.
- Completion-rate denominator is record grain.
- Shortage quantity and shortage-record count are different metrics.
- Delivery status is meaningful in context and uses N/A where delivery is outside the relevant channel scope.
