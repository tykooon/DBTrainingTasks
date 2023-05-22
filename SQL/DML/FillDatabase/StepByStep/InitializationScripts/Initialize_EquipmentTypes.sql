use MedCenterDB
go

delete EquipmentTypes
go

exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "EquipmentTypes": [
    {
      "EquipmentType": "Personal Computer"
    },
    {
      "EquipmentType": "Ultrasound" 
    },
    {
      "EquipmentType": "X-Ray" 
    },
    {
      "EquipmentType": "Laser Surgery" 
    },
    {
      "EquipmentType": "Analyzer" 
    },
    {
      "EquipmentType": "Office Technic" 
    }
  ] 
}
'
go