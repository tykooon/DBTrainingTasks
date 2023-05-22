use MedCenterDB
go

if OBJECT_ID('dbo.usp_CreateRoom', 'P') is not null
    drop procedure dbo.usp_CreateRoom
go

---------------------------------------------------------------------------------------
-- procedure creates Staffer assigned to User and Administrator
-- created by:   Alexander Tykoun
-- created date: 10/06/2022
-- sample call: 
-- exec dbo.usp_CreateRoom @params =
--N'
--{
--   "Admin": {
--        "Login": "UserWithAdminRole",
--        "PasswordHash": "9871827B34A35D53C983FF"    },
--   "Room": {
--        "RoomName": "RoomName(Digits&Letters)",
--        "RoomState": { "RoomState": "Accessible/Non-Accessible/Renovation/Abolished" },
--        "RoomType":  { "RoomType": "Common Area/Doctor's office/Service Space/Laboratory/Surgery" },
--        "RoomNotes": "Lorem Ipsum",
--        "LastUpdateDateTime": "2022-10-06T19:22:42.6276382+03:00"      }
--}
--'
---------------------------------------------------------------------------------------

create proc dbo.usp_CreateRoom(
    @createRoomJson nvarchar(max)
)
as
begin
	if (ISJSON(@createRoomJson) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try

--		if OBJECT_ID('tempdb..#CreateRoomData', 'U') is  not null
--		drop table #CreateRoomData;
		
		create table #CreateRoomData
		(	
			RoomName				nvarchar(20),
			RoomStateId				tinyint,
			RoomTypeId				tinyint,
			LastUpdateDateTime		datetime2,
			RoomNotes				nvarchar(100)
		);

		with cte_CreateRoomData
		(
			AdminLogin,
			AdminPass,
			RoomName,
			RoomState,
			RoomType,
			LastUpdateDateTime,
			RoomNotes
		) as 
		(
			select 
				AdminLogin,
				AdminPass,
				RoomName,
				RoomState,
				RoomType,
				ISNULL(LastUpdateDateTime, SYSDATETIME()),
				RoomNotes
			from openjson(@createRoomJson)
			with
			(
				AdminLogin			nvarchar(20)	N'$.Admin.Login',
				AdminPass			char(64)		N'$.Admin.PasswordHash',
				RoomName			nvarchar(20)	N'$.Room.RoomName',
				RoomState			nvarchar(30)	N'$.Room.RoomState.RoomState',
				RoomType			nvarchar(30)	N'$.Room.RoomType.RoomType',
				LastUpdateDateTime	datetime2		N'$.Room.LastUpdateDateTime',
				RoomNotes			nvarchar(100)	N'$.Room.RoomNotes'
			)
		)
	
		insert into #CreateRoomData
		(
			RoomName,
			RoomStateId,
			RoomTypeId,
			LastUpdateDateTime,
			RoomNotes		
		)
		select
			tmp.RoomName,
			rs.RoomStateId,
			rt.RoomTypeId,
			tmp.LastUpdateDateTime,
			tmp.RoomNotes			
		from cte_CreateRoomData as tmp
		inner join RoomStates as rs on rs.RoomState = tmp.RoomState
		inner join RoomTypes as rt on rt.RoomType = tmp.RoomType
		inner join Users as adm on adm.[Login] = tmp.[AdminLogin] AND adm.PasswordHash = tmp.AdminPass
		inner join UserRoles as ur on (adm.UserRoleId = ur.UserRoleId AND ur.UserRole = 'Administrator')	

		begin transaction
--insert Room 
			insert into dbo.Rooms
			(
				RoomName,
				RoomStateId,
				RoomTypeId,
				LastUpdateDateTime,
				RoomNotes
			)
			select				
				RoomName,
				RoomStateId,
				RoomTypeId,
				LastUpdateDateTime,
				RoomNotes
			from #CreateRoomData

		commit transaction
	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

		if (XACT_STATE() <> 0)
			rollback transaction

	end catch
end
go