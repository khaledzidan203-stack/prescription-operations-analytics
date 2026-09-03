# Suggested DAX Measures

The measures below use fictional workflow labels and configurable analytical parameters.

```DAX
Total Records = DISTINCTCOUNT(FactRecord[record_id])

Completed Records =
CALCULATE([Total Records], FactRecord[status] = "Completed")

Open Records =
CALCULATE([Total Records], FactRecord[status] = "Open")

Completion Rate = DIVIDE([Completed Records], [Total Records])

Known Record Value = SUM(FactRecord[known_value])

Value N/A Records =
CALCULATE([Total Records], ISBLANK(FactRecord[known_value]))

Exception Records =
CALCULATE([Total Records], FactRecord[has_exception] = TRUE())

Open Exception Qty =
CALCULATE(SUM(FactException[required_qty]), FactException[status] = "Open")

Records Affected by Exceptions = DISTINCTCOUNT(FactException[record_id])
```

Do not replace blank `known_value` with zero when the analytical distinction between unknown and true zero is important.

## Workflow Measures

```DAX
Workflow Alpha Records =
CALCULATE(
    [Total Records],
    FactRecord[workflow_category] = "Workflow Alpha"
)

Workflow Beta Records =
CALCULATE(
    [Total Records],
    FactRecord[workflow_category] = "Workflow Beta"
)

Workflow Gamma Records =
CALCULATE(
    [Total Records],
    FactRecord[workflow_category] = "Workflow Gamma"
)

Operational Value N/A =
CALCULATE(
    [Total Records],
    ISBLANK(FactRecord[known_value])
)
```

## Configurable Threshold Example

If a portfolio scenario needs a threshold analysis, use a fictional parameter rather than a real business rule.

```DAX
Records Below Demo Threshold =
VAR DemoThreshold = 150
RETURN
CALCULATE(
    [Total Records],
    NOT ISBLANK(FactRecord[known_value]),
    FactRecord[known_value] <= DemoThreshold
)
```

`150` is an arbitrary demonstration value and must not be interpreted as a real operational threshold.

## Date Logic

Future, Due, and Overdue measures should be based on a proper Date dimension and a configurable reporting window. Do not encode real employer-specific timing rules in the public model.
