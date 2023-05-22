using MedCenterDB.DbObjects.Infos;

namespace MedCenterDB.DbObjects;

public class Equipment : DbObject
{
    public string EquipmentName { get; set; }
    public string InventaryNumber { get; set; }
    public EquipmentStateInfo EquipmentState { get; set; }
    public EquipmentTypeInfo EquipmentType { get; set; }
    public string EquipmentNote { get; set; }
    public List<Service> Services { get; set; }
    public Room EquipmentRoom { get; set; }
    public DateTime? RegistrationDateTime { get; set; } = DateTime.Now;
    public User LastEditor { get; set; }
}
