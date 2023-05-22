use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParseTestStatesInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParseTestStatesInitialization
go

create procedure dbo.usp_JsonParseTestStatesInitialization
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

		with cte_TestStates([TestState]) as
		(
			select [TestState]
			from OPENJSON(@json) with 
			(
				TestStates nvarchar(max) '$.TestStates' as json
			)
			outer apply
			OPENJSON(TestStates) with
			(
				[TestState] nvarchar(20) '$.TestState'
			)
		)
		insert into dbo.TestStates ([TestState])
		select [TestState]
		from cte_TestStates

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go