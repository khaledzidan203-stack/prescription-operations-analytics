# Portfolio Notes

## What I personally built

I designed the business workflow, analytical logic, KPI framework, data model, dashboard structure, validation rules, and reporting requirements that this public portfolio edition demonstrates. I also translated operational requirements into technical specifications covering branch scoping, status workflows, historical pricing, item requirements, search/filter behavior, and management dashboards.

This repository is a confidentiality-safe reconstruction for portfolio use, not a dump of private production source code.

## Analytical skills demonstrated

- Translating an operational process into measurable states and KPIs
- Defining grain, keys, relationships, and aggregation rules
- Separating unknown values from zero values
- Designing branch/network analysis with consistent filters
- Building shortage and item-requirement summaries
- Creating reusable Python and SQL calculation logic
- Designing a Power BI semantic model and DAX measures
- Testing data quality and calculation edge cases

## Business problems solved

- Fragmented operational tracking across branches
- Inconsistent definitions of completion and pending work
- Limited visibility of item shortages by location
- Difficulty separating known financial value from missing values
- Need for branch-level accountability and management-level oversight
- Need for a documented, repeatable reporting model

## Technologies used

Python, pandas, Streamlit, Plotly, SQL Server-compatible SQL, Power BI modeling concepts/DAX, Git/GitHub documentation practices.

## Interview discussion points

- Why the record grain matters and how duplicate counting is prevented
- Why historical unit-price snapshots are safer than joining only to current prices
- Why N/A must remain different from zero
- How to design branch-level filters without breaking metric definitions
- How item requirements should be grouped by Item + Branch for actionability
- How I would scale the model from a synthetic demo to a governed enterprise semantic model
- How requirements, data quality, security, and analytics were documented together
