# Generic Domain Model

## Modeling Approach

The public model separates synthetic record intake, workflow occurrences, record lines, exceptions, transfers, fulfilment events, collaboration, and auditability. The goal is to demonstrate explicit grain and reusable architecture patterns without reproducing a private system schema.

## Domain Groups

### Identity and Site Scope

- `Site` is the synthetic ownership boundary.
- `ApplicationUser` may belong to one demo Site.

### Intake

- `ImportBatch` represents one validated synthetic upload.
- `IncomingRecord` represents one routed portfolio record.
- Duplicate detection uses a configurable fictional logical key.

### Workflow Records

- `OperationalRecord` represents one workflow occurrence.
- `RecordLine` stores quantity and optional historical value snapshot.
- Workflow categories are `Workflow Alpha`, `Workflow Beta`, and `Workflow Gamma`.
- Unknown values remain nullable.

### Exceptions and Resource Analysis

- `ExceptionRecord` captures an unresolved synthetic requirement.
- `ResourceSnapshot` preserves a historical analytical view when required.

### Fulfilment and Transfers

- `FulfilmentEvent` represents a generic service-completion event.
- `TransferEvent` records source/destination lineage between synthetic sites.

### Collaboration and Governance

- `Notification` is recipient-specific.
- `Conversation` and `Message` demonstrate collaboration modeling.
- `AuditEvent` records important mutations with timestamps and generic identifiers.

## Persistence Principles

- Server-side persistence is treated as the source of truth.
- UTC timestamps are stored where time-zone-safe analysis is required.
- Client-supplied ownership and workflow state are revalidated by backend examples.
- Constraints, unique indexes, and row versions demonstrate defense-in-depth.
- Timing windows and thresholds remain configurable demo parameters.

## Publication Boundary

The public entity names, relationships, and workflow categories are fictional. Do not replace them with real company table names, internal status names, thresholds, operating sequences, or schema mappings.