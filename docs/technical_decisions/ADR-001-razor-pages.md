# ADR-001: ASP.NET Core Razor Pages

## Context

The application is workflow-heavy, form-oriented, and organized around role-based
operational pages rather than a public API and independent SPA.

## Decision

Use ASP.NET Core Razor Pages with PageModels for server-rendered UI, binding,
authorization, and workflow orchestration.

## Why

- Direct mapping between an operational page and its handlers.
- Built-in Identity, authorization, validation, and antiforgery integration.
- Server-side rendering keeps authoritative workflow decisions on the backend.
- Appropriate deployment profile for a Windows Server/IIS environment.

## Alternatives

- MVC controllers/views.
- SPA plus Web API.
- Separate microservices per workflow.

## Trade-offs

Large PageModels can accumulate too many responsibilities. Shared services and
query helpers are needed as workflows grow.

## Consequences

The codebase remains a modular monolith. New pages must keep mutations thin and
reuse domain/query services rather than duplicating rules.
