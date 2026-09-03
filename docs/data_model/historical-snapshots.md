# Historical Snapshots

Historical snapshots are a generic analytics pattern used when later changes to a reference value must not rewrite past reporting.

## Example

A record line may store:

- item identifier;
- quantity;
- reference value at the time of the event;
- event timestamp.

The stored snapshot remains unchanged even if the current item master is updated later.

## Why It Matters

- reproducible historical reporting;
- stable audit trails;
- prevention of retrospective metric drift;
- clear separation between current reference data and historical facts.

## Portfolio Usage

The synthetic portfolio uses snapshot concepts for record-line values and optional analytical resource snapshots. Workflow categories remain fictional and thresholds are configurable.

## Publication Boundary

Do not document private snapshot tables, real business rules, organization-specific batch processes, or internal workflow mappings.