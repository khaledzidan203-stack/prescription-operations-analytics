# Release Gates

A public portfolio change is publishable only when all gates below pass.

## Gate 1 — Synthetic Data

- Required synthetic files parse successfully.
- Identifiers follow explicit demo patterns.
- References are valid.
- Quantities are positive where required.
- No realistic identity-number patterns are present.

## Gate 2 — Terminology

- Workflow categories use only fictional public labels.
- No private acronym or internal workflow name is present.
- No public-to-private reverse mapping exists.

## Gate 3 — Business Logic

- Thresholds are configurable fictional parameters.
- Scheduling windows are configurable.
- No real approval, queue, export, fulfilment, transfer, or exception sequence is documented.

## Gate 4 — Security & Configuration

- No credentials, secrets, private keys, connection strings, internal hosts, or private paths.
- No database backups or binary BI files.
- No real screenshots or attachments.

## Gate 5 — Quality

- `python -m pytest -q` passes.
- Publication-safety tests pass.
- Relative Markdown links resolve.
- GitHub Actions complete successfully.

## Gate 6 — Manual Review

Review the repository as an outsider and ask: could these artifacts reveal a specific employer, private terminology, or reconstruct a proprietary operating model? If yes, the release fails even if automated tests pass.
