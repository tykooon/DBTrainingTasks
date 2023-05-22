use MedCenterDB
go

--delete UsersPhonesLink
--delete Guests
--delete Users
--delete Phones


declare @newUserRegisrtationJson nvarchar(max);

set @newUserRegisrtationJson =
'
{
  "Guest": {
    "IpAddress": "22.34.25.34",
    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
    "SessionDateTime": "2022-09-27T19:35:33.6578067+03:00"
  },
  "User": {
	"Login": "Kalabukh",
	"Email": "eugenkalabukhov@coherentsolutions.com",
	"PasswordHash": "20e0wetwdckdjc02kdcjlaksdca",
	"FullName": "Eugen Kalabukhov",
	"Gender": {
	  "GenderName": "Male"
	},
	"DateOfBirth": "12/23/1972",
	"Phones": [
	 {
	   "PhoneNumber": "\u002B375297013414"
	 }
	],
    "RegisterDateTime": "2022-09-04T11:51:00.9086322+03:00",
    "LastActiveDateTime": "2022-10-01T11:51:00.9159824+03:00"
  }
}
'
exec dbo.usp_NewUserRegistration
	@newUserRegisrtationJson

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
    "Email": "igorkheidorov@coherentsolutions.com",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca",
    "FullName": "Igor Kheidorov",
    "Gender": {
      "GenderName": "Male"
    },
    "DateOfBirth": "6/15/1974",
    "Phones": [
      {
        "PhoneNumber": "\u002B375296210031"
      }
    ],
    "RegisterDateTime": "2021-03-04T11:51:00.9086322+03:00",
    "LastActiveDateTime": "2022-10-03T11:51:00.9159824+03:00"
  }
}
'

exec dbo.usp_NewUserRegistration
	@newUserRegisrtationJson

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
    "DateOfBirth": "6/15/1999",
    "Phones": [
      {
        "PhoneNumber": "\u002B375336277743"
      },
      {
        "PhoneNumber": "\u002B16122791213"
      }
    ],
    "RegisterDateTime": "2022-08-04T11:51:00.9086322+03:00"
  }
}
'

exec dbo.usp_NewUserRegistration
	@newUserRegisrtationJson

set @newUserRegisrtationJson =
'
{
  "Guest": {
    "IpAddress": "28.47.25.134",
    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
    "SessionDateTime": "2022-09-27T19:35:33.6578067+03:00"
  },
  "User": {
    "Login": "Oleg66",
    "Email": "olegfridlyand@coherentsolutions.com",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca",
    "FullName": "Oleg Fridlyand",
    "Gender": {
      "GenderName": "Male"
    },
    "DateOfBirth": "6/15/1966",
    "Phones": [
        {
          "PhoneNumber": "\u002B375291225543"
        },
        {
          "PhoneNumber": "\u002B16122360502"
        }
      ],
    "RegisterDateTime": "2022-10-01T11:51:00.9086322+03:00"
  }
}
'


exec dbo.usp_NewUserRegistration
	@newUserRegisrtationJson

set @newUserRegisrtationJson =
'
{
  "Guest": {
    "IpAddress": "116.34.25.34",
    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
    "SessionDateTime": "2022-10-02T20:57:59.0862273+03:00"
  },
  "User": {
    "Login": "Tykooon",
    "Email": "alexandertykun@coherentsolutions.com",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca",
    "FullName": "Alex Tykoun",
    "Gender": {
      "GenderName": "Male"
    },
    "DateOfBirth": "10/13/1977",
    "Phones": [
      {
        "PhoneNumber": "\u002B375296480979"
      },
      {
        "PhoneNumber": "\u002B375173074754"
      }
    ],
    "RegisterDateTime": "2022-10-02T11:51:00.9086322+03:00",
    "LastActiveDateTime": "2022-10-03T11:51:00.9159824+03:00"
  }
}
'


exec dbo.usp_NewUserRegistration
	@newUserRegisrtationJson

set @newUserRegisrtationJson =
'
{
  "Guest": {
    "IpAddress": "212.14.125.4",
    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
    "SessionDateTime": "2022-10-02T20:57:59.0862827+03:00"
  },
  "User": {
    "Login": "Sidor86",
    "Email": "alexandrasidorovich@coherentsolutions.com",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca",
    "FullName": "Alexandra Sidorovich",
    "Gender": {
      "GenderName": "Female"
    },
    "DateOfBirth": "10/26/1986",
    "Phones": [
      {
        "PhoneNumber": "\u002B375295103565"
      }
    ],
    "RegisterDateTime": "2022-09-08T11:51:00.9086322+03:00",
    "LastActiveDateTime": "2022-10-02T11:51:00.9159824+03:00"
  }
}
'

exec dbo.usp_NewUserRegistration
	@newUserRegisrtationJson

	set @newUserRegisrtationJson =
'
{
  "Guest": {
    "IpAddress": "62.53.89.234",
    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
    "SessionDateTime": "2022-10-02T20:57:59.0862829+03:00"
  },
  "User": {
    "Login": "Volosevich76",
    "Email": "alexeyvolosevich@coherentsolutions.com",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca",
    "FullName": "Alexei Volosevich",
    "Gender": {
      "GenderName": "Male"
    },
    "DateOfBirth": "06/15/1976",
    "Phones": [
      {
        "PhoneNumber": "\u002B375296208259"
      }
    ],
    "RegisterDateTime": "2022-07-04T11:51:00.9086322+03:00",
    "LastActiveDateTime": "2022-09-03T11:51:00.9159824+03:00"
  }
}'


exec dbo.usp_NewUserRegistration
	@newUserRegisrtationJson
go

declare @newUserRegisrtationJson nvarchar(max) =
N'
{
  "Guest": {
    "IpAddress": "62.13.89.214",
    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
    "SessionDateTime": "2022-10-10T18:35:24.6772797+03:00"
  },
  "User": {
    "Login": "Liviu",
    "Email": "LiviuLupanciuc@coherentsolutions.com",
    "PasswordHash": "20e0we45744sdgs43aksdca",
    "FullName": "Liviu Lupanciuc",
    "Gender": {
      "GenderName": "Male"
    },
    "DateOfBirth": "4/15/1999",
    "Phones": [
      {
        "PhoneNumber": "\u002B373(68)936625"
      }
    ],
    "RegisterDateTime": "2022-10-10T18:35:24.6821586+03:00",
    "LastActiveDateTime": "2022-10-10T18:35:24.6821587+03:00"
  }
}
'
exec dbo.usp_NewUserRegistration
	@newUserRegisrtationJson
go
-----------------------------------

declare @newUserRegisrtationJson nvarchar(max) =
N'
{
  "Guest": {
    "IpAddress": "142.34.25.44",
    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
    "SessionDateTime": "2022-10-10T18:35:24.6772336+03:00"
  },
  "User": {
    "Login": "GoodGuy",
    "Email": "KirillGuydo@coherentsolutions.com",
    "PasswordHash": "20e0wetw346345kdcjlaksdca",
    "FullName": "Kirill Guydo",
    "Gender": {
      "GenderName": "Male"
    },
    "DateOfBirth": "4/3/2004",
    "Phones": [
      {
        "PhoneNumber": "\u002B375(29)3084851"
      }
    ],
    "RegisterDateTime": "2022-10-10T18:35:24.6821578+03:00",
    "LastActiveDateTime": "2022-10-10T18:35:24.6821578+03:00"
  }
}
'
exec dbo.usp_NewUserRegistration
	@newUserRegisrtationJson
go
-----------------------------------

declare @newUserRegisrtationJson nvarchar(max) =
N'
{
  "Guest": {
    "IpAddress": "172.14.127.4",
    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
    "SessionDateTime": "2022-10-10T18:35:24.6772796+03:00"
  },
  "User": {
    "Login": "Malets",
    "Email": "VadimMaletsky@coherentsolutions.com",
    "PasswordHash": "20e0we457445345kdcjlaksdca",
    "FullName": "Vadim Maletsky",
    "Gender": {
      "GenderName": "Male"
    },
    "DateOfBirth": "2/7/1998",
    "Phones": [
      {
        "PhoneNumber": "\u002B375(29)6662103"
      }
    ],
    "RegisterDateTime": "2022-10-10T18:35:24.6821583+03:00",
    "LastActiveDateTime": "2022-10-10T18:35:24.6821583+03:00"
  }
}
'
exec dbo.usp_NewUserRegistration
	@newUserRegisrtationJson
go
-----------------------------------

declare @newUserRegisrtationJson nvarchar(max) =
N'
{
  "Guest": {
    "IpAddress": "192.124.127.4",
    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
    "SessionDateTime": "2022-10-10T18:35:24.6772796+03:00"
  },
  "User": {
    "Login": "Gavr",
    "Email": "timofeygavrilenko@coherentsolutions.com",
    "PasswordHash": "20e0we4572346345cjlaksdca",
    "FullName": "Timofey Gavrilenko",
    "Gender": {
      "GenderName": "Male"
    },
    "DateOfBirth": "4/12/1973",
    "Phones": [
      {
        "PhoneNumber": "\u002B375(44) 5860643"
      }
    ],
    "RegisterDateTime": "2022-09-10T18:35:24.6821583+03:00",
    "LastActiveDateTime": "2022-10-10T18:35:24.6821583+03:00"
  }
}
'
exec dbo.usp_NewUserRegistration
	@newUserRegisrtationJson
go
-----------------------------------

declare @newUserRegisrtationJson nvarchar(max) =
N'
{
  "Guest": {
    "IpAddress": "172.14.17.44",
    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
    "SessionDateTime": "2022-10-10T18:35:24.6772796+03:00"
  },
  "User": {
    "Login": "ValeraP",
    "Email": "ValeryPrytkov@coherentsolutions.com",
    "PasswordHash": "20e0we457445345kdcjla2t351a",
    "FullName": "Valery Prytkov",
    "Gender": {
      "GenderName": "Male"
    },
    "DateOfBirth": "5/1/1969",
    "Phones": [
      {
        "PhoneNumber": "\u002B48517251998"
      },
	  {
        "PhoneNumber": "\u002B375(29)3495574"
      }
    ],
    "RegisterDateTime": "2022-10-03T18:35:24.6821583+03:00"
  }
}
'
exec dbo.usp_NewUserRegistration
	@newUserRegisrtationJson
go
-----------------------------------