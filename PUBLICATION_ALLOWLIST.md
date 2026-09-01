# Public Portfolio Publication Allowlist

This repository uses an explicit review-first publication model. Content may be
added only after it has been reviewed, classified as `SAFE TO PUBLISH`, and
validated against `PUBLICATION_DENYLIST.md` and `SANITIZATION_MANIFEST.md`.

## Allowed content categories

- Portfolio documentation written for a public audience.
- Deterministic synthetic datasets that cannot represent real people,
  prescriptions, pharmacies, employees, or company transactions.
- Screenshots generated exclusively from synthetic demo data.
- Generic architecture, workflow, security, and data-model diagrams.
- Sanitized SQL schema, analytics, and validation examples.
- Sanitized EF Core and Razor Pages examples.
- Generic business-workflow documentation.
- KPI definitions and calculation methodology.
- Data-quality and validation methodology.
- Security design documentation that excludes exploitable environment details.
- Technical decisions and lessons learned.
- Reproducible portfolio tests and publication-safety scripts.
- Open-source dependency and license notices.

## Review rule

Anything not explicitly reviewed and classified `SAFE TO PUBLISH` must not be
copied, generated, or committed automatically. Being present in the private
application source does not make an item safe for this public repository.

## Required validation

Every candidate item must pass, as applicable:

1. Secret and credential scanning.
2. PII and real-data scanning.
3. Internal path, hostname, and infrastructure scanning.
4. Branding and intellectual-property review.
5. Synthetic-data provenance verification.
6. Manual staged-diff review before commit or push.
