# Power BI Analytics Blueprint

> **Implementation status — design blueprint only.** This repository does not contain a committed PBIP, PBIR, TMDL, PBIX or PBIT runtime implementation.

The Power BI documentation is aligned with the implemented analytics companion under `data/sample/`.

## Synthetic sources

Load:

- `records.csv`
- `record_items.csv`
- `shortages.csv`
- `branches.csv`
- `items.csv`

These are the same public synthetic files used by the pandas/Streamlit analytics companion.

## Recommended report pages

1. Executive Overview
2. Channel Performance
3. Branch Performance
4. Monthly Throughput
5. Shortage / Resource Requirements
6. Data Quality & N/A Value
7. Operational Detail

## Recommended slicers

- Date
- City
- Branch
- Channel
- Final Status
- Delivery Status
- Item

## Modeling rules

- Keep unknown `known_value_sar` as BLANK rather than converting it to zero.
- Use a governed Date dimension.
- Keep record, record-item and shortage grains separate.
- Use single-direction dimension-to-fact filters by default.
- Use historical `unit_price_snapshot` for historical item-line analysis.
- Count shortage-affected records distinctly to avoid line multiplication.
- Reconcile DAX totals to the committed Python/SQL KPI definitions before runtime validation is claimed.

See [DATA_MODEL.md](DATA_MODEL.md) and [MEASURES.md](MEASURES.md).

## Governance model boundary

The separate `sample-data/` Workflow Alpha / Beta / Gamma governance examples are not the input to this Power BI blueprint.

They remain a separate generic design layer.

## Evidence boundary

No Power BI runtime result is claimed until a source-controlled implementation and retained execution/reconciliation evidence are added.
