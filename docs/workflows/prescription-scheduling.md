# Prescription Scheduling

## Scope

Scheduling applies to active, non-archived WL prescriptions where:

- `WasfatyStatus = Not Yet`.
- `NextFillAtUtc` has a value.
- The record belongs to the authenticated Pharmacy for Pharmacy views.

Run-X and Pick-up do not enter these queues.

## Saudi business-date boundaries

Timestamps are stored in UTC. Queue boundaries are calculated from Saudi Today
using a centralized business-time helper, then converted to UTC for SQL queries.
This prevents host-machine timezone settings from changing operational dates.

## Queue definitions

### Upcoming

`NextFillAtUtc > current UTC time`.

There is no maximum future horizon. A later time today and dates weeks or months
ahead are Upcoming.

### Due

Saudi Next Fill date from Today through Today+5 inclusive. The SQL range is:

```text
Saudi Today start UTC <= NextFillAtUtc < Saudi (Today+6) start UTC
```

Today remains Due even when the scheduled time has passed.

### Overdue

Saudi Next Fill date before Today:

```text
NextFillAtUtc < Saudi Today start UTC
```

## Overlap behavior

- Due and Overdue never overlap.
- Upcoming is a future-time view and may overlap Due for future times inside the
  six-day Due window; it answers a different operational question.
- Archived, completed, or unscheduled records are excluded.

## Consistency rule

Pages, navigation counters, search filters, and dashboards should reuse the same
schedule helper. Reimplementing date boundaries independently can create queue and
counter mismatches.
