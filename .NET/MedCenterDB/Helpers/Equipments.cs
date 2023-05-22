using MedCenterDB.DbObjects;
using MedCenterDB.DbObjects.Infos;
using MedCenterDB.Helpers.References;
using System.Runtime.CompilerServices;

namespace MedCenterDB.Helpers;

public static class Equipments
{
    public static Equipment PC1 = new()
    {
        EquipmentName = "Computer Dell",
        InventaryNumber = "PC111-222",
        EquipmentState = EquipmentState.InService,
        EquipmentType = EquipmentType.PersonalComputer,
        EquipmentNote = "Windows 10, Intel Core i5",
        Services = new() { Services.TherapistConsultation, Services.CardioConsultation },
        RegistrationDateTime = DateTime.Now,
        EquipmentRoom = new() { RoomName = Rooms.Cabinet1.RoomName }
    };

    public static Equipment PC2 = new()
    {
        EquipmentName = "Computer Lenovo",
        InventaryNumber = "PC333-444",
        EquipmentState = EquipmentState.InService,
        EquipmentType = EquipmentType.PersonalComputer,
        EquipmentNote = "Windows 11, Intel Core i9",
        RegistrationDateTime = DateTime.Now,
        Services = new() { Services.TherapistConsultation, Services.CardioConsultation },
        EquipmentRoom = new() { RoomName = Rooms.BossRoom.RoomName }
    };

    public static Equipment PC3 = new()
    {
        EquipmentName = "Laptop HP",
        InventaryNumber = "PC555-666",
        EquipmentState = EquipmentState.InService,
        EquipmentType = EquipmentType.PersonalComputer,
        EquipmentNote = "Windows 10, AMD, 200GB",
        RegistrationDateTime = DateTime.Now,
        Services = new() { Services.TherapistConsultation },
        EquipmentRoom = new() { RoomName = Rooms.CabinetTest.RoomName }
    };

    public static Equipment PC4 = new()
    {
        EquipmentName = "Intel Pentium",
        InventaryNumber = "PC777-888",
        EquipmentState = EquipmentState.InService,
        EquipmentType = EquipmentType.PersonalComputer,
        EquipmentNote = "Windows 7, Intel, 4GB RAM",
        RegistrationDateTime = DateTime.Now
    };

    public static Equipment PC5 = new()
    {
        EquipmentName = "Acer",
        InventaryNumber = "PC999-000",
        EquipmentState = EquipmentState.InService,
        EquipmentType = EquipmentType.PersonalComputer,
        EquipmentNote = "Windows 8, AMD, 3TB",
        LastEditor = Users.Kalabuhov,
    };


    public static Equipment Ultrasound1 = new()
    {
        EquipmentName = "GE Voluson S8 Ultrasound",
        InventaryNumber = "US111-222",
        EquipmentState = EquipmentState.InService,
        EquipmentType = EquipmentType.Ultrasound,
        EquipmentNote = "For women’s health applications, obstetrics, gynecology, fertility. Secondary applications: general imaging, adult and pediatric cardiology, and neonatal cardiology.",
        RegistrationDateTime = DateTime.Now,
        Services = new() { Services.UlrtasoundLiver, Services.UlrtasoundHeart },
        EquipmentRoom = new() { RoomName = Rooms.CabinetUS.RoomName }
    };

    public static Equipment XRay = new()
    {
        EquipmentName = "BPL H-RAD 32 High Frequency X Ray",
        InventaryNumber = "XR222-333",
        EquipmentState = EquipmentState.InService,
        EquipmentType = EquipmentType.XRay,
        EquipmentNote = "User configurable anatomic programming with 216 program options. 40 to 125 in steps of 1kVp only",
        RegistrationDateTime = DateTime.Now,
        EquipmentRoom = new() { RoomName = Rooms.CabinetXRay.RoomName }
    };

    public static Equipment BloodAnalyzer1 = new()
    {
        EquipmentName = "Mindray BC-1800 Hematology Analyzer",
        InventaryNumber = "BA444-555",
        EquipmentState = EquipmentState.InService,
        EquipmentType = EquipmentType.Analyzer,
        EquipmentNote = "Fully Automated hematology analyzer. 3 Part differentiation of WBC 19 Parameters + 3 histograms.",
        RegistrationDateTime = DateTime.Now,
        Services = new() { Services.BloodTest1, Services.BloodTest2 },
        EquipmentRoom = new() { RoomName = Rooms.CabinetTest.RoomName }
    };

    public static Equipment CashDesk1 = new()
    {
        EquipmentName = "zPOS D2s",
        InventaryNumber = "CD-01-101",
        EquipmentState = EquipmentState.InService,
        EquipmentType = EquipmentType.OfficeTechnic,
        EquipmentNote = "Main Cash Desk on Reception"
    };




    public static void OnlyNumber(this Equipment equipment)
    {
        equipment.EquipmentName = null;
        equipment.Services = null;
        equipment.EquipmentState = null;
        equipment.EquipmentType = null;
        equipment.EquipmentNote = null;
        equipment.LastEditor = null;
        equipment.EquipmentRoom = null;
        equipment.RegistrationDateTime = null;
    }


}
