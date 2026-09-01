// Portfolio-safe illustrative example derived from the project architecture.
using ClosedXML.Excel;
using Microsoft.EntityFrameworkCore;

namespace PortfolioExamples.Excel;

public sealed class SafeImportPattern
{
    private readonly ImportContext _db;

    public SafeImportPattern(ImportContext db) => _db = db;

    public async Task<ImportOutcome> ImportAsync(
        Stream workbookStream,
        int authorizedPharmacyId,
        CancellationToken cancellationToken = default)
    {
        using var workbook = new XLWorkbook(workbookStream);
        var sheet = workbook.Worksheet(1);
        var accepted = new List<ImportRow>();
        var rejected = new List<string>();

        foreach (var row in sheet.RowsUsed().Skip(1))
        {
            var recordNumber = row.Cell(1).GetString().Trim();
            var syntheticIdentity = row.Cell(2).GetString().Trim();

            if (recordNumber.Length is 0 or > 100 ||
                syntheticIdentity.Length is 0 or > 30)
            {
                rejected.Add($"Row {row.RowNumber()}: required value is invalid.");
                continue;
            }

            accepted.Add(new ImportRow
            {
                PharmacyId = authorizedPharmacyId,
                RecordNumber = recordNumber,
                SyntheticIdentity = syntheticIdentity
            });
        }

        await using var transaction = await _db.Database
            .BeginTransactionAsync(cancellationToken);

        _db.Rows.AddRange(accepted);
        await _db.SaveChangesAsync(cancellationToken);
        await transaction.CommitAsync(cancellationToken);

        return new ImportOutcome(accepted.Count, rejected);
    }
}

public sealed record ImportOutcome(int Accepted, IReadOnlyCollection<string> Rejected);
public sealed class ImportContext : DbContext { public DbSet<ImportRow> Rows => Set<ImportRow>(); }
public sealed class ImportRow
{
    public int Id { get; init; }
    public int PharmacyId { get; init; }
    public string RecordNumber { get; init; } = "";
    public string SyntheticIdentity { get; init; } = "";
}
