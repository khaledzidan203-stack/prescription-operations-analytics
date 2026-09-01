# Analytical Methodology

This methodology belongs to the **Operational Analytics Companion**. It consumes
synthetic flattened facts and remains intentionally separate from the private
transactional application. Confirmed operational KPI definitions are maintained
in [`kpi_dictionary/operational-kpis.md`](kpi_dictionary/operational-kpis.md).

1. **Define the business grain.** One row in the main fact equals one operational record.
2. **Normalize categorical states.** Status, channel, delivery, and reasons use controlled values.
3. **Separate facts from dimensions.** Branch and item descriptors are modeled independently.
4. **Preserve history.** Item-line price snapshots are retained even if the item master changes.
5. **Handle missing values explicitly.** Unknown value is tracked as N/A and excluded from known-value sums.
6. **Aggregate for action.** Shortage demand is summarized by Item + Branch, not Item alone.
7. **Validate calculations across layers.** Python tests, SQL queries, and Power BI measures use the same definitions.
8. **Avoid claims beyond the data.** Insights in this repo are illustrative and reproducible from synthetic data only.
