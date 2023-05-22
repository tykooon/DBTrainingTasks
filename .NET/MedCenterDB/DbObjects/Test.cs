using MedCenterDB.DbObjects.Infos;

namespace MedCenterDB.DbObjects;

public class Test : DbObject
{
    public Service Service { get; set; }
    public Visit Visit { get; set; }
    public TestStateInfo TestState { get; set; }
    public TestTypeInfo TestType { get; set; }
    public string TestComment { get; set; }
    public string Result { get; set; }
}
