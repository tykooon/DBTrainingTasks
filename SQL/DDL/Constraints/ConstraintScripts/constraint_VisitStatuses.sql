use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.VisitStatuses',
	@fields = 'VisitStatus',
	@constraintName = 'AK_VisitStatuses_VisitStatus'
go