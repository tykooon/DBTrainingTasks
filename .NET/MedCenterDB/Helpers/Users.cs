using MedCenterDB.DbObjects;
using MedCenterDB.DbObjects.Infos;
using MedCenterDB.Helpers.References;
using System.Collections.Generic;

namespace MedCenterDB.Helpers;

public static class Users
{
    public static User Tykoun { get; } = new()
    {
        Login = "Tykooon",
        Email = "alexandertykun@coherentsolutions.com",
        PasswordHash = "20e0dckdjc02kdcjlaksdca",
        FullName = "Alex Tykoun",
        DateOfBirth = new DateOnly(1977, 10, 13).ToString(),
        Gender = Gender.Male,
        UserRole = UserRole.Administrator,
        Phones = new() { new PhoneInfo("+375296480979"), new PhoneInfo("+375173074754") },
    };

    public static User Sidorovich { get; } = new()
    {
        Login = "Sidor86",
        Email = "alexandrasidorovich@coherentsolutions.com",
        PasswordHash = "20e0wetwdckdjc02kdcjlaksdca",
        FullName = "Alexandra Sidorovich",
        DateOfBirth = new DateOnly(1986, 10, 26).ToString(),
        Gender = Gender.Female,
        UserRole = UserRole.Regular,
        Phones = new() { new PhoneInfo("+375295103565") },
    };

    public static User Kalabuhov { get; } = new()
    {
        Login = "Kalabukh",
        Email = "eugenkalabukhov@coherentsolutions.com",
        PasswordHash = "20e0wetwdckdjc02kdcjlaksdca",
        FullName = "Eugen Kalabukhov",
        DateOfBirth = new DateOnly(1972, 12, 23).ToString(),
        Gender = Gender.Male,
        UserRole = UserRole.Regular,
        Phones = new() { new PhoneInfo("+375297013414") },
    };

    public static User Volosevich { get; } = new()
    {
        Login = "Volosevich76",
        Email = "alexeyvolosevich@coherentsolutions.com",
        PasswordHash = "20e0wetwdckdjc02kdcjlaksdca",
        FullName = "Alexei Volosevich",
        DateOfBirth = new DateOnly(1976, 06, 15).ToString(),
        Gender = Gender.Male,
        UserRole = UserRole.Regular,
        Phones = new() { new PhoneInfo("+375296208259") },
    };

    public static User Kovbovich { get; } = new()
    {
        Login = "Kovboy",
        Email = "nastyakovbovich@coherentsolutions.com",
        PasswordHash = "20e0wetwdckdjc02kdcjlaksdca",
        FullName = "Nastya Kovbovich",
        DateOfBirth = new DateOnly(1999, 06, 15).ToString(),
        Gender = Gender.Female,
        UserRole = UserRole.Regular,
        Phones = new() { new PhoneInfo("+375336277743"), new PhoneInfo("+16122791213") },
    };

    public static User Kheidorov { get; } = new()
    {
        Login = "Kheidor",
        Email = "igorkheidorov@coherentsolutions.com",
        PasswordHash = "20e0wetwdckdjc02kdcjlaksdca",
        FullName = "Igor Kheidorov",
        DateOfBirth = new DateOnly(1974, 06, 15).ToString(),
        Gender = Gender.Male,
        UserRole = UserRole.Regular,
        Phones = new() { new PhoneInfo("+375296210031") },
    };

    public static User Fridlyand { get; } = new()
    {
        Login = "Oleg66",
        Email = "olegfridlyand@coherentsolutions.com",
        PasswordHash = "20e0wetwdckdjc02kdcjlaksdca",
        FullName = "Oleg Fridlyand",
        DateOfBirth = new DateOnly(1966, 06, 15).ToString(),
        Gender = Gender.Male,
        UserRole = UserRole.Regular,
        Phones = new() { new PhoneInfo("+375291225543"), new PhoneInfo("+16122360502") },
    };

    public static User Guydo { get; } = new()
    {
        Login = "GoodGuy",
        Email = "KirillGuydo@coherentsolutions.com",
        PasswordHash = "20e0wetw346345kdcjlaksdca",
        FullName = "Kirill Guydo",
        DateOfBirth = new DateOnly(2004, 04, 03).ToString(),
        Gender = Gender.Male,
        UserRole = UserRole.Regular,
        Phones = new() { new PhoneInfo("+375(29)3084851") },
    };

    public static User Maletsky { get; } = new()
    {
        Login = "Malets",
        Email = "VadimMaletsky@coherentsolutions.com",
        PasswordHash = "20e0we457445345kdcjlaksdca",
        FullName = "Vadim Maletsky",
        DateOfBirth = new DateOnly(1998, 02, 07).ToString(),
        Gender = Gender.Male,
        UserRole = UserRole.Regular,
        Phones = new() { new PhoneInfo("+375(29)6662103") },
    };

    public static User Liviu { get; } = new()
    {
        Login = "Liviu",
        Email = "LiviuLupanciuc@coherentsolutions.com",
        PasswordHash = "20e0we45744sdgs43aksdca",
        FullName = "Liviu Lupanciuc",
        DateOfBirth = new DateOnly(1999, 04, 15).ToString(),
        Gender = Gender.Male,
        UserRole = UserRole.Regular,
        Phones = new() { new PhoneInfo("+373(68)936625") },
    };

    public static void OnlyLoginAndPassword(this User user)
    {
        user.Email = null;
        user.FullName = null;
        user.DateOfBirth = null;
        user.Gender = null;
        user.UserRole = null;
        user.Phones = null;
        user.LastActiveDateTime = null;
        user.RegisterDateTime = null;
        user.AdminApprover = null;
        return;
    }

    public static void OnlyLogin(this User user)
    {
        user.OnlyLoginAndPassword();
        user.PasswordHash = null;
        return;
    }
}
