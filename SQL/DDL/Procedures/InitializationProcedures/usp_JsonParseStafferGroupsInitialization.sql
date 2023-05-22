use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParseStafferGroupsInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParseStafferGroupsInitialization
go

create procedure dbo.usp_JsonParseStafferGroupsInitialization
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

		with cte_StafferGroups([StafferGroup]) as
		(
			select [StafferGroup]
			from OPENJSON(@json) with 
			(
				StafferGroups nvarchar(max) '$.StafferGroups' as json
			)
			outer apply
			OPENJSON(StafferGroups) with
			(
				[StafferGroup] nvarchar(20) '$.StafferGroup'
			)
		)
		insert into dbo.StafferGroups ([StafferGroup])
		select [StafferGroup]
		from cte_StafferGroups

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go