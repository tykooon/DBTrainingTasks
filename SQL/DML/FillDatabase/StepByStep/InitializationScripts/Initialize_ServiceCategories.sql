use MedCenterDB
go

delete ServiceCategories
go

exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "ServiceCategories": [
    {
      "ServiceCategory": "Consultation"
    },
    {
      "ServiceCategory": "Examination"
    },
    {
      "ServiceCategory": "Test"
    },
    {
      "ServiceCategory": "Manipulation"
    },
    {
      "ServiceCategory": "Operation"
    },
    {
      "ServiceCategory": "Rehabilitation"
    }
  ] 
}
'
go