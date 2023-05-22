use MedCenterDB
go

delete Specialities
go

exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "Specialities": [
    {
      "Speciality": "Non-Medical"
    },
    {
      "Speciality": "Nursing"
    },
    {
      "Speciality": "Surgery"
    },
    {
      "Speciality": "Therapy"
    },
    {
      "Speciality": "Otorhinolaryngology"
    },
    {
      "Speciality": "Cardiology"
    }
  ] 
}
'
go