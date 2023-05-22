use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.Phones',
	@fields = 'PhoneNumber',
	@constraintName = 'AK_Phones_PhoneNumber'
go