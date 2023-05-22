using MedCenterDB.DbObjects.Infos;

namespace MedCenterDB.DbObjects;

public class Visit : DbObject
{
    public Service BaseService { get; set; }
    public User Specialist { get; set; }
    public DateTime ScheduledDateTime { get; set; } = DateTime.MinValue;
    public User RecordedPatient { get; set; }
    public string PreliminaryNotes { get; set; }
    public Room VisitRoom { get; set; }
    public string Summary { get; set; }
    public decimal? TotalPrice { get; set; }
    public PaymentStateInfo PaymentState { get; set; }
    public VisitStatusInfo VisitStatus { get; set; }
    public VisitTypeInfo VisitType { get; set; }
    public string InternalComment { get; set; }
    public DateTime? RecordDateTime { get; set; }
}
