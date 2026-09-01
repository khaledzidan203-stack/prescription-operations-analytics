// Portfolio-safe illustrative example derived from the project architecture.
using Microsoft.EntityFrameworkCore;

namespace PortfolioExamples.EfCore;

public sealed class TransferAcceptanceService
{
    private readonly PortfolioDbContext _db;

    public TransferAcceptanceService(PortfolioDbContext db) => _db = db;

    public async Task<AcceptanceResult> AcceptAsync(
        int transferId,
        int authenticatedPharmacyId,
        byte[] submittedRowVersion,
        CancellationToken cancellationToken = default)
    {
        var transfer = await _db.Transfers.SingleOrDefaultAsync(
            row => row.Id == transferId &&
                   row.ToPharmacyId == authenticatedPharmacyId &&
                   row.Status == "Pending Receipt",
            cancellationToken);

        if (transfer is null)
            return AcceptanceResult.NotAvailable;

        _db.Entry(transfer).Property(row => row.RowVersion).OriginalValue =
            submittedRowVersion;
        transfer.Status = "Received";

        try
        {
            await _db.SaveChangesAsync(cancellationToken);
            return AcceptanceResult.Accepted;
        }
        catch (DbUpdateConcurrencyException)
        {
            return AcceptanceResult.Conflict;
        }
    }
}

public enum AcceptanceResult { Accepted, NotAvailable, Conflict }
public sealed class PortfolioDbContext : DbContext
{
    public DbSet<TransferRow> Transfers => Set<TransferRow>();
}
public sealed class TransferRow
{
    public int Id { get; init; }
    public int ToPharmacyId { get; init; }
    public string Status { get; set; } = "Pending Receipt";
    public byte[] RowVersion { get; set; } = [];
}
