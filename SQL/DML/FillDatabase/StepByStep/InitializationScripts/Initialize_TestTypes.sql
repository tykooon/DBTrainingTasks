use MedCenterDB
go

delete TestTypes
go

exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "TestTypes": [
    {
      "TestType": "Ultrasonic"
    },
    {
      "TestType": "X-Ray" 
    },
    {
      "TestType": "Blood Analysis" 
    },
    {
      "TestType": "Urine Analysis" 
    },
    {
      "TestType": "Cytology" 
    }
  ] 
}
'
go