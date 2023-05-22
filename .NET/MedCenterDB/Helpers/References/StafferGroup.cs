using MedCenterDB.DbObjects.Infos;

namespace MedCenterDB.Helpers.References;

public static class StafferGroup
{
    public static StafferGroupInfo Receptionists { get; } = new() { StafferGroup = "Receptionists" };

    public static StafferGroupInfo MedicalStaff { get; } = new() { StafferGroup = "Medical Staff" };

    public static StafferGroupInfo Administration { get; } = new() { StafferGroup = "Administration" };

    public static StafferGroupInfo TechnicalStaff { get; } = new() { StafferGroup = "Technical Staff" };

    public static StafferGroupInfo NonStaff { get; } = new() { StafferGroup = "Non-Staff" };
}
