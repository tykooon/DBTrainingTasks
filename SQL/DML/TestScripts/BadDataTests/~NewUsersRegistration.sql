use MedCenterDB
go

-- Missing parameters
declare @newUserRegisrtationJson nvarchar(max) =
'
{
  "Guest": {
    "IpAddress": "22.34.25.34",
    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36"
  },
  "User": {
	"Login": "Kalabukh",
	"PasswordHash": "20e0wetwdckdjc02kdcjlaksdca",
	"FullName": "Eugen Kalabukhov",
	"DateOfBirth": "12/23/1972"
  }
}
'
exec dbo.usp_NewUserRegistration
	@newUserRegisrtationJson

-- ***************************************************************
-- Wrong Gender Value
set @newUserRegisrtationJson =
'
{
  "Guest": {
    "IpAddress": "122.38.15.34",
    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
    "SessionDateTime": "2022-09-27T19:35:33.6578067+03:00"
  },
  "User": {
    "Login": "Kheidor",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca",
    "FullName": "Igor Kheidorov",
    "Gender": {
      "GenderName": "Man"
    },
    "DateOfBirth": "6/15/1974"
  }
}
'
exec dbo.usp_NewUserRegistration
	@newUserRegisrtationJson

-- **********************************************
-- Try to Add User with Existing [Login]
set @newUserRegisrtationJson =
'
{
  "Guest": {
    "IpAddress": "122.34.95.4",
    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
    "SessionDateTime": "2022-09-27T19:35:33.6578067+03:00"
  },
  "User": {
    "Login": "Kovboy",
    "Email": "nastyakovbovich@coherentsolutions.com",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca",
    "FullName": "Nastya Kovbovich",
    "Gender": {
      "GenderName": "Female"
    },
    "DateOfBirth": "05/15/1999",
    "RegisterDateTime": "2022-08-04T11:51:00.9086322+03:00"
  }
}
'
exec dbo.usp_NewUserRegistration
	@newUserRegisrtationJson

--set @newUserRegisrtationJson =
--'
--{
--  "Guest": {
--    "IpAddress": "28.47.25.134",
--    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
--    "SessionDateTime": "2022-09-27T19:35:33.6578067+03:00"
--  },
--  "User": {
--    "Login": "Oleg66",
--    "Email": "olegfridlyand@coherentsolutions.com",
--    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca",
--    "FullName": "Oleg Fridlyand",
--    "Gender": {
--      "GenderName": "Male"
--    },
--    "DateOfBirth": "6/15/1966",
--    "Phones": [
--        {
--          "PhoneNumber": "\u002B375291225543"
--        },
--        {
--          "PhoneNumber": "\u002B16122360502"
--        }
--      ],
--    "RegisterDateTime": "2022-10-01T11:51:00.9086322+03:00"
--  }
--}
--'


--exec dbo.usp_NewUserRegistration
--	@newUserRegisrtationJson

--set @newUserRegisrtationJson =
--'
--{
--  "Guest": {
--    "IpAddress": "116.34.25.34",
--    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
--    "SessionDateTime": "2022-10-02T20:57:59.0862273+03:00"
--  },
--  "User": {
--    "Login": "Tykooon",
--    "Email": "alexandertykun@coherentsolutions.com",
--    "PasswordHash": "20e0dckdjc02kdcjlaksdca",
--    "FullName": "Alex Tykoun",
--    "Gender": {
--      "GenderName": "Male"
--    },
--    "DateOfBirth": "10/13/1977",
--    "Phones": [
--      {
--        "PhoneNumber": "\u002B375296480979"
--      },
--      {
--        "PhoneNumber": "\u002B375173074754"
--      }
--    ],
--    "RegisterDateTime": "2022-10-02T11:51:00.9086322+03:00",
--    "LastActiveDateTime": "2022-10-03T11:51:00.9159824+03:00"
--  }
--}
--'


--exec dbo.usp_NewUserRegistration
--	@newUserRegisrtationJson

--set @newUserRegisrtationJson =
--'
--{
--  "Guest": {
--    "IpAddress": "212.14.125.4",
--    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
--    "SessionDateTime": "2022-10-02T20:57:59.0862827+03:00"
--  },
--  "User": {
--    "Login": "Sidor86",
--    "Email": "alexandrasidorovich@coherentsolutions.com",
--    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca",
--    "FullName": "Alexandra Sidorovich",
--    "Gender": {
--      "GenderName": "Female"
--    },
--    "DateOfBirth": "10/26/1986",
--    "Phones": [
--      {
--        "PhoneNumber": "\u002B375295103565"
--      }
--    ],
--    "RegisterDateTime": "2022-09-08T11:51:00.9086322+03:00",
--    "LastActiveDateTime": "2022-10-02T11:51:00.9159824+03:00"
--  }
--}
--'

--exec dbo.usp_NewUserRegistration
--	@newUserRegisrtationJson

--	set @newUserRegisrtationJson =
--'
--{
--  "Guest": {
--    "IpAddress": "62.53.89.234",
--    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
--    "SessionDateTime": "2022-10-02T20:57:59.0862829+03:00"
--  },
--  "User": {
--    "Login": "Volosevich76",
--    "Email": "alexeyvolosevich@coherentsolutions.com",
--    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca",
--    "FullName": "Alexei Volosevich",
--    "Gender": {
--      "GenderName": "Male"
--    },
--    "DateOfBirth": "06/15/1976",
--    "Phones": [
--      {
--        "PhoneNumber": "\u002B375296208259"
--      }
--    ],
--    "RegisterDateTime": "2022-07-04T11:51:00.9086322+03:00",
--    "LastActiveDateTime": "2022-09-03T11:51:00.9159824+03:00"
--  }
--}'


--exec dbo.usp_NewUserRegistration
--	@newUserRegisrtationJson


go