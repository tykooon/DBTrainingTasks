using MedCenterDB.DbObjects;
using MedCenterDB.DbObjects.Infos;
using System.Collections.Generic;

namespace MedCenterDB.Helpers;

public static class Guests
{
    public static Guest Guest1 { get; } = new()
    {
        IpAddress = "122.34.25.34",
        SessionDateTime = DateTime.Now,
        BrowserUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36"
    };

    public static Guest Guest2 { get; } = new()
    {
        IpAddress = "112.14.125.4",
        SessionDateTime = DateTime.Now,
        BrowserUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36"
    };

    public static Guest Guest3 { get; } = new()
    {
        IpAddress = "62.53.89.234",
        SessionDateTime = DateTime.Now,
        BrowserUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36"
    };

    public static Guest Guest4 { get; } = new()
    {
        IpAddress = "77.94.75.134",
        SessionDateTime = DateTime.Now,
        BrowserUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36"
    };
}

