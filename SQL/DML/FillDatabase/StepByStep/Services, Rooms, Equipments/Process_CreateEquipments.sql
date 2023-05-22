use MedCenterDB
go

--delete EquipmentsServicesLink
--delete Equipments


declare @json nvarchar(max) =
N'
{
  "Admin": {
    "Login": "Kalabukh",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Equipment": {
    "EquipmentName": "Computer Dell",
    "InventaryNumber": "PC111-222",
    "EquipmentState": {
      "EquipmentState": "In Service"
    },
    "EquipmentType": {
      "EquipmentType": "Personal Computer"
    },
    "EquipmentNote": "Windows 10, Intel Core i5",
    "Services": [
      {
        "ServiceName": "Therapist Consultation"
      },
      {
        "ServiceName": "Cardiologist Consultation"
      }
    ],
    "EquipmentRoom": {
      "RoomName": "Cabinet 1"
    },
    "RegistrationDateTime": "2022-10-06T19:22:42.6603694+03:00"
  }
}
'
exec dbo.usp_CreateEquipment
		@json
go
-------------------------------------------------------------------------

declare @json nvarchar(max) =
N'
{
  "Admin": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  },
  "Equipment": {
    "EquipmentName": "Computer Lenovo",
    "InventaryNumber": "PC333-444",
    "EquipmentState": {
      "EquipmentState": "In Service"
    },
    "EquipmentType": {
      "EquipmentType": "Personal Computer"
    },
    "EquipmentNote": "Windows 11, Intel Core i9",
    "Services": [
      {
        "ServiceName": "Therapist Consultation"
      },
      {
        "ServiceName": "Cardiologist Consultation"
      }
    ],
    "EquipmentRoom": {
      "RoomName": "Cabinet 5"
    },
    "RegistrationDateTime": "2022-10-06T19:22:42.6604042+03:00"
  }
}
'
exec dbo.usp_CreateEquipment
		@json
go

--------------------------------------------------------------
declare @json nvarchar(max) =
N'
{
  "Admin": {
    "Login": "Kalabukh",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Equipment": {
    "EquipmentName": "Laptop HP",
    "InventaryNumber": "PC555-666",
    "EquipmentState": {
      "EquipmentState": "In Service"
    },
    "EquipmentType": {
      "EquipmentType": "Personal Computer"
    },
    "EquipmentNote": "Windows 10, AMD, 200GB",
    "Services": [
      {
        "ServiceName": "Therapist Consultation"
      }
    ],
    "EquipmentRoom": {
      "RoomName": "Cabinet 4"
    },
    "RegistrationDateTime": "2022-10-06T19:22:42.6604048+03:00"
  }
}
'
exec dbo.usp_CreateEquipment
		@json
go

--------------------------------------------------------------

declare @json nvarchar(max) =
N'
{
  "Admin": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  },
  "Equipment": {
    "EquipmentName": "BPL H-RAD 32 High Frequency X Ray",
    "InventaryNumber": "XR222-333",
    "EquipmentState": {
      "EquipmentState": "In Service"
    },
    "EquipmentType": {
      "EquipmentType": "X-Ray"
    },
    "EquipmentNote": "User configurable anatomic programming with 216 program options. 40 to 125 in steps of 1kVp only",
    "EquipmentRoom": {
      "RoomName": "Cabinet 3"
    },
    "RegistrationDateTime": "2022-10-06T19:22:42.6604234+03:00"
  }
}
'
exec dbo.usp_CreateEquipment
		@json
go

--------------------------------------------------------------

declare @json nvarchar(max) =
N'
{
  "Admin": {
    "Login": "Kalabukh",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Equipment": {
    "EquipmentName": "GE Voluson S8 Ultrasound",
    "InventaryNumber": "US111-222",
    "EquipmentState": {
      "EquipmentState": "In Service"
    },
    "EquipmentType": {
      "EquipmentType": "Ultrasound"
    },
    "EquipmentNote": "For women\u2019s health applications, obstetrics, gynecology, fertility. Secondary applications: general imaging, adult and pediatric cardiology, and neonatal cardiology.",
    "Services": [
      {
        "ServiceName": "Liver USI"
      },
      {
        "ServiceName": "Heart USI"
      }
    ],
    "EquipmentRoom": {
      "RoomName": "Cabinet 2"
    },
    "RegistrationDateTime": "2022-10-06T19:22:42.6604149+03:00"
  }
}
'
exec dbo.usp_CreateEquipment
		@json
go

--------------------------------------------------------------

declare @json nvarchar(max) =
N'
{
  "Admin": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  },
  "Equipment": {
    "EquipmentName": "Mindray BC-1800 Hematology Analyzer",
    "InventaryNumber": "BA444-555",
    "EquipmentState": {
      "EquipmentState": "In Service"
    },
    "EquipmentType": {
      "EquipmentType": "Analyzer"
    },
    "EquipmentNote": "Fully Automated hematology analyzer. 3 Part differentiation of WBC 19 Parameters \u002B 3 histograms.",
    "Services": [
      {
        "ServiceName": "Common Blood Test"
      },
      {
        "ServiceName": "Biochemical Blood Test"
      }
    ],
    "EquipmentRoom": {
      "RoomName": "Cabinet 4"
    },
    "RegistrationDateTime": "2022-10-06T19:22:42.6604315+03:00"
  }
}
'
exec dbo.usp_CreateEquipment
		@json
go

--------------------------------------------------------------

declare @json nvarchar(max) =
N'
{
  "Admin": {
    "Login": "Kalabukh",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Equipment": {
    "EquipmentName": "Intel Pentium",
    "InventaryNumber": "PC777-888",
    "EquipmentState": {
      "EquipmentState": "In Service"
    },
    "EquipmentType": {
      "EquipmentType": "Personal Computer"
    },
    "EquipmentNote": "Windows 7, Intel, 4GB RAM",
    "RegistrationDateTime": "2022-10-07T12:35:15.0620365+03:00"
  }
}
'
exec dbo.usp_CreateEquipment
		@json
go
-------------------------------------------------------------------------

declare @json nvarchar(max) =
N'
{
  "Admin": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  },
  "Equipment": {
    "EquipmentName": "Acer",
    "InventaryNumber": "PC999-000",
    "EquipmentState": {
      "EquipmentState": "In Service"
    },
    "EquipmentType": {
      "EquipmentType": "Personal Computer"
    },
    "EquipmentNote": "Windows 8, AMD, 3TB",
    "RegistrationDateTime": "2022-10-07T12:42:31.3480969+03:00",
    "LastEditor": {
      "Login": "Kalabukh",
      "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
    }
  }
}
'
exec dbo.usp_CreateEquipment
		@json
go

--------------------------------------------------------------------

declare @json nvarchar(max) =
N'
{
  "Admin": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  },
  "Equipment": {
    "EquipmentName": "zPOS D2s",
    "InventaryNumber": "CD-01-101",
    "EquipmentState": {
      "EquipmentState": "In Service"
    },
    "EquipmentType": {
      "EquipmentType": "Office Technic"
    },
    "EquipmentNote": "Main Cash Desk on Reception",
    "RegistrationDateTime": "2022-10-07T15:42:49.1462638+03:00"
  }
}
'
exec dbo.usp_CreateEquipment
		@json
go

