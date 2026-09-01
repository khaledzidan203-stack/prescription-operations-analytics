# ADR-004: SQL-Enforced Active Logical Uniqueness

## Context

Two concurrent imports can pass an application `AnyAsync` duplicate check before
either transaction commits.

## Decision

Keep the friendly application pre-check and add a unique SQL index over the
normalized logical key plus an active-state discriminator.

## Why

- SQL Server is the final concurrency authority.
- Active New/In Progress duplicates are impossible after commit.
- Historical rows do not block a legitimate future cycle.

## Alternatives

- Application check only.
- Serializable isolation for the entire import.
- Permanent uniqueness across active and historical records.

## Trade-offs

The computed discriminator and named-index error handling add schema complexity.

## Consequences

SQL duplicate errors are converted into a friendly rolled-back `Already Waiting`
result. Import code must normalize keys consistently with the index.
