use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.TestStates',
	@fields = 'TestState',
	@constraintName = 'AK_TestStates_TestState'
go