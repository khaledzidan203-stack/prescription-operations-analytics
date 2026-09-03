# Concise Threat Model

## Protected assets

- Prescription and patient-linked operational records.
- Pharmacy ownership and workflow state.
- Identity accounts and role assignments.
- Item/value history and procurement decisions.
- Delivery/transfer lineage.
- Notifications, chat messages, locations, and attachments.
- Audit records and database integrity.

## Trust boundaries

1. Browser to ASP.NET Core application.
2. Application to SQL Server.
3. Application to private attachment storage.
4. Excel files entering or leaving the application.
5. Admin network scope versus Pharmacy-owned scope.

## Representative threats and controls

| Threat | Primary controls |
|---|---|
| Cross-pharmacy IDOR | Server-derived PharmacyId, scoped database predicates, backend workflow guards |
| Role escalation | ASP.NET Core Identity and role authorization on PageModels |
| Duplicate concurrent import | Application pre-check plus SQL unique active logical key |
| Lost update/double transfer receipt | `RowVersion` and concurrency exception handling |
| Historical price manipulation | Server-resolved price and immutable UnitPriceSnapshot behavior |
| Malicious attachment | Type allowlist, size, Content-Type/signature checks, private storage |
| Path traversal | Canonical path containment checks and generated storage names |
| Unauthorized chat download | Conversation participant validation before streaming |
| Spreadsheet injection or malformed import | Controlled parsing, required headers, row validation, rejected reports |
| Workflow bypass | Reload authoritative state and re-run eligibility in POST handlers |
| Secret/data publication | Allowlist/denylist, synthetic data, scans, staged-diff review |

## Known improvement areas

- Content Security Policy and broader response-header hardening.
- Formal automated multi-tenant integration tests.
- Attachment malware scanning and retention automation.
- Operational health checks and retry policy.

These are improvement areas, not claims that the current design lacks its core
authorization and data-integrity controls.
