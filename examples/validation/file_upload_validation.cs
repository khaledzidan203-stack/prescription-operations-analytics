// Portfolio-safe illustrative example derived from the project architecture.
using Microsoft.AspNetCore.Http;

namespace PortfolioExamples.Validation.Uploads;

public static class FileUploadValidation
{
    private const long MaximumFileBytes = 15L * 1024 * 1024;

    private static readonly IReadOnlyDictionary<string, string[]> AllowedTypes =
        new Dictionary<string, string[]>(StringComparer.OrdinalIgnoreCase)
        {
            [".png"] = ["image/png"],
            [".pdf"] = ["application/pdf"],
            [".xlsx"] = ["application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"]
        };

    public static string? Validate(IFormFile file)
    {
        if (file.Length <= 0 || file.Length > MaximumFileBytes)
            return "File size is not allowed.";

        var safeDisplayName = Path.GetFileName(file.FileName);
        var extension = Path.GetExtension(safeDisplayName);

        if (!AllowedTypes.TryGetValue(extension, out var contentTypes) ||
            !contentTypes.Contains(file.ContentType, StringComparer.OrdinalIgnoreCase))
        {
            return "File type is not allowed.";
        }

        // Production code should also validate the file signature and write the
        // bytes under a generated storage name outside the public web root.
        return null;
    }
}
