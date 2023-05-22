using MedCenterDB.DbObjects.Infos;

namespace MedCenterDB.Helpers.References;

public static class RoomState
{
    public static RoomStateInfo Accessible { get; } = new() { RoomState = "Accessible" };

    public static RoomStateInfo NonAccessible { get; } = new() { RoomState = "Non-Accessible" };

    public static RoomStateInfo Renovation { get; } = new() { RoomState = "Renovation" };

    public static RoomStateInfo Abolished { get; } = new() { RoomState = "Abolished" };
}


