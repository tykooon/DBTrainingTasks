using MedCenterDB.DbObjects;
using MedCenterDB.DbObjects.Infos;
using MedCenterDB.Helpers.References;

namespace MedCenterDB.Helpers;

public static class Services
{
    public static Service TherapistConsultation = new()
    {
        ServiceName = "Therapist Consultation",
        ServiceStatus = ServiceStatus.Accessible,
        Comment = "Not available on Sunday and Saturday",
        Price = 43.5M,
        ServiceCategory = ServiceCategory.Consultation,
        Description = "Common procedures, Blood Pressure, Survey",
    };

    public static Service CardioConsultation = new()
    {
        ServiceName = "Cardiologist Consultation",
        ServiceStatus = ServiceStatus.Accessible,
        Comment = "Only Wednesday and Friday",
        Price = 45.5M,
        ServiceCategory = ServiceCategory.Consultation,
        Description = "Common survey, Cardiography included",
    };

    public static Service BloodTest1 = new()
    {
        ServiceName = "Common Blood Test",
        ServiceStatus = ServiceStatus.Accessible,
        Comment = "Everuday, till 11:00",
        Price = 10M,
        ServiceCategory = ServiceCategory.Test,
        Description = "Common Blood Formula, Hemoglobine",
    };

    public static Service BloodTest2 = new()
    {
        ServiceName = "Biochemical Blood Test",
        ServiceStatus = ServiceStatus.Accessible,
        Comment = "",
        Price = 15.8M,
        ServiceCategory = ServiceCategory.Test,
        Description = "Cholesterine, ASAT, ALAT, Proteine",
    };

    public static Service UlrtasoundLiver = new()
    {
        ServiceName = "Liver USI",
        ServiceStatus = ServiceStatus.Accessible,
        Comment = "Not available after 15:00",
        Price = 55.5M,
        ServiceCategory = ServiceCategory.Examination,
        Description = "Ultrasonic examination of liver",
    };

    public static Service UlrtasoundHeart = new()
    {
        ServiceName = "Heart USI",
        ServiceStatus = ServiceStatus.Accessible,
        Comment = "",
        Price = 60.5M,
        ServiceCategory = ServiceCategory.Examination,
        Description = "Ultrasonic examination of heart",
    };

    public static void OnlyName(this Service service)
    {
        service.Price = null;
        service.ServiceCategory = null;
        service.ServiceStatus = null;
        service.Comment = null;
        service.Description = null;
    }

}
