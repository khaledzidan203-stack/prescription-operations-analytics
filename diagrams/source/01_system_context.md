# System Context Diagram

```mermaid
flowchart LR
    PharmacyUser[Pharmacy User]
    AdminUser[Admin User]
    Browser[Web Browser]
    Platform[Prescription Operations Platform]
    Sql[(SQL Server)]
    Files[(Private Attachment Storage)]
    Excel[Validated Excel Boundary]

    PharmacyUser --> Browser
    AdminUser --> Browser
    Browser -->|HTTPS| Platform
    Platform -->|EF Core| Sql
    Platform -->|Authorized file I/O| Files
    Excel -->|Import| Platform
    Platform -->|Export| Excel
```

The browser is an interaction boundary, not an ownership or persistence authority.
