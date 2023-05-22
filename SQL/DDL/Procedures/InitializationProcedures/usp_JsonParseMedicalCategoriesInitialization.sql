use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParseMedicalCategoriesInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParseMedicalCategoriesInitialization
go

create procedure dbo.usp_JsonParseMedicalCategoriesInitialization
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

		with cte_MedicalCategories([MedicalCategory]) as
		(
			select [MedicalCategory]
			from OPENJSON(@json) with 
			(
				MedicalCategories nvarchar(max) '$.MedicalCategories' as json
			)
			outer apply
			OPENJSON(MedicalCategories) with
			(
				[MedicalCategory] nvarchar(20) '$.MedicalCategory'
			)
		)
		insert into dbo.MedicalCategories ([MedicalCategory])
		select [MedicalCategory]
		from cte_MedicalCategories

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go