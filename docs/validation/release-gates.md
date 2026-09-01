# Reusable Release Gates

## Gate sequence

```text
Build
-> 0 Errors
-> 0 unintended Warnings
-> EF model/migration consistency
-> Workflow validation
-> Security validation
-> Synthetic-data validation
-> Publication scan
-> Git review
-> Release approval
```

## 1. Build

- Run a clean Release build.
- Require zero errors.
- Investigate warnings; do not normalize unexpected warnings as acceptable.

## 2. EF model and database boundary

- List migrations in order.
- Check for pending model changes.
- Confirm the intended database/environment before any update.
- Compare Production migration history independently; never infer it from source.
- Take and verify a database backup before approved Production schema work.

## 3. Workflow checks

- Pharmacy isolation and cross-Pharmacy URL/POST attempts.
- WL edit/duplicate/delivery/transfer guards.
- Run-X and Pick-up Done/Not Yet item rules.
- SAR 200 exact boundary for Run-X.
- Upcoming/Due/Overdue date boundaries.
- Missing Items, Procurement, Delivery, and Transfer concurrency.
- Excel import/export handlers and filter propagation.

## 4. Security checks

- Roles and inactive/password-change behavior.
- Backend ownership and participant validation.
- Attachment validation/private storage.
- Secret/configuration scan.
- Audit coverage for critical mutations.

## 5. Portfolio checks

- Synthetic data parses and uses explicit synthetic identifiers.
- Denied file types/directories are absent.
- No credentials, internal paths, hostnames, or realistic identifiers.
- Markdown links resolve.
- Git diff and staged content receive manual review.

## Confirmed validation history

The private project final source verification on 2026-08-24 recorded a Release
build with 0 errors and 0 warnings, all 16 Development migrations applied, and no
pending EF model changes. That historical gate did not modify or validate a
Production database. The active application is not built or run by this public
portfolio phase.
