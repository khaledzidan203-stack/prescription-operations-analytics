# Historical Snapshots

## Why mutable reference data is dangerous

Item names, current prices, Pharmacy descriptors, workflow labels, and requirement
quantities can change. If historical reports always join to the current reference
value, past operations are silently restated.

## Prescription item price

`PrescriptionItem.UnitPriceSnapshot` captures the unit price used for one WL
dispense. Editing quantity or notes while retaining the same item preserves the
snapshot. A new or replaced Item Master item resolves the current price on the
server and stores a new snapshot.

```text
Historical line total = Dispensed quantity × UnitPriceSnapshot
```

A Duplicate/New Dispense copies the source snapshot into the new starting item
set instead of recalculating prior history from the current Item Master.

## Run-X and Pick-up items

Incoming operational item rows snapshot code, name, generic name, quantity, unit
price, and sort order. Known total is the sum of quantity multiplied by snapshot
price. No item rows means `N/A`, not zero.

## Procurement batches

Procurement batch lines capture the requirement selected at pull time, including
item and Pharmacy context. Later resolution, description changes, or prescription
edits do not rewrite the batch that was already exported.

## Delivery and transfer history

Delivery pull batches preserve request membership. Transfers preserve original,
source, and destination references plus Pharmacy lineage and status timestamps.

## Design trade-off

Snapshots duplicate selected descriptive data and require explicit mapping. The
benefit is stable audit/report output and protection from retrospective business
changes—essential for operational and financial interpretation.
