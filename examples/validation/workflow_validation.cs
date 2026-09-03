// Portfolio-safe illustrative example derived from the project architecture.
namespace PortfolioExamples.Validation;

public static class WorkflowValidation
{
    public static ValidationResult ValidateRunX(
        string decision,
        IReadOnlyCollection<ItemInput> items)
    {
        if (decision == "Not Yet")
            return ValidationResult.Valid();

        if (decision != "Done")
            return ValidationResult.Invalid("Choose Done or Not Yet.");

        if (items.Count == 0)
            return ValidationResult.Invalid("Add at least one item.");

        var total = items.Sum(item => item.Quantity * item.UnitPriceSnapshot);
        return total > 200m
            ? ValidationResult.Valid()
            : ValidationResult.Invalid("Done requires a total above SAR 200.");
    }

    public static ValidationResult ValidatePickUp(
        string decision,
        IReadOnlyCollection<ItemInput> items)
    {
        if (decision == "Not Yet")
            return ValidationResult.Valid();

        return decision == "Done" && items.Count > 0
            ? ValidationResult.Valid()
            : ValidationResult.Invalid("Done requires at least one item.");
    }
}

public sealed record ItemInput(int Quantity, decimal UnitPriceSnapshot);
public sealed record ValidationResult(bool IsValid, string? Error)
{
    public static ValidationResult Valid() => new(true, null);
    public static ValidationResult Invalid(string error) => new(false, error);
}
