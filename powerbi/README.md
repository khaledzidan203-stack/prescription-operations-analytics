# Power BI Analytics Companion

This repository contains Power BI **documentation only**. It does not contain a `.pbix` or `.pbit` file. The model is designed to be rebuilt from synthetic CSV sources so every public artifact remains reviewable.

## Synthetic Sources

Load the CSV files from `data/sample/`:

- records
- record items
- exceptions
- sites
- items

Public workflow categories are intentionally fictional:

- `Workflow Alpha`
- `Workflow Beta`
- `Workflow Gamma`

These categories are arbitrary demonstration labels and must not be mapped to any real organization, internal acronym, product, service channel, or operating process.

## Recommended Report Pages

1. Executive Overview
2. Workflow Alpha Analysis
3. Workflow Beta Analysis
4. Workflow Gamma Analysis
5. Exceptions & Data Quality
6. Resource Requirements
7. Transfer & Lineage Analysis
8. Site Performance
9. Trends & Throughput

## Recommended Slicers

- Business date
- Region
- Site
- Workflow category
- Status
- Exception category
- Item

## Modeling Rules

- Keep unknown numeric values as BLANK rather than silently converting them to zero.
- Use a proper Date dimension.
- Use single-direction dimension-to-fact filters by default.
- Define the grain of each fact table explicitly.
- Preserve historical numeric snapshots where historical reporting requires them.
- Use configurable parameters for thresholds and due-date windows.
- Keep all public KPI logic generic and independent from real company policies.

See [DATA_MODEL.md](DATA_MODEL.md) and [MEASURES.md](MEASURES.md).

## Publication Safety

Power BI documentation must not include:

- private terminology or acronyms;
- mappings from fictional labels to real workflow names;
- real thresholds, eligibility rules, or time windows;
- internal organizational structures;
- production connection information;
- real screenshots or exported business data.
