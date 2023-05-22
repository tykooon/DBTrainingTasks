use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParseVisitStatusesInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParseVisitStatusesInitialization
go

create procedure dbo.usp_JsonParseVisitStatusesInitialization
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

		with cte_VisitStatuses([VisitStatus]) as
		(
			select [VisitStatus]
			from OPENJSON(@json) with 
			(
				VisitStatuses nvarchar(max) '$.VisitStatuses' as json
			)
			outer apply
			OPENJSON(VisitStatuses) with
			(
				[VisitStatus] nvarchar(20) '$.VisitStatus'
			)
		)
		insert into dbo.VisitStatuses ([VisitStatus])
		select [VisitStatus]
		from cte_VisitStatuses

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go