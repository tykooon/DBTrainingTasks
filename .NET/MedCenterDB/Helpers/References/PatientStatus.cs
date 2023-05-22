using MedCenterDB.DbObjects.Infos;

namespace MedCenterDB.Helpers.References;

public static class PaymentState
{
    public static PaymentStateInfo NotPaid { get; } = new() { PaymentState = "Not Paid" };

    public static PaymentStateInfo CompletelyPaid { get; } = new() { PaymentState = "Completely Paid" };

    public static PaymentStateInfo Rejected { get; } = new() { PaymentState = "Rejected" };

    public static PaymentStateInfo Delayed { get; } = new() { PaymentState = "Delayed" };
}


