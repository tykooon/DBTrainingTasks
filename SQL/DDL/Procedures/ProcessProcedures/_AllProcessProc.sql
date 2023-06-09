use MedCenterDB
go

if OBJECT_ID('dbo.usp_AcceptPayment', 'P') is not null
    drop procedure dbo.usp_AcceptPayment
go

---------------------------------------------------------------------------------------
-- procedure set Payment State of visit to 'Completely Paid'
-- created by:   Alexander Tykoun
-- created date: 10/11/2022
-- sample call: 
-- exec dbo.usp_AcceptPayment @params =
--N'
--{
--   "Staffer": {
--        "Login": "StafferLogin",   
--        "PasswordHash": "9871827B34A35D53C983FF"      },
--   "VisitInfo": {
--		  "Specialist": { "Login": "StafferLogin"  },
--        "ScheduledDateTime": "2022-10-04T18:28:42.8903578+03:00"   }
--}
--'
---------------------------------------------------------------------------------------

create proc dbo.usp_AcceptPayment(
    @AcceptPaymentJson nvarchar(max)
)
as
begin
	if (ISJSON(@AcceptPaymentJson) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try

--		if OBJECT_ID('tempdb..#AcceptPaymentData', 'U') is  not null
--		drop table #AcceptPaymentData;
		
		create table #AcceptPaymentData
		(	
			VisitId		int
		);

		with cte_AcceptPayment
		(
			StafferLogin,
			StafferPass,
			ScheduledDateTime,
			SpecialistLogin
		) as 
		(
			select 
				StafferLogin,
				StafferPass,
				ScheduledDateTime,
				SpecialistLogin
			from openjson(@AcceptPaymentJson)
			with
			(
				StafferLogin		nvarchar(20)	N'$.Staffer.Login',
				StafferPass			char(64)		N'$.Staffer.PasswordHash',
				ScheduledDateTime	datetime2		N'$.VisitInfo.ScheduledDateTime',
				SpecialistLogin		nvarchar(20)	N'$.VisitInfo.Specialist.Login'
			)
		)
	
		insert into #AcceptPaymentData
		(
			VisitId
		)
		select 
			v.VisitId
		from cte_AcceptPayment as tmp
		inner join Users as reg on reg.[Login] = tmp.StafferLogin AND reg.PasswordHash = tmp.StafferPass
		inner join Staffers as st on st.StafferUserId = reg.UserId
		inner join StafferGroups as sg on st.StafferGroupId = sg.StafferGroupId
		inner join Users as specuser on specuser.[Login] = tmp.SpecialistLogin
		inner join Staffers as stspec on stspec.StafferUserId = specuser.UserId
		inner join Visits as v on (v.Specialist = stspec.StafferId AND v.ScheduledDateTime = tmp.ScheduledDateTime)	
		inner join PaymentStates as ps on v.PaymentStateId = ps.PaymentStateId
		where sg.StafferGroup = 'Receptionists' AND ps.PaymentState != 'Completely Paid'

		if not exists (select 1 from #AcceptPaymentData)
		begin
			print 'Can''t accept paymnet for this visit'
			return 100
		end

		begin transaction
	
--update Visit 
			update dbo.Visits
			set	
				PaymentStateId = ps.PaymentStateId
			from Visits as v 
			inner join #AcceptPaymentData as tmp on tmp.VisitId = v.VisitId 
			cross join PaymentStates as ps 
			where ps.PaymentState = 'Completely Paid'

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
use [MedCenterDB]
go

if OBJECT_ID('dbo.usp_AddRatingToStaffer', 'P') is not null
    drop procedure dbo.usp_AddRatingToStaffer
go
---------------------------------------------------------------------------------------
-- procedure assigns list of services to each equipment in list
-- created by:   Alexander Tykoun
-- created date: 10/07/2022
-- sample call: 
-- exec dbo.usp_AddRatingToStaffer @params =
--N'
--{
--  "Patient": {
--    "Login": "Tykooon",
--    "PasswordHash": "20e0dckdjc02kdcjlaksdca" },
--  "Staffer": { 
--		"Login": "Sidor86" },
--  "RatingInfo": { 
--		"RatingValue": 10,
--      "RatingComment": "Nice! Thanx." 
--		"RatingDateTime": "2022-09-27T19:35:33.6578067+03:00"   }
--}
--'
---------------------------------------------------------------------------------

create proc [dbo].usp_AddRatingToStaffer(
    @addRatingJson nvarchar(max)
)
as
begin
	if (ISJSON(@addRatingJson) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try

--		if OBJECT_ID('tempdb..#AddRatingData', 'U') is  not null
--		drop table #AddRatingData;
		
		create table #AddRatingData
		(	
			PatientId				int,
			StafferId				int,
			RatingValue				tinyint,
			RatingComment			nvarchar(250),
			RatingDateTime			datetime2
		);

		with cte_AddRating
		(
			PatientLogin,
			PatientPass,
			StafferLogin,
			RatingValue,
			RatingComment,
			RatingDateTime
		) as
		(
			select 
				PatientLogin,
				PatientPass,
				StafferLogin,
				RatingValue,
				RatingComment,
				ISNULL(RatingDateTime,SYSDATETIME())
			from openjson(@addRatingJson)
			with
			(			
				PatientLogin			nvarchar(20)		N'$.Patient.Login',
				PatientPass				char(64)			N'$.Patient.PasswordHash',
				StafferLogin			nvarchar(20)		N'$.Staffer.Login',
				RatingValue				tinyint				N'$.RatingInfo.RatingValue',
				RatingComment			nvarchar(250)		N'$.RatingInfo.RatingComment',
				RatingDateTime			datetime2			N'$.RatingInfo.RatingDateTime'
			)
		)

	insert into #AddRatingData
		(
			PatientId,
			StafferId,
			RatingValue,
			RatingComment,
			RatingDateTime
		)
		select
			p.PatientId,
			s.StafferId,
			tmp.RatingValue,
			tmp.RatingComment,
			tmp.RatingDateTime
		from cte_AddRating as tmp
			inner join Users as pu on pu.[Login] = tmp.PatientLogin AND pu.PasswordHash = tmp.PatientPass
			inner join Patients as p on p.PatientUserId = pu.UserId
			inner join Users as su on su.[Login] = tmp.StafferLogin
			inner join Staffers as s on s.StafferUserId = su.UserId

		begin transaction

--upsert Rating
			update dbo.Ratings
			set RatingValue = tmp.RatingValue,
				RatingDateTime = tmp.RatingDateTime,
				RatingComment = tmp.RatingComment
			from #AddRatingData as tmp
			inner join Ratings as r on (tmp.PatientId = r.PatientId AND 
										tmp.StafferId = r.StafferId)
			insert into dbo.Ratings 
			(
				PatientId,
				StafferId,
				RatingValue,
				RatingComment,
				RatingDateTime
			)
			select 
					tmp.PatientId,
					tmp.StafferId,
					tmp.RatingValue,
					tmp.RatingComment,
					tmp.RatingDateTime
			from #AddRatingData as tmp
			left outer join Ratings as r on (tmp.PatientId = r.PatientId AND 
	 										 tmp.StafferId = r.StafferId)
			where (r.RatingId is null)	  				   				   
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

use MedCenterDB
go

if OBJECT_ID('dbo.usp_ApproveAsAdministrator', 'P') is not null
    drop procedure dbo.usp_ApproveAsAdministrator
go

---------------------------------------------------------------------------------------
-- procedure approves Administrator UserRole given from Approver to User
-- created by:   Alexander Tykoun
-- created date: 10/04/2022
-- sample call: 
-- exec dbo.usp_ApproveAsAdministrator @params =
--N'
--{
--  "User": {
--    "Login": "UserLogin"  },
--  "Approver": {
--    "Login": "ApproverLogin",
--    "PasswordHash": "8B89C76F232B422D626A04B3"
--    }
--}
--'
---------------------------------------------------------------------------------------

create proc dbo.usp_ApproveAsAdministrator(
    @ApproveAsAdminJson nvarchar(max)
)
as
begin
	if (ISJSON(@ApproveAsAdminJson) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try
		create table #@ApproveAsAdminData (	
			UserId				int,
			ApproverId			int,
			RoleId				tinyint
		);		

		with cte_ApproveAsAdmin (
			[Login],
			ApproverLogin,
			ApproverPasswordHash
		) as 
		(
			select 
				[Login],
				ApproverLogin,
				ApproverPasswordHash
			from openjson(@ApproveAsAdminJson)
			with
			(
				[Login]					nvarchar(20)	N'$.User.Login',
				ApproverLogin			nvarchar(20)	N'$.Approver.Login',
				ApproverPasswordHash	char(64)		N'$.Approver.PasswordHash'
			)
		)
	
		insert into #@ApproveAsAdminData (
			UserId,
			ApproverId,
			RoleId			
			)
		select
			u.UserId,
			a.UserId,
			ur.UserRoleId
		from cte_ApproveAsAdmin as tmp
		inner join Users as u on tmp.[Login] = u.[Login]
		inner join Users as a on (tmp.ApproverLogin = a.[Login] AND
								   tmp.ApproverPasswordHash = a.PasswordHash)
		inner join UserRoles as ur on (a.UserRoleId = ur.UserRoleId AND
									ur.UserRole = 'Administrator')	
		
		if (not exists(select 1 from #@ApproveAsAdminData))
		begin
			print 'User or approved Admin are not found'
			return 404
		end

		begin transaction
				
			update Users 
			set UserRoleId = tmp.RoleId,
				AdminApprover = tmp.ApproverId
			from Users u 
			inner join #@ApproveAsAdminData tmp on u.UserId = tmp.UserId
			
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
use MedCenterDB
go

if OBJECT_ID('dbo.usp_CreateService', 'P') is not null
    drop procedure dbo.usp_CreateService
go

---------------------------------------------------------------------------------------
-- procedure creates Staffer assigned to User and Administrator
-- created by:   Alexander Tykoun
-- created date: 10/06/2022
-- sample call: 
-- exec dbo.usp_CreateService @params =
--N'
--{
--   "Admin": {
--        "Login": "UserWithAdminRole",
--        "PasswordHash": "9871827B34A35D53C983FF"   },
--   "Service": {
--        "ServiceName": "NameOfService",
--        "ServiceStatus": { "ServiceStatus": "Accessible/Suspended/On Demand/Depricated" },
--        "Comment": "Lorem Ipsum",
--        "Price": "MoneyValue",
--        "ServiceCategory": {"ServiceCategory": "Consultation/Examination/Test/Manipulation/Operation/Rehabilitation"},
--        "Description": "Plain Text"  }
--}
--'
---------------------------------------------------------------------------------------

create proc dbo.usp_CreateService(
    @createServiceJson nvarchar(max)
)
as
begin
	if (ISJSON(@createServiceJson) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try

--		if OBJECT_ID('tempdb..#CreateServiceData', 'U') is  not null
--		drop table #CreateServiceData;
		
		create table #CreateServiceData
		(	
			ServiceName				nvarchar(50),
			ServiceStatusId			tinyint,
			Comment					nvarchar(150),
			Price					money,
			ServiceCategoryId		tinyint,
			[Description]			nvarchar(200)
		);

		with cte_CreateServiceData
		(
			AdminLogin,
			AdminPasswordHash,
			ServiceName,
			ServiceStatus,
			Comment,
			Price,
			ServiceCategory,
			[Description]
		) as 
		(
			select 
				AdminLogin,
				AdminPass,
				ServiceName,
				ServiceStatus,
				Comment,
				Price,
				ServiceCategory,
				[Description]
			from openjson(@createServiceJson)
			with
			(
				AdminLogin			nvarchar(20)	N'$.Admin.Login',
				AdminPass			char(64)		N'$.Admin.PasswordHash',
				ServiceName			nvarchar(50)	N'$.Service.ServiceName',
				ServiceStatus		nvarchar(30)	N'$.Service.ServiceStatus.ServiceStatus',
				Comment				nvarchar(150)	N'$.Service.Comment',
				Price				money			N'$.Service.Price',
				ServiceCategory		nvarchar(30)	N'$.Service.ServiceCategory.ServiceCategory',
				[Description]		nvarchar(200)	N'$.Service.Description'
			)
		)
	
		insert into #CreateServiceData
		(
			ServiceName,
			ServiceStatusId,
			Comment,
			Price,
			ServiceCategoryId,
			[Description]			
		)
		select
			tmp.ServiceName,
			ss.ServiceStatusId,
			tmp.Comment,
			tmp.Price,
			sc.ServiceCategoryId,
			tmp.[Description]			
		from cte_CreateServiceData as tmp
		inner join ServiceStatuses as ss on ss.ServiceStatus = tmp.ServiceStatus
		inner join ServiceCategories as sc on sc.ServiceCategory = tmp.ServiceCategory
		inner join Users as adm on adm.[Login] = tmp.[AdminLogin] AND adm.PasswordHash = tmp.AdminPasswordHash
		inner join UserRoles as ur on (adm.UserRoleId = ur.UserRoleId AND ur.UserRole = 'Administrator')	

		begin transaction
--insert Service 
			insert into dbo.Services
			(
				ServiceName,
				ServiceStatusId,
				Comment,
				Price,
				ServiceCategoryId,
				[Description]			
			)
			select				
				ServiceName,
				ServiceStatusId,
				Comment,
				Price,
				ServiceCategoryId,
				[Description]			
			from #CreateServiceData

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
use MedCenterDB
go

if OBJECT_ID('dbo.usp_EditVisit', 'P') is not null
    drop procedure dbo.usp_EditVisit
go

---------------------------------------------------------------------------------------
-- procedure edits selected data of visit
-- created by:   Alexander Tykoun
-- created date: 10/11/2022
-- sample call: 
-- exec dbo.usp_EditVisit @params =
--N'
--{
--   "Staffer": {
--        "Login": "StafferLogin",   
--        "PasswordHash": "9871827B34A35D53C983FF"      },
--   "VisitInfo": {
--        "ScheduledDateTime": "2022-10-04T18:28:42.8903578+03:00",
--        "PreliminaryNotes": "Visit Prescriptions",														--optional
--        "VisitType": { "VisitType": "Consultation/Examination/Test Taking/Operation" },					--optional
--        "VisitStatus": { "VisitStatus": "Planned/Canceled/Postponed/Rejected/Finished/Extended " },		--optional
--        "Summary": "VisitSummary",																		--optional
--        "PaymentState": { "PaymentState": "Not Paid/Completely Paid/Rejected/Delayed"},					--optional
--        "InternalComment": "Text from Specialist to Colleagues" },										--optional
--   "Assistants": [																						--optional
--                  { "Login": "StafferUser1"  },															--optional
--                  { "Login": "StafferUser2"  },       ]													--optional
--}
--'
---------------------------------------------------------------------------------------

create proc dbo.usp_EditVisit(
    @editVisitJson nvarchar(max)
)
as
begin
	if (ISJSON(@editVisitJson) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try

--		if OBJECT_ID('tempdb..#EditVisitData', 'U') is  not null
--		drop table #EditVisitData;
		
		create table #EditVisitData
		(	
			ScheduledDateTime	datetime2,
			SpecialistId		int,
			PreliminaryNotes	nvarchar(300),
			Summary				nvarchar(300),
			VisitTypeId			tinyint,
			VisitStatusId		tinyint,
			PaymentStateId		tinyint,
			InternalComment		nvarchar(200),
			AssistantId			int
		);

		with cte_ScheduleVisit
		(
			StafferLogin,
			StafferPass,
			ScheduledDateTime,
			Preliminary,
			VisitType,
			VisitStatus,
			Summary,
			PaymentState,
			InternalComment,
			AssistantLogin
		) as 
		(
			select 
				StafferLogin,
				StafferPass,
				ScheduledDateTime,
				Preliminary,
				VisitType,
				VisitStatus,
				Summary,
				PaymentState,
				InternalComment,
				AssistantLogin
			from openjson(@editVisitJson)
			with
			(
				StafferLogin		nvarchar(20)	N'$.Staffer.Login',
				StafferPass			char(64)		N'$.Staffer.PasswordHash',
				ScheduledDateTime	datetime2		N'$.VisitInfo.ScheduledDateTime',
				Preliminary			nvarchar(300)	N'$.VisitInfo.PreliminaryNotes',
				VisitType			nvarchar(30)	N'$.VisitInfo.VisitType.VisitType',
				VisitStatus			nvarchar(30)	N'$.VisitInfo.VisitStatus.VisitStatus',
				Summary				nvarchar(300)	N'$.VisitInfo.Summary',
				PaymentState		nvarchar(30)	N'$.VisitInfo.PaymentState.PaymentState',
				InternalComment		nvarchar(200)	N'$.VisitInfo.InternalComment',
				Assistants			nvarchar(max)	N'$.Assistants' as json
			)
			outer apply openjson(Assistants) with
			(	AssistantLogin         nvarchar(20)    N'$.Login' )
		)
	
		insert into #EditVisitData
		(
			ScheduledDateTime,
			SpecialistId,
			PreliminaryNotes,
			Summary,
			VisitTypeId,
			VisitStatusId,
			PaymentStateId,
			InternalComment,
			AssistantId
		)
		select 
			tmp.ScheduledDateTime,
			v.Specialist,
			tmp.Preliminary,
			tmp.Summary,
			vt.VisitTypeId,
			vs.VisitStatusId,
			ps.PaymentStateId,
			tmp.InternalComment,
			assist.UserId
		from cte_ScheduleVisit as tmp
		inner join Users as reg on reg.[Login] = tmp.StafferLogin AND reg.PasswordHash = tmp.StafferPass
		inner join Staffers as st on st.StafferUserId = reg.UserId	
		inner join Visits as v on (v.Specialist = st.StafferId AND v.ScheduledDateTime = tmp.ScheduledDateTime)	
		left join VisitTypes as vt on tmp.VisitType = vt.VisitType
		left join VisitStatuses as vs on tmp.VisitStatus = vs.VisitStatus
		left join PaymentStates as ps on tmp.PaymentState = ps.PaymentState
		left join Users as assist on tmp.AssistantLogin = assist.[Login]
		left join Staffers as staffassist on staffassist.StafferUserId = assist.UserId

		begin transaction
	
--update Visit 
			update dbo.Visits
			set	
				PreliminaryNotes = ISNULL(tmp.PreliminaryNotes, v.PreliminaryNotes),
				Summary = ISNULL(tmp.Summary, v.Summary),
				VisitTypeId = ISNULL(tmp.VisitTypeId, v.VisitTypeId),
				VisitStatusId = ISNULL(tmp.VisitStatusId, v.VisitStatusId),
				PaymentStateId = ISNULL(tmp.PaymentStateId, v.PaymentStateId),
				InternalComment =  ISNULL(tmp.InternalComment, v.InternalComment)
			from #EditVisitData as tmp 
			inner join Visits as v on (v.Specialist = tmp.SpecialistId AND v.ScheduledDateTime = tmp.ScheduledDateTime)

--insert StaffersVisitsLink
			
			insert into dbo.StaffersVisitsLink
			(
				StafferId,
				VisitId
			)
			select
				tmp.AssistantId,
				v.VisitId
			from #EditVisitData as tmp 
			inner join Visits as v on (v.ScheduledDateTime = tmp.ScheduledDateTime AND v.Specialist = tmp.SpecialistId)
			left join StaffersVisitsLink as svl on (svl.VisitId = v.VisitId AND svl.StafferId = tmp.SpecialistId)
			where svl.VisitId is null	  AND svl.StafferId		is null AND
					v.VisitId is not null AND tmp.AssistantId  is not null

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
use MedCenterDB
go

if OBJECT_ID('dbo.usp_InitializeAdministrator', 'P') is not null
    drop procedure dbo.usp_InitializeAdministrator
go

---------------------------------------------------------------------------------------
-- procedure initialize existing user as primary Administrator
-- created by:   Alexander Tykoun
-- created date: 10/04/2022
-- sample call: 
-- exec dbo.usp_InitializeAdministrator @params =
--N'
--{
--  "User": {
--    "Login": "Tykooon"  }
--}
--'
---------------------------------------------------------------------------------------

create proc dbo.usp_InitializeAdministrator(
    @InitializeAdminJson nvarchar(max)
)
as
begin
	if (ISJSON(@InitializeAdminJson) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try
		create table #InitializeAdminData
		(	
			UserId					int,
			[Login]					nvarchar(20),
		);		
		
		with cte_InitialAdmin
		(
			[Login]
		) as 
		(
			select 
				[Login]
			from openjson(@InitializeAdminJson)
			with ( [Login]  	nvarchar(20)	N'$.User.Login'  )
		)

		insert into #InitializeAdminData
		(
			UserId,
			[Login]
		)
		select
			u.UserId,
			a.[Login]
		from cte_InitialAdmin as a
		inner join Users as u on a.[Login] = u.[Login]
							
		if (not exists(select 1 from #InitializeAdminData))
		begin
			print 'User not found'
			return 404
		end

		begin transaction
				
			update Users 
			set UserRoleId = ur.UserRoleId,
				AdminApprover = NULL
			from Users u 
			inner join #InitializeAdminData tmp on u.[Login] = tmp.[Login]
			inner join UserRoles ur on ur.UserRole = 'Administrator'

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
use MedCenterDB
go

if OBJECT_ID('dbo.usp_NewUserRegistration', 'P') is not null
    drop procedure dbo.usp_NewUserRegistration
go

---------------------------------------------------------------------------------------
-- procedure imports new phone numbers from incoming JSON-parameter into table dbo.Phones
-- created by:   Alexander Tykoun
-- created date: 09/29/2022
-- sample call: 
-- exec dbo.usp_NewUserRegistration @params =
--N'
--{
--  "Guest": { 
--    "IpAddress": "11.22.33.44",
--    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
--    "SessionDateTime": "2022-09-27T19:35:33.6578067+03:00",
--  },
--  "User": {
--    "Login": "Tykooon",
--	  "Email": "alexandertykun@coherentsolutions.com",				-- optional
--    "PasswordHash": "20e0dckdjc02kdcjlaksdca",
--    "FullName": "Alex Tykoun",
--    "Gender": { "GenderName": "Male" },
--    "DateOfBirth": "10/13/1977",
--    "Phones": [													-- optional
--			{"PhoneNumber": "+375296480979"},						-- optional
--			{"PhoneNumber": "+375173074754"}						-- optional
--		],
--    "RegisterDateTime": "2022-10-04T11:51:00.9086322+03:00",		-- optional
--    "LastActiveDateTime": "2022-10-04T11:51:00.9159824+03:00"		-- optional
--    }
--  }
--}
--'
---------------------------------------------------------------------------------------

create proc dbo.usp_NewUserRegistration(
    @newUserRegisrtationJson nvarchar(max)
)
as
begin
	if (ISJSON(@newUserRegisrtationJson) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try

--		if OBJECT_ID('tempdb..#NewUserRegistrationData', 'U') is  not null
--		drop table #NewUserRegistrationData;
		
		create table #NewUserRegistrationData
		(	
			[Login]					nvarchar(20),
			Email					nvarchar(50),
			PasswordHash			char(64),
			FullName				nvarchar(100),
 			GenderId				tinyint, 
			DateOfBirth				date,
			UserRoleId				tinyint, 
			RegisterDateTime		datetime2,
			LastActiveDateTime		datetime2,

			IPAddress				nvarchar(15),
			SessionDateTime			datetime2,
			BrowserUserAgent		nvarchar(200)
		);

		with cte_NewUserRegistration
		(
			[Login],
			Email,
			PasswordHash,
			FullName,
			GenderName, 
			DateOfBirth,
			RegisterDateTime,
			LastActiveDateTime,

			IPAddress,
			SessionDateTime,
			BrowserUserAgent
		) as 
		(
			select 
				[Login],
				Email,
				PasswordHash,
				FullName,
				GenderName, 
				DateOfBirth,
				COALESCE(RegisterDateTime, LastActiveDateTime, SYSDATETIME()),
				ISNULL(LastActiveDateTime, SYSDATETIME()),
	
				IPAddress,
				SessionDateTime,
				BrowserUserAgent
			from openjson(@newUserRegisrtationJson)
			with
			(
				[Login]				nvarchar(20)	N'$.User.Login',
				Email				nvarchar(50)	N'$.User.Email',
				PasswordHash		char(64)		N'$.User.PasswordHash',
				FullName			nvarchar(100)	N'$.User.FullName',
				GenderName			nvarchar(30)	N'$.User.Gender.GenderName', 
				DateOfBirth			date			N'$.User.DateOfBirth',
				RegisterDateTime	datetime2		N'$.User.RegisterDateTime',
				LastActiveDateTime	datetime2		N'$.User.LastActiveDateTime',
	
				IpAddress			nvarchar(15)	N'$.Guest.IpAddress',
				SessionDateTime		datetime2		N'$.Guest.SessionDateTime',
				BrowserUserAgent	nvarchar(200)	N'$.Guest.BrowserUserAgent'
			)
		)
	
		insert into #NewUserRegistrationData
		(
			[Login],
			Email,
			PasswordHash,
			FullName,
			GenderId,			
			DateOfBirth,
			UserRoleId,
			RegisterDateTime,
			LastActiveDateTime,
	
			IPAddress,
			SessionDateTime,
			BrowserUserAgent
		)
		select
			nu.[Login],
			nu.Email,
			nu.PasswordHash,
			nu.FullName,
			g.GenderId,			
			nu.DateOfBirth,
			ur.UserRoleId,
			nu.RegisterDateTime,
			nu.LastActiveDateTime,
	
			nu.IPAddress,
			nu.SessionDateTime,
			nu.BrowserUserAgent
		from cte_NewUserRegistration as nu
		inner join Genders as g on nu.GenderName = g.GenderName
		inner join UserRoles as ur on ur.UserRole = 'Regular'

		declare @phones nvarchar(max)
		set @phones = (	select [value]
						from openjson(@newUserRegisrtationJson, N'$.User')
						where [key] = 'Phones')
						-- ПРОВЕРКА НА NULL  НЕ НУЖНА ЛИ?

		begin transaction
				
			-- import New Phones To dbo.Phones
			exec dbo.usp_ImportPhonesFromJson
				@phones


			--insert User into dbo.Users if new
			insert into dbo.Users
			(
				[Login],
				Email,
				PasswordHash,
				FullName,
				GenderId,			
				DateOfBirth,
				UserRoleId,
				RegisterDateTime,
				LastActiveDateTime
			)
			select	nu.[Login],
					nu.Email,
					nu.PasswordHash,
					nu.FullName,
					nu.GenderId,
					nu.DateOfBirth,
					nu.UserRoleId,
					nu.RegisterDateTime,
					nu.LastActiveDateTime
			from #NewUserRegistrationData as NU
			left join dbo.Users as u on nu.[Login] = u.[Login]
			where u.[Login] is null AND nu.[Login] is not null

			-- insert Guest (Set AuthorizedUser = User Id)
			insert into dbo.Guests
			(
				IPAddress,
				SessionDateTime,
				BrowserUserAgent,
				AuthorizedUser
			)
			select	ng.IPAddress,
					ng.SessionDateTime,
					ng.BrowserUserAgent,
					u.UserId
			from #NewUserRegistrationData as ng
			inner join dbo.Users as u on ng.[Login] = u.[Login]
			left join dbo.Guests as g on 
					(ng.IPAddress = g.IPAddress AND 
					 ng.SessionDateTime = g.SessionDateTime AND 
					 ng.BrowserUserAgent = g.BrowserUserAgent)
			where	(ng.IPAddress is not null AND g.IPAddress is null AND 
					ng.SessionDateTime is not null AND g.SessionDateTime is null AND 
					ng.BrowserUserAgent is not null AND g.BrowserUserAgent is null)
					
			-- insert UsersPhoneLink (get PhoneId's from Phones)

			insert into dbo.UsersPhonesLink
			(
				UserId,
				PhoneId
			)
			select	u.UserId,
					ph.PhoneId
			from #NewUserRegistrationData as nu
			inner join dbo.Users as u on nu.[Login] = u.[Login]
			outer apply 
				openjson(@phones) 
				with (	PhNumber		nvarchar(20)  	N'$.PhoneNumber'  )
			left join dbo.Phones as ph on ph.PhoneNumber = PhNumber
			left join dbo.UsersPhonesLink as upl
				   on upl.PhoneId = ph.PhoneId AND
				      upl.UserId  = u.UserId
			where upl.PhoneId is null AND upl.UserId is null AND
				  ph.PhoneId is not null AND u.UserId is not null

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
use [MedCenterDB]
go

if OBJECT_ID('dbo.usp_RecordToVisit', 'P') is not null
    drop procedure dbo.usp_RecordToVisit
go
---------------------------------------------------------------------------------------
-- procedure records patient to the visit (from staffer side)
-- created by:   Alexander Tykoun
-- created date: 10/21/2022
-- sample call: 
-- exec dbo.usp_RecordToVisit @params =
--N'
--{
--   "Staffer": {
--        "Login": "StafferLogin",
--        "PasswordHash": "9871827B34A35D53C983FF"     },
--   "Patient": {
--        "Login": "UserLogin",
--		  "PasswordHash": "9871827B34A35D53C983FF"     },
--   "Visit": {
--        "Specialist": { "Login":  "StafferLogin" },
--		  "RecordDateTime": "2022-10-04T18:28:42.8903578+03:00",
--		  "ScheduledDateTime": "2022-10-04T18:28:42.8903578+03:00"  }
--}
--'
---------------------------------------------------------------------------------

create proc [dbo].usp_RecordToVisit(
    @recToVisit nvarchar(max)
)
as
begin
	if (ISJSON(@recToVisit) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try

--		if OBJECT_ID('tempdb..#RecordData', 'U') is  not null
--		drop table #RecordData;
		
		create table #RecordData
		(	
			VisitId					int,
			PatientId				int,
			RecordDateTime			datetime2,
			PassFlag				bit

		);

		with cte_RecordJson
		(
			StafferLogin,
			StafferPass,
			PatientLogin,
			PatientPass,
			SpecialistLogin,
			VisitDateTime,
			RecordDateTime
		) as
		(
			select 
				StafferLogin,
				StafferPass,
				PatientLogin,
				PatientPass,
				SpecialistLogin,
				VisitDateTime,
				ISNULL(RecordDateTime, SYSDATETIME())
			from openjson(@recToVisit)
			with
			(			
				StafferLogin			nvarchar(20)		N'$.Staffer.Login',
				StafferPass				char(64)			N'$.Staffer.PasswordHash',
				PatientLogin			nvarchar(20)		N'$.Patient.Login',
				PatientPass				char(64)			N'$.Patient.PasswordHash',
				SpecialistLogin			nvarchar(20)		N'$.Visit.Specialist.Login',
				VisitDateTime			datetime2			N'$.Visit.ScheduledDateTime',
				RecordDateTime			datetime2			N'$.Visit.RecordDateTime'
			)
		)
	insert into #RecordData
		(
			PatientId,
			VisitId,
			RecordDateTime,
			PassFlag
		)
		select
			p.PatientId,
			v.VisitId,
			tmp.RecordDateTime,
			case when patpass.PasswordHash is null AND reg.PasswordHash is null then 0 else 1 end
		from cte_RecordJson as tmp
			inner join Users as pu on pu.[Login] = tmp.PatientLogin
			inner join Patients as p on p.PatientUserId = pu.UserId
			inner join Users as su on su.[Login] = tmp.SpecialistLogin
			inner join Staffers as s on s.StafferUserId = su.UserId
			inner join Visits as v on v.Specialist = s.StafferId AND v.ScheduledDateTime = tmp.VisitDateTime
			left join Users as patpass on patpass.[Login] = tmp.PatientLogin AND patpass.PasswordHash = tmp.PatientPass
			left join Users as reg on reg.[Login] = tmp.StafferLogin AND reg.PasswordHash = tmp.StafferPass
			left join Staffers as regs on regs.StafferUserId = reg.UserId


			if 0 = (select distinct PassFlag from #RecordData)
		begin
			print 'Verification is not passed.'
			return
		end

			if exists (select 1 from Visits v inner join #RecordData tmp on v.VisitId = tmp.VisitId AND v.RecordedPatient is not null)
		begin
			print 'Sorry. Visit is booked already.'
			return
		end

		begin transaction
--upsert Visits
			update dbo.Visits
			set RecordedPatient = tmp.PatientId,
				RecordDateTime = tmp.RecordDateTime
			from Visits as v 
			inner join #RecordData as tmp on (tmp.VisitId = v.VisitId)

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


use [MedCenterDB]
go

if OBJECT_ID('dbo.usp_RecordToVisitByPatient', 'P') is not null
    drop procedure dbo.usp_RecordToVisitByPatient
go
---------------------------------------------------------------------------------------
-- procedure records patient to the visit (from patient side)
-- created by:   Alexander Tykoun
-- created date: 10/10/2022
-- sample call: 
-- exec dbo.usp_RecordToVisitByPatient @params =
--N'
--{
--   "Patient": {
--        "Login": "UserWithAdminRole",
--        "PasswordHash": "9871827B34A35D53C983FF"    },
--   "Visit": {
--        "Specialist": { "Login":  "StafferLogin" },
--		  "RecordDateTime": "2022-10-04T18:28:42.8903578+03:00",
--		  "ScheduledDateTime": "2022-10-04T18:28:42.8903578+03:00"  }
--}
--'
---------------------------------------------------------------------------------

create proc [dbo].usp_RecordToVisitByPatient(
    @recToVisitByPatient nvarchar(max)
)
as
begin
	if (ISJSON(@recToVisitByPatient) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try

--		if OBJECT_ID('tempdb..#RecordByPatient', 'U') is  not null
--		drop table #RecordByPatient;
		
		create table #RecordByPatient
		(	
			VisitId					int,
			PatientId				int,
			RecordDateTime			datetime2
		);

		with cte_RecByPatient
		(
			PatientLogin,
			PatientPass,
			SpecialistLogin,
			VisitDateTime,
			RecordDateTime
		) as
		(
			select 
				PatientLogin,
				PatientPass,
				SpecialistLogin,
				VisitDateTime,
				ISNULL(RecordDateTime, SYSDATETIME())
			from openjson(@recToVisitByPatient)
			with
			(			
				PatientLogin			nvarchar(20)		N'$.Patient.Login',
				PatientPass				char(64)			N'$.Patient.PasswordHash',
				SpecialistLogin			nvarchar(20)		N'$.Visit.Specialist.Login',
				VisitDateTime			datetime2			N'$.Visit.ScheduledDateTime',
				RecordDateTime			datetime2			N'$.Visit.RecordDateTime'
			)
		)

	insert into #RecordByPatient
		(
			PatientId,
			VisitId,
			RecordDateTime
		)
		select
			p.PatientId,
			v.VisitId,
			tmp.RecordDateTime
		from cte_RecByPatient as tmp
			inner join Users as pu on pu.[Login] = tmp.PatientLogin AND pu.PasswordHash = tmp.PatientPass
			inner join Patients as p on p.PatientUserId = pu.UserId
			inner join Users as su on su.[Login] = tmp.SpecialistLogin
			inner join Staffers as s on s.StafferUserId = su.UserId
			inner join Visits as v on v.Specialist = s.StafferId AND v.ScheduledDateTime = tmp.VisitDateTime

		if exists (select 1 from Visits v inner join #RecordByPatient tmp on v.VisitId = tmp.VisitId AND v.RecordedPatient is not null)
		begin
			print 'Sorry. Visit is booked already.'
			return
		end
		
		begin transaction
--upsert Visits
			update dbo.Visits
			set RecordedPatient = tmp.PatientId,
				RecordDateTime = tmp.RecordDateTime
			from Visits as v 
			inner join #RecordByPatient as tmp on (tmp.VisitId = v.VisitId)

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

use [MedCenterDB]
go

if OBJECT_ID('dbo.usp_RecordToVisitByStaffer', 'P') is not null
    drop procedure dbo.usp_RecordToVisitByStaffer
go
---------------------------------------------------------------------------------------
-- procedure records patient to the visit (from staffer side)
-- created by:   Alexander Tykoun
-- created date: 10/10/2022
-- sample call: 
-- exec dbo.usp_RecordToVisitByStaffer @params =
--N'
--{
--   "Staffer": {
--        "Login": "StafferLogin",
--        "PasswordHash": "9871827B34A35D53C983FF"     },
--   "Patient": {
--        "Login": "UserLogin"				   },
--   "Visit": {
--        "Specialist": { "Login":  "StafferLogin" },
--		  "RecordDateTime": "2022-10-04T18:28:42.8903578+03:00",
--		  "ScheduledDateTime": "2022-10-04T18:28:42.8903578+03:00"  }
--}
--'
---------------------------------------------------------------------------------

create proc [dbo].usp_RecordToVisitByStaffer(
    @recToVisitByStaffer nvarchar(max)
)
as
begin
	if (ISJSON(@recToVisitByStaffer) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try

--		if OBJECT_ID('tempdb..#RecordByStaffer', 'U') is  not null
--		drop table #RecordByStaffer;
		
		create table #RecordByStaffer
		(	
			VisitId					int,
			PatientId				int,
			RecordDateTime			datetime2
		);

		with cte_RecByStaffer
		(
			StafferLogin,
			StafferPass,
			PatientLogin,
			SpecialistLogin,
			VisitDateTime,
			RecordDateTime
		) as
		(
			select 
				StafferLogin,
				StafferPass,
				PatientLogin,
				SpecialistLogin,
				VisitDateTime,
				ISNULL(RecordDateTime, SYSDATETIME())
			from openjson(@recToVisitByStaffer)
			with
			(			
				StafferLogin			nvarchar(20)		N'$.Staffer.Login',
				StafferPass				char(64)			N'$.Staffer.PasswordHash',
				PatientLogin			nvarchar(20)		N'$.Patient.Login',
				SpecialistLogin			nvarchar(20)		N'$.Visit.Specialist.Login',
				VisitDateTime			datetime2			N'$.Visit.ScheduledDateTime',
				RecordDateTime			datetime2			N'$.Visit.RecordDateTime'
			)
		)
		
	insert into #RecordByStaffer
		(
			PatientId,
			VisitId,
			RecordDateTime
		)
		select
			p.PatientId,
			v.VisitId,
			tmp.RecordDateTime
		from cte_RecByStaffer as tmp
			inner join Users as pu on pu.[Login] = tmp.PatientLogin
			inner join Patients as p on p.PatientUserId = pu.UserId
			inner join Users as su on su.[Login] = tmp.SpecialistLogin
			inner join Staffers as s on s.StafferUserId = su.UserId
			inner join Users as reg on reg.[Login] = tmp.StafferLogin AND reg.PasswordHash = tmp.StafferPass
			inner join Staffers as regs on regs.StafferUserId = reg.UserId
			inner join Visits as v on v.Specialist = s.StafferId AND v.ScheduledDateTime = tmp.VisitDateTime

		if exists (select 1 from Visits v inner join #RecordByStaffer tmp on v.VisitId = tmp.VisitId AND v.RecordedPatient is not null)
		begin
			print 'Sorry. Visit is booked already.'
			return
		end
		
		begin transaction
--upsert Visits
			update dbo.Visits
			set RecordedPatient = tmp.PatientId,
				RecordDateTime = tmp.RecordDateTime
			from Visits as v 
			inner join #RecordByStaffer as tmp on (tmp.VisitId = v.VisitId)

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

use MedCenterDB
go

if OBJECT_ID('dbo.usp_RegisterUserAsPatient', 'P') is not null
    drop procedure dbo.usp_RegisterUserAsPatient
go

---------------------------------------------------------------------------------------
-- procedure creates Patient assigned to User 
-- created by:   Alexander Tykoun
-- created date: 10/07/2022
-- sample call: 
-- exec dbo.usp_RegisterUserAsPatient @params =
--N'
--{
--  "User": {
--      "Login": "UserLogin"				},
--  "PatientInfo": {
--    "PatientPassport": "MP0000000",
--    "PatientStatus": { "PatientStatus": "VIP/Discount/Regular"  },
--    "PatientHomeAddress": "City, Street, Building",
--    "InsurancePolicy": "Policy Info",									-- optional
--    "Photo": "https://robohash.org/set_set1/bgset_bg2/2294dhdg",		-- optional
--    "ChronicDeseases": "ChronicInfo",									-- optional
--    "IndividualNotes": "Clautrophobia",								-- optional
--    "InnerComment": "Too Emotional",									-- optional
--    "RegisterDateTime": "2022-10-04T18:28:42.8903578+03:00"    }		-- optional
--  "Registrator": {
--      "Login": "StafferLogin",
--      "PasswordHash": "ADADADADADADADADADAD"   }
--  }
--}
--'
---------------------------------------------------------------------------------------

create proc dbo.usp_RegisterUserAsPatient(
    @patientRegisterJson nvarchar(max)
)
as
begin
	if (ISJSON(@patientRegisterJson) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try

--		if OBJECT_ID('tempdb..#PatientRegistrationData', 'U') is  not null
--		drop table #PatientRegistrationData;
		
		create table #PatientRegistrationData
		(	
			UserId				nvarchar(20),
			PatientStatusId		tinyint,
			Passport			nvarchar(10),
			HomeAddress			nvarchar(100),
			Insurance			nvarchar(30),
			Photo				nvarchar(200), 
			ChronicDeseases		nvarchar(200),
			IndividualNotes		nvarchar(200),
			InnerComment		nvarchar(200),
			RegisterDateTime	datetime2,
			RegistratorId		int
		);

		with cte_PatientRegistration
		(
			[Login],
			Passport,
			PatientStatus,
			HomeAddress,
			Insurance,
			Photo,
			Chronic,
			IndividualNotes,
			InnerComment,
			RegisterDateTime,
			RegistratorLogin,
			RegistratorHash
		) as 
		(
			select 
				[Login],
				Passport,
				ISNULL (PatientStatus,'Regular'),
				HomeAddress,
				Insurance,
				ISNULL (Photo, 'https://robohash.org/set_set1/bgset_bg2/NoAvatar'),
				Chronic,
				IndividualNotes,
				InnerComment,
				RegisterDateTime,
				RegistratorLogin,
				RegistratorHash
			from openjson(@patientRegisterJson)
			with
			(
				[Login]				nvarchar(20)	N'$.User.Login',
				Passport			nvarchar(10)	N'$.PatientInfo.PatientPassport',
				PatientStatus		nvarchar(30)	N'$.PatientInfo.PatientStatus.PatientStatus',
				HomeAddress			nvarchar(100)	N'$.PatientInfo.PatientHomeAddress',
				Insurance			nvarchar(200)	N'$.PatientInfo.InsurancePolicy',
				Photo				nvarchar(200)	N'$.PatientInfo.Photo',
				Chronic				nvarchar(200)	N'$.PatientInfo.ChronicDeseases',
				IndividualNotes		nvarchar(200)	N'$.PatientInfo.IndividualNotes',
				InnerComment		nvarchar(200)	N'$.PatientInfo.InnerComment',
				RegisterDateTime	datetime2		N'$.PatientInfo.RegisterDateTime',
				RegistratorLogin	nvarchar(20)	N'$.Registrator.Login',
				RegistratorHash		char(64)		N'$.Registrator.PasswordHash'
			)
		)
	
		insert into #PatientRegistrationData
		(
			UserId,
			PatientStatusId,
			Passport,
			HomeAddress,
			Insurance,
			Photo, 
			ChronicDeseases,
			IndividualNotes,
			InnerComment,
			RegisterDateTime,
			RegistratorId
		)
		select
				u.UserId,
				ps.PatientStatusId,
				tmp.Passport,				
				tmp.HomeAddress,
				tmp.Insurance,
				tmp.Photo,
				tmp.Chronic,
				tmp.IndividualNotes,
				tmp.InnerComment,
				tmp.RegisterDateTime,
				reg.UserId
		from cte_PatientRegistration as tmp
		inner join Users as u on u.[Login] = tmp.[Login]
		inner join Users as reg on reg.[Login] = tmp.[RegistratorLogin] AND reg.PasswordHash = tmp.RegistratorHash
		inner join Staffers as sreg on sreg.StafferUserId = reg.UserId	
		inner join PatientStatuses as ps on ps.PatientStatus = tmp.PatientStatus
		where u.UserId not in 
			  (	select StafferUserId from Staffers )

		begin transaction
	
--insert Patient 
			insert into dbo.Patients
			(
				PatientUserId,
				PatientPassport,
				PatientStatusId,
				PatientHomeAddress,
				InsurancePolicy,
				Photo,
				ChronicDeseases,
				IndividualNotes, 
				InnerComment,
				RegisterDateTime,
				PatientRegistrator
			)
			select	
					UserId,
					Passport,
					PatientStatusId,
					HomeAddress,
					Insurance,
					Photo,
					ChronicDeseases,
					IndividualNotes,
					InnerComment,
					RegisterDateTime,
					RegistratorId
			from #PatientRegistrationData

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
use MedCenterDB
go

if OBJECT_ID('dbo.usp_RegisterUserAsStaffer', 'P') is not null
    drop procedure dbo.usp_RegisterUserAsStaffer
go

---------------------------------------------------------------------------------------
-- procedure creates Staffer assigned to User and Administrator
-- created by:   Alexander Tykoun
-- created date: 10/04/2022
-- sample call: 
-- exec dbo.usp_RegisterUserAsStaffer @params =
--N'
--{
--  "User": {
--      "Login": "UserLogin"				},
--  "StafferInfo": {
--    "StafferPassport": "MP0000000",
--    "StafferGroup": { "StafferGroup": "Receptionists"  },
--    "MedicalCategory": { "MedicalCategory": "No Category" },
--    "StafferHomeAddress": "City, Street, Building",
--    "ShortSummary": "Education, Expierience",							-- optional
--    "Speciality": { "Speciality": "Non-Medical"  },
--    "Photo": "https://robohash.org/set_set1/bgset_bg2/2294dhdg",		-- optional
--    "RegisterDateTime": "2022-10-04T18:28:42.8903578+03:00",			-- optional
--    "PersonalNotes": "Lorem Ipsum Mood"       },						-- optional
--  "Registrator": {
--      "Login": "AdminLogin",
--      "PasswordHash": "ADADADADADADADADADAD"   }
--  }
--}
--'
---------------------------------------------------------------------------------------

create proc dbo.usp_RegisterUserAsStaffer(
    @stafferRegisterJson nvarchar(max)
)
as
begin
	if (ISJSON(@stafferRegisterJson) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try

--		if OBJECT_ID('tempdb..#StafferRegistrationData', 'U') is  not null
--		drop table #StafferRegistrationData;
		
		create table #StafferRegistrationData
		(	
			UserId				nvarchar(20),
			GroupId				tinyint,
			Passport			nvarchar(10),
			HomeAddress			nvarchar(100),
			Summary				nvarchar(200),
			SpecialityId		tinyint,
			MedicalCategoryId	tinyint,
			Photo				nvarchar(200), 
			PersonalNotes		nvarchar(200),
			RegisterDateTime	datetime2,
			RegistratorId		int
		);

		with cte_StafferRegistration
		(
			[Login],
			Passport,
			GroupName,
			CategoryName,
			HomeAddress,
			Summary,
			SpecialityName,
			Photo,
			RegisterDateTime,
			PersonalNotes,
			RegistratorLogin,
			RegistratorHash
		) as 
		(
			select 
				[Login],
				Passport,
				GroupName,
				CategoryName,
				HomeAddress,
				Summary,
				SpecialityName,
				ISNULL (Photo, 'https://robohash.org/set_set1/bgset_bg2/NoAvatar'),
				ISNULL(RegisterDateTime, SYSDATETIME()),
				PersonalNotes,
				RegistratorLogin,
				RegistratorHash
			from openjson(@stafferRegisterJson)
			with
			(
				[Login]				nvarchar(20)	N'$.User.Login',
				Passport			nvarchar(10)	N'$.StafferInfo.StafferPassport',
				GroupName			nvarchar(30)	N'$.StafferInfo.StafferGroup.StafferGroup',
				CategoryName		nvarchar(30)	N'$.StafferInfo.MedicalCategory.MedicalCategory',
				HomeAddress			nvarchar(100)	N'$.StafferInfo.StafferHomeAddress',
				Summary				nvarchar(200)	N'$.StafferInfo.ShortSummary',
				SpecialityName		nvarchar(30)	N'$.StafferInfo.Speciality.Speciality',
				Photo				nvarchar(200)	N'$.StafferInfo.Photo',
				RegisterDateTime	datetime2		N'$.StafferInfo.RegisterDateTime',
				PersonalNotes		nvarchar(200)	N'$.StafferInfo.PersonalNotes',
				RegistratorLogin	nvarchar(20)	N'$.Registrator.Login',
				RegistratorHash		char(64)		N'$.Registrator.PasswordHash'
			)
		)
	
		insert into #StafferRegistrationData
		(
			UserId,
			GroupId,
			Passport,
			HomeAddress,
			Summary,
			SpecialityId,
			MedicalCategoryId,
			Photo, 
			PersonalNotes,
			RegisterDateTime,
			RegistratorId
		)
		select
			u.UserId,
			gro.StafferGroupId,
			tmp.Passport,
			tmp.HomeAddress,
			tmp.Summary,
			spec.SpecialityId,
			mcat.MedicalCategoryId,
			tmp.Photo, 
			tmp.PersonalNotes,
			tmp.RegisterDateTime,
			reg.UserId
		from cte_StafferRegistration as tmp
		inner join StafferGroups as gro on gro.StafferGroup = tmp.GroupName
		inner join Specialities as spec on spec.Speciality = tmp.SpecialityName
		inner join MedicalCategories as mcat on mcat.MedicalCategory = tmp.CategoryName
		inner join Users as u on u.[Login] = tmp.[Login]
		inner join Users as reg on reg.[Login] = tmp.[RegistratorLogin] AND reg.PasswordHash = tmp.RegistratorHash
		inner join UserRoles as ur on (reg.UserRoleId = ur.UserRoleId AND ur.UserRole = 'Administrator')	

		begin transaction
	
--insert Staffer 
			insert into dbo.Staffers
			(
				StafferUserId,
				StafferGroupId,
				StafferPassport,
				StafferHomeAddress,
				ShortSummary,
				SpecialityId,
				MedicalCategoryId,
				Photo, 
				PersonalNotes,
				RegisterDateTime,
				StafferRegistrator
			)
			select	UserId,
					GroupId,
					Passport,
					HomeAddress,
					Summary,
					SpecialityId,
					MedicalCategoryId,
					Photo,
					PersonalNotes,
					RegisterDateTime,
					RegistratorId
			from #StafferRegistrationData

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
use MedCenterDB
go

if OBJECT_ID('dbo.usp_ScheduleVisit', 'P') is not null
    drop procedure dbo.usp_ScheduleVisit
go

---------------------------------------------------------------------------------------
-- procedure creates blank scheduled visit for Specialist
-- created by:   Alexander Tykoun
-- created date: 10/04/2022
-- sample call: 
-- exec dbo.usp_ScheduleVisit @params =
--N'
--{
--   "Staffer": {
--        "Login": "StafferLogin",   
--        "PasswordHash": "9871827B34A35D53C983FF"      },
--   "BaseService": {  "ServiceName": "NameOfService1"  },
--   "Specialist": {   "Login": "SpecialistLogin"       },
--   "VisitInfo": {
--        "ScheduledDateTime": "2022-10-04T18:28:42.8903578+03:00",
--        "PreliminaryNotes": "Visit Prescriptions",
--        "VisitType": { "VisitType": "Consultation/Examination/Test Taking/Operation" },
--        "VisitStatus": { "VisitStatus": "Planned/Canceled/Postponed/Rejected/Finished/Extended " },
--        "Summary": "Visit Summary",
--        "PaymentState": { "PaymentState": "Not Paid/Completely Paid/Rejected/Delayed"},
--        "InternalComment": "Text from Specialist to Colleagues" },		--optional
--   "Assistants": [														--optional
--                  { "Login": "StafferUser1"  },							--optional
--                  { "Login": "StafferUser2"  },       ],					--optional
--   "Room": {  "RoomName": "NameOfRoom"                }
--}
--'
---------------------------------------------------------------------------------------

create proc dbo.usp_ScheduleVisit(
    @scheduleVisitJson nvarchar(max)
)
as
begin
	if (ISJSON(@scheduleVisitJson) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try

--		if OBJECT_ID('tempdb..#ScheduledVisitData', 'U') is  not null
--		drop table #ScheduledVisitData;
		
		create table #ScheduledVisitData
		(	
			SpecialistId		int,
			ServiceId			int,
			ScheduledDateTime	datetime2,
			PreliminaryNotes	nvarchar(300),
			Summary				nvarchar(300),
			VisitRoomId			int,
			VisitTypeId			tinyint,
			VisitStatusId		tinyint,
			PaymentStateId		tinyint,
			InternalComment		nvarchar(200),
			AssistantId			int,
			TotalPrice			money
		);

		with cte_ScheduleVisit
		(
			StafferLogin,
			StafferPass,
			BaseServiceName,
			SpecialistLogin,
			ScheduledDateTime,
			Preliminary,
			VisitType,
			VisitStatus,
			Summary,
			PaymentState,
			InternalComment,
			RoomName,
			AssistantLogin
		) as 
		(
			select 
				StafferLogin,
				StafferPass,
				BaseServiceName,
				ISNULL(SpecialistLogin, StafferLogin),
				ScheduledDateTime,
				Preliminary,
				VisitType,
				VisitStatus,
				Summary,
				PaymentState,
				InternalComment,
				RoomName,
				AssistantLogin
			from openjson(@scheduleVisitJson)
			with
			(
				StafferLogin		nvarchar(20)	N'$.Staffer.Login',
				StafferPass			char(64)		N'$.Staffer.PasswordHash',
				BaseServiceName		nvarchar(30)	N'$.BaseService.ServiceName',
				SpecialistLogin		nvarchar(20)	N'$.Specialist.Login',
				ScheduledDateTime	datetime2		N'$.VisitInfo.ScheduledDateTime',
				Preliminary			nvarchar(300)	N'$.VisitInfo.PreliminaryNotes',
				VisitType			nvarchar(30)	N'$.VisitInfo.VisitType.VisitType',
				VisitStatus			nvarchar(30)	N'$.VisitInfo.VisitStatus.VisitStatus',
				Summary				nvarchar(300)	N'$.VisitInfo.Summary',
				PaymentState		nvarchar(30)	N'$.VisitInfo.PaymentState.PaymentState',
				InternalComment		nvarchar(200)	N'$.VisitInfo.Summary',
				RoomName			nvarchar(20)	N'$.Room.RoomName',
				Assistants			nvarchar(max)	N'$.Assistants' as json
			)
			outer apply openjson(Assistants) with
			(	AssistantLogin         nvarchar(20)    N'$.Login' )
		)
	
		insert into #ScheduledVisitData
		(
			SpecialistId,
			ServiceId,
			ScheduledDateTime,
			PreliminaryNotes,
			Summary,
			VisitRoomId,
			VisitTypeId,
			VisitStatusId,
			PaymentStateId,
			InternalComment,
			AssistantId,
			TotalPrice
		)
		select 
			spec.StafferId,
			serv.ServiceId,
			tmp.ScheduledDateTime,
			tmp.Preliminary,
			tmp.Summary,
			r.RoomId,
			vt.VisitTypeId,
			vs.VisitStatusId,
			ps.PaymentStateId,
			tmp.InternalComment,
			staffassist.StafferId,
			serv.Price
		from cte_ScheduleVisit as tmp
		inner join Users as reg on reg.[Login] = tmp.StafferLogin AND reg.PasswordHash = tmp.StafferPass
		inner join Staffers as st on st.StafferUserId = reg.UserId	
		inner join Users as specuser on specuser.[Login] = tmp.SpecialistLogin 
		inner join Staffers as spec on spec.StafferUserId = specuser.UserId	
		inner join [Services] as serv on tmp.BaseServiceName = serv.ServiceName
		inner join VisitTypes as vt on tmp.VisitType = vt.VisitType
		inner join VisitStatuses as vs on tmp.VisitStatus = vs.VisitStatus
		inner join PaymentStates as ps on tmp.PaymentState = ps.PaymentState
		left join Users as assist on tmp.AssistantLogin = assist.[Login]
		left join Staffers as staffassist on staffassist.StafferUserId = assist.UserId
		left join Rooms as r on r.RoomName = tmp.RoomName

		begin transaction
	
--insert Visit 
			insert into dbo.Visits
			(
				BaseService,
				Specialist,
				ScheduledDateTime,
				PreliminaryNotes,
				VisitRoom,
				Summary,
				TotalPrice,
				PaymentStateId,
				VisitTypeId,
				VisitStatusId,
				InternalComment
			)
			select distinct	
				tmp.ServiceId,
				tmp.SpecialistId,
				tmp.ScheduledDateTime,
				tmp.PreliminaryNotes,
				tmp.VisitRoomId,
				tmp.Summary,
				tmp.TotalPrice,
				tmp.PaymentStateId,
				tmp.VisitTypeId,
				tmp.VisitStatusId,
				tmp.InternalComment
			from #ScheduledVisitData as tmp

--insert StaffersVisitsLink
			
			insert into dbo.StaffersVisitsLink
			(
				StafferId,
				VisitId
			)
			select
				tmp.AssistantId,
				v.VisitId
			from #ScheduledVisitData as tmp 
			inner join Visits as v on (v.ScheduledDateTime = tmp.ScheduledDateTime AND v.Specialist = tmp.SpecialistId)
			inner join Staffers as s on (s.StafferId = tmp.AssistantId)
			left join StaffersVisitsLink as svl on (svl.VisitId = v.VisitId AND svl.StafferId = tmp.SpecialistId)
			where svl.VisitId is null	  AND svl.StafferId		is null AND
					v.VisitId is not null AND tmp.SpecialistId  is not null

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
use [MedCenterDB]
go

if OBJECT_ID('dbo.usp_SetServicesForEquipments', 'P') is not null
    drop procedure dbo.usp_SetServicesForEquipments
go
---------------------------------------------------------------------------------------
-- procedure assigns list of services to each equipment in list
-- created by:   Alexander Tykoun
-- created date: 10/07/2022
-- sample call: 
-- exec dbo.usp_SetServicesForEquipments @params =
--N'
--{
--  "Admin": {
--    "Login": "Tykooon",
--    "PasswordHash": "20e0dckdjc02kdcjlaksdca" },
--  "Equipments": [
--    { "InventaryNumber": "PC111-222" },
--    { "InventaryNumber": "PC333-444" },
--    { "InventaryNumber": "PC555-666" },
--    { "InventaryNumber": "PC777-888" },
--    { "InventaryNumber": "PC999-000" }                    ],
--  "Services": [
--    { "ServiceName": "Therapist Consultation" },
--    { "ServiceName": "Cardiologist Consultation" }        ]
--}
--'
---------------------------------------------------------------------------------------





create proc [dbo].[usp_SetServicesForEquipments](
    @setServicesForEquipmentJson nvarchar(max)
)
as
begin
	if (ISJSON(@setServicesForEquipmentJson) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try

--		if OBJECT_ID('tempdb..#NewUserRegistrationData', 'U') is  not null
--		drop table #NewUserRegistrationData;
		
		create table #SetServicesForEquipmentsData
		(	
			EquipmentId				int,
			ServiceId				int
		);

		with cte_SetServicesForEquipments
		(
			AdminLogin,
			AdminPass,
			InventaryNumber,
			ServiceName
		) as
		(
			select 
				AdminLogin,
				AdminPass,
				InventaryNumber,
				ServiceName
			from openjson(@setServicesForEquipmentJson)
			with
			(			
				AdminLogin				nvarchar(20)		N'$.Admin.Login',
				AdminPass				char(64)			N'$.Admin.PasswordHash',
				[Equipments]		    nvarchar(max)		N'$.Equipments' as json,
				[Services]				nvarchar(max)		N'$.Services' as json
			)
			outer apply openjson([Services]) with
					(
						ServiceName			nvarchar(50)	N'$.ServiceName'
					)
			outer apply openjson([Equipments]) with
					(
						InventaryNumber		nvarchar(15)	N'$.InventaryNumber'
					)
		)

	insert into #SetServicesForEquipmentsData
		(
			EquipmentId,
			ServiceId
		)
		select
			e.EquipmentId,
			s.ServiceId
		from cte_SetServicesForEquipments as tmp
			inner join [Equipments] as e on e.InventaryNumber = tmp.InventaryNumber
			inner join [Services] as s on s.ServiceName = tmp.ServiceName
			inner join Users as adm on adm.[Login] = tmp.[AdminLogin] AND adm.PasswordHash = tmp.AdminPass
			inner join UserRoles as ur on (adm.UserRoleId = ur.UserRoleId AND ur.UserRole = 'Administrator')	

		begin transaction

--insert EquipmentsServicesLink

			insert into dbo.EquipmentsServicesLink
			(
				EquipmentId,
				ServiceId
			)
			select 
				tmp.EquipmentId,
				tmp.ServiceId
			from #SetServicesForEquipmentsData as tmp			
			left join dbo.EquipmentsServicesLink as esl
				   on esl.EquipmentId = tmp.EquipmentId AND
				      esl.ServiceId  = tmp.ServiceId
			where esl.EquipmentId is null AND esl.ServiceId is null AND
				  tmp.EquipmentId is not null AND tmp.ServiceId is not null			  				   				   

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

use MedCenterDB
go

if OBJECT_ID('dbo.usp_UserAuthorization', 'P') is not null
    drop procedure dbo.usp_UserAuthorization
go

---------------------------------------------------------------------------------------
-- procedure authorizes existing user and updates LAstActiveDateTime
-- created by:   Alexander Tykoun
-- created date: 10/03/2022
-- sample call: 
-- exec dbo.usp_UserAuthorization @params =
--N'
--{
--  "Guest": { 
--    "IpAddress": "122.34.25.34",
--    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
--    "SessionDateTime": "2022-09-27T19:35:33.6578067+03:00"
--  },
--  "User": {
--    "Login": "Tykooon",
--    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
--    }
--}
--'
---------------------------------------------------------------------------------------

create proc dbo.usp_UserAuthorization(
    @UserAuthorizationJson nvarchar(max)
)
as
begin
	if (ISJSON(@UserAuthorizationJson) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try

--		if OBJECT_ID('tempdb..#UserAuthorizationData', 'U') is  not null
--		drop table #UserAuthorizationData;
		
		create table #UserAuthorizationData
		(	
			UserId					int,
			[Login]					nvarchar(20),
			PasswordHash			char(64),

			IPAddress				nvarchar(15),
			SessionDateTime			datetime2,
			BrowserUserAgent		nvarchar(200)
		);		
		
		with cte_UserAuthorization
		(
			[Login],
			PasswordHash,

			IPAddress,
			SessionDateTime,
			BrowserUserAgent
		) as 
		(
			select 
				[Login],
				PasswordHash,

				IPAddress,
				SessionDateTime,
				BrowserUserAgent
			from openjson(@UserAuthorizationJson)
			with
			(
				[Login]				nvarchar(20)	N'$.User.Login',
				PasswordHash		char(64)		N'$.User.PasswordHash',
	
				IpAddress			nvarchar(15)	N'$.Guest.IpAddress',
				SessionDateTime		datetime2		N'$.Guest.SessionDateTime',
				BrowserUserAgent	nvarchar(200)	N'$.Guest.BrowserUserAgent'
			)
		)
	
		insert into #UserAuthorizationData
		(
			UserId,
			[Login],
			PasswordHash,
	
			IPAddress,
			SessionDateTime,
			BrowserUserAgent
		)
		select
			u.UserId,
			nu.[Login],
			nu.PasswordHash,
	
			nu.IPAddress,
			nu.SessionDateTime,
			nu.BrowserUserAgent
		from cte_UserAuthorization as nu
		inner join Users as u on nu.[Login] = u.[Login] AND
								 nu.PasswordHash = u.PasswordHash
							
		if (not exists(select 1 from #UserAuthorizationData))
		begin
			print 'User not found'
			return 404
		end

		begin transaction
				
			insert into dbo.Guests
			(
				IPAddress,
				SessionDateTime,
				BrowserUserAgent,
				AuthorizedUser
			)
			select	ng.IPAddress,
					ng.SessionDateTime,
					ng.BrowserUserAgent,
					ng.UserId
			from #UserAuthorizationData as ng
			left join dbo.Guests as g on 
					ng.IPAddress = g.IPAddress AND 
					ng.SessionDateTime = g.SessionDateTime AND 
					ng.BrowserUserAgent = g.BrowserUserAgent
			where	ng.IPAddress is not null AND g.IPAddress is null AND 
					ng.SessionDateTime is not null AND g.SessionDateTime is null AND 
					ng.BrowserUserAgent is not null AND g.BrowserUserAgent is null

			update Users 
			set LastActiveDateTime = SYSDATETIME()
			from Users u 
			inner join #UserAuthorizationData tmp on u.[Login] = tmp.[Login]

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
use MedCenterDB
go

if OBJECT_ID('dbo.usp_ViewVisits', 'P') is not null
    drop procedure dbo.usp_ViewVisits
go

---------------------------------------------------------------------------------------
-- procedure edits selected data of visit
-- created by:   Alexander Tykoun
-- created date: 10/17/2022
-- sample call: 
-- exec dbo.usp_ViewVisits @params =
--N'{
--  "Viewer": {
--		"Login": "ViewerLogin",
--		"PasswordHash": "00000PASSHASH00000"     
--	},
--  "Filters": {
--  "Specialists":[												--optional
--			{   "Login": "StafferLogin1"		  },			--optional
--		    {	"Login": "StafferLogin2"	  }  	],			--optional
--		"Patient": {	"Login": "PatientLogin"	},				--optional
--		"StartDateTime": "2022-07-19T09:45:24.6821586+03:00",	--optional
--		"EndDateTime": "2022-11-19T09:45:24.6821586+03:00",		--optional	
--		"Rooms": [
--			{	"RoomName": "Cabinet 1" 	  },				--optional
--			{ 	"RoomName": "Cabinet 2" 	  }		],			--optional	
--		"Service": "ServiceName"								--optional
--  },
--  "VisitOptions": "AllRecords/OnlyEmpty/OnlyRecorded",		--optional
--  "OrderTarget": "Date/Specialist/Room/Service",				--optional
--  "OrderType": "Asc/Desc"										--optional
--}'
---------------------------------------------------------------------------------------

create proc dbo.usp_ViewVisits(
    @Json nvarchar(max)
)
as
begin
	if (ISJSON(@Json) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try

		--if OBJECT_ID('tempdb..#tempJson', 'U') is  not null
		--drop table #tempJson;

            create table #tempJson
            (
				ViewerUserId			int,
                ViewerLogin				nvarchar(20),
				SpecialistId			int,
				SpecialistFullName		nvarchar(30),
				PatientId				int,
				FilterStartDateTime		nvarchar(30),
				FilterEndDateTime		nvarchar(30),
				RoomId					int,
				RoomName				nvarchar(20),
				ServiceId				int,
				ServiceName				nvarchar(50),
				OrderTarget				nvarchar(15),
				OrderType				nvarchar(5),
				IsViewerAdmin			bit,
				IsViewerPatient			bit,
				IsViewerStaffer			bit,
				IsAllSpecialists		bit, 
				VisitOptions			tinyint,
				IsAllRooms				bit,
				IsAllServices			bit
            );

            with cte_jsonData 
			(
				ViewerLogin,	
				ViewerPass,		
				Specialist,	
				StartDateTime,	
				EndDateTime,
				PatientLogin,
				RoomName,			
				ServiceName,	
				OrderTarget,	
				OrderType,
				AllSpecialistsFlag,
				VisitOptions,
				AllRoomsFlag,
				AllServicesFlag
			) as
			(
                select 
					ViewerLogin,	
					ViewerPass,
					SpecialistLogin,	
					StartDateTime,	
					EndDateTime,	
					PatientLogin,
					RoomName,			
					ServiceName,	
					OrderTarget,	
					OrderType,
					case when len(SpecialistsJson) >0 then 0 else 1 end,
					case when PatientLogin is not null then 0 
						 when VisitOptions = 'AllRecords' then 1 
						 when VisitOptions = 'OnlyEmpty' then 2 
						 else 3 end,	   -- Only Visits with Patients 
					case when len(RoomsJson) >0 then 0 else 1 end,		
					case when ServiceName is null then 1 else 0 end

                from OPENJSON(@Json) with
                (
					 ViewerLogin		nvarchar(20)	N'$.Viewer.Login',
					 ViewerPass			char(64)		N'$.Viewer.PasswordHash',
					 SpecialistsJson	nvarchar(max)	N'$.Filters.Specialists' as json,
					 StartDateTime		datetime2(0)	N'$.Filters.StartDateTime',
					 EndDateTime		datetime2(0)	N'$.Filters.EndDateTime',
					 PatientLogin		nvarchar(20)	N'$.Filters.Patient.Login',
					 RoomsJson			nvarchar(max)	N'$.Filters.Rooms' as json,
					 ServiceName		nvarchar(50)	N'$.Filters.Service.ServiceName',
					 VisitOptions		nvarchar(25)	N'$.VisitOptions',
					 OrderTarget		nvarchar(50)	N'$.OrderTarget',
					 OrderType			nvarchar(10)	N'$.OrderType'
				)
				outer apply openjson(SpecialistsJson) with 
				(
					SpecialistLogin		nvarchar(20)	N'$.Login'
				) as specs
				outer apply openjson(RoomsJson) with 
				(
					RoomName		nvarchar(20)	N'$.RoomName'
				) as rooms
            )						
            insert into #tempJson 
			(	
				ViewerUserId,
				ViewerLogin,
                SpecialistId,
				SpecialistFullName,
				PatientId,
				FilterStartDateTime,
				FilterEndDateTime,
				RoomId,
				RoomName,
				ServiceId,
				ServiceName,
				OrderTarget,
				OrderType,
				IsViewerAdmin,
				IsViewerPatient,
				IsViewerStaffer,
				IsAllSpecialists, 
				VisitOptions,
				IsAllRooms,
				IsAllServices )
            select 
				vu.UserId,
				vu.[Login],
                spec_st.StafferId,
				spec_us.FullName,
				pat_filt.PatientId,
				convert(nvarchar(30), StartDateTime),
				convert(nvarchar(30), EndDateTime),
				ro.RoomId,
				ro.RoomName,
				serv.ServiceId,
				serv.ServiceName,
				filt.OrderTarget,
				filt.OrderType,
				case when ur.UserRole = 'Administrator' then 1 else 0 end,
				case when pat.PatientId is not null then 1 else 0 end,
				case when staff.StafferId is not null then 1 else 0 end,
				filt.AllSpecialistsFlag,
				filt.VisitOptions,
				filt.AllRoomsFlag,
				filt.AllServicesFlag
			from cte_JsonData as filt
			inner join Users as vu on vu.[Login] = filt.ViewerLogin AND vu.PasswordHash = filt.ViewerPass
			inner join UserRoles as ur on vu.UserRoleId = ur.UserRoleId
			left join Patients as pat on vu.UserId = pat.PatientUserId
			left join Staffers as staff on vu.UserId = staff.StafferUserId
			left join Users as spec_us on filt.Specialist = spec_us.[Login]
			left join Staffers as spec_st on spec_us.UserId = spec_st.StafferUserId
			left join Users as pat_us on filt.PatientLogin = pat_us.[Login]
			left join Patients as pat_filt on pat_us.UserId = pat_filt.PatientUserId
			left join Rooms as ro on filt.RoomName = ro.RoomName
			left join [Services] as serv on filt.ServiceName = serv.ServiceName;

			declare @innerJoinClause nvarchar(300) = ''
			declare @andPart nvarchar(5) = ''
			declare @whereClause nvarchar (200) = ''
			declare @orderClause nvarchar (200) = ''
			declare @selectPart nvarchar (200) = ''
			declare @patientFilter nvarchar (40) = ''

------------------ JSON ENTREES FILTER
			if ((select top(1) IsAllSpecialists from #tempJson)=0)
			begin 
				set @innerJoinClause = CONCAT(@innerJoinClause, @andPart, 'v.Specialist = tmp.SpecialistId')
				set @andPart = ' AND '
			end
			
			if ((select top(1) VisitOptions from #tempJson)=0)
			begin 
				set @innerJoinClause = CONCAT(@innerJoinClause, @andPart, 'v.RecordedPatient = tmp.PatientId')
				set @andPart = ' AND '
			end

			if ((select top(1) IsAllRooms from #tempJson)=0)
			begin 
				set @innerJoinClause = CONCAT(@innerJoinClause, @andPart, 'v.VisitRoom = tmp.RoomId')
				set @andPart = ' AND '
			end

			if ((select top(1) IsAllServices from #tempJson)=0)
			begin 
				set @innerJoinClause = CONCAT(@innerJoinClause, @andPart, 'v.BaseService = tmp.ServiceId')
			end

			if (len(@innerJoinClause) > 0 )
			begin
				set @innerJoinClause = CONCAT('inner join dbo.#tempJson as tmp on ', @innerJoinClause)
			end

-------------------- TIME FILTER
			set @andPart = ''
			if ((select distinct FilterStartDateTime from #tempJson) is not null)
			begin
				set @whereClause = CONCAT(@whereClause, @andPart, 'v.ScheduledDateTime >= (select top(1) FilterStartDateTime from #tempJson)')
				set @andPart = ' AND '
			end

			if ((select distinct FilterEndDateTime from #tempJson) is not null)
			begin
				set @whereClause = CONCAT(@whereClause, @andPart, 'v.ScheduledDateTime <= (select top(1) FilterEndDateTime from #tempJson)')
			end

			if (len(@whereClause) > 0 )
			begin
				set @whereClause = CONCAT('where ', @whereClause)
			end

			if ((select top(1) IsViewerAdmin from #tempJson)=1)
			begin
				set @selectPart = ', le.EquipmentList,	ISNULL(la.AssistantList,'' '') as Assistants'
			end

			set @patientFilter = case 
			when (select top(1) VisitOptions from #tempJson)=2 then 'where vf.Patient is null '
			when (select top(1) VisitOptions from #tempJson)=3 then 'where vf.Patient is not null '
			else ''  	   end

			set @orderClause = lower((select top(1) OrderTarget from #tempJson))
			set @orderClause = case 
				when @orderClause='date' then 'order by vf.VisitDateTime '
				when @orderClause='specialist' then 'order by vf.Specialist '
				when @orderClause='room' then 'order by vf.Room '
				when @orderClause='service' then 'order by vf.Service '
				else ''  	   end
			if (len(@orderClause) > 0 AND lower((select top(1) OrderType from #tempJson)) in ('asc','desc'))
			begin
				set @orderClause = CONCAT(@orderClause, (select top(1) OrderType from #tempJson))
			end

	begin transaction

		declare @sqlScript nvarchar(max) =
'with cte_VisitsFiltered	(
		VisitId,
		Specialist, 
		RoomId,
		Room, 
		[Service], 
		PatientId,
		Patient, 
		VisitDateTime,
		VisitStatus,
		PaymentState
		)
as( select
		VisitId,
		u_st.FullName,
		r.RoomId,
		r.RoomName,
		serv.ServiceName,
		pat.PatientId,
		u_pat.FullName,
		CONVERT(datetime2(0), v.ScheduledDateTime),
		vs.VisitStatus,
		ps.PaymentState
	from Visits as v
	INNER_JOIN_CLAUSE
	inner join Rooms as r on v.VisitRoom = r.RoomId
	inner join Staffers as st on st.StafferId = v.Specialist
	inner join Users as u_st on u_st.UserId = st.StafferUserId
	inner join [Services] as serv on serv.ServiceId = v.BaseService
	inner join VisitStatuses as vs on v.VisitStatusId = vs.VisitStatusId
	inner join PaymentStates as ps on v.PaymentStateId = ps.PaymentStateId
	left join Patients as pat on pat.PatientId = v.RecordedPatient
	left join Users as u_pat on u_pat.UserId = pat.PatientUserId
	WHERE_CLAUSE
),
cte_ListEquip 
	(	VisitId,
		EquipmentList )
as(
	select 
		cte.VisitId,
		STRING_AGG(eq.EquipmentName, '', '')
	from cte_VisitsFiltered as cte 
	inner join Equipments as eq on eq.EquipmentRoom = cte.RoomId
	Group by cte.VisitId 
	),
cte_ListAssist
	(	VisitId,
		AssistantList  )
as(
	select	
		cte2.VisitId,
		STRING_AGG(us_as.FullName, '', '')
	from cte_VisitsFiltered as cte2
	inner join StaffersVisitsLink as svl on svl.VisitId = cte2.VisitId
	inner join Staffers as as_st on svl.StafferId = as_st.StafferId
	inner join Users as us_as on as_st.StafferUserId = us_as.UserId
	Group by cte2.VisitId
	)
select 
		CONVERT(date, vf.VisitDateTime) as VisitDate,
		FORMAT(vf.VisitDateTime,''HH:mm'') as VisitTime,
		vf.Specialist,
		vf.Room,
		vf.Patient,
		vf.[Service] ADMIN_EXTENSION , 
		vf.VisitStatus, 
		vf.PaymentState
from cte_VisitsFiltered as vf
left join cte_ListEquip as le on vf.VisitId = le.VisitId
left join cte_ListAssist as la on vf.VisitId = la.VisitId
PATIENT_FILTER
ORDER_CLAUSE 
'

set @sqlScript = REPLACE(@sqlScript, 'INNER_JOIN_CLAUSE', @innerJoinClause )
set @sqlScript = REPLACE(@sqlScript, 'WHERE_CLAUSE', @whereClause )
set @sqlScript = REPLACE(@sqlScript, 'ADMIN_EXTENSION', @selectPart )
set @sqlScript = REPLACE(@sqlScript, 'PATIENT_FILTER', @patientFilter )
set @sqlScript = REPLACE(@sqlScript, 'ORDER_CLAUSE', @orderClause )


exec(@sqlScript)
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
use MedCenterDB
go

if OBJECT_ID('dbo.usp_VisitDataAnalytics', 'P') is not null
    drop procedure dbo.usp_VisitDataAnalytics
go

---------------------------------------------------------------------------------------
-- procedure sort data of visits by two categories: Service Category and Patient Status
-- created by:   Alexander Tykoun
-- created date: 10/20/2022
-- sample call: 
-- exec dbo.usp_VisitDataAnalytics @params =
--N'{
--  "Viewer": {
--		"Login": "ViewerLogin",
--		"PasswordHash": "00000PASSHASH00000"     
--	},
--	"ServiceCategories": [									--optional. null = ALL
--			"Category1",
--			"Category2",  ],
--	"PatientStatuses": [									--optional. null = ALL
--			"Status1",
--			"Status2",  ],
--	"StartDateTime": "2022-07-19T09:45:24.6821586+03:00",	--optional. null = from Start 
--	"EndDateTime": "2022-11-19T09:45:24.6821586+03:00",		--optional. null = till Today	
--  "ShowNullRows": "0/1",									--optional. null = 0 (false) 
--  "ShowNullCols": "0/1"									--optional. null = 0 (false)
--}'
---------------------------------------------------------------------------------------

create proc dbo.usp_VisitDataAnalytics(
    @Json nvarchar(max)
)
as
begin
	if (ISJSON(@Json) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try
            create table #tempJson2
            (
				ServiceCategory			nvarchar(30),
				PatientStatus			nvarchar(30),
				FilterStartDateTime		datetime2(0),
				FilterEndDateTime		datetime2(0),
				TargetOutput			nvarchar(30),
				IsAllCategories			bit, 
				IsAllStatuses			bit, 
				ShowNullRows			bit,
				ShowNullCols			bit
            );

            with cte_jsonData 
			(
				ViewerLogin,	
				ViewerPass,		
				StartDateTime,	
				EndDateTime,
				ServiceCategory,
				PatientStatus,			
				IsAllCategories,
				IsAllStatuses,
				TargetOutput,
				ShowNullRows,
				ShowNullCols
			) as
			(
                select 
					ViewerLogin,	
					ViewerPass,
					ISNULL(StartDateTime, (select MIN(ScheduledDateTime) from Visits)),	
					ISNULL(EndDateTime, SYSDATETIME()),	
					ServiceCategory,	
					PatientStatus,	
					case when len(ServiceCategoriesJson) >0 then 0 else 1 end,
					case when len(PatientStatusesJson) >0 then 0 else 1 end,		
					ISNULL(TargetOutput, 'TotalIncome'),
					ShowNullRows,
					ShowNullCols
                from OPENJSON(@Json) with
                (
					 ViewerLogin			nvarchar(20)	N'$.Viewer.Login',
					 ViewerPass				char(64)		N'$.Viewer.PasswordHash',
					 ServiceCategoriesJson	nvarchar(max)	N'$.ServiceCategories' as json,
					 PatientStatusesJson	nvarchar(max)	N'$.PatientStatuses' as json,
					 StartDateTime			datetime2(0)	N'$.StartDateTime',
					 EndDateTime			datetime2(0)	N'$.EndDateTime',
					 TargetOutput			nvarchar(30)	N'$.TargetOutput',
					 ShowNullRows			bit				N'$.ShowNullRows',
					 ShowNullCols			bit				N'$.ShowNullCols'
				)
				outer apply openjson(ServiceCategoriesJson) with 
				(
					ServiceCategory		nvarchar(30)	N'$'
				) as scat
				outer apply openjson(PatientStatusesJson) with 
				(
					PatientStatus		nvarchar(20)	N'$'
				) as pstat
            )
		
            insert into #tempJson2 
			(	
				ServiceCategory,
				PatientStatus,	
				FilterStartDateTime,
				FilterEndDateTime,
				IsAllCategories,
				IsAllStatuses,	
				TargetOutput,
				ShowNullRows,
				ShowNullCols				
			)
            select 
				filt.ServiceCategory,
				filt.PatientStatus,
				filt.StartDateTime,
				filt.EndDateTime,
				filt.IsAllCategories,
				filt.IsAllStatuses,
				filt.TargetOutput,
				filt.ShowNullRows,
				filt.ShowNullCols
			from cte_JsonData as filt
			inner join Users as vu on vu.[Login] = filt.ViewerLogin AND vu.PasswordHash = filt.ViewerPass
			inner join UserRoles as ur on vu.UserRoleId = ur.UserRoleId
			where ur.UserRole = 'Administrator'

			if not exists (select #tempJson2.FilterEndDateTime,
			                      #tempJson2.FilterStartDateTime 
                           from #tempJson2
                           where #tempJson2.FilterStartDateTime < #tempJson2.FilterEndDateTime)
            begin
                print 'Error. Transaction aborted.'
                return
            end

			create table #tempServiceCategories
            (
                ServiceCategoryId	tinyint,
				ServiceCategory		nvarchar(30)
            )

            create table #tempPatientStatuses
            (
                PatientStatusId		tinyint,
				PatientStatus		nvarchar(30)
            )

            create table #tempRawData
            (
                ServiceCategoryId   tinyint,
				ServiceCategory		nvarchar(30),
                PatientStatusId		tinyint,
				PatientStatus		nvarchar(30),
				VisitId				int,
                VisitStatus			nvarchar(30),
				PaymentState		nvarchar(30),
				VisitDateTime		datetime2,
				TotalPrice			money,
				PatientId			int
            );

			if 1 = (select distinct IsAllCategories
                       from #tempJson2)
				begin
					insert into #tempServiceCategories (ServiceCategoryId, ServiceCategory)
					select ServiceCategoryId, ServiceCategory
					from ServiceCategories ;
	            end
            else
		        begin
				    insert into #tempServiceCategories (ServiceCategoryId, ServiceCategory)
					select distinct sc.ServiceCategoryId, sc.ServiceCategory
					from ServiceCategories as sc
					inner join #tempJson2 as tmp on (sc.ServiceCategory = tmp.ServiceCategory);
				end

			if 1 = (select distinct IsAllStatuses
                       from #tempJson2)
				begin
					insert into #tempPatientStatuses (PatientStatusId, PatientStatus)
					select PatientStatusId, PatientStatus
					from PatientStatuses ;
	            end
            else
		        begin
				    insert into #tempPatientStatuses (PatientStatusId, PatientStatus)
					select  distinct ps.PatientStatusId, ps.PatientStatus
					from PatientStatuses as ps
					inner join #tempJson2 as tmp on (ps.PatientStatus = tmp.PatientStatus);
				end

            if 1 = (select distinct #tempJson2.ShowNullRows from #tempJson2)
            begin
                -- all Rows
                insert into #tempRawData (
					ServiceCategoryId,
					ServiceCategory,
					PatientStatusId,
					PatientStatus,
					VisitId,
					VisitDateTime,
					PatientId,
					TotalPrice,
					VisitStatus,
					PaymentState )
                select sc_tmp.ServiceCategoryId,
					   sc_tmp.ServiceCategory,
                       ps.PatientStatusId,
					   ps.PatientStatus,
					   v.VisitId,
                       v.ScheduledDateTime,
					   v.RecordedPatient,
					   v.TotalPrice,
					   vs.VisitStatus,
					   pay.PaymentState
				from #tempServiceCategories as sc_tmp
				left outer join
                     (ServiceCategories as sc
					 inner join [Services] as serv on serv.ServiceCategoryId = sc.ServiceCategoryId
					 inner join Visits as v on v.BaseService = serv.ServiceId
					 inner join Patients as pat on pat.PatientId = v.RecordedPatient
					 inner join PatientStatuses as ps on (pat.PatientStatusId = ps.PatientStatusId)
					 inner join VisitStatuses as vs on v.VisitStatusId = vs.VisitStatusId
					 inner join PaymentStates as pay on v.PaymentStateId = pay.PaymentStateId					 
					 )
                         on (sc_tmp.ServiceCategoryId = sc.ServiceCategoryId)
                where ((v.ScheduledDateTime >= (select distinct FilterStartDateTime from #tempJson2)) and
                        (v.ScheduledDateTime <= (select distinct FilterEndDateTime from #tempJson2)) 
						OR v.ScheduledDateTime is null) 
            end
            else
            begin
                insert into #tempRawData (
					ServiceCategoryId,
					ServiceCategory,
					PatientStatusId,
					PatientStatus,
					VisitId,
					VisitDateTime,
					PatientId,
					TotalPrice,
					VisitStatus,
					PaymentState )
                select sc_tmp.ServiceCategoryId,
					   sc_tmp.ServiceCategory,	
                       ps.PatientStatusId,
					   ps.PatientStatus,
					   v.VisitId,
                       v.ScheduledDateTime,
					   v.RecordedPatient,
					   v.TotalPrice,
					   v.VisitStatusId,
					   v.PaymentStateId
				from #tempServiceCategories as sc_tmp
				inner join ServiceCategories as sc on sc_tmp.ServiceCategoryId = sc.ServiceCategoryId
				inner join [Services] as serv on serv.ServiceCategoryId = sc.ServiceCategoryId
				inner join Visits as v on v.BaseService = serv.ServiceId
				inner join Patients as pat on pat.PatientId = v.RecordedPatient
				inner join PatientStatuses as ps on (pat.PatientStatusId = ps.PatientStatusId)
	    		inner join VisitStatuses as vs on v.VisitStatusId = vs.VisitStatusId
				inner join PaymentStates as pay on v.PaymentStateId = pay.PaymentStateId					 
				where (v.ScheduledDateTime >= (select distinct FilterStartDateTime from #tempJson2)) and
                      (v.ScheduledDateTime <= (select distinct FilterEndDateTime from #tempJson2))
            end


	begin transaction				
	 declare @ResultQuery nvarchar(max) =
	 N'(select #tempRawData.ServiceCategory as ''Service Category'',
                        SUM(ISNULL(#tempRawData.TotalPrice,0)) as ''Total'' 
						{SUBQUERY}
                 from #tempRawData
				{WHERE_PART}
				group by #tempRawData.ServiceCategory)
				union all
                (select ''OVERALL'' as ''Service Category'',
                        SUM(ISNULL(#tempRawData.TotalPrice,0)) as ''Total''
						{SUBQUERY}
                 from #tempRawData				
				{WHERE_PART}
	 )'

	declare @ResultSubquery nvarchar(max)
	if 1 = (select distinct ShowNullCols from #tempJson2)
    begin
		set @ResultSubquery  = 
		 (select STRING_AGG(CONCAT(
			'SUM(iif(#tempRawData.PatientStatus in (N''',
			#tempPatientStatuses.PatientStatus,
			'''), #tempRawData.TotalPrice, 0)) as ''',
			#tempPatientStatuses.PatientStatus,
			''''),
			', ')
		 from #tempPatientStatuses)
	end
	else
	begin
		set @ResultSubquery  = 
		 (select STRING_AGG(CONCAT(
			'SUM(iif(#tempRawData.PatientStatus in (N''',
			#tempPatientStatuses.PatientStatus,
			'''), #tempRawData.TotalPrice, 0)) as ''',
			#tempPatientStatuses.PatientStatus,
			''''),
			', ')
		 from #tempPatientStatuses
		 where (#tempPatientStatuses.PatientStatus in (select distinct #tempRawData.PatientStatus
                                                       from #tempRawData
                                                       where (#tempRawData.PatientStatus is not null)))
		 )
	end

	if @ResultSubquery is not null
	set @ResultSubquery = CONCAT(', ', @ResultSubquery) 
	else
	set @ResultSubquery = ' '

	 declare @WherePart nvarchar(max) = 
	 (select STRING_AGG(CONCAT('N''', 
							    #tempPatientStatuses.PatientStatus,
								''''),	
								', ') 
	  from #tempPatientStatuses)
	  if @WherePart is not null 
		set @WherePart = CONCAT('where #tempRawData.PatientStatus in (', @WherePart, ')  OR #tempRawData.PatientStatus is null')
	else 
		set @WherePart = ' '

     set @ResultQuery = replace(@ResultQuery, N'{SUBQUERY}', @ResultSubquery)
	 set @ResultQuery = replace(@ResultQuery, N'{WHERE_PART}', @WherePart)

	 if 'Visits' = (select distinct TargetOutput from #tempJson2)
		set @ResultQuery = replace(@ResultQuery, N'#tempRawData.TotalPrice', 'iif(#tempRawData.VisitId is null, 0, 1)')

	exec (@ResultQuery)
		
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
use MedCenterDB
go

if OBJECT_ID('dbo.usp_VisitDataPivotAnalytics', 'P') is not null
    drop procedure dbo.usp_VisitDataPivotAnalytics
go

---------------------------------------------------------------------------------------
-- procedure sort data of visits by two categories: Service Category and Patient Status
-- created by:   Alexander Tykoun
-- created date: 10/20/2022
-- sample call: 
-- exec dbo.usp_VisitDataPivotAnalytics @params =
--N'{
--  "Viewer": {
--		"Login": "ViewerLogin",
--		"PasswordHash": "00000PASSHASH00000"     
--	},
--	"ServiceCategories": [									--optional. null = ALL
--			"Category1",
--			"Category2",  ],
--	"PatientStatuses": [									--optional. null = ALL
--			"Status1",
--			"Status2",  ],
--	"StartDateTime": "2022-07-19T09:45:24.6821586+03:00",	--optional. null = from Start 
--	"EndDateTime": "2022-11-19T09:45:24.6821586+03:00",		--optional. null = till Today	
--  "ShowNullRows": "0/1",									--optional. null = 0 (false) 
--  "ShowNullCols": "0/1"									--optional. null = 0 (false)
--}'
---------------------------------------------------------------------------------------

create proc dbo.usp_VisitDataPivotAnalytics(
    @Json nvarchar(max)
)
as
begin
	if (ISJSON(@Json) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try
            create table #tempJson2
            (
				ServiceCategory			nvarchar(30),
				PatientStatus			nvarchar(30),
				FilterStartDateTime		datetime2(0),
				FilterEndDateTime		datetime2(0),
				TargetOutput			nvarchar(30),
				IsAllCategories			bit, 
				IsAllStatuses			bit, 
				ShowNullRows			bit,
				ShowNullCols			bit
            );

            with cte_jsonData 
			(
				ViewerLogin,	
				ViewerPass,		
				StartDateTime,	
				EndDateTime,
				ServiceCategory,
				PatientStatus,			
				IsAllCategories,
				IsAllStatuses,
				TargetOutput,
				ShowNullRows,
				ShowNullCols
			) as
			(
                select 
					ViewerLogin,	
					ViewerPass,
					ISNULL(StartDateTime, (select MIN(ScheduledDateTime) from Visits)),	
					ISNULL(EndDateTime, SYSDATETIME()),	
					ServiceCategory,	
					PatientStatus,	
					case when len(ServiceCategoriesJson) >0 then 0 else 1 end,
					case when len(PatientStatusesJson) >0 then 0 else 1 end,		
					ISNULL(TargetOutput, 'TotalIncome'),
					ShowNullRows,
					ShowNullCols
                from OPENJSON(@Json) with
                (
					 ViewerLogin			nvarchar(20)	N'$.Viewer.Login',
					 ViewerPass				char(64)		N'$.Viewer.PasswordHash',
					 ServiceCategoriesJson	nvarchar(max)	N'$.ServiceCategories' as json,
					 PatientStatusesJson	nvarchar(max)	N'$.PatientStatuses' as json,
					 StartDateTime			datetime2(0)	N'$.StartDateTime',
					 EndDateTime			datetime2(0)	N'$.EndDateTime',
					 TargetOutput			nvarchar(30)	N'$.TargetOutput',
					 ShowNullRows			bit				N'$.ShowNullRows',
					 ShowNullCols			bit				N'$.ShowNullCols'
				)
				outer apply openjson(ServiceCategoriesJson) with 
				(
					ServiceCategory		nvarchar(30)	N'$'
				) as scat
				outer apply openjson(PatientStatusesJson) with 
				(
					PatientStatus		nvarchar(20)	N'$'
				) as pstat
            )
		
            insert into #tempJson2 
			(	
				ServiceCategory,
				PatientStatus,	
				FilterStartDateTime,
				FilterEndDateTime,
				IsAllCategories,
				IsAllStatuses,	
				TargetOutput,
				ShowNullRows,
				ShowNullCols				
			)
            select 
				filt.ServiceCategory,
				filt.PatientStatus,
				filt.StartDateTime,
				filt.EndDateTime,
				filt.IsAllCategories,
				filt.IsAllStatuses,
				filt.TargetOutput,
				filt.ShowNullRows,
				filt.ShowNullCols
			from cte_JsonData as filt
			inner join Users as vu on vu.[Login] = filt.ViewerLogin AND vu.PasswordHash = filt.ViewerPass
			inner join UserRoles as ur on vu.UserRoleId = ur.UserRoleId
			where ur.UserRole = 'Administrator'

			if not exists (select #tempJson2.FilterEndDateTime,
			                      #tempJson2.FilterStartDateTime 
                           from #tempJson2
                           where #tempJson2.FilterStartDateTime < #tempJson2.FilterEndDateTime)
            begin
                print 'Error. Transaction aborted.'
                return
            end

			create table #tempServiceCategories
            (
                ServiceCategoryId	tinyint,
				ServiceCategory		nvarchar(30)
            )

            create table #tempPatientStatuses
            (
                PatientStatusId		tinyint,
				PatientStatus		nvarchar(30)
            )

            create table #tempRawData
            (
                ServiceCategoryId   tinyint,
				ServiceCategory		nvarchar(30),
                PatientStatusId		tinyint,
				PatientStatus		nvarchar(30),
				VisitId				int,
                VisitStatus			nvarchar(30),
				PaymentState		nvarchar(30),
				VisitDateTime		datetime2,
				TotalPrice			money,
				PatientId			int
            );

			if 1 = (select distinct IsAllCategories
                       from #tempJson2)
				begin
					insert into #tempServiceCategories (ServiceCategoryId, ServiceCategory)
					select ServiceCategoryId, ServiceCategory
					from ServiceCategories ;
	            end
            else
		        begin
				    insert into #tempServiceCategories (ServiceCategoryId, ServiceCategory)
					select distinct sc.ServiceCategoryId, sc.ServiceCategory
					from ServiceCategories as sc
					inner join #tempJson2 as tmp on (sc.ServiceCategory = tmp.ServiceCategory);
				end

			if 1 = (select distinct IsAllStatuses
                       from #tempJson2)
				begin
					insert into #tempPatientStatuses (PatientStatusId, PatientStatus)
					select PatientStatusId, PatientStatus
					from PatientStatuses ;
	            end
            else
		        begin
				    insert into #tempPatientStatuses (PatientStatusId, PatientStatus)
					select  distinct ps.PatientStatusId, ps.PatientStatus
					from PatientStatuses as ps
					inner join #tempJson2 as tmp on (ps.PatientStatus = tmp.PatientStatus);
				end

            if 1 = (select distinct #tempJson2.ShowNullRows from #tempJson2)
            begin
                -- all Rows
                insert into #tempRawData (
					ServiceCategoryId,
					ServiceCategory,
					PatientStatusId,
					PatientStatus,
					VisitId,
					VisitDateTime,
					PatientId,
					TotalPrice,
					VisitStatus,
					PaymentState )
                select sc_tmp.ServiceCategoryId,
					   sc_tmp.ServiceCategory,
                       ps.PatientStatusId,
					   ps.PatientStatus,
					   v.VisitId,
                       v.ScheduledDateTime,
					   v.RecordedPatient,
					   v.TotalPrice,
					   vs.VisitStatus,
					   pay.PaymentState
				from #tempServiceCategories as sc_tmp
				left outer join
                     (ServiceCategories as sc
					 inner join [Services] as serv on serv.ServiceCategoryId = sc.ServiceCategoryId
					 inner join Visits as v on v.BaseService = serv.ServiceId
					 inner join Patients as pat on pat.PatientId = v.RecordedPatient
					 inner join PatientStatuses as ps on (pat.PatientStatusId = ps.PatientStatusId)
					 inner join VisitStatuses as vs on v.VisitStatusId = vs.VisitStatusId
					 inner join PaymentStates as pay on v.PaymentStateId = pay.PaymentStateId					 
					 )
                         on (sc_tmp.ServiceCategoryId = sc.ServiceCategoryId)
                where ((v.ScheduledDateTime >= (select distinct FilterStartDateTime from #tempJson2)) and
                        (v.ScheduledDateTime <= (select distinct FilterEndDateTime from #tempJson2)) 
						OR v.ScheduledDateTime is null) 
            end
            else
            begin
                insert into #tempRawData (
					ServiceCategoryId,
					ServiceCategory,
					PatientStatusId,
					PatientStatus,
					VisitId,
					VisitDateTime,
					PatientId,
					TotalPrice,
					VisitStatus,
					PaymentState )
                select sc_tmp.ServiceCategoryId,
					   sc_tmp.ServiceCategory,	
                       ps.PatientStatusId,
					   ps.PatientStatus,
					   v.VisitId,
                       v.ScheduledDateTime,
					   v.RecordedPatient,
					   v.TotalPrice,
					   v.VisitStatusId,
					   v.PaymentStateId
				from #tempServiceCategories as sc_tmp
				inner join ServiceCategories as sc on sc_tmp.ServiceCategoryId = sc.ServiceCategoryId
				inner join [Services] as serv on serv.ServiceCategoryId = sc.ServiceCategoryId
				inner join Visits as v on v.BaseService = serv.ServiceId
				inner join Patients as pat on pat.PatientId = v.RecordedPatient
				inner join PatientStatuses as ps on (pat.PatientStatusId = ps.PatientStatusId)
	    		inner join VisitStatuses as vs on v.VisitStatusId = vs.VisitStatusId
				inner join PaymentStates as pay on v.PaymentStateId = pay.PaymentStateId					 
				where (v.ScheduledDateTime >= (select distinct FilterStartDateTime from #tempJson2)) and
                      (v.ScheduledDateTime <= (select distinct FilterEndDateTime from #tempJson2))
            end


	begin transaction				
			declare @PivotQuery nvarchar(max) =
			N'
			select ServiceCategory {SUBQUERY}
				from 
				(
					select ServiceCategory, PatientStatus, ISNULL(TotalPrice, 0) as Price from #tempRawData
				) as R
				PIVOT
				(
					SUM(Price) FOR
					R.PatientStatus IN ({INPART})
				) pivot_table
			'

			declare @PivotSubquery nvarchar(max)
			declare @InPart nvarchar(max)

			if 1 = (select distinct ShowNullCols from #tempJson2)
			begin
				set @PivotSubquery = (select STRING_AGG(CONCAT(
										'ISNULL(', 
										QUOTENAME(PatientStatus),
										' , 0) as ',
										PatientStatus), 
										', ') 
									  from #tempPatientStatuses)

				set @InPart = (	select STRING_AGG(QUOTENAME(PatientStatus), ', ') 
							    from #tempPatientStatuses)
			end
			else
			begin
				set @PivotSubquery = (select STRING_AGG(CONCAT(
										'ISNULL(', 
										QUOTENAME(PatientStatus),
										' , 0) as ',
										PatientStatus), 
										', ') 
									  from #tempPatientStatuses
									  where (#tempPatientStatuses.PatientStatus 
													in (select distinct #tempRawData.PatientStatus
														from #tempRawData
														where (#tempRawData.PatientStatus is not null)))
									  )

				set @InPart = (	select STRING_AGG(QUOTENAME(PatientStatus), ', ') 
							    from #tempPatientStatuses
								where (#tempPatientStatuses.PatientStatus 
												in (select distinct #tempRawData.PatientStatus
													from #tempRawData
													where (#tempRawData.PatientStatus is not null)))
								)
			end
			
			if @PivotSubquery is not null
				set @PivotSubquery = CONCAT(' , ', @PivotSubquery)
			else 
				set  @PivotSubquery = ' '

			if @InPart is null
			begin
				print ('No Data for output')
				return
			end

			
			set @PivotQuery = REPLACE(@PivotQuery, '{SUBQUERY}', @PivotSubquery)
			set @PivotQuery = REPLACE(@PivotQuery, '{INPART}', @InPart)

			exec(@PivotQuery)
		
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
