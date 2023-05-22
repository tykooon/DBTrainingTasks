use MedCenterDB
go

delete RoomTypes
go

exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "RoomTypes": [
    {
      "RoomType": "Common Area"
    },
    {
      "RoomType": "Doctor''s office" 
    },
    {
      "RoomType": "Service Space" 
    },
    {
      "RoomType": "Laboratory" 
    },
    {
      "RoomType": "Surgery" 
    }
  ] 
}
'
go