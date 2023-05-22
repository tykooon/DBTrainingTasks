using MedCenterDB.DbObjects.Infos;

namespace MedCenterDB.Helpers.References;

public static class TestState
{
    public static TestStateInfo Planned { get; } = new() { TestState = "Planned" };

    public static TestStateInfo Started { get; } = new() { TestState = "Started" };

    public static TestStateInfo Postponed { get; } = new() { TestState = "Postponed" };

    public static TestStateInfo Completed { get; } = new() { TestState = "Completed" };

    public static TestStateInfo Failed { get; } = new() { TestState = "Failed" };

    public static TestStateInfo Canceled { get; } = new() { TestState = "Canceled" };
}


