# Sanitization Manifest

This manifest governs future changes to the public portfolio. It intentionally avoids listing private source paths, private class names, internal workflow names, or one-to-one mappings from a confidential project.

## Public-Safe Content Classes

| Content Class | Public Action | Required Treatment |
|---|---|---|
| Generic entity examples | Allowed | Use fictional names and synthetic identifiers |
| Generic validation patterns | Allowed | Use configurable fictional rules |
| Generic authorization patterns | Allowed | Use `Site` ownership terminology only |
| Generic SQL constraints/indexes | Allowed | Rebuild independently; do not mirror a private schema |
| Generic analytics code | Allowed | Use synthetic fields and fictional workflow categories |
| Power BI documentation | Allowed | Use synthetic sources and generic measures |
| Synthetic datasets | Allowed | Revalidate provenance and ensure they do not encode real rules |
| Architecture diagrams | Allowed | Use generic components and fictional flows |
| Private application source | Do not publish | Rebuild concepts independently if needed |
| Production/development configuration | Do not publish | Never copy |
| Database files | Do not publish | Never copy |
| Real imports/exports/reports | Do not publish | Generate synthetic alternatives |
| Real screenshots | Do not publish | Recreate with synthetic data |
| Company branding | Do not publish | Use neutral branding |
| Internal deployment documentation | Do not publish | Replace with generic portfolio deployment notes only |

## Prohibited Reverse Mapping

The public repository must never contain a statement such as:

```text
Public Demo Label = Private Internal Label
```

This includes direct mappings, abbreviations, comments, filenames, examples, diagrams, commit messages, and documentation notes.

## Business-Logic Sanitization Rules

Do not publish:

- real eligibility thresholds;
- real timing windows;
- original status names when they are organization-specific;
- actual approval or handoff sequences;
- real role responsibilities if they reveal internal structure;
- private queue, batch, export, transfer, fulfilment, or exception procedures;
- combinations of generic-looking details that reconstruct the original operating model.

Use fictional configurable parameters such as `DemoThreshold`, `DueWindowDays`, and generic statuses such as `Open`, `Completed`, and `Deferred`.

## Release Procedure

1. Confirm every changed artifact is understandable without private context.
2. Search for private terminology, internal acronyms, company names, paths, hostnames, credentials, and real identifiers.
3. Search for reverse mappings between fictional and private terminology.
4. Review thresholds, dates, states, and workflow sequences for mosaic inference risk.
5. Run automated publication-safety checks.
6. Review the complete Git diff manually.
7. Publish only synthetic or generic artifacts.

## Historical Note

This manifest is intentionally one-way: it defines what may exist publicly without documenting the names or structure of any private source system.