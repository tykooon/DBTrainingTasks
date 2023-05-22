namespace MedCenterDB.DbObjects;

public class Guest : DbObject
{
    public string IpAddress { get; set; }
    public string BrowserUserAgent{ get; set; }
    public DateTime SessionDateTime { get; set; } = DateTime.Now;
    public User AuthorizedUser { get; set; }
}
