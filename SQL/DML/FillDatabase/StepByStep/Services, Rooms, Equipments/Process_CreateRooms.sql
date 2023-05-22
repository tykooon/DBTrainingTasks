use MedCenterDB
go

delete Rooms

declare @json nvarchar(max) =
'
{
  "Admin": {
    "Login": "Kalabukh",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Room": {
    "RoomName": "Reception",
    "RoomState": {
      "RoomState": "Accessible"
    },
    "RoomType": {
      "RoomType": "Common Area"
    },
    "RoomNotes": "Main Reception",
    "LastUpdateDateTime": "2022-10-06T19:49:53.1999334+03:00"
  }
}'
exec dbo.usp_CreateRoom
	@json
go


declare @json nvarchar(max) =
'
{
  "Admin": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  },
  "Room": {
    "RoomName": "Cabinet 5",
    "RoomState": {
      "RoomState": "Accessible"
    },
    "RoomType": {
      "RoomType": "Service Space"
    },
    "RoomNotes": "Director and Administration",
    "LastUpdateDateTime": "2022-10-06T19:22:42.6276382+03:00"
  }
}
'

exec dbo.usp_CreateRoom
	@json
go

declare @json nvarchar(max) =
'
{
  "Admin": {
    "Login": "Kalabukh",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Room": {
    "RoomName": "Cabinet 1",
    "RoomState": {
      "RoomState": "Accessible"
    },
    "RoomType": {
      "RoomType": "Doctor\u0027s Office"
    },
    "RoomNotes": "Cardiological Office",
    "LastUpdateDateTime": "2022-10-06T19:22:42.6276194+03:00"
  }
}
'

exec dbo.usp_CreateRoom
	@json
go

declare @json nvarchar(max) =
'
{
  "Admin": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  },
  "Room": {
    "RoomName": "Cabinet 3",
    "RoomState": {
      "RoomState": "Accessible"
    },
    "RoomType": {
      "RoomType": "Doctor\u0027s Office"
    },
    "RoomNotes": "X-Ray Room",
    "LastUpdateDateTime": "2022-10-06T19:22:42.6276197+03:00"
  }
}
'

exec dbo.usp_CreateRoom
	@json
go

declare @json nvarchar(max) =
'
{
  "Admin": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  },
  "Room": {
    "RoomName": "Cabinet 2",
    "RoomState": {
      "RoomState": "Accessible"
    },
    "RoomType": {
      "RoomType": "Doctor\u0027s Office"
    },
    "RoomNotes": "Ultrasound Room",
    "LastUpdateDateTime": "2022-10-06T19:22:42.6276196+03:00"
  }
}
'

exec dbo.usp_CreateRoom
	@json
go

declare @json nvarchar(max) =
'
{
  "Admin": {
    "Login": "Kalabukh",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Room": {
    "RoomName": "Cabinet 4",
    "RoomState": {
      "RoomState": "Accessible"
    },
    "RoomType": {
      "RoomType": "Laboratory"
    },
    "RoomNotes": "Test Laboratory",
    "LastUpdateDateTime": "2022-10-06T19:22:42.6276292+03:00"
  }
}
'

exec dbo.usp_CreateRoom
	@json
go
