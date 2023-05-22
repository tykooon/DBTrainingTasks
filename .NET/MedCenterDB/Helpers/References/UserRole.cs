using MedCenterDB.DbObjects.Infos;

namespace MedCenterDB.Helpers.References;

public static class UserRole
{
    public static UserRoleInfo Administrator { get; } = new() { UserRole = "Administrator" };

    public static UserRoleInfo Advanced { get; } = new() { UserRole = "Advanced" };

    public static UserRoleInfo Regular { get; } = new() { UserRole = "Regular" };
}
