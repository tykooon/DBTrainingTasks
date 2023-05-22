use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParseEquipmentStatesInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParseEquipmentStatesInitialization
go

create procedure dbo.usp_JsonParseEquipmentStatesInitialization
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

		with cte_EquipmentStates([EquipmentState]) as
		(
			select [EquipmentState]
			from OPENJSON(@json) with 
			(
				EquipmentStates nvarchar(max) '$.EquipmentStates' as json
			)
			outer apply
			OPENJSON(EquipmentStates) with
			(
				[EquipmentState] nvarchar(20) '$.EquipmentState'
			)
		)
		insert into dbo.EquipmentStates ([EquipmentState])
		select [EquipmentState]
		from cte_EquipmentStates

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go