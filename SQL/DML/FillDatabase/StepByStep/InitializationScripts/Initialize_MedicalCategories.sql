use MedCenterDB
go

delete MedicalCategories
go

exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "MedicalCategories": [
    {
      "MedicalCategory": "No Category"
    },
    {
      "MedicalCategory": "Second Category"
    },
    {
      "MedicalCategory": "First Category"
    },
    {
      "MedicalCategory": "Highest Category"
    }
  ] 
}
'
go