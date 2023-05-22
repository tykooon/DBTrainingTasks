namespace MedCenterDB.DbObjects.Infos;

public class PhoneInfo
{
    public string PhoneNumber { get; set; }

    public PhoneInfo(string phoneNumber)
    {
        PhoneNumber = phoneNumber;
    }
}
