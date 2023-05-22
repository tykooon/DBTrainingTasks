using MedCenterDB.DbObjects.Infos;

namespace MedCenterDB.Helpers.References;

public static class MedicalCategory
{
    public static MedicalCategoryInfo NoCategory { get; } = new() { MedicalCategory = "No Category" };

    public static MedicalCategoryInfo Second { get; } = new() { MedicalCategory = "Second Category" };

    public static MedicalCategoryInfo First { get; } = new() { MedicalCategory = "First Category" };

    public static MedicalCategoryInfo Highest { get; } = new() { MedicalCategory = "Highest Category" };
}