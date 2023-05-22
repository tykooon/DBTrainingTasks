use MedCenterDB
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.EquipmentsServicesLink',
	@targetFields = 'EquipmentId',
	@parentTableName = 'dbo.Equipments',
	@parentFields = 'EquipmentId',
	@constraintName = 'FK_EquipmentsServicesLink_Equipments'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.EquipmentsServicesLink',
	@targetFields = 'ServiceId',
	@parentTableName = 'dbo.Services',
	@parentFields = 'ServiceId',
	@constraintName = 'FK_EquipmentsServicesLink_Services'
go