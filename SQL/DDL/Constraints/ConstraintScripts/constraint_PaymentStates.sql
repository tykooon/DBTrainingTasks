use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.PaymentStates',
	@fields = 'PaymentState',
	@constraintName = 'AK_PaymentStates_PaymentState'
go