# Public Publication Allowlist

This repository uses an explicit review-first publication model. Content may be added only after it has been reviewed, classified as safe for public release, and validated against `PUBLICATION_DENYLIST.md` and `SANITIZATION_MANIFEST.md`.

## Allowed content categories

- Public documentation written for an external audience.
- Synthetic datasets with documented provenance that do not represent real people, prescriptions, branches, employees or company transactions.
- Deterministically generated synthetic data only when the generator and regeneration evidence are retained.
- Screenshots or presentation graphics generated exclusively from synthetic data.
- Generic architecture, workflow, security and data-model diagrams.
- Sanitized SQL schema, analytics and validation examples.
- Generic software-engineering examples.
- Generic business-workflow documentation.
- KPI definitions and calculation methodology.
- Data-quality and validation methodology.
- Security design documentation that excludes exploitable environment details.
- Technical decisions and lessons learned.
- Reproducible tests and publication-safety scripts.
- Open-source dependency and license notices.

## Approved presentation asset

The following synthetic presentation asset is explicitly approved:

`docs/assets/Prescription Operations Analytics Dashboard.png`

Because it is a generated presentation graphic, automated safety checks permit this exact PNG to exceed the repository's normal 1 MB artifact threshold, with a strict maximum of 2 MB.

This exception does not apply to any other file.

## Review rule

Anything not explicitly reviewed and classified safe to publish must not be copied or committed automatically.

## Required validation

Every candidate item must pass, as applicable:

1. Secret and credential scanning.
2. PII and real-data scanning.
3. Internal path, hostname and infrastructure scanning.
4. Branding and intellectual-property review.
5. Synthetic-data provenance verification.
6. Automated analytical and publication-safety tests.
7. Manual staged-diff review before release.
