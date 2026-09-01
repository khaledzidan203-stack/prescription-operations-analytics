// Portfolio-safe illustrative example derived from the project architecture.
namespace PortfolioExamples.EfCore;

public static class HistoricalPriceSnapshot
{
    public static PrescriptionLine PrepareLine(
        PrescriptionLineInput input,
        ExistingPrescriptionLine? existing,
        ItemMaster itemMaster)
    {
        if (input.Quantity <= 0)
            throw new ArgumentOutOfRangeException(nameof(input.Quantity));

        var keepsSameItem =
            existing is not null && existing.ItemMasterId == itemMaster.Id;

        return new PrescriptionLine
        {
            ItemMasterId = itemMaster.Id,
            Quantity = input.Quantity,
            UnitPriceSnapshot = keepsSameItem
                ? existing!.UnitPriceSnapshot
                : itemMaster.CurrentUnitPrice
        };
    }
}

public sealed record PrescriptionLineInput(int Quantity);
public sealed record ExistingPrescriptionLine(int ItemMasterId, decimal UnitPriceSnapshot);
public sealed record ItemMaster(int Id, decimal CurrentUnitPrice);
public sealed class PrescriptionLine
{
    public int ItemMasterId { get; init; }
    public int Quantity { get; init; }
    public decimal UnitPriceSnapshot { get; init; }
    public decimal LineTotal => Quantity * UnitPriceSnapshot;
}
