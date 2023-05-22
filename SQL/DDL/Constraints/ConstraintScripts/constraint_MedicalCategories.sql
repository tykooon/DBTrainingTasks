use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.MedicalCategories',
	@fields = 'MedicalCategory',
	@constraintName = 'AK_MedicalCategories_MedicalCategory'
go