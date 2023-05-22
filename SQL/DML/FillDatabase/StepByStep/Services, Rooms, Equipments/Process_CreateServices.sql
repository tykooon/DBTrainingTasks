use MedCenterDB
go

delete EquipmentsServicesLink
delete Equipments

declare @json nvarchar(max) =
N'
{
  "Admin": {
    "Login": "Kalabukh",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Service": {
    "ServiceName": "Cardiologist Consultation",
    "ServiceStatus": {
      "ServiceStatus": "Accessible"
    },
    "Comment": "Only Wednesday and Friday",
    "Price": 45.5,
    "ServiceCategory": {
      "ServiceCategory": "Consultation"
    },
    "Description": "Common survey, Cardiography included"
  }
}
'
exec dbo.usp_CreateService
	@json
go

declare @json nvarchar(max) =
N'
{
  "Admin": {
    "Login": "Kalabukh",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Service": {
    "ServiceName": "Therapist Consultation",
    "ServiceStatus": {
      "ServiceStatus": "Accessible"
    },
    "Comment": "Not available on Sunday and Saturday",
    "Price": 43.5,
    "ServiceCategory": {
      "ServiceCategory": "Consultation"
    },
    "Description": "Common procedures, Blood Pressure, Survey"
  }
}
'
exec dbo.usp_CreateService
	@json
go

declare @json nvarchar(max) =
N'
{
  "Admin": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  },
  "Service": {
    "ServiceName": "Common Blood Test",
    "ServiceStatus": {
      "ServiceStatus": "Accessible"
    },
    "Comment": "Everuday, till 11:00",
    "Price": 10,
    "ServiceCategory": {
      "ServiceCategory": "Test"
    },
    "Description": "Common Blood Formula, Hemoglobine"
  }
}
'
exec dbo.usp_CreateService
	@json
go

declare @json nvarchar(max) =
N'
{
  "Admin": {
    "Login": "Kalabukh",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Service": {
    "ServiceName": "Biochemical Blood Test",
    "ServiceStatus": {
      "ServiceStatus": "Accessible"
    },
    "Comment": "",
    "Price": 15.8,
    "ServiceCategory": {
      "ServiceCategory": "Test"
    },
    "Description": "Cholesterine, ASAT, ALAT, Proteine"
  }
}
'
exec dbo.usp_CreateService
	@json
go

declare @json nvarchar(max) =
N'
{
  "Admin": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  },
  "Service": {
    "ServiceName": "Liver USI",
    "ServiceStatus": {
      "ServiceStatus": "Accessible"
    },
    "Comment": "Not available after 15:00",
    "Price": 55.5,
    "ServiceCategory": {
      "ServiceCategory": "Examination"
    },
    "Description": "Ultrasonic examination of liver"
  }
}
'
exec dbo.usp_CreateService
	@json
go

declare @json nvarchar(max) =
N'
{
  "Admin": {
    "Login": "Kalabukh",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Service": {
    "ServiceName": "Heart USI",
    "ServiceStatus": {
      "ServiceStatus": "Accessible"
    },
    "Comment": "",
    "Price": 60.5,
    "ServiceCategory": {
      "ServiceCategory": "Examination"
    },
    "Description": "Ultrasonic examination of heart"
  }
}
'
exec dbo.usp_CreateService
	@json
go
