use MedCenterDB
go

delete TestStates
go

exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "TestStates": [
    {
      "TestState": "Planned"
    },
    {
      "TestState": "Started" 
    },
    {
      "TestState": "Canceled" 
    },
    {
      "TestState": "Postponed" 
    },
    {
      "TestState": "Completed" 
    },
    {
      "TestState": "Failed" 
    }
  ] 
}
'
go