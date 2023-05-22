use [MedCenterDB]
go

if OBJECT_ID('dbo.usp_AssignEquipmentsToRoom', 'P') is not null
    drop procedure dbo.usp_AssignEquipmentsToRoom
go
---------------------------------------------------------------------------------------
-- procedure assigns list of equipments to room
-- created by:   Alexander Tykoun
-- created date: 10/07/2022
-- sample call: 
-- exec dbo.usp_AssignEquipmentsToRoom @params =
--N'
--{
--  "Admin": {
--    "Login": "Kalabukh",
--    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
--  },
--  "Room": {
--    "RoomName": "Reception"
--  },
--  "Equipments": [
--    {
--      "InventaryNumber": "PC777-888"
--    },
--    {
--      "InventaryNumber": "CD-01-101"
--    }
--  ]
--}
--'
---------------------------------------------------------------------------------------

create proc [dbo].usp_AssignEquipmentsToRoom(
    @assignEquipmentsToRoomJson nvarchar(max)
)
as
begin
	if (ISJSON(@assignEquipmentsToRoomJson) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try

--		if OBJECT_ID('tempdb..#AssignEquipmentsToRoomData', 'U') is  not null
--		drop table #AssignEquipmentsToRoomData;
		
		create table #AssignEquipmentsToRoomData
		(	
			EquipmentId				int,
			RoomId					int
		);

		with cte_AssignEquipmentsToRoom
		(
			AdminLogin,
			AdminPass,
			InventaryNumber,
			RoomName
		) as
		(
			select 
				AdminLogin,
				AdminPass,
				InventaryNumber,
				RoomName
			from openjson(@assignEquipmentsToRoomJson)
			with
			(			
				AdminLogin				nvarchar(20)		N'$.Admin.Login',
				AdminPass				char(64)			N'$.Admin.PasswordHash',
				[Equipments]		    nvarchar(max)		N'$.Equipments' as json,
				RoomName				nvarchar(20)		N'$.Room.RoomName'
			)
			outer apply openjson([Equipments]) with
					(
						InventaryNumber		nvarchar(15)	N'$.InventaryNumber'
					)
		)

	insert into #AssignEquipmentsToRoomData
		(
			EquipmentId,
			RoomId
		)
		select
			e.EquipmentId,
			r.RoomId
		from cte_AssignEquipmentsToRoom as tmp
			inner join Equipments as e on e.InventaryNumber = tmp.InventaryNumber
			inner join Rooms as r on r.RoomName = tmp.RoomName
			inner join Users as adm on adm.[Login] = tmp.[AdminLogin] AND adm.PasswordHash = tmp.AdminPass
			inner join UserRoles as ur on (adm.UserRoleId = ur.UserRoleId AND ur.UserRole = 'Administrator')	

		begin transaction

--insert EquipmentsServicesLink

			update dbo.Equipments
			set EquipmentRoom = tmp.RoomId
			from Equipments as e
			inner join #AssignEquipmentsToRoomData as tmp on e.EquipmentId = tmp.EquipmentId
			

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

