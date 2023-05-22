use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.EquipmentTypes',
	@fields = 'EquipmentType',
	@constraintName = 'AK_EquipmentTypes_EquipmentType'
go