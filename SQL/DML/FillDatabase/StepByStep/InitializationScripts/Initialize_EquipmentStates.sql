use MedCenterDB
go

delete EquipmentStates
go

exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "EquipmentStates": [
    {
      "EquipmentState": "In Service"
    },
    {
      "EquipmentState": "Out Of Service" 
    },
    {
      "EquipmentState": "On Repair" 
    },
    {
      "EquipmentState": "Disposed" 
    }
  ] 
}
'
go