using MedCenterDB.DbObjects.Infos;

namespace MedCenterDB.Helpers.References;

public static class EquipmentType
{
    public static EquipmentTypeInfo PersonalComputer { get; } = new() { EquipmentType = "Personal Computer" };

    public static EquipmentTypeInfo Ultrasound { get; } = new() { EquipmentType = "Ultrasound" };

    public static EquipmentTypeInfo XRay { get; } = new() { EquipmentType = "X-Ray" };

    public static EquipmentTypeInfo LaserSurgery { get; } = new() { EquipmentType = "Laser Surgery" };

    public static EquipmentTypeInfo Analyzer { get; } = new() { EquipmentType = "Analyzer" };

    public static EquipmentTypeInfo OfficeTechnic { get; } = new() { EquipmentType = "Office Technic" };
}


