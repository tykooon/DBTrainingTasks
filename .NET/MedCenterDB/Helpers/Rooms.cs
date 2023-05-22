using MedCenterDB.DbObjects;
using MedCenterDB.DbObjects.Infos;
using MedCenterDB.Helpers.References;

namespace MedCenterDB.Helpers;

public static class Rooms
{
    public static Room Reception = new()
    {
        RoomName = "Reception",
        RoomState = RoomState.Accessible,
        RoomType = RoomType.CommonArea,
        RoomNotes = "Main Reception",
        LastUpdateDateTime = DateTime.Now
    };

    public static Room Cabinet1 = new()
    {
        RoomName = "Cabinet 1",
        RoomState = RoomState.Accessible,
        RoomType = RoomType.DoctorsOffice,
        RoomNotes = "Cardiological Office",
        LastUpdateDateTime = DateTime.Now
    };

    public static Room CabinetUS = new()
    {
        RoomName = "Cabinet 2",
        RoomState = RoomState.Accessible,
        RoomType = RoomType.DoctorsOffice,
        RoomNotes = "Ultrasound Room",
        LastUpdateDateTime = DateTime.Now
    };

    public static Room CabinetXRay = new()
    {
        RoomName = "Cabinet 3",
        RoomState = RoomState.Accessible,
        RoomType = RoomType.DoctorsOffice,
        RoomNotes = "X-Ray Room",
        LastUpdateDateTime = DateTime.Now
    };

    public static Room CabinetTest = new()
    {
        RoomName = "Cabinet 4",
        RoomState = RoomState.Accessible,
        RoomType = RoomType.Laboratory,
        RoomNotes = "Test Laboratory",
        LastUpdateDateTime = DateTime.Now
    };

    public static Room BossRoom = new()
    {
        RoomName = "Cabinet 5",
        RoomState = RoomState.Accessible,
        RoomType = RoomType.ServiceSpace,
        RoomNotes = "Director and Administration",
        LastUpdateDateTime = DateTime.Now
    };

    public static void OnlyName(this Room room)
    {
        room.RoomState = null;
        room.RoomType = null;
        room.LastUpdateDateTime = null;
        room.RoomNotes = null;
    }
}
