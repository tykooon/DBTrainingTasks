use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParsePatientStatusesInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParsePatientStatusesInitialization
go

create procedure dbo.usp_JsonParsePatientStatusesInitialization
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

		with cte_PatientStatuses([PatientStatus]) as
		(
			select [PatientStatus]
			from OPENJSON(@json) with 
			(
				PatientStatuses nvarchar(max) '$.PatientStatuses' as json
			)
			outer apply
			OPENJSON(PatientStatuses) with
			(
				[PatientStatus] nvarchar(20) '$.PatientStatus'
			)
		)
		insert into dbo.PatientStatuses ([PatientStatus])
		select [PatientStatus]
		from cte_PatientStatuses

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go