using MedCenterDB.DbObjects.Infos;

namespace MedCenterDB.DbObjects;

public class Room : DbObject
{
    public string RoomName { get; set; }
    public RoomStateInfo RoomState { get; set; }
    public RoomTypeInfo RoomType { get; set; }
    public string RoomNotes { get; set; }
    public DateTime? LastUpdateDateTime { get; set; }
}
