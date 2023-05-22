using MedCenterDB.DbObjects;
using MedCenterDB.Helpers.References;

namespace MedCenterDB.Helpers;

public static class Staffers
{
    public static Staffer Receptionist1 { get; } = new()
    {
        User = null,
        StafferGroup = StafferGroup.Receptionists,
        MedicalCategory = MedicalCategory.NoCategory,
        StafferPassport = "MP1234567",
        Speciality = Speciality.NonMedical,
        StafferHomeAddress = "Minsk, Chapaeva 5, off.417",
        ShortSummary = "Education: Belarusian State University, Bachelor of Philology. Expierience: 5 years.",
        Photo = "https://robohash.org/set_set1/bgset_bg2/2294dhdg",
        PersonalNotes = "Monday - permanent day-off",
        RegisterDateTime = DateTime.Now
    };

    public static Staffer Doctor1 { get; } = new()
    {
        User = null,
        StafferGroup = StafferGroup.MedicalStaff,
        MedicalCategory = MedicalCategory.First,
        StafferPassport = "MP7654321",
        Speciality = Speciality.Cardiology,
        StafferHomeAddress = "Minsk, Chapaeva 5, off.409",
        ShortSummary = "Education: Belarusian State University Of Informatics and Radioelectronics, Master Degree. Expierience: 12 years.",
        Photo = "https://robohash.org/set_set1/bgset_bg2/Alexandra",
        PersonalNotes = "Don't work after 18:00",
        RegisterDateTime = DateTime.Now
    };


    public static Staffer Doctor2 { get; } = new()
    {
        User = null,
        StafferGroup = StafferGroup.MedicalStaff,
        MedicalCategory = MedicalCategory.Highest,
        StafferPassport = "MP9876543",
        Speciality = Speciality.Therapy,
        StafferHomeAddress = "Minsk, Chapaeva 5, off.400",
        ShortSummary = "Education: Belarusian State University Of Informatics and Radioelectronics, Master Degree. Expierience: 12 years.",
        Photo = "https://robohash.org/set_set1/bgset_bg2/Igor",
        RegisterDateTime = DateTime.Now
    };

    public static Staffer Director { get; } = new()
    {
        User = null,
        StafferGroup = StafferGroup.Administration,
        MedicalCategory = MedicalCategory.Second,
        StafferPassport = "MP3456789",
        Speciality = Speciality.NonMedical,
        StafferHomeAddress = "Minsk, Chapaeva 5, off.400",
        ShortSummary = "Education: Belarusian State University, Expierience: 22 years.",
        Photo = "https://robohash.org/set_set1/bgset_bg2/Oleg",
        RegisterDateTime = DateTime.Now
    };

    public static Staffer Assistant { get; } = new()
    {
        User = null,
        StafferGroup = StafferGroup.MedicalStaff,
        MedicalCategory = MedicalCategory.Second,
        StafferPassport = "MP1357986",
        Speciality = Speciality.Nursing,
        StafferHomeAddress = "Minsk, Chapaeva 5, off.401",
        ShortSummary = "Education: Belarusian State University, Expierience: 16 years.",
        Photo = "https://robohash.org/set_set1/bgset_bg2/Alexei",
        RegisterDateTime = DateTime.Now
    };

    public static Staffer AssignToUser(this Staffer staffer, User user)
    {
        staffer.User = user;
        return staffer;
    }

}
