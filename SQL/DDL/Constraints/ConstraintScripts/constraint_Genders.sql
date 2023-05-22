use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.Genders',
	@fields = 'GenderName',
	@constraintName = 'AK_Genders_GenderName'
go