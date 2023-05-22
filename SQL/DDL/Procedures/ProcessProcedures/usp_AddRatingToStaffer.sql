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

