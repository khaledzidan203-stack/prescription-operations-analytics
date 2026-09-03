# ADR-005: Private Attachment Storage

## Context

Chat attachments may contain operational content and must not be exposed by a
guessable static URL.

## Decision

Store metadata in SQL Server and bytes in a private directory outside the public
web root. Stream downloads through an authorized participant handler.

## Why

- Prevent direct static access.
- Keep relational authorization and message context in SQL.
- Allow filesystem ACLs, retention, and backup policies independent of web assets.

## Alternatives

- Store under `wwwroot`.
- Store all bytes in SQL.
- Use object storage with signed URLs.

## Trade-offs

Filesystem and database operations require compensation cleanup and coordinated
backup/retention. Multi-server deployment would require shared storage.

## Consequences

Uploads use type/signature/size/path validation and generated names. Deployment
must provision a least-privilege external storage root.
