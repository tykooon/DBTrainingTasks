use MedCenterDB
go

--ВОПРОС ПРО ЗНАЧЕНИЯ ПО УМОЛЧАНИЮ ДЛЯ КЛАССИФИЦИРУЮЩИХ ПОЛЕЙ

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.Patients',
	@fields = 'PatientPassport',
	@constraintName = 'AK_Patients_PatientPassport'
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.Patients',
	@fields = 'PatientUserId',
	@constraintName = 'AK_Patients_PatientUserId'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Patients',
	@targetFields = 'PatientUserId',
	@parentTableName = 'dbo.Users',
	@parentFields = 'UserId',
	@constraintName = 'FK_Patients_Users'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Patients',
	@targetFields = 'PatientStatusId',
	@parentTableName = 'dbo.PatientStatuses',
	@parentFields = 'PatientStatusId',
	@constraintName = 'FK_Patients_PatientStatuses'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Patients',
	@targetFields = 'PatientRegistrator',
	@parentTableName = 'dbo.Staffers',
	@parentFields = 'StafferId',
	@constraintName = 'FK_Patients_Staffers'
go

exec dbo.usp_AddCheckConstraint
	@tableName = 'dbo.Patients',
	@condition = 'RegisterDateTime <= SYSDATETIME()',
	@constraintName = 'CK_Patients_RegisterDateTime'
go

exec dbo.usp_AddDefaultConstraint
	@tableName = 'dbo.Patients',
	@field = 'RegisterDateTime',
	@value = 'SYSDATETIME()',
	@constraintName = 'DF_Patients_RegisterDateTime'
go