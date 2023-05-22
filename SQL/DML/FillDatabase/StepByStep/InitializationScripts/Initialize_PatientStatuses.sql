use MedCenterDB
go

delete PatientStatuses
go

exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "PatientStatuses": [
    {
      "PatientStatus": "VIP"
    },
    {
      "PatientStatus": "Discount" 
    },
    {
      "PatientStatus": "Regular" 
    },
    {
      "PatientStatus": "Social" 
    }
  ] 
}
'
go