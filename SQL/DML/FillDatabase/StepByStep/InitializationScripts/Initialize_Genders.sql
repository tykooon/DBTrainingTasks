use MedCenterDB
go

delete Genders
go

exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "Genders": [
    {
      "GenderName": "Undefined"
    },
    {
      "GenderName": "Male" 
    },
    {
      "GenderName": "Female" 
    }
  ] 
}
'
go