# Prescription Transfers

## Transfer types

### Pre-Dispense Transfer

Moves an unfinished WL workflow to another Pharmacy. After acceptance, the
destination can continue the normal prescription process.

### Delivery Transfer

Moves delivery responsibility after dispensing. The destination receives a
delivery-only context and cannot reopen Wasfaty, Solver, or item editing.

### Return to Original Pharmacy

Returns delivery responsibility to the Pharmacy where the transfer chain began.
The stored original reference remains stable across multiple hops.

## Lineage model

| Reference | Meaning |
|---|---|
| Original Prescription | First prescription in the transfer chain |
| Source Prescription | Record that initiated the current transfer |
| Destination Prescription | Record linked or created when the destination accepts |
| Original Pharmacy | Pharmacy where the chain began |
| From Pharmacy | Sender for the current hop |
| To Pharmacy | Intended receiver for the current hop |

## States

- `Pending Receipt`: created but not accepted.
- `Received`: destination accepted and the destination context is active.
- `Cancelled`: no longer receivable.

Return-related timestamps and audit actions preserve additional historical facts
without erasing the original chain.

## Acceptance security

The receiver is derived from the authenticated user's Pharmacy. The handler loads
a pending transfer where `ToPharmacyId` matches that Pharmacy and rejects stale,
cancelled, already-received, or otherwise invalid state.

## Optimistic concurrency

`RowVersion` prevents two users from accepting or returning the same transfer
simultaneously. A concurrency conflict results in a controlled reload/message,
not a second destination workflow.

## Duplicate guard interaction

An active outgoing transfer blocks normal WL Duplicate. Delivery-only and return
destinations also cannot use the standard duplicate path to escape their restricted
workflow.
