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