# Power BI Build Guide

Load the five CSV files from `data/sample/`. Set date and numeric types explicitly, then create relationships documented in `DATA_MODEL.md`.

Recommended pages:

1. Executive Overview
2. Channel Analysis
3. Item Requirements
4. Branch Performance
5. Data Quality

Recommended slicers: Date, City, Branch, Channel, Final Status.

The repository does not include a `.pbix` file because binary BI files are difficult to review in Git and may embed data. This documentation is designed to make the model reproducible.
