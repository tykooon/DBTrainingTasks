using MedCenterDB.DbObjects;
using MedCenterDB.Helpers.References;

namespace MedCenterDB.Helpers;

public static class Visits
{
    public static Visit[] Cardio0811 = new Visit[6];

    public static Visit[] Ultrasound0911 = new Visit[4];

    static Visits()
    {
        for (int i = 0; i < 6; i++)
        {
            Cardio0811[i] = new Visit()
            {
                BaseService = Services.CardioConsultation,
                Specialist = Users.Volosevich,
                VisitRoom = Rooms.Cabinet1,
                VisitType = VisitType.Consultation,
                VisitStatus = VisitStatus.Planned,
                PreliminaryNotes = " ",
                PaymentState = PaymentState.NotPaid,
                ScheduledDateTime = new DateTime(2022, 11, 08, 12 + i / 3, 20 * (i % 3), 0)
            };
        };

        for (int i = 0; i < 4; i++)
        {
            Ultrasound0911[i] = new Visit()
            {
                BaseService = Services.UlrtasoundHeart,
                Specialist = Users.Kheidorov,
                VisitRoom = Rooms.CabinetUS,
                VisitType = VisitType.Examination,
                VisitStatus = VisitStatus.Planned,
                PreliminaryNotes = "No food at least 2 hours before.",
                PaymentState = PaymentState.NotPaid,
                ScheduledDateTime = new DateTime(2022, 11, 09, 9 + i / 2, 30 * (i % 2), 0)
            };
        }
    }





    public static void OnlyValues(this Visit visit)
    {
        visit.BaseService = null;
        visit.RecordedPatient = null;
        visit.Specialist = null;
        visit.VisitRoom = null;
    }
}

