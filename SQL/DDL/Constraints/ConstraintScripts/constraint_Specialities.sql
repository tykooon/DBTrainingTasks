use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.Specialities',
	@fields = 'Speciality',
	@constraintName = 'AK_Specialities_Speciality'
go