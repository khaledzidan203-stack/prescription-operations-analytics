// Portfolio-safe illustrative example derived from the project architecture.
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;

namespace PortfolioExamples.RazorPages.Export;

[Authorize(Roles = "Pharmacy")]
public sealed class RecordsModel : PageModel
{
    private readonly UserManager<ExportUser> _users;
    private readonly ExportContext _db;
    private readonly IWorkbookExporter _exporter;

    [BindProperty(SupportsGet = true)] public string? Search { get; set; }
    [BindProperty(SupportsGet = true)] public DateOnly? From { get; set; }
    [BindProperty(SupportsGet = true)] public int PageNumber { get; set; } = 1;

    public RecordsModel(
        UserManager<ExportUser> users,
        ExportContext db,
        IWorkbookExporter exporter)
    {
        _users = users;
        _db = db;
        _exporter = exporter;
    }

    public async Task<IActionResult> OnGetExportAsync(
        CancellationToken cancellationToken)
    {
        var user = await _users.GetUserAsync(User);
        if (user?.PharmacyId is null)
            return Forbid();

        var query = _db.Records.AsNoTracking()
            .Where(row => row.PharmacyId == user.PharmacyId.Value);

        query = ApplyFilters(query, Search, From);

        // Export every matching row. PageNumber is intentionally not applied.
        var rows = await query.OrderBy(row => row.Id).ToListAsync(cancellationToken);
        var bytes = _exporter.Build(rows);

        return File(
            bytes,
            "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
            "synthetic-records.xlsx");
    }

    private static IQueryable<ExportRow> ApplyFilters(
        IQueryable<ExportRow> query,
        string? search,
        DateOnly? from) => query;
}

public sealed class ExportUser : IdentityUser { public int? PharmacyId { get; init; } }
public sealed class ExportContext : DbContext { public DbSet<ExportRow> Records => Set<ExportRow>(); }
public sealed class ExportRow { public int Id { get; init; } public int PharmacyId { get; init; } }
public interface IWorkbookExporter { byte[] Build(IReadOnlyCollection<ExportRow> rows); }
