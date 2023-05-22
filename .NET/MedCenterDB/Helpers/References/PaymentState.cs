using MedCenterDB.DbObjects.Infos;

namespace MedCenterDB.Helpers.References;

public static class PatientStatus
{
    public static PatientStatusInfo Vip { get; } = new() { PatientStatus = "VIP" };

    public static PatientStatusInfo Discount { get; } = new() { PatientStatus = "Discount" };

    public static PatientStatusInfo Regular { get; } = new() { PatientStatus = "Regular" };
}


