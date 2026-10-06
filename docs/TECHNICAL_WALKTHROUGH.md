# Technical Walkthrough — 60–90 Seconds

**0–10 seconds — Scope**

Prescription Operations Analytics is a synthetic multi-branch operations project combining pandas analytics, Streamlit/Plotly reporting, SQL Server-compatible queries and publication-safety governance.

**10–25 seconds — Analytics grain**

The main analytics dataset contains 500 records, 1,185 item lines, 49 shortage rows, 8 branches and 12 items. The primary record grain is one operational record, while item lines and shortage requirements remain separate child grains.

**25–45 seconds — KPI logic**

The analytics layer measures Done versus Not Yet records, completion rate, known value, missing-value counts, channel performance, monthly record trends and shortage requirements. Unknown value stays N/A rather than being converted to zero.

**45–60 seconds — Actionable aggregation**

Shortage demand is grouped by Item + Branch, and affected records use distinct record count. This avoids inflating operational demand through line-level joins.

**60–75 seconds — Delivery layers**

pandas functions provide reusable calculations, Streamlit supplies the interactive application, and SQL Server-compatible views/queries mirror the same analytical definitions. Power BI is documented as a design blueprint only.

**75–90 seconds — Governance**

A separate generic synthetic governance model demonstrates security, workflow, transfer and publication controls. Automated tests scan for prohibited artifacts, private terminology, identity-like values, broken links and data-quality failures before publication.
