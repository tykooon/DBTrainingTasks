use MedCenterDB
go

if OBJECT_ID('dbo.usp_ApproveAsAdministrator', 'P') is not null
    drop procedure dbo.usp_ApproveAsAdministrator
go

---------------------------------------------------------------------------------------
-- procedure approves Administrator UserRole given from Approver to User
-- created by:   Alexander Tykoun
-- created date: 10/04/2022
-- sample call: 
-- exec dbo.usp_ApproveAsAdministrator @params =
--N'
--{
--  "User": {
--    "Login": "UserLogin"  },
--  "Approver": {
--    "Login": "ApproverLogin",
--    "PasswordHash": "8B89C76F232B422D626A04B3"
--    }
--}
--'
---------------------------------------------------------------------------------------

create proc dbo.usp_ApproveAsAdministrator(
    @ApproveAsAdminJson nvarchar(max)
)
as
begin
	if (ISJSON(@ApproveAsAdminJson) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try
		create table #@ApproveAsAdminData (	
			UserId				int,
			ApproverId			int,
			RoleId				tinyint
		);		

		with cte_ApproveAsAdmin (
			[Login],
			ApproverLogin,
			ApproverPasswordHash
		) as 
		(
			select 
				[Login],
				ApproverLogin,
				ApproverPasswordHash
			from openjson(@ApproveAsAdminJson)
			with
			(
				[Login]					nvarchar(20)	N'$.User.Login',
				ApproverLogin			nvarchar(20)	N'$.Approver.Login',
				ApproverPasswordHash	char(64)		N'$.Approver.PasswordHash'
			)
		)
	
		insert into #@ApproveAsAdminData (
			UserId,
			ApproverId,
			RoleId			
			)
		select
			u.UserId,
			a.UserId,
			ur.UserRoleId
		from cte_ApproveAsAdmin as tmp
		inner join Users as u on tmp.[Login] = u.[Login]
		inner join Users as a on (tmp.ApproverLogin = a.[Login] AND
								   tmp.ApproverPasswordHash = a.PasswordHash)
		inner join UserRoles as ur on (a.UserRoleId = ur.UserRoleId AND
									ur.UserRole = 'Administrator')	
		
		if (not exists(select 1 from #@ApproveAsAdminData))
		begin
			print 'User or approved Admin are not found'
			return 404
		end

		begin transaction
				
			update Users 
			set UserRoleId = tmp.RoleId,
				AdminApprover = tmp.ApproverId
			from Users u 
			inner join #@ApproveAsAdminData tmp on u.UserId = tmp.UserId
			
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