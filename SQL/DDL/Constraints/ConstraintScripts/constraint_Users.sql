use MedCenterDB
go

-- СОМНЕНИЯ ПО DF ДЛЯ LastActiveDateTime

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.Users',
	@fields = 'Login',
	@constraintName = 'AK_Users_Login'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Users',
	@targetFields = 'GenderId',
	@parentTableName = 'dbo.Genders',
	@parentFields = 'GenderId',
	@constraintName = 'FK_Users_Genders'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Users',
	@targetFields = 'UserRoleId',
	@parentTableName = 'dbo.UserRoles',
	@parentFields = 'UserRoleId',
	@constraintName = 'FK_Users_UserRoles'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Users',
	@targetFields = 'AdminApprover',
	@parentTableName = 'dbo.Users',
	@parentFields = 'UserId',
	@constraintName = 'FK_Users_AdminApprovers'
go

exec dbo.usp_AddCheckConstraint
	@tableName = 'dbo.Users',
	@condition = 'RegisterDateTime <= SYSDATETIME()',
	@constraintName = 'CK_Users_RegisterDateTime'
go

exec dbo.usp_AddCheckConstraint
	@tableName = 'dbo.Users',
	@condition = 'LastActiveDateTime >= RegisterDateTime',
	@constraintName = 'CK_Users_LastActiveDateTime_RegisterDateTime'
go

exec dbo.usp_AddCheckConstraint
	@tableName = 'dbo.Users',
	@condition = 'LastActiveDateTime <= SYSDATETIME()',
	@constraintName = 'CK_Users_LastActiveDateTime_SysDateTime'
go

exec dbo.usp_AddCheckConstraint
	@tableName = 'dbo.Users',
	@condition = '(0+ format(GETDATE(),''yyyyMMdd'') - format(DateOfBirth,''yyyyMMdd'') ) /10000 >= 18',
	@constraintName = 'CK_Users_DateOfBirth'
go

exec dbo.usp_AddDefaultConstraint
	@tableName = 'dbo.Users',
	@field = 'RegisterDateTime',
	@value = 'SYSDATETIME()',
	@constraintName = 'DF_Users_RegisterDateTime'
go

exec dbo.usp_AddDefaultConstraint
	@tableName = 'dbo.Users',
	@field = 'LastActiveDateTime',
	@value = 'SYSDATETIME()',
	@constraintName = 'DF_Users_LastActiveDateTime'
go