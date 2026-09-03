# System Context

## Purpose

The platform is a central prescription-operations system for a network of
pharmacies. It coordinates transactional work and exposes governed operational
analytics while preserving pharmacy-level ownership.

## Actors and external boundaries

| Actor/system | Interaction |
|---|---|
| Pharmacy user | Processes owned incoming records, prescriptions, shortages, delivery, transfers, notifications, and chat |
| Admin user | Imports and routes records, manages pharmacies, pulls delivery/procurement batches, and reviews network analytics |
| SQL Server | Stores identity, workflow state, relationships, audit records, and reporting data |
| Private file storage | Stores chat attachment bytes outside the public web root |
| Excel files | Controlled import and export boundary with validation and rejected-row reporting |
| Browser | Renders Razor Pages and submits commands; it is not a business datastore |

## Trust statement

The browser is untrusted for ownership. `PharmacyId`, workflow state, prices,
eligibility, and attachment access are re-derived or revalidated on the server.
SQL Server is the source of truth; LocalStorage is not used for business
persistence.

## Context diagram

See [`diagrams/source/01_system_context.md`](../../diagrams/source/01_system_context.md).

## Public portfolio boundary

The public repository contains documentation, synthetic data, analytics code,
generic SQL, and curated examples. It excludes the private application source,
databases, attachments, credentials, configuration, and operational exports.
