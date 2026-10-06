# Final Release Validation

## Release scope

This hardening release improves analytical regression coverage, presentation clarity, Power BI documentation alignment and repository quality gates while preserving the synthetic-data and publication-safety boundaries.

## Automated analytics checks

Fresh CI validates the committed analytics sample:

- 500 records;
- 1,185 record-item lines;
- 49 shortage rows;
- 8 branches;
- 12 items;
- 372 Done;
- 128 Not Yet;
- 74.4% completion rate;
- SAR 82,760.75 known value;
- 47 N/A-value records;
- 158 Delivered records;
- channel counts;
- monthly total reconciliation;
- 126 shortage units;
- 24 affected shortage records.

## Publication-safety checks

The existing privacy gates remain active:

- prohibited extensions/directories;
- artifact-size controls;
- explicit approval for the synthetic presentation image only;
- realistic identity-pattern scans;
- internal-host and secret-pattern scans;
- private-terminology scans;
- synthetic identifier checks;
- referential checks;
- Markdown-link checks.

## Runtime boundaries

- Python/pandas analytics: implemented and executed in CI tests.
- Streamlit/Plotly application: implemented source artifact.
- SQL Server-compatible model and KPI queries: implemented source artifacts; SQL Server runtime is not provisioned in CI.
- Power BI: design blueprint only; no PBIP/PBIR/TMDL/PBIX execution artifact is claimed.
- Generic governance model: separate synthetic design layer, not the Streamlit analytics dataset.
- Real dashboard screenshots: not claimed.

## Synthetic-data reproducibility boundary

The committed `data/sample/` analytics files are validated as fixed public fixtures.

This release does **not** claim that those files are regenerated from a fixed random seed because no generator for that specific dataset is retained in the repository.
