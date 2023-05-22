using MedCenterDB.DbObjects;

namespace MedCenterDB.Helpers;

public static class Extensions
{
    public static T Clone<T>(this T instance) where T : DbObject, new()
    {
        return DbObject.ShadowClone(instance);
    }
}
