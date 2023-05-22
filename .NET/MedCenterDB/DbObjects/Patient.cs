using MedCenterDB.DbObjects.Infos;

namespace MedCenterDB.DbObjects;

public class Patient : DbObject
{
    public User User { get; set; }
    public string PatientPassport { get; set; }
    public PatientStatusInfo PatientStatus { get; set; }
    public string PatientHomeAddress { get; set; }
    public string InsurancePolicy { get; set; }
    public string Photo { get; set; }
    public string ChronicDeseases { get; set; }
    public DateTime? RegisterDateTime { get; set; } = DateTime.Now;
    public string IndividualNotes { get; set; }
    public string InnerComment { get; set; }
    public User PatientRegistrator { get; set; }
}
