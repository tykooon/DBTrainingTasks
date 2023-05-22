using MedCenterDB.DbObjects.Infos;

namespace MedCenterDB.Helpers.References;

public static class TestType
{
    public static TestTypeInfo Ultrasonic { get; } = new() { TestType = "Ultrasonic" };

    public static TestTypeInfo XRay { get; } = new() { TestType = "X-Ray" };

    public static TestTypeInfo BloodAnalysis { get; } = new() { TestType = "Blood Analysis" };

    public static TestTypeInfo UrineAnalysis { get; } = new() { TestType = "Urine Analysis" };

    public static TestTypeInfo Cytology { get; } = new() { TestType = "Cytology" };

}


