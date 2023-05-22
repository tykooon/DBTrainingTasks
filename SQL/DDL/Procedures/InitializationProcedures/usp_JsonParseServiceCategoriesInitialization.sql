use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParseServiceCategoriesInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParseServiceCategoriesInitialization
go

create procedure dbo.usp_JsonParseServiceCategoriesInitialization
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

		with cte_ServiceCategories([ServiceCategory]) as
		(
			select [ServiceCategory]
			from OPENJSON(@json) with 
			(
				ServiceCategories nvarchar(max) '$.ServiceCategories' as json
			)
			outer apply
			OPENJSON(ServiceCategories) with
			(
				[ServiceCategory] nvarchar(20) '$.ServiceCategory'
			)
		)
		insert into dbo.ServiceCategories ([ServiceCategory])
		select [ServiceCategory]
		from cte_ServiceCategories

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go