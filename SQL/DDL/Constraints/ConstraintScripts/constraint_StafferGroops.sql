use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.StafferGroups',
	@fields = 'StafferGroup',
	@constraintName = 'AK_StafferGroups_StafferGroup'
go