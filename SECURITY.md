# Security and Privacy

- The repository contains synthetic data only.
- Never commit patient/customer identifiers, employee details, passwords, API keys, tokens, connection strings, internal hostnames, or proprietary extracts.
- Use environment variables or secret managers for any future credentials.
- Before publishing changes, run the privacy scan described in `docs/PRIVACY_VERIFICATION.md`.
- Report accidental sensitive-data exposure by removing the material from Git history and rotating any exposed secret immediately.
