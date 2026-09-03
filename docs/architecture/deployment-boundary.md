# Deployment and Publication Boundary

## Operational deployment model

The verified design targets an ASP.NET Core application hosted behind HTTPS with
SQL Server as the central database and an external private directory for chat
attachments. Environment configuration supplies connection and storage settings;
the application does not treat browser storage as persistence.

```text
HTTPS client
  -> Web host / ASP.NET Core application
      -> SQL Server
      -> Private attachment storage
```

## Operational responsibilities

- IT provides the approved hostname, TLS certificate, hosting runtime, service
  identity, database access, filesystem ACLs, secrets, backups, and monitoring.
- Migrations are reviewed and applied deliberately; they are not assumed to run
  automatically at application startup.
- Attachment storage must be outside the public web root and writable only by the
  application identity and authorized administrators.
- Production state is not inferred from source code or Development history.

## Public repository boundary

This repository is not a deployment package. It intentionally excludes:

- Application configuration and connection strings.
- Database files, dumps, and migration bundles.
- Private attachments and operational Excel files.
- Production hostnames, paths, certificates, and credentials.
- Full private application source.

The public CI validates documentation, synthetic data, and publication safety;
it does not deploy healthcare infrastructure.
