# Notifications

## Purpose

Notifications convert important workflow events into recipient-specific action
signals without making the notification table the workflow source of truth.

## Capabilities

- Notify one user.
- Notify active users belonging to a Pharmacy.
- Notify Admin users.
- Store title, message, event type, target URL, and creation time.
- Track read/unread state.
- Return unread counts and a compact unread-state payload.
- Mark one or all notifications as read.
- Open an authorized notification and redirect to its target.

## Deduplication

Operational callers can provide a deterministic deduplication key. This prevents
retries from creating repeated notifications for the same business event while
allowing distinct events to remain visible.

## Representative events

- Incoming records assigned to a Pharmacy.
- Delivery request or Admin pull changes.
- Transfer created or accepted.
- Procurement batch created for a Pharmacy.
- Internal chat message activity.

## Security

Read, open, and mark-read operations filter by the authenticated user. A user
cannot open another recipient's notification by changing an ID in the request.
