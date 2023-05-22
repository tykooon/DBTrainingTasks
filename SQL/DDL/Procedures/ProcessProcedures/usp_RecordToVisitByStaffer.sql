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

