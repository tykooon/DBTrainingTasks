use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParseVisitTypesInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParseVisitTypesInitialization
go

create procedure dbo.usp_JsonParseVisitTypesInitialization
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

		with cte_VisitTypes([VisitType]) as
		(
			select [VisitType]
			from OPENJSON(@json) with 
			(
				VisitTypes nvarchar(max) '$.VisitTypes' as json
			)
			outer apply
			OPENJSON(VisitTypes) with
			(
				[VisitType] nvarchar(20) '$.VisitType'
			)
		)
		insert into dbo.VisitTypes ([VisitType])
		select [VisitType]
		from cte_VisitTypes

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go