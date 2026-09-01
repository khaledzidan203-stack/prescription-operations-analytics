# Attachment Security

## Storage model

SQL Server stores attachment metadata. File bytes are written to private storage
outside `wwwroot`; they are not addressable through a static public URL.

## Upload controls

- Maximum 5 files per message.
- Maximum 15 MB per file.
- Maximum 50 MB total per message.
- Allowed extensions: JPG/JPEG, PNG, WEBP, PDF, and XLSX.
- Legacy XLS is rejected.
- Extension must be allowlisted.
- Declared Content-Type must match the allowed type.
- File signature is inspected rather than trusting extension alone.
- Original filenames are retained as display metadata only.
- Storage filenames are generated identifiers, not user-controlled names.

## Path protection

The configured root is canonicalized with `Path.GetFullPath`. Startup rejects a
root under the public web directory. Every read/delete candidate is recombined,
canonicalized, and checked for containment under the storage root, protecting
against `../` and absolute-path traversal.

## Authorized download

The browser requests an attachment through an authenticated handler. The service
loads metadata only when the current user participates in the containing
conversation, then opens the private file stream. Knowing an attachment ID or
storage-relative path is insufficient.

## Failure handling

If attachment persistence succeeds but message/database creation fails, the newly
stored files are deleted. Operational logging avoids printing file bytes or secret
content.

## Deployment responsibility

The application identity needs least-privilege read/write access to the private
attachment root. Backup, retention, malware scanning policy, and lifecycle
cleanup remain deployment/governance responsibilities.
