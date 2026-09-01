# Authentication and Authorization

## Identity architecture

The operational application uses ASP.NET Core Identity with two business roles:

- `Admin`: network-wide administration and reporting.
- `Pharmacy`: operational access for one associated Pharmacy.

Admin and Pharmacy Razor PageModels use role-based `[Authorize]` attributes.
Shared authenticated pages, such as notifications and chat, perform their own
recipient/participant checks.

## Account controls

- Password policy requires upper/lowercase, digit, non-alphanumeric character,
  and a minimum length of 12.
- Temporary Pharmacy credentials require a password change.
- Inactive users are signed out before accessing normal application pages.
- Temporary credential values are not stored as reusable application records.
- Production cookies are HttpOnly, SameSite Lax, and Secure over non-Development
  hosting.
- HTTPS redirection and HSTS protect non-Development traffic.

## Backend authorization

Authorization does not stop at navigation visibility. State-changing handlers:

1. Resolve the authenticated user.
2. Verify role and active account state.
3. Derive Pharmacy ownership when applicable.
4. Reload the target entity from the database within that scope.
5. Revalidate current workflow state.
6. Apply the change and audit it where required.

## Admin boundary

Admin queries intentionally cross Pharmacy boundaries, but only behind the Admin
role. A Pharmacy account cannot gain Admin scope by submitting an Admin-looking
route or Pharmacy filter.

## Defense in depth

Application authorization is reinforced by optimistic concurrency, unique
indexes, check constraints, transactions, audit events, and private file access.
