use MedCenterDB
go

-- НАДО ЛИ ЗДЕСЬ ПРОВЕРЯТЬ ЗНАЧЕНИЕ КОНКРЕТНОГО ПОЛЯ UserRoles У StafferRegistrator, ПРИ СОЗДАНИИ

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.Staffers',
	@fields = 'StafferPassport',
	@constraintName = 'AK_Staffers_StafferPassport'
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.Staffers',
	@fields = 'StafferUserId',
	@constraintName = 'AK_Staffers_StafferUserId'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Staffers',
	@targetFields = 'StafferUserId',
	@parentTableName = 'dbo.Users',
	@parentFields = 'UserId',
	@constraintName = 'FK_Staffers_Users'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Staffers',
	@targetFields = 'StafferGroupId',
	@parentTableName = 'dbo.StafferGroups',
	@parentFields = 'StafferGroupId',
	@constraintName = 'FK_Staffers_StafferGroups'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Staffers',
	@targetFields = 'SpecialityId',
	@parentTableName = 'dbo.Specialities',
	@parentFields = 'SpecialityId',
	@constraintName = 'FK_Staffers_Specialities'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Staffers',
	@targetFields = 'MedicalCategoryId',
	@parentTableName = 'dbo.MedicalCategories',
	@parentFields = 'MedicalCategoryId',
	@constraintName = 'FK_Staffers_MedicalCategories'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Staffers',
	@targetFields = 'StafferRegistrator',
	@parentTableName = 'dbo.Users',
	@parentFields = 'UserId',
	@constraintName = 'FK_Staffers_AdminUsers'
go

exec dbo.usp_AddCheckConstraint
	@tableName = 'dbo.Staffers',
	@condition = 'RegisterDateTime <= SYSDATETIME()',
	@constraintName = 'CK_Staffers_RegisterDateTime'
go

exec dbo.usp_AddDefaultConstraint
	@tableName = 'dbo.Staffers',
	@field = 'RegisterDateTime',
	@value = 'SYSDATETIME()',
	@constraintName = 'DF_Staffers_RegisterDateTime'
go