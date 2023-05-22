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