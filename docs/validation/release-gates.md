# Release Gates

A public change is publishable only when all applicable gates below pass.

## Gate 1 — Synthetic Data

- Required synthetic files parse successfully.
- Identifiers follow documented demo patterns where applicable.
- References are valid.
- Quantities are positive where required.
- No realistic identity-number patterns are present.
- Any reproducibility claim is backed by a retained generator or equivalent evidence.

## Gate 2 — Terminology

- Generic governance workflow categories use only fictional public labels.
- No private acronym or internal workflow name is present.
- No public-to-private reverse mapping exists.

## Gate 3 — Business Logic

- Demonstration thresholds are configurable or explicitly synthetic.
- No private approval, queue, export, fulfilment, transfer or exception sequence is documented.
- Analytics-companion and governance-model terminology remain clearly separated.

## Gate 4 — Security & Configuration

- No credentials, secrets, private keys, connection strings, internal hosts or private paths.
- No database backups or binary BI runtime files.
- No real screenshots or attachments.
- The only presentation asset above 1 MB is the explicitly approved synthetic PNG, capped at 2 MB.

## Gate 5 — Analytical Quality

- `python scripts/validate_repository.py` passes.
- `python -m pytest -q` passes.
- Publication-safety tests pass.
- Relative Markdown links resolve.
- KPI baselines reconcile to committed synthetic analytics fixtures.

## Gate 6 — Automation

- Analytical/documentation validation completes successfully.
- Publication-safety scan completes successfully.

## Gate 7 — Manual Review

Review the repository as an outsider and ask whether any artifact could reveal private terminology, real data, confidential infrastructure or a reconstructable proprietary operating model. If yes, the release fails even if automated tests pass.
