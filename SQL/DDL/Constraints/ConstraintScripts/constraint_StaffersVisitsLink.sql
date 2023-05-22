use MedCenterDB
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.StaffersVisitsLink',
	@targetFields = 'StafferId',
	@parentTableName = 'dbo.Staffers',
	@parentFields = 'StafferId',
	@constraintName = 'FK_StaffersVisitsLink_Users'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.StaffersVisitsLink',
	@targetFields = 'VisitId',
	@parentTableName = 'dbo.Visits',
	@parentFields = 'VisitId',
	@constraintName = 'FK_StaffersVisitsLink_Phones'
go
