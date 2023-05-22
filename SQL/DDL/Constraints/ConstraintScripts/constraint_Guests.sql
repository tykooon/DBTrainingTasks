use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.Guests',
	@fields = 'IPAddress, SessionDateTime, BrowserUserAgent',
	@constraintName = 'AK_Guests_IPAddress_SessionDateTime_BrowserUserAgent'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Guests',
	@targetFields = 'AuthorizedUser',
	@parentTableName = 'dbo.Users',
	@parentFields = 'UserId',
	@constraintName = 'FK_Guests_Users'
go

exec dbo.usp_AddCheckConstraint
	@tableName = 'dbo.Guests',
	@condition = 'SessionDateTime <= SYSDATETIME()',
	@constraintName = 'CK_Guests_SessionDateTime'
go