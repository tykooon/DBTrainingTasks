use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.RoomStates',
	@fields = 'RoomState',
	@constraintName = 'AK_RoomStates_RoomState'
go