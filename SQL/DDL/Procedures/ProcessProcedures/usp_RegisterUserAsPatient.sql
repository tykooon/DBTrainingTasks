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