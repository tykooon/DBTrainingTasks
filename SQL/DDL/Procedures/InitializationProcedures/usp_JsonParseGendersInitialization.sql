use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParseGendersInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParseGendersInitialization
go

create procedure dbo.usp_JsonParseGendersInitialization
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

		with cte_Genders([GenderName]) as
		(
			select [GenderName]
			from OPENJSON(@json) with 
			(
				Genders nvarchar(max) '$.Genders' as json
			)
			outer apply
			OPENJSON(Genders) with
			(
				[GenderName] nvarchar(20) '$.GenderName'
			)
		)
		insert into dbo.Genders ([GenderName])
		select [GenderName]
		from cte_Genders

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go