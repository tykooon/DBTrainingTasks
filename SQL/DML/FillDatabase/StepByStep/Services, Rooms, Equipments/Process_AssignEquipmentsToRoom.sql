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
  "Room": {
    "RoomName": "Reception"
  },
  "Equipments": [
    {
      "InventaryNumber": "PC777-888"
    },
    {
      "InventaryNumber": "CD-01-101"
    }
  ]
}
'

exec dbo.usp_AssignEquipmentsToRoom
   @json
go