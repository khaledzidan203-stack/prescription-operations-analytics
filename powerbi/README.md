# Power BI Operational Analytics Companion

This repository contains Power BI **documentation only**. It does not contain a
`.pbix` or `.pbit` file. Binary BI files can embed data and are difficult to review
through Git, so the model and measures are documented for reproducible manual
construction from synthetic files.

## Available synthetic sources

### Existing analytical model

Load the five CSV files from `data/sample/` for the original larger dashboard:

- records
- record items
- shortages
- branches
- items

The channel labels are intentionally generalized analytical proxies:

- `Standard`: WL-like analysis.
- `Call-Back`: Run-X-like analysis.
- `Pickup`: Pick-up-like analysis.

### Workflow-oriented examples

The smaller `sample-data/` files illustrate explicit WL e-RXs, Run-X e-RXs,
Pick-up e-RXs, scheduling, Missing Items, and Transfers. They are documentation
fixtures rather than a full star schema.

## Recommended report pages

1. Executive Overview.
2. WL and schedule analysis.
3. Run-X status, reasons, value band, trend, and top items.
4. Pick-up status, reasons, value, trend, and top items.
5. Missing Items and Procurement requirements.
6. Delivery requests and completion.
7. Transfers and destination activity.
8. Pharmacy performance.
9. Data quality and Value N/A.

## Recommended slicers

- Business date.
- City.
- Pharmacy/branch.
- Record type/channel.
- Final status and reason.
- Delivery or transfer status.
- Item.

## Modeling rules

- Keep nullable known value as BLANK; never replace it with zero.
- Use a proper Date dimension and explicit Saudi business-date definition.
- Use single-direction dimension-to-fact filters by default.
- Distinguish incoming queue rows, final workflow rows, prescriptions, item lines,
  transfer hops, and procurement lines by grain.
- Use historical unit-price snapshots for value measures.
- Apply the same KPI definitions as SQL/Python documentation.

See [DATA_MODEL.md](DATA_MODEL.md), [MEASURES.md](MEASURES.md), and the
[operational KPI dictionary](../docs/kpi_dictionary/operational-kpis.md).
