use MedCenterDB
go

delete VisitTypes
go

exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "VisitTypes": [
    {
      "VisitType": "Consultation"
    },
    {
      "VisitType": "Examination" 
    },
    {
      "VisitType": "Test Taking" 
    },
    {
      "VisitType": "Operation" 
    }
  ] 
}
'
go