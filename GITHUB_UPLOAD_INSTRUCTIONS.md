# GitHub Upload Instructions

## Option A — Git command line (recommended)

1. Create a new **empty** GitHub repository. Suggested name: `prescription-operations-analytics`.
2. Do not initialize it with a README, license, or `.gitignore` because those files already exist locally.
3. Extract the ZIP and open a terminal inside `prescription-operations-analytics-portfolio`.
4. Run:

```bash
git init
git branch -M main
git add .
git status
git commit -m "Initial portfolio release"
git remote add origin https://github.com/YOUR-USERNAME/prescription-operations-analytics.git
git push -u origin main
```

5. On GitHub, add repository topics such as:

`data-analytics`, `business-analysis`, `power-bi`, `sql`, `python`, `streamlit`, `data-modeling`, `kpi`, `portfolio`

6. In **About**, use a short description such as:

`Synthetic multi-branch operations analytics portfolio demonstrating KPI design, SQL, Python, Power BI modeling, data quality, and business requirements.`

## Option B — GitHub web upload

1. Create an empty repository on GitHub.
2. Choose **Add file → Upload files**.
3. Upload the extracted repository contents, preserving folders.
4. Commit with message `Initial portfolio release`.

The command-line method is preferred because it preserves the complete directory structure more reliably.

## Before publishing

- Open `PRIVACY_SCAN_REPORT.txt` and confirm it says PASS.
- Do not add private PBIX files, local databases, exports, `.env` files, credentials, or original business datasets.
- If you later build a PBIX from the sample data, confirm that it imports only files under `data/sample/` before publishing it.
