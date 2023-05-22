using MedCenterDB.DbObjects.Infos;

namespace MedCenterDB.Helpers.References;

public static class VisitStatus
{
    public static VisitStatusInfo Planned { get; } = new() { VisitStatus = "Planned" };

    public static VisitStatusInfo Canceled { get; } = new() { VisitStatus = "Canceled" };

    public static VisitStatusInfo Postponed { get; } = new() { VisitStatus = "Postponed" };

    public static VisitStatusInfo Rejected { get; } = new() { VisitStatus = "Rejected" };

    public static VisitStatusInfo Finished { get; } = new() { VisitStatus = "Finished" };

    public static VisitStatusInfo Extended { get; } = new() { VisitStatus = "Extended" };
}


