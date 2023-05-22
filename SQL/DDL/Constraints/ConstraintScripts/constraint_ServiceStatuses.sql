use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.ServiceStatuses',
	@fields = 'ServiceStatus',
	@constraintName = 'AK_ServiceStatuses_ServiceStatus'
go