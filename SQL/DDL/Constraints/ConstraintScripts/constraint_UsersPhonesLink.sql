use MedCenterDB
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.UsersPhonesLink',
	@targetFields = 'UserId',
	@parentTableName = 'dbo.Users',
	@parentFields = 'UserId',
	@constraintName = 'FK_UsersPhonesLink_Users'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.UsersPhonesLink',
	@targetFields = 'PhoneId',
	@parentTableName = 'dbo.Phones',
	@parentFields = 'PhoneId',
	@constraintName = 'FK_UsersPhonesLink_Phones'
go
