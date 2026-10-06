# Presentation Assets

This directory contains presentation-only visual assets for Prescription Operations Analytics.

## Current overview

`Prescription Operations Analytics Dashboard.png`

The root README uses this image as a high-level visual summary of the analytical workflow.

## Evidence-supported scope

The repository supports:

- 500 synthetic operational records;
- 1,185 record-item lines;
- 49 shortage rows;
- 8 fictional branches;
- 12 synthetic items;
- 372 Done / 128 Not Yet records;
- 74.4% completion rate;
- SAR 82,760.75 known record value;
- 47 records with unknown value;
- 158 Delivered records;
- 126 open shortage units affecting 24 records;
- pandas analytical functions;
- Streamlit + Plotly application source;
- SQL Server-compatible schema, views and KPI queries;
- automated analytical and publication-safety tests;
- a separate generic workflow-governance model;
- Power BI design documentation only.

## Evidence boundary

The infographic is a **presentation schematic**, not a captured Streamlit screenshot.

Exact runtime and implementation status is governed by the repository:

- Python/pandas analytics — implemented.
- Streamlit/Plotly — implemented source artifact.
- SQL Server — source artifacts committed; SQL runtime is not executed in CI.
- Power BI — blueprint only; no PBIP/PBIR/TMDL/PBIX runtime artifact.
- Generic workflow model — separate synthetic design layer.
- Excel-style visual iconography, if visible in the schematic, is illustrative only; this repository does not claim an Excel analytical artifact.
- Branch-performance and shortage visuals in the schematic summarize analytical concepts; exact implemented Streamlit sections are documented in the README and `app.py`.

## Publication-safety note

The image is synthetic and is the only specifically approved presentation asset allowed above the repository's normal 1 MB artifact-size threshold. It remains capped at 2 MB by automated publication checks.

Presentation assets do not replace source data, test evidence, SQL execution evidence, Power BI runtime evidence or real operational screenshots.
