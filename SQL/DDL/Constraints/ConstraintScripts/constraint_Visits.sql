use MedCenterDB
go

-- ДОБАВИТЬ ЛИ ПРОВЕРКУ ЗАПЛАНИРОВАННОГО ВРЕМЕНИ ВИЗИТА (ВЫХОДНЫЕ ДНИ, РАБОЧЕЕ ВРЕМЯ)

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.Visits',
	@fields = 'Specialist, ScheduledDateTime',
	@constraintName = 'AK_Visits_Specialist_ScheduledDateTime'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Visits',
	@targetFields = 'BaseService',
	@parentTableName = 'dbo.Services',
	@parentFields = 'ServiceId',
	@constraintName = 'FK_Visits_BaseService'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Visits',
	@targetFields = 'Specialist',
	@parentTableName = 'dbo.Staffers',
	@parentFields = 'StafferId',
	@constraintName = 'FK_Visits_Specialist'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Visits',
	@targetFields = 'RecordedPatient',
	@parentTableName = 'dbo.Patients',
	@parentFields = 'PatientId',
	@constraintName = 'FK_Visits_RecordedPatient'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Visits',
	@targetFields = 'VisitRoom',
	@parentTableName = 'dbo.Rooms',
	@parentFields = 'RoomId',
	@constraintName = 'FK_Visits_Rooms'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Visits',
	@targetFields = 'PaymentStateId',
	@parentTableName = 'dbo.PaymentStates',
	@parentFields = 'PaymentStateId',
	@constraintName = 'FK_Visits_PaymentStates'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Visits',
	@targetFields = 'VisitStatusId',
	@parentTableName = 'dbo.VisitStatuses',
	@parentFields = 'VisitStatusId',
	@constraintName = 'FK_Visits_VisitStates'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Visits',
	@targetFields = 'VisitTypeId',
	@parentTableName = 'dbo.VisitTypes',
	@parentFields = 'VisitTypeId',
	@constraintName = 'FK_Visits_VisitTypes'
go

--exec dbo.usp_AddCheckConstraint
--	@tableName = 'dbo.Visits',
--	@condition = 'RecordDateTime <= ScheduledDateTime',
--	@constraintName = 'CK_Visits_RecordDateTime'
--go
