using MedCenterDB.DbObjects.Infos;

namespace MedCenterDB.Helpers.References;

public static class Speciality
{
    public static SpecialityInfo NonMedical { get; } = new() { Speciality = "Non-Medical" };

    public static SpecialityInfo Nursing { get; } = new() { Speciality = "Nursing" };

    public static SpecialityInfo Surgery { get; } = new() { Speciality = "Surgery" };

    public static SpecialityInfo Therapy { get; } = new() { Speciality = "Therapy" };

    public static SpecialityInfo Otorhinolaryngology { get; } = new() { Speciality = "Otorhinolaryngology" };

    public static SpecialityInfo Cardiology { get; } = new() { Speciality = "Cardiology" };

}


