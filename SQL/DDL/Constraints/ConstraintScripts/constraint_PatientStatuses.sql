use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.PatientStatuses',
	@fields = 'PatientStatus',
	@constraintName = 'AK_PatientStatuses_PatientStatus'
go