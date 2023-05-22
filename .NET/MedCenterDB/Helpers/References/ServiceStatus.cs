using MedCenterDB.DbObjects.Infos;

namespace MedCenterDB.Helpers.References;

public static class ServiceStatus
{
    public static ServiceStatusInfo Accessible { get; } = new() { ServiceStatus = "Accessible" };

    public static ServiceStatusInfo Suspended { get; } = new() { ServiceStatus = "Suspended" };

    public static ServiceStatusInfo OnDemand { get; } = new() { ServiceStatus = "On Demand" };

    public static ServiceStatusInfo Depricated { get; } = new() { ServiceStatus = "Depricated" };
}