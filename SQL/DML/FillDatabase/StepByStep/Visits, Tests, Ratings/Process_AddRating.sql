use MedCenterDB
go

delete Ratings

declare @json nvarchar(max) =
N'
{
  "Patient": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  },
  "Staffer": {
    "Login": "Sidor86"
  },
  "RatingInfo": {
    "RatingValue": 10,
    "RatingDateTime": "2022-10-10T16:38:57.7621259+03:00",
    "RatingComment": "Cooool!"
  }
}
'

exec dbo.usp_AddRatingToStaffer	@json
go

-------------------------------------------------

declare @json nvarchar(max) =
N'
{
  "Patient": {
    "Login": "GoodGuy",
    "PasswordHash": "20e0wetw346345kdcjlaksdca"
  },
  "Staffer": {
    "Login": "Oleg66"
  },
  "RatingInfo": {
    "RatingValue": 10,
    "RatingDateTime": "2022-10-11T11:44:56.7798749+03:00",
    "RatingComment": "Perfect!"
  }
}
'

exec dbo.usp_AddRatingToStaffer	@json
go


-------------------------------------------------

declare @json nvarchar(max) =
N'
{
  "Patient": {
    "Login": "GoodGuy",
    "PasswordHash": "20e0wetw346345kdcjlaksdca"
  },
  "Staffer": {
    "Login": "Volosevich76"
  },
  "RatingInfo": {
    "RatingValue": 9,
    "RatingDateTime": "2022-10-11T11:44:56.780127+03:00",
    "RatingComment": "Very good!"
  }
}
'

exec dbo.usp_AddRatingToStaffer	@json
go


-------------------------------------------------

declare @json nvarchar(max) =
N'
{
  "Patient": {
    "Login": "GoodGuy",
    "PasswordHash": "20e0wetw346345kdcjlaksdca"
  },
  "Staffer": {
    "Login": "Kheidor"
  },
  "RatingInfo": {
    "RatingValue": 7,
    "RatingDateTime": "2022-10-11T11:44:56.7803208+03:00",
    "RatingComment": "Normal!"
  }
}
'

exec dbo.usp_AddRatingToStaffer	@json
go


-----------------------------------------

declare @json nvarchar(max) =
N'
{
  "Patient": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  },
  "Staffer": {
    "Login": "Volosevich76"
  },
  "RatingInfo": {
    "RatingValue": 9,
    "RatingDateTime": "2022-10-10T16:38:57.7674564+03:00",
    "RatingComment": "Nice!"
  }
}
'

exec dbo.usp_AddRatingToStaffer	@json
go



-------------------------------------------------

declare @json nvarchar(max) =
N'
{
  "Patient": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  },
  "Staffer": {
    "Login": "Kheidor"
  },
  "RatingInfo": {
    "RatingValue": 7,
    "RatingDateTime": "2022-10-10T16:38:57.7679638+03:00",
    "RatingComment": "Not Bad!"
  }
}
'

exec dbo.usp_AddRatingToStaffer	@json
go



-------------------------------------------------

declare @json nvarchar(max) =
N'
{
  "Patient": {
    "Login": "Liviu",
    "PasswordHash": "20e0we45744sdgs43aksdca"
  },
  "Staffer": {
    "Login": "Sidor86"
  },
  "RatingInfo": {
    "RatingValue": 9,
    "RatingDateTime": "2022-10-11T11:44:56.7448175+03:00",
    "RatingComment": "Wow!"
  }
}
'

exec dbo.usp_AddRatingToStaffer	@json
go



-------------------------------------------------

declare @json nvarchar(max) =
N'
{
  "Patient": {
    "Login": "Liviu",
    "PasswordHash": "20e0we45744sdgs43aksdca"
  },
  "Staffer": {
    "Login": "Volosevich76"
  },
  "RatingInfo": {
    "RatingValue": 8,
    "RatingDateTime": "2022-10-11T11:44:56.7781922+03:00",
    "RatingComment": "Good!"
  }
}
'

exec dbo.usp_AddRatingToStaffer	@json
go



-------------------------------------------------

declare @json nvarchar(max) =
N'
{
  "Patient": {
    "Login": "Liviu",
    "PasswordHash": "20e0we45744sdgs43aksdca"
  },
  "Staffer": {
    "Login": "Kovboy"
  },
  "RatingInfo": {
    "RatingValue": 6,
    "RatingDateTime": "2022-10-11T11:44:56.7785701+03:00",
    "RatingComment": "Some Questions!"
  }
}
'

exec dbo.usp_AddRatingToStaffer	@json
go



-------------------------------------------------

declare @json nvarchar(max) =
N'
{
  "Patient": {
    "Login": "Malets",
    "PasswordHash": "20e0we457445345kdcjlaksdca"
  },
  "Staffer": {
    "Login": "Kheidor"
  },
  "RatingInfo": {
    "RatingValue": 9,
    "RatingDateTime": "2022-10-11T11:44:56.7788391+03:00",
    "RatingComment": "Great!"
  }
}
'

exec dbo.usp_AddRatingToStaffer	@json
go



-------------------------------------------------

declare @json nvarchar(max) =
N'
{
  "Patient": {
    "Login": "Malets",
    "PasswordHash": "20e0we457445345kdcjlaksdca"
  },
  "Staffer": {
    "Login": "Sidor86"
  },
  "RatingInfo": {
    "RatingValue": 10,
    "RatingDateTime": "2022-10-11T11:44:56.7791315+03:00",
    "RatingComment": "Best!"
  }
}
'

exec dbo.usp_AddRatingToStaffer	@json
go



-------------------------------------------------

declare @json nvarchar(max) =
N'
{
  "Patient": {
    "Login": "Malets",
    "PasswordHash": "20e0we457445345kdcjlaksdca"
  },
  "Staffer": {
    "Login": "Oleg66"
  },
  "RatingInfo": {
    "RatingValue": 10,
    "RatingDateTime": "2022-10-11T11:44:56.7796351+03:00",
    "RatingComment": "No Questions!"
  }
}
'

exec dbo.usp_AddRatingToStaffer	@json
go
