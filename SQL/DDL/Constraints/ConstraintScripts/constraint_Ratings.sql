use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.Ratings',
	@fields = 'PatientId, StafferId',
	@constraintName = 'AK_Ratings_PatientId_StafferId'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Ratings',
	@targetFields = 'PatientId',
	@parentTableName = 'dbo.Patients',
	@parentFields = 'PatientId',
	@constraintName = 'FK_Ratings_Patients'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Ratings',
	@targetFields = 'StafferId',
	@parentTableName = 'dbo.Staffers',
	@parentFields = 'StafferId',
	@constraintName = 'FK_Ratings_Staffers'
go

exec dbo.usp_AddCheckConstraint
	@tableName = 'dbo.Ratings',
	@condition = 'RatingDateTime <= SYSDATETIME()',
	@constraintName = 'CK_Ratings_RatingDateTime'
go
