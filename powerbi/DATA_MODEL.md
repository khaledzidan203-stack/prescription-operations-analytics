# Power BI Data Model Blueprint

> Design reference only. No source-controlled Power BI runtime model is committed.

## Recommended dimensions

- `DimDate`
- `DimBranch`
- `DimItem`
- optional `DimChannel`
- optional `DimStatus`

## Facts

### FactRecord

Source: `data/sample/records.csv`

Grain: one synthetic operational record.

Primary analytical fields:

- record_id
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

### FactRecordItem

Source: `data/sample/record_items.csv`

Grain: one item line within a record.

Historical price should use `unit_price_snapshot`, not current master price.

### FactShortage

Source: `data/sample/shortages.csv`

Grain: one shortage requirement for one record, branch and item.

## Relationships

Recommended:

- `DimBranch[branch_id]` 1:* `FactRecord[branch_id]`
- `DimBranch[branch_id]` 1:* `FactShortage[branch_id]`
- `DimItem[item_id]` 1:* `FactRecordItem[item_id]`
- `DimItem[item_id]` 1:* `FactShortage[item_id]`
- `FactRecord[record_id]` 1:* `FactRecordItem[record_id]`
- `FactRecord[record_id]` 1:* `FactShortage[record_id]`
- `DimDate[date]` 1:* active relationship to the primary reporting date

## Modeling rules

- Declare every fact grain explicitly.
- Preserve N/A versus zero semantics.
- Avoid summing record-level values after multiplying records through item-line joins.
- Use DISTINCTCOUNT(record_id) for record-level KPIs.
- Use shortage quantity from the shortage fact.
- Use a proper Date dimension for monthly/time-intelligence analysis.
- Avoid bidirectional filtering unless a documented use case requires it.
