use MedCenterDB
go

if OBJECT_ID('dbo.usp_CreateEquipment', 'P') is not null
    drop procedure dbo.usp_CreateEquipment
go

---------------------------------------------------------------------------------------
-- procedure creates Equipment linked with Room and Services
-- created by:   Alexander Tykoun
-- created date: 10/06/2022
-- sample call: 
-- exec dbo.usp_CreateEquipment @params =
--N'
--{
--   "Admin": {
--       "Login": "UserWithAdminRole",
--       "PasswordHash": "9871827B34A35D53C983FF"    },
--   "Equipment": {
--       "EquipmentName": "NameOfEquipment",
--       "InventaryNumber": "InvNumber",
--       "EquipmentState": { "EquipmentState": "In Service /Out Of Service/On Repair/Disposed" },
--       "EquipmentType": { "EquipmentType": "Personal Computer/Ultrasound/XRay/Laser Surgery/Analyzer"},
--       "EquipmentNote": "Lorem Ipsum",
--       "Services": [
--                 { "ServiceName": "Therapist Consultation" },
--                 { "ServiceName": "Cardiologist Consultation" }    ],
--       "RegistrationDateTime": "2022-10-06T19:22:42.6276382+03:00",
--		 "LastEditor": { "Login": "AdminUserLogin" },  
--		 "EquipmentRoom": { "RoomName": "Cabinet 5" }                 }
--}
--'
---------------------------------------------------------------------------------------

create proc dbo.usp_CreateEquipment(
    @createEquipmentJson nvarchar(max)
)
as
begin
	if (ISJSON(@createEquipmentJson) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try

--		if OBJECT_ID('tempdb..#CreateEquipmentData', 'U') is  not null
--		drop table #CreateEquipmentData;
		
		create table #CreateEquipmentData
		(	
			EquipmentName			nvarchar(100),
			InventaryNumber			nvarchar(15),
			EquipmentStateId		tinyint,
			EquipmentTypeId			tinyint,
			EquipmentRoomId			int,
			RegistrationDateTime	datetime2,
			EquipmentNote			nvarchar(200),
			LastEditor				int,
			ServiceId				int
		);

		with cte_CreateEquipmentData
		(
			AdminLogin,
			AdminPass,
			EquipmentName,		
			InventaryNumber,
			EquipmentState,	 
			EquipmentType,	
			EquipmentRoomName,
			RegistrationDateTime,
			EquipmentNote,
			LastEditorLogin,
			ServiceName
		) as
		(
			select 
				AdminLogin,
				AdminPass,
				EquipmentName,		
				InventaryNumber,
				ISNULL (EquipmentState, 'In Service'),	 
				EquipmentType,	
				EquipmentRoomName,
				ISNULL(RegistrationDateTime, SYSDATETIME()),
				EquipmentNote,
				ISNULL (LastEditorLogin, AdminLogin),
				ServiceName
			from openjson(@createEquipmentJson)
			with
			(			
				AdminLogin				nvarchar(20)		N'$.Admin.Login',
				AdminPass				char(64)			N'$.Admin.PasswordHash',
				EquipmentName			nvarchar(100)		N'$.Equipment.EquipmentName',
				InventaryNumber			nvarchar(15)		N'$.Equipment.InventaryNumber',
				EquipmentState			nvarchar(30)		N'$.Equipment.EquipmentState.EquipmentState',
				EquipmentType			nvarchar(30)		N'$.Equipment.EquipmentType.EquipmentType',
				EquipmentRoomName		nvarchar(20)		N'$.Equipment.EquipmentRoom.RoomName',
				RegistrationDateTime	datetime2			N'$.Equipment.RegistrationDateTime',
				EquipmentNote			nvarchar(200)		N'$.Equipment.EquipmentNote',
				LastEditorLogin			nvarchar(20)		N'$.Equipment.LastEditor.Login',
				[Services]				nvarchar(max)		N'$.Equipment.Services' as json
			)
			outer apply openjson([Services]) with
					(
						ServiceName		nvarchar(50)	N'$.ServiceName'
					)
		)


	insert into #CreateEquipmentData
		(
			EquipmentName,
			InventaryNumber,
			EquipmentStateId,
			EquipmentTypeId,
			EquipmentRoomId,
			RegistrationDateTime,
			EquipmentNote,
			LastEditor,
			ServiceId
		)
		select
			tmp.EquipmentName,
			tmp.InventaryNumber,
			es.EquipmentStateId,
			et.EquipmentTypeId,
			r.RoomId,
			tmp.RegistrationDateTime,
			tmp.EquipmentNote,
			u.UserId,
			ServiceId
		from cte_CreateEquipmentData as tmp
		inner join EquipmentStates as es on es.EquipmentState = tmp.EquipmentState
		inner join EquipmentTypes as et on et.EquipmentType = tmp.EquipmentType
		inner join Users as adm on adm.[Login] = tmp.[AdminLogin] AND adm.PasswordHash = tmp.AdminPass
		inner join UserRoles as ur on (adm.UserRoleId = ur.UserRoleId AND ur.UserRole = 'Administrator')	
		left join [Services] as s on s.ServiceName = tmp.ServiceName
		left join Rooms as r on r.RoomName = tmp.EquipmentRoomName
		inner join Users as u on u.[Login] = tmp.[LastEditorLogin]

		begin transaction

--insert Equipment 
			insert into dbo.Equipments
			(
				EquipmentName,
				InventaryNumber,
				EquipmentRoom,
				EquipmentTypeId,
				EquipmentStateId,
				RegistrationDateTime,
				EquipmentNote,
				LastEditor
			)
			select distinct				
					EquipmentName,
					InventaryNumber,
					EquipmentRoomId,
					EquipmentTypeId,
					EquipmentStateId,
					RegistrationDateTime,
					EquipmentNote,
					LastEditor
			from #CreateEquipmentData

--insert EquipmentsServicesLink

			insert into dbo.EquipmentsServicesLink
			(
				EquipmentId,
				ServiceId
			)
			select 
				e.EquipmentId,
				tmp.ServiceId
			from #CreateEquipmentData as tmp
			inner join Equipments as e on tmp.EquipmentName = e.EquipmentName
			left join dbo.EquipmentsServicesLink as esl
				   on esl.EquipmentId = e.EquipmentId AND
				      esl.ServiceId  = tmp.ServiceId
			where esl.EquipmentId is null AND esl.ServiceId is null AND
				  e.EquipmentId is not null AND tmp.ServiceId is not null			  				   				   

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