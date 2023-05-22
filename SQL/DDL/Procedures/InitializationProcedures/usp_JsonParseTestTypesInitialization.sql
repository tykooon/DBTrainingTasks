use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParseTestTypesInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParseTestTypesInitialization
go

create procedure dbo.usp_JsonParseTestTypesInitialization
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

		with cte_TestTypes([TestType]) as
		(
			select [TestType]
			from OPENJSON(@json) with 
			(
				TestTypes nvarchar(max) '$.TestTypes' as json
			)
			outer apply
			OPENJSON(TestTypes) with
			(
				[TestType] nvarchar(20) '$.TestType'
			)
		)
		insert into dbo.TestTypes ([TestType])
		select [TestType]
		from cte_TestTypes

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go