use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.ServiceCategories',
	@fields = 'ServiceCategory',
	@constraintName = 'AK_ServiceCategories_ServiceCategory'
go