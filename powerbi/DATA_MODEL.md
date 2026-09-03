# Power BI Data Model

The public semantic model is built from synthetic, fictional workflow data.

## Recommended Star Schema

### Dimensions

- `DimDate`
- `DimSite`
- `DimWorkflow`
- `DimItem`
- `DimStatus`

### Facts

- `FactRecord` — one synthetic operational record
- `FactRecordLine` — one item line per record
- `FactException` — one unresolved analytical exception
- `FactTransfer` — one generic movement event
- `FactFulfilment` — one generic fulfilment event

## Relationships

Use one-to-many, single-direction relationships from dimensions to facts wherever practical.

## Workflow Categories

`Workflow Alpha`, `Workflow Beta`, and `Workflow Gamma` are fictional categories created solely for the public portfolio.

## Modeling Rules

- Declare grain explicitly for every fact.
- Keep unknown numeric values as BLANK.
- Use historical snapshots where past values must remain stable.
- Keep thresholds and due windows configurable.
- Avoid bidirectional filters unless a documented analytical need exists.
- Do not encode private organization terminology or operating rules in the semantic model.
