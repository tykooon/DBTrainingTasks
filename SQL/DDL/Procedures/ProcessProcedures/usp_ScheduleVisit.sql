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