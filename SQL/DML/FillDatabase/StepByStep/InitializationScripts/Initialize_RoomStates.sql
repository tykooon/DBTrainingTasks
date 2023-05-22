use MedCenterDB
go

delete RoomStates
go

exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "RoomStates": [
    {
      "RoomState": "Accessible"
    },
    {
      "RoomState": "Non-Accessible" 
    },
    {
      "RoomState": "Renovation" 
    },
    {
      "RoomState": "Abolished" 
    }
  ] 
}
'
go