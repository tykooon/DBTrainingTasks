using MedCenterDB.DbObjects.Infos;

namespace MedCenterDB.Helpers.References;

public static class VisitType
{
    public static VisitTypeInfo Consultation { get; } = new() { VisitType = "Consultation" };

    public static VisitTypeInfo Examination { get; } = new() { VisitType = "Examination" };

    public static VisitTypeInfo TestTaking { get; } = new() { VisitType = "TestTaking" };

    public static VisitTypeInfo Operation { get; } = new() { VisitType = "Operation" };
}


