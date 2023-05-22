use MedCenterDB
go

if OBJECT_ID('dbo.usp_UserAuthorization', 'P') is not null
    drop procedure dbo.usp_UserAuthorization
go

---------------------------------------------------------------------------------------
-- procedure authorizes existing user and updates LAstActiveDateTime
-- created by:   Alexander Tykoun
-- created date: 10/03/2022
-- sample call: 
-- exec dbo.usp_UserAuthorization @params =
--N'
--{
--  "Guest": { 
--    "IpAddress": "122.34.25.34",
--    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
--    "SessionDateTime": "2022-09-27T19:35:33.6578067+03:00"
--  },
--  "User": {
--    "Login": "Tykooon",
--    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
--    }
--}
--'
---------------------------------------------------------------------------------------

create proc dbo.usp_UserAuthorization(
    @UserAuthorizationJson nvarchar(max)
)
as
begin
	if (ISJSON(@UserAuthorizationJson) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try

--		if OBJECT_ID('tempdb..#UserAuthorizationData', 'U') is  not null
--		drop table #UserAuthorizationData;
		
		create table #UserAuthorizationData
		(	
			UserId					int,
			[Login]					nvarchar(20),
			PasswordHash			char(64),

			IPAddress				nvarchar(15),
			SessionDateTime			datetime2,
			BrowserUserAgent		nvarchar(200)
		);		
		
		with cte_UserAuthorization
		(
			[Login],
			PasswordHash,

			IPAddress,
			SessionDateTime,
			BrowserUserAgent
		) as 
		(
			select 
				[Login],
				PasswordHash,

				IPAddress,
				SessionDateTime,
				BrowserUserAgent
			from openjson(@UserAuthorizationJson)
			with
			(
				[Login]				nvarchar(20)	N'$.User.Login',
				PasswordHash		char(64)		N'$.User.PasswordHash',
	
				IpAddress			nvarchar(15)	N'$.Guest.IpAddress',
				SessionDateTime		datetime2		N'$.Guest.SessionDateTime',
				BrowserUserAgent	nvarchar(200)	N'$.Guest.BrowserUserAgent'
			)
		)
	
		insert into #UserAuthorizationData
		(
			UserId,
			[Login],
			PasswordHash,
	
			IPAddress,
			SessionDateTime,
			BrowserUserAgent
		)
		select
			u.UserId,
			nu.[Login],
			nu.PasswordHash,
	
			nu.IPAddress,
			nu.SessionDateTime,
			nu.BrowserUserAgent
		from cte_UserAuthorization as nu
		inner join Users as u on nu.[Login] = u.[Login] AND
								 nu.PasswordHash = u.PasswordHash
							
		if (not exists(select 1 from #UserAuthorizationData))
		begin
			print 'User not found'
			return 404
		end

		begin transaction
				
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
					ng.UserId
			from #UserAuthorizationData as ng
			left join dbo.Guests as g on 
					ng.IPAddress = g.IPAddress AND 
					ng.SessionDateTime = g.SessionDateTime AND 
					ng.BrowserUserAgent = g.BrowserUserAgent
			where	ng.IPAddress is not null AND g.IPAddress is null AND 
					ng.SessionDateTime is not null AND g.SessionDateTime is null AND 
					ng.BrowserUserAgent is not null AND g.BrowserUserAgent is null

			update Users 
			set LastActiveDateTime = SYSDATETIME()
			from Users u 
			inner join #UserAuthorizationData tmp on u.[Login] = tmp.[Login]

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