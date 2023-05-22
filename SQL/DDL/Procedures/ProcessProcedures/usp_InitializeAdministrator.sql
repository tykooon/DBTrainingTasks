use MedCenterDB
go

if OBJECT_ID('dbo.usp_InitializeAdministrator', 'P') is not null
    drop procedure dbo.usp_InitializeAdministrator
go

---------------------------------------------------------------------------------------
-- procedure initialize existing user as primary Administrator
-- created by:   Alexander Tykoun
-- created date: 10/04/2022
-- sample call: 
-- exec dbo.usp_InitializeAdministrator @params =
--N'
--{
--  "User": {
--    "Login": "Tykooon"  }
--}
--'
---------------------------------------------------------------------------------------

create proc dbo.usp_InitializeAdministrator(
    @InitializeAdminJson nvarchar(max)
)
as
begin
	if (ISJSON(@InitializeAdminJson) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try
		create table #InitializeAdminData
		(	
			UserId					int,
			[Login]					nvarchar(20),
		);		
		
		with cte_InitialAdmin
		(
			[Login]
		) as 
		(
			select 
				[Login]
			from openjson(@InitializeAdminJson)
			with ( [Login]  	nvarchar(20)	N'$.User.Login'  )
		)

		insert into #InitializeAdminData
		(
			UserId,
			[Login]
		)
		select
			u.UserId,
			a.[Login]
		from cte_InitialAdmin as a
		inner join Users as u on a.[Login] = u.[Login]
							
		if (not exists(select 1 from #InitializeAdminData))
		begin
			print 'User not found'
			return 404
		end

		begin transaction
				
			update Users 
			set UserRoleId = ur.UserRoleId,
				AdminApprover = NULL
			from Users u 
			inner join #InitializeAdminData tmp on u.[Login] = tmp.[Login]
			inner join UserRoles ur on ur.UserRole = 'Administrator'

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