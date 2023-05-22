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


