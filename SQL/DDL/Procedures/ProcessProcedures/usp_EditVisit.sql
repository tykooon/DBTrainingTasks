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