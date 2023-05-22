using MedCenterDB.DbObjects.Infos;

namespace MedCenterDB.Helpers.References;

public static class EquipmentState
{
    public static EquipmentStateInfo InService { get; } = new() { EquipmentState = "In Service" };

    public static EquipmentStateInfo OutOfService { get; } = new() { EquipmentState = "Out Of Service" };

    public static EquipmentStateInfo OnRepair { get; } = new() { EquipmentState = "OnRepair" };

    public static EquipmentStateInfo Disposed { get; } = new() { EquipmentState = "Disposed" };
}


