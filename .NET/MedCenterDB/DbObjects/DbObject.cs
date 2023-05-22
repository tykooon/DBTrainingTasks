namespace MedCenterDB.DbObjects;

public abstract class DbObject
{
    public static T ShadowClone<T>(T instance) where T : DbObject, new()
    {
        var res = instance as DbObject;
        return res.MemberwiseClone() as T;
    }
}
