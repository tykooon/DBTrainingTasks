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

