# Data Model Documentation

## Tables / files

### FactRecord (`records.csv`)
Grain: one operational record per branch/channel occurrence.
Primary key: `record_id`.

### FactRecordItem (`record_items.csv`)
Grain: one item line within a record.
Relationship: many item lines to one record.

### FactShortage (`shortages.csv`)
Grain: one missing-item requirement for one record and branch.

### DimBranch (`branches.csv`)
Grain: one branch.

### DimItem (`items.csv`)
Grain: one item.

## Relationship diagram

```text
DimBranch (1) ─────── (*) FactRecord (1) ─────── (*) FactRecordItem (*) ─────── (1) DimItem
   │                         │
   └────────────── (*) FactShortage (*) ─────────────────────────────────────── (1) DimItem
```

## Modeling notes

- `known_value_sar` is nullable. Null means value not known.
- `unit_price_snapshot` is historical, while `current_unit_price` belongs to the item master.
- Delivery status is meaningful for Standard records and uses N/A for channels where delivery is outside scope.

## Power BI relationship settings

- DimBranch[branch_id] 1 → * FactRecord[branch_id]
- FactRecord[record_id] 1 → * FactRecordItem[record_id]
- FactRecord[record_id] 1 → * FactShortage[record_id]
- DimItem[item_id] 1 → * FactRecordItem[item_id]
- DimItem[item_id] 1 → * FactShortage[item_id]

Prefer single-direction filters from dimensions to facts. Use a proper Date dimension for production-quality time intelligence.
