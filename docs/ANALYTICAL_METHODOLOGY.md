# Analytical Methodology

This methodology belongs to the **Operational Analytics Companion** and consumes `data/sample/`.

It remains separate from the generic governance model under `sample-data/`.

1. **Define the business grain.** One row in the main record fact equals one operational record.
2. **Normalize categorical states.** Status, channel, delivery and reasons use controlled values.
3. **Separate facts from dimensions.** Branch and item descriptors are modeled independently.
4. **Preserve history.** Item-line price snapshots remain stable even if current item reference values change.
5. **Handle missing values explicitly.** Unknown value is N/A and remains different from true zero.
6. **Aggregate for action.** Shortage demand is summarized by Item + Branch and affected records are counted distinctly.
7. **Validate totals at compatible grain.** Record KPIs must not be inflated through item-line joins.
8. **Reconcile analytical layers.** Python tests and SQL definitions use the same KPI contract; any future Power BI runtime should reconcile to the same baseline.
9. **Avoid unsupported claims.** All numerical findings are limited to the committed synthetic sample.

Confirmed KPI definitions are maintained in [KPI_DEFINITIONS.md](KPI_DEFINITIONS.md).
