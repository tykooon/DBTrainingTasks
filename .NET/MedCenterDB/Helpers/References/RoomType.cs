using MedCenterDB.DbObjects.Infos;

namespace MedCenterDB.Helpers.References;

public static class RoomType
{
    public static RoomTypeInfo CommonArea { get; } = new() { RoomType = "Common Area" };

    public static RoomTypeInfo DoctorsOffice { get; } = new() { RoomType = "Doctor's Office" };

    public static RoomTypeInfo ServiceSpace { get; } = new() { RoomType = "Service Space" };

    public static RoomTypeInfo Laboratory { get; } = new() { RoomType = "Laboratory" };

    public static RoomTypeInfo Surgery { get; } = new() { RoomType = "Surgery" };

}


