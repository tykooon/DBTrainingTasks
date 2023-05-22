use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.TestTypes',
	@fields = 'TestType',
	@constraintName = 'AK_TestTypes_TestType'
go