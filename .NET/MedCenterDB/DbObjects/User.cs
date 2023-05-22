using MedCenterDB.DbObjects.Infos;

namespace MedCenterDB.DbObjects;

public class User : DbObject
{
    public string Login { get; set; }
    public string Email { get; set; }
    public string PasswordHash { get; set; }
    public string FullName { get; set; }
    public GenderInfo Gender { get; set; }
    public string DateOfBirth { get; set; }
    public List<PhoneInfo> Phones { get; set; }
    public DateTime? RegisterDateTime { get; set; } = DateTime.Now;
    public UserRoleInfo UserRole { get; set; }
    public DateTime? LastActiveDateTime { get; set; } = DateTime.Now;
    public User AdminApprover { get; set; }
}


