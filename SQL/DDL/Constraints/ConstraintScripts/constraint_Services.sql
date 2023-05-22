use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.Services',
	@fields = 'ServiceName',
	@constraintName = 'AK_Services_ServiceName'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Services',
	@targetFields = 'ServiceStatusId',
	@parentTableName = 'dbo.ServiceStatuses',
	@parentFields = 'ServiceStatusId',
	@constraintName = 'FK_Services_ServiceStatuses'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Services',
	@targetFields = 'ServiceCategoryId',
	@parentTableName = 'dbo.ServiceCategories',
	@parentFields = 'ServiceCategoryId',
	@constraintName = 'FK_Services_ServiceCategories'
go
