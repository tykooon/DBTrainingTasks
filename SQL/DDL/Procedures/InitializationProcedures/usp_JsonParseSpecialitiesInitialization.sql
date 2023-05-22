use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParseSpecialitiesInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParseSpecialitiesInitialization
go

create procedure dbo.usp_JsonParseSpecialitiesInitialization
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

		with cte_Specialities([Speciality]) as
		(
			select [Speciality]
			from OPENJSON(@json) with 
			(
				Specialities nvarchar(max) '$.Specialities' as json
			)
			outer apply
			OPENJSON(Specialities) with
			(
				[Speciality] nvarchar(20) '$.Speciality'
			)
		)
		insert into dbo.Specialities ([Speciality])
		select [Speciality]
		from cte_Specialities

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go