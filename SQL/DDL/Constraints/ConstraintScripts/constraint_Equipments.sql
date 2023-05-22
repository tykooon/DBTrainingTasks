use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.Equipments',
	@fields = 'InventaryNumber',
	@constraintName = 'AK_Equipments_InventaryNumber'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Equipments',
	@targetFields = 'EquipmentStateId',
	@parentTableName = 'dbo.EquipmentStates',
	@parentFields = 'EquipmentStateId',
	@constraintName = 'FK_Equipments_EquipmentStateId'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Equipments',
	@targetFields = 'EquipmentTypeId',
	@parentTableName = 'dbo.EquipmentTypes',
	@parentFields = 'EquipmentTypeId',
	@constraintName = 'FK_Equipments_EquipmentTypeId'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Equipments',
	@targetFields = 'EquipmentRoom',
	@parentTableName = 'dbo.Rooms',
	@parentFields = 'RoomId',
	@constraintName = 'FK_Equipments_EquipmentRoom'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Equipments',
	@targetFields = 'LastEditor',
	@parentTableName = 'dbo.Users',
	@parentFields = 'UserId',
	@constraintName = 'FK_Equipments_LastEditor'
go

exec dbo.usp_AddCheckConstraint
	@tableName = 'dbo.Equipments',
	@condition = 'RegistrationDateTime <= SYSDATETIME()',
	@constraintName = 'CK_Equipments_RegistrationDateTime'
go
