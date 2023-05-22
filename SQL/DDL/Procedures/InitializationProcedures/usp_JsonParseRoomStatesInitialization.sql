use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParseRoomStatesInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParseRoomStatesInitialization
go

create procedure dbo.usp_JsonParseRoomStatesInitialization
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

		with cte_RoomStates([RoomState]) as
		(
			select [RoomState]
			from OPENJSON(@json) with 
			(
				RoomStates nvarchar(max) '$.RoomStates' as json
			)
			outer apply
			OPENJSON(RoomStates) with
			(
				[RoomState] nvarchar(20) '$.RoomState'
			)
		)
		insert into dbo.RoomStates ([RoomState])
		select [RoomState]
		from cte_RoomStates

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go