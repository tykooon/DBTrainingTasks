use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParseServiceStatusesInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParseServiceStatusesInitialization
go

create procedure dbo.usp_JsonParseServiceStatusesInitialization
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

		with cte_ServiceStatuses([ServiceStatus]) as
		(
			select [ServiceStatus]
			from OPENJSON(@json) with 
			(
				ServiceStatuses nvarchar(max) '$.ServiceStatuses' as json
			)
			outer apply
			OPENJSON(ServiceStatuses) with
			(
				[ServiceStatus] nvarchar(20) '$.ServiceStatus'
			)
		)
		insert into dbo.ServiceStatuses ([ServiceStatus])
		select [ServiceStatus]
		from cte_ServiceStatuses

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go