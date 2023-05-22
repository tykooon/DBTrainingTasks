use MedCenterDB
go

-- ВОПРОС ПРО СОСТАВНОЙ КЛЮЧ В ЛИНКОВОЧНОЙ ТАБЛИЦЕ

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.TestsEquipmentsLink',
	@targetFields = 'EquipmentId',
	@parentTableName = 'dbo.Equipments',
	@parentFields = 'EquipmentId',
	@constraintName = 'FK_TestsEquipmentsLink_Equipments'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.TestsEquipmentsLink',
	@targetFields = 'TestId',
	@parentTableName = 'dbo.Tests',
	@parentFields = 'TestId',
	@constraintName = 'FK_TestsEquipmentsLink_Tests'
go
