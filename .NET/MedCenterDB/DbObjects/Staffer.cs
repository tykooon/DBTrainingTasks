using MedCenterDB.DbObjects.Infos;

namespace MedCenterDB.DbObjects;

public class Staffer : DbObject
{
    public User User { get; set; }
    public string StafferPassport { get; set; }
    public StafferGroupInfo StafferGroup { get; set; }
    public MedicalCategoryInfo MedicalCategory { get; set; }
    public string StafferHomeAddress { get; set; }
    public string ShortSummary { get; set; }
    public SpecialityInfo Speciality { get; set; }
    public string Photo { get; set; }
    public DateTime? RegisterDateTime { get; set; } = DateTime.Now;
    public string PersonalNotes { get; set; }
    public User StafferRegistrator { get; set; }
}
