// Portfolio-safe illustrative example derived from the project architecture.
using Microsoft.EntityFrameworkCore;

namespace PortfolioExamples.EfCore;

public static class PharmacyIsolationQuery
{
    public static Task<OperationalRecord?> FindOwnedAsync(
        IQueryable<OperationalRecord> records,
        int recordId,
        int authenticatedPharmacyId,
        CancellationToken cancellationToken = default)
    {
        // The Pharmacy comes from the authenticated server-side user context.
        // A route or form PharmacyId is never accepted as ownership authority.
        return records.SingleOrDefaultAsync(
            row => row.Id == recordId &&
                   row.PharmacyId == authenticatedPharmacyId,
            cancellationToken);
    }
}

public sealed class OperationalRecord
{
    public int Id { get; init; }
    public int PharmacyId { get; init; }
    public string Status { get; init; } = "";
}
