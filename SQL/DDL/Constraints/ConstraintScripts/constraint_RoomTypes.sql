use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.RoomTypes',
	@fields = 'RoomType',
	@constraintName = 'AK_RoomTypes_RoomType'
go