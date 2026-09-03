# Data Quality Rules

The public project uses generic validation rules that are common to analytical systems.

## Record-Level Rules

- Record identifier must be unique at the declared grain.
- Workflow category must be one of `Workflow Alpha`, `Workflow Beta`, or `Workflow Gamma`.
- Status must use the fictional public status vocabulary.
- Site reference must exist.
- Required timestamps must parse correctly.

## Line-Level Rules

- Quantity must be positive where a line exists.
- Numeric reference values must be non-negative.
- Unknown value remains NULL/BLANK rather than being coerced to zero.
- Item references must exist when supplied.

## Date Rules

- Completion cannot precede creation.
- Transfer receipt cannot precede transfer creation.
- Scheduling classification uses configurable demo parameters.

## Relationship Rules

- Child records must reference an existing parent.
- Transfer source and destination sites must differ.
- Exception records must reference existing synthetic records and items.

## Duplicate Rules

Duplicate detection uses a configurable fictional logical key. The public repository intentionally does not publish a private organization's real uniqueness predicate.

## Analytical Reconciliation

- Card totals should reconcile with drill-down records.
- Distinct record counts must not be inflated by line-item joins.
- Unknown value and zero value must remain distinguishable.
- Fact-table grain must be documented for every measure.

## Publication Boundary

Do not add organization-specific status vocabularies, eligibility conditions, real thresholds, real timing windows, or private process rules to this document.