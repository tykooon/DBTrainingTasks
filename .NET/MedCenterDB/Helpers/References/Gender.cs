using MedCenterDB.DbObjects.Infos;

namespace MedCenterDB.Helpers.References;

public static class Gender
{
    public static GenderInfo Undefined { get; } = new() { GenderName = "Undefined" };

    public static GenderInfo Male { get; } = new() { GenderName = "Male" };

    public static GenderInfo Female { get; } = new() { GenderName = "Female" };
}
