use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParsePaymentStatesInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParsePaymentStatesInitialization
go

create procedure dbo.usp_JsonParsePaymentStatesInitialization
(
	@json nvarchar(max)
)
as
begin
	if (ISJSON(@json) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try

		with cte_PaymentStates([PaymentState]) as
		(
			select [PaymentState]
			from OPENJSON(@json) with 
			(
				PaymentStates nvarchar(max) '$.PaymentStates' as json
			)
			outer apply
			OPENJSON(PaymentStates) with
			(
				[PaymentState] nvarchar(20) '$.PaymentState'
			)
		)
		insert into dbo.PaymentStates ([PaymentState])
		select [PaymentState]
		from cte_PaymentStates

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go