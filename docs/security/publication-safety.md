# Publication Safety

## Principle

The private application is a source of architectural understanding, not a folder
to synchronize with GitHub. Public artifacts are created through an explicit
allowlist and sanitization process.

## Never publish

- Databases, backups, App_Data, or attachments.
- Real Excel imports/exports or screenshots.
- Real identity, patient, prescription, Pharmacy, employee, or pricing data.
- Passwords, credentials, tokens, certificates, or User Secrets.
- Production/Development connection strings, hostnames, or machine paths.
- Company-only release/deployment documentation or unapproved branding.
- Full unreviewed PageModels, services, migrations, or configuration.

## Safe construction process

```text
Understand private source read-only
-> Select one concept
-> Recreate a generic artifact
-> Record action in sanitization manifest
-> Run automated scans
-> Perform manual privacy/IP review
-> Review Git diff
-> Commit only after approval
```

## Synthetic-data standard

Synthetic identifiers use explicit prefixes such as `DEMO-` and `SYN-`. They do
not mimic valid national identifiers, emails, phone numbers, Pharmacy codes, or
prescription numbers. Prices, dates, statuses, and item names are constructed for
coverage rather than copied from operations.

## Controls in this repository

- `PUBLICATION_ALLOWLIST.md`
- `PUBLICATION_DENYLIST.md`
- `SANITIZATION_MANIFEST.md`
- Public-safe `.gitignore`
- PowerShell validation scripts
- pytest publication and sample-data tests
- GitHub Actions without private credentials

Passing an automated scan does not replace manual review.
