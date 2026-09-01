# Internal Chat

## Purpose

Internal Chat supports operational collaboration between authorized users without
placing messages or attachments in public browser storage.

## Conversation model

- Direct conversations connect two participants.
- A deterministic direct key avoids creating duplicate direct conversations.
- Participants link users to conversations and track `LastReadAtUtc`.
- Messages retain sender, body, UTC timestamp, attachments, and optional location.
- Admin broadcast creates deliveries to eligible Pharmacy recipients while keeping
  participant authorization for each resulting conversation.

## User experience

- Recipient search is role-aware.
- Conversation list shows last activity and unread counts.
- Message history is paginated.
- Sending a message updates last-activity state and notification behavior.
- Location sharing creates a structured location message.

## Authorization

Every conversation read, send, location-share, and attachment-download operation
requires the authenticated user to be a participant. Conversation IDs and
attachment IDs alone do not grant access.

## Message constraints

- Message text is normalized and length-limited.
- A message can carry validated attachments.
- Failed database persistence triggers cleanup of newly stored files.
- Broadcast is restricted to the authorized Admin path and recorded in AuditLog.

## Attachment boundary

Attachment bytes are stored privately, while SQL stores metadata. See
[`attachment-security.md`](../security/attachment-security.md) for validation,
storage, and download controls.
