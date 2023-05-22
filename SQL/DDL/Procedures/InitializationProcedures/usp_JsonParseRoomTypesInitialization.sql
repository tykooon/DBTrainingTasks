use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParseRoomTypesInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParseRoomTypesInitialization
go

create procedure dbo.usp_JsonParseRoomTypesInitialization
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

		with cte_RoomTypes([RoomType]) as
		(
			select [RoomType]
			from OPENJSON(@json) with 
			(
				RoomTypes nvarchar(max) '$.RoomTypes' as json
			)
			outer apply
			OPENJSON(RoomTypes) with
			(
				[RoomType] nvarchar(20) '$.RoomType'
			)
		)
		insert into dbo.RoomTypes ([RoomType])
		select [RoomType]
		from cte_RoomTypes

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go