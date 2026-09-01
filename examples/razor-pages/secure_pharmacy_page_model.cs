// Portfolio-safe illustrative example derived from the project architecture.
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;

namespace PortfolioExamples.RazorPages;

[Authorize(Roles = "Pharmacy")]
public sealed class SecurePharmacyPageModel : PageModel
{
    private readonly UserManager<PortfolioUser> _users;
    private readonly PortfolioContext _db;

    public SecurePharmacyPageModel(
        UserManager<PortfolioUser> users,
        PortfolioContext db)
    {
        _users = users;
        _db = db;
    }

    public OwnedRecord? Record { get; private set; }

    public async Task<IActionResult> OnGetAsync(
        int id,
        CancellationToken cancellationToken)
    {
        var user = await _users.GetUserAsync(User);
        if (user?.PharmacyId is null)
            return Forbid();

        Record = await _db.Records.AsNoTracking().SingleOrDefaultAsync(
            row => row.Id == id && row.PharmacyId == user.PharmacyId.Value,
            cancellationToken);

        return Record is null ? NotFound() : Page();
    }
}

public sealed class PortfolioUser : IdentityUser { public int? PharmacyId { get; init; } }
public sealed class PortfolioContext : DbContext { public DbSet<OwnedRecord> Records => Set<OwnedRecord>(); }
public sealed class OwnedRecord { public int Id { get; init; } public int PharmacyId { get; init; } }
