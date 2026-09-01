# Sanitization Manifest

This manifest governs any future transfer from the private application source
into this public portfolio. No transfer is authorized merely because it appears
in this table; each item still requires the stated validation.

| Source Item | Classification | Public Destination | Action | Sanitization Required | Validation Required | Notes |
|---|---|---|---|---|---|---|
| `Models/Prescription.cs` | SANITIZE FIRST | `examples/ef-core/Prescription.example.cs` | Extract generic entity architecture only | Yes | Yes | Do not copy company-specific or patient-identifying fields blindly |
| `Models/PrescriptionItem.cs` | SANITIZE FIRST | `examples/ef-core/PrescriptionItem.example.cs` | Demonstrate quantity and historical price snapshot concepts | Yes | Yes | Use generic names and no production identifiers |
| `Models/IncomingRecordTypes.cs` | SANITIZE FIRST | `examples/validation/RecordTypeNormalization.example.cs` | Extract canonical-value normalization pattern | Yes | Yes | Public terminology must remain generalized where required |
| `Data/ApplicationDbContext.cs` | SANITIZE FIRST | `examples/ef-core/PortfolioDbContext.example.cs` | Extract selected relationship, index, and constraint patterns | Yes | Yes | Never copy connection or environment configuration |
| `Data/SaudiTimeHelper.cs` | SANITIZE FIRST | `examples/validation/BusinessTimeHelper.example.cs` | Generalize business-time conversion example | Yes | Yes | Remove company-specific naming |
| `Services/IncomingRecordUniquenessGuard.cs` | SANITIZE FIRST | `examples/validation/ActiveRecordUniqueness.example.cs` | Extract concurrency-safe uniqueness concept | Yes | Yes | Keep SQL error handling generic |
| `Services/OperationalRecordItemService.cs` | SANITIZE FIRST | `examples/validation/OperationalItemValidation.example.cs` | Extract item validation rules | Yes | Yes | No proprietary workflow payloads |
| `Pages/**/*.cshtml*` | SANITIZE FIRST | `examples/razor-pages/` | Rebuild small generic examples | Yes | Yes | Do not copy full production pages |
| `Migrations/**` | SANITIZE FIRST | `sql/schema_examples/` | Translate selected constraints/indexes into generic SQL | Yes | Yes | Do not publish the full production schema automatically |
| Existing internal release documentation | SANITIZE FIRST | `docs/` | Rewrite for a public portfolio audience | Yes | Yes | Remove paths, hostnames, company-only deployment information, and release operations |
| Production or Development configuration | DO NOT PUBLISH | None | Never copy | N/A | Yes | Create minimal public-safe examples from scratch if needed |
| `app.db` and other database files | DO NOT PUBLISH | None | Never copy | N/A | Yes | Database content may contain real operational data |
| `App_Data/` | DO NOT PUBLISH | None | Never copy | N/A | Yes | Includes private attachment storage |
| Real Excel imports/exports and reports | DO NOT PUBLISH | None | Never copy | N/A | Yes | Use generated synthetic files only |
| Real screenshots | DO NOT PUBLISH | None | Never copy | N/A | Yes | Recreate screens from synthetic data |
| Company logo/branding | DO NOT PUBLISH pending approval | None | Exclude unless written approval exists | N/A | Yes | Use neutral portfolio branding by default |
| Synthetic analytics datasets already in this repository | SAFE TO PUBLISH | `data/sample/` | Preserve | No | Yes | Revalidate provenance and privacy before each release |
| Generic Python/SQL/Power BI documentation already in this repository | SAFE TO PUBLISH | Existing paths | Preserve | No | Yes | Keep existing history and rerun privacy checks |

## Transfer procedure

1. Select a single candidate source item.
2. Assign a classification before copying.
3. Recreate or extract only the approved generic concept.
4. Run automated publication-safety checks.
5. Perform manual privacy, security, and IP review.
6. Review the staged Git diff.
7. Commit only after explicit approval.
