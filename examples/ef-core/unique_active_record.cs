// Portfolio-safe illustrative example derived from the project architecture.
using Microsoft.EntityFrameworkCore;

namespace PortfolioExamples.EfCore;

public static class ActiveRecordConfiguration
{
    public static void Configure(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<IncomingRecord>()
            .Property(row => row.ActiveDiscriminator)
            .HasComputedColumnSql(
                "CASE WHEN [Status] IN (N'New', N'In Progress') " +
                "THEN 0 ELSE [Id] END",
                stored: true);

        modelBuilder.Entity<IncomingRecord>()
            .HasIndex(row => new
            {
                row.PharmacyId,
                row.RecordType,
                row.NormalizedIdentityKey,
                row.NormalizedRecordNumber,
                row.ActiveDiscriminator
            })
            .IsUnique()
            .HasDatabaseName("UX_IncomingRecord_ActiveLogicalKey");
    }
}

public sealed class IncomingRecord
{
    public int Id { get; init; }
    public int PharmacyId { get; init; }
    public string RecordType { get; init; } = "";
    public string NormalizedIdentityKey { get; init; } = "";
    public string NormalizedRecordNumber { get; init; } = "";
    public string Status { get; init; } = "New";
    public int ActiveDiscriminator { get; private set; }
}
