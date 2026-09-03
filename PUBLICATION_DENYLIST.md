# Public Portfolio Publication Denylist

The following content must never be copied from the active application source
or published in this repository unless a future written approval explicitly
changes its classification.

## Databases, storage, and generated artifacts

- `app.db`
- `*.db`
- `*.sqlite`
- `*.mdf`
- `*.ldf`
- `*.bak`
- `App_Data/**`
- `ChatAttachments/**`
- `bin/**`
- `obj/**`
- `Release/**`
- `Source_Archive/**`
- `logs/**`
- `*.log`
- Backup source files such as `*.backup`
- Temporary artifacts

## Data and exports

- Real Excel imports or exports.
- Credential exports.
- Real screenshots.
- Real National IDs or other government identifiers.
- Real patient or customer data.
- Real prescription data.
- Real pharmacy records, codes, or operational metrics.
- Real user or employee data.
- Production extracts, rejected-row reports, and generated operational reports.

## Secrets and infrastructure

- Production connection strings.
- Local or Development connection strings tied to a real machine.
- Development machine paths.
- Server hostnames, private addresses, or internal network details.
- Passwords.
- API keys.
- Tokens.
- Certificates.
- Private keys.
- User Secrets or secret-store exports.
- Environment-specific credentials or authentication material.

## Confidential and proprietary material

- Company-only documentation.
- Internal infrastructure and deployment details.
- Company branding or logo unless explicitly approved for public use.
- Proprietary datasets.
- Unreviewed production application source.

An ignored file is not automatically safe. The denylist remains authoritative
even when a pattern is missing from `.gitignore`.
