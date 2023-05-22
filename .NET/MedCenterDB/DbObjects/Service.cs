using MedCenterDB.DbObjects.Infos;

namespace MedCenterDB.DbObjects;

public class Service : DbObject
{
    public string ServiceName { get; set; }
    public ServiceStatusInfo ServiceStatus { get; set; }
    public string Comment { get; set; }
    public decimal? Price { get; set; }
    public ServiceCategoryInfo ServiceCategory { get; set; }
    public string Description { get; set; }
}
