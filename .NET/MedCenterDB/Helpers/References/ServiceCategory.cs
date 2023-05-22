using MedCenterDB.DbObjects.Infos;

namespace MedCenterDB.Helpers.References;

public static class ServiceCategory
{
    public static ServiceCategoryInfo Consultation { get; } = new() { ServiceCategory = "Consultation" };

    public static ServiceCategoryInfo Examination { get; } = new() { ServiceCategory = "Examination" };

    public static ServiceCategoryInfo Test { get; } = new() { ServiceCategory = "Test" };

    public static ServiceCategoryInfo Manipulation { get; } = new() { ServiceCategory = "Manipulation" };

    public static ServiceCategoryInfo Operation { get; } = new() { ServiceCategory = "Operation" };

    public static ServiceCategoryInfo Rehabilitation { get; } = new() { ServiceCategory = "Rehabilitation" };
}