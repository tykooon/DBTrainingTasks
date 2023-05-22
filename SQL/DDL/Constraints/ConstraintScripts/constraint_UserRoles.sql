use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.UserRoles',
	@fields = 'UserRole',
	@constraintName = 'AK_UserRoles_UserRole'
go