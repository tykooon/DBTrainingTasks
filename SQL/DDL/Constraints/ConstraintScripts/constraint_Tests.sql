use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.Tests',
	@fields = 'ServiceId, VisitId',
	@constraintName = 'AK_Tests_ServiceId_VisitId'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Tests',
	@targetFields = 'ServiceId',
	@parentTableName = 'dbo.Services',
	@parentFields = 'ServiceId',
	@constraintName = 'FK_Tests_Services'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Tests',
	@targetFields = 'VisitId',
	@parentTableName = 'dbo.Visits',
	@parentFields = 'VisitId',
	@constraintName = 'FK_Tests_Visits'
go


exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Tests',
	@targetFields = 'TestStateId',
	@parentTableName = 'dbo.TestStates',
	@parentFields = 'TestStateId',
	@constraintName = 'FK_Tests_TestStates'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Tests',
	@targetFields = 'TestTypeId',
	@parentTableName = 'dbo.TestTypes',
	@parentFields = 'TestTypeId',
	@constraintName = 'FK_Tests_TestTypes'
go

