use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.Rooms',
	@fields = 'RoomName',
	@constraintName = 'AK_Rooms_RoomName'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Rooms',
	@targetFields = 'RoomStateId',
	@parentTableName = 'dbo.RoomStates',
	@parentFields = 'RoomStateId',
	@constraintName = 'FK_Rooms_RoomStateId'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Rooms',
	@targetFields = 'RoomTypeId',
	@parentTableName = 'dbo.RoomTypes',
	@parentFields = 'RoomTypeId',
	@constraintName = 'FK_Rooms_RoomTypeId'
go

exec dbo.usp_AddCheckConstraint
	@tableName = 'dbo.Rooms',
	@condition = 'LastUpdateDateTime <= SYSDATETIME()',
	@constraintName = 'CK_Rooms_LastUpdateDateTime'
go
