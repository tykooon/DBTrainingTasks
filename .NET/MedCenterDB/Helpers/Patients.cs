using MedCenterDB.DbObjects;
using MedCenterDB.Helpers.References;

namespace MedCenterDB.Helpers;

public static class Patients
{
    public static Patient Patient1 { get; } = new()
    {
        User = null,
        PatientStatus = PatientStatus.Vip,
        PatientPassport = "MP1357911",
        PatientHomeAddress = "Minsk, Chapaeva 5, off.417",
        InsurancePolicy = "Task, DS034252321",
        Photo = "https://robohash.org/set_set1/bgset_bg2/AlexanderTykoun",
        IndividualNotes = "No Allergy to Medicine",
        InnerComment = "No Comments",
        ChronicDeseases = "Hypertesia",
        RegisterDateTime = DateTime.Now
    };

    public static Patient Patient2 { get; } = new()
    {
        User = null,
        PatientStatus = PatientStatus.Regular,
        PatientPassport = "MP9786754",
        PatientHomeAddress = "Minsk, Chapaeva 5, off.317",
        InsurancePolicy = null,
        Photo = "https://robohash.org/set_set1/bgset_bg2/Guydo",
        IndividualNotes = " ",
        InnerComment = "No Comments",
        ChronicDeseases = "Miopia",
        RegisterDateTime = DateTime.Now
    };

    public static Patient Patient3 { get; } = new()
    {
        User = null,
        PatientStatus = PatientStatus.Regular,
        PatientPassport = "MP8463756",
        PatientHomeAddress = "Minsk, Chapaeva 5, off.117",
        InsurancePolicy = "Task, DS033754321",
        Photo = "https://robohash.org/set_set1/bgset_bg2/Maletsky",
        IndividualNotes = " ",
        InnerComment = "No Comments",
        ChronicDeseases = " ",
        RegisterDateTime = DateTime.Now
    };

    public static Patient Patient4 { get; } = new()
    {
        User = null,
        PatientStatus = PatientStatus.Discount,
        PatientPassport = "MP1113423",
        PatientHomeAddress = "Minsk, Chapaeva 7, off.417",
        InsurancePolicy = " ",
        Photo = "https://robohash.org/set_set1/bgset_bg2/Liviu",
        IndividualNotes = "No registration in Minsk",
        InnerComment = "No Comments",
        ChronicDeseases = "No",
        RegisterDateTime = DateTime.Now
    };

    public static Staffer AssignToUser(this Staffer staffer, User user)
    {
        staffer.User = user;
        return staffer;
    }

}
