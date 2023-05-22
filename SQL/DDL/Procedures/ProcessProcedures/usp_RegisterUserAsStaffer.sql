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