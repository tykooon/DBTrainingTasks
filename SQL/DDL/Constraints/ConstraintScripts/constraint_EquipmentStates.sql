use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.EquipmentStates',
	@fields = 'EquipmentState',
	@constraintName = 'AK_EquipmentStates_EquipmentState'
go