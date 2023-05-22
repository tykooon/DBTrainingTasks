use MedCenterDB
go

delete StafferGroups
go

exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "StafferGroups": [
    {
      "StafferGroup": "Receptionists"
    },
    {
      "StafferGroup": "Medical Staff"
    },
    {
      "StafferGroup": "Administration"
    },
    {
      "StafferGroup": "Technical Staff"
    },
    {
      "StafferGroup": "Non-Staff"
    }
  ] 
}
'
go