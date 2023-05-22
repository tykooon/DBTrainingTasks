use MedCenterDB
go

--delete EquipmentsServicesLink
--delete Equipments


declare @json nvarchar(max) =
N'
{
  "Admin": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  },
  "Equipments": [
    {
      "InventaryNumber": "PC111-222"
    },
    {
      "InventaryNumber": "PC333-444"
    },
    {
      "InventaryNumber": "PC555-666"
    },
    {
      "InventaryNumber": "PC777-888"
    },
    {
      "InventaryNumber": "PC999-000"
    }
  ],
  "Services": [
    {
      "ServiceName": "Therapist Consultation"
    },
    {
      "ServiceName": "Cardiologist Consultation"
    }
  ]
}
'

exec usp_SetServicesForEquipments
		@json

	go

	declare @json nvarchar(max) =
N'
{
  "Admin": {
    "Login": "Kalabukh",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Room": {
    "RoomName": "Cabinet 2"
  },
  "Equipments": [
    {
      "InventaryNumber": "PC999-000"
    }
  ]
}
'

exec dbo.usp_AssignEquipmentsToRoom
   @json
go