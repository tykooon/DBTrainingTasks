use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParseEquipmentTypesInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParseEquipmentTypesInitialization
go

create procedure dbo.usp_JsonParseEquipmentTypesInitialization
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

		with cte_EquipmentTypes([EquipmentType]) as
		(
			select [EquipmentType]
			from OPENJSON(@json) with 
			(
				EquipmentTypes nvarchar(max) '$.EquipmentTypes' as json
			)
			outer apply
			OPENJSON(EquipmentTypes) with
			(
				[EquipmentType] nvarchar(20) '$.EquipmentType'
			)
		)
		insert into dbo.EquipmentTypes ([EquipmentType])
		select [EquipmentType]
		from cte_EquipmentTypes

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go