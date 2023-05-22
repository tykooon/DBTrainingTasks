use MedCenterDB
go

delete ServiceStatuses
go

exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "ServiceStatuses": [
    {
      "ServiceStatus": "Accessible"
    },
    {
      "ServiceStatus": "Suspended"
    },
    {
      "ServiceStatus": "Depricated"
    },
    {
      "ServiceStatus": "On Demand"
    }
  ] 
}
'
go