use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParseUserRolesInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParseUserRolesInitialization
go

create procedure dbo.usp_JsonParseUserRolesInitialization
(
	@json nvarchar(max)
)
as
begin
	if (ISJSON(@json) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try

		with cte_UserRoles([UserRole]) as
		(
			select [UserRole]
			from OPENJSON(@json) with 
			(
				UserRoles nvarchar(max) '$.UserRoles' as json
			)
			outer apply
			OPENJSON(UserRoles) with
			(
				[UserRole] nvarchar(20) '$.UserRole'
			)
		)
		insert into dbo.UserRoles ([UserRole])
		select [UserRole]
		from cte_UserRoles

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go