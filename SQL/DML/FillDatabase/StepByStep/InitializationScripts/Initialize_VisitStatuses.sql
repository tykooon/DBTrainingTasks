use MedCenterDB
go

delete VisitStatuses
go

exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "VisitStatuses": [
    {
      "VisitStatus": "Planned"
    },
    {
      "VisitStatus": "Canceled" 
    },
    {
      "VisitStatus": "Postponed" 
    },
    {
      "VisitStatus": "Rejected" 
    },
    {
      "VisitStatus": "Finished" 
    },
    {
      "VisitStatus": "Extended" 
    }
  ] 
}
'
go