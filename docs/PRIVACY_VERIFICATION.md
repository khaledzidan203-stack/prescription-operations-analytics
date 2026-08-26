# Privacy Verification

Before publishing:

1. Confirm all data files are synthetic.
2. Search the repository for emails, phone numbers, National-ID-like labels, passwords, tokens, API keys, `Server=`, internal hostnames, and private file paths.
3. Confirm screenshots are generated from synthetic data.
4. Confirm `.env`, PBIX files containing imported private data, exports, and local databases are ignored.
5. If a secret is ever committed, rotate it and remove it from Git history; deleting only the latest file is not sufficient.

A machine-generated scan summary is included in `PRIVACY_SCAN_REPORT.txt`.
