use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.VisitTypes',
	@fields = 'VisitType',
	@constraintName = 'AK_VisitTypes_VisitType'
go