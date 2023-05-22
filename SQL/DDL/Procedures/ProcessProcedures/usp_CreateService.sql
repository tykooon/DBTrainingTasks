use MedCenterDB
go

if OBJECT_ID('dbo.usp_CreateService', 'P') is not null
    drop procedure dbo.usp_CreateService
go

---------------------------------------------------------------------------------------
-- procedure creates Staffer assigned to User and Administrator
-- created by:   Alexander Tykoun
-- created date: 10/06/2022
-- sample call: 
-- exec dbo.usp_CreateService @params =
--N'
--{
--   "Admin": {
--        "Login": "UserWithAdminRole",
--        "PasswordHash": "9871827B34A35D53C983FF"   },
--   "Service": {
--        "ServiceName": "NameOfService",
--        "ServiceStatus": { "ServiceStatus": "Accessible/Suspended/On Demand/Depricated" },
--        "Comment": "Lorem Ipsum",
--        "Price": "MoneyValue",
--        "ServiceCategory": {"ServiceCategory": "Consultation/Examination/Test/Manipulation/Operation/Rehabilitation"},
--        "Description": "Plain Text"  }
--}
--'
---------------------------------------------------------------------------------------

create proc dbo.usp_CreateService(
    @createServiceJson nvarchar(max)
)
as
begin
	if (ISJSON(@createServiceJson) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try

--		if OBJECT_ID('tempdb..#CreateServiceData', 'U') is  not null
--		drop table #CreateServiceData;
		
		create table #CreateServiceData
		(	
			ServiceName				nvarchar(50),
			ServiceStatusId			tinyint,
			Comment					nvarchar(150),
			Price					money,
			ServiceCategoryId		tinyint,
			[Description]			nvarchar(200)
		);

		with cte_CreateServiceData
		(
			AdminLogin,
			AdminPasswordHash,
			ServiceName,
			ServiceStatus,
			Comment,
			Price,
			ServiceCategory,
			[Description]
		) as 
		(
			select 
				AdminLogin,
				AdminPass,
				ServiceName,
				ServiceStatus,
				Comment,
				Price,
				ServiceCategory,
				[Description]
			from openjson(@createServiceJson)
			with
			(
				AdminLogin			nvarchar(20)	N'$.Admin.Login',
				AdminPass			char(64)		N'$.Admin.PasswordHash',
				ServiceName			nvarchar(50)	N'$.Service.ServiceName',
				ServiceStatus		nvarchar(30)	N'$.Service.ServiceStatus.ServiceStatus',
				Comment				nvarchar(150)	N'$.Service.Comment',
				Price				money			N'$.Service.Price',
				ServiceCategory		nvarchar(30)	N'$.Service.ServiceCategory.ServiceCategory',
				[Description]		nvarchar(200)	N'$.Service.Description'
			)
		)
	
		insert into #CreateServiceData
		(
			ServiceName,
			ServiceStatusId,
			Comment,
			Price,
			ServiceCategoryId,
			[Description]			
		)
		select
			tmp.ServiceName,
			ss.ServiceStatusId,
			tmp.Comment,
			tmp.Price,
			sc.ServiceCategoryId,
			tmp.[Description]			
		from cte_CreateServiceData as tmp
		inner join ServiceStatuses as ss on ss.ServiceStatus = tmp.ServiceStatus
		inner join ServiceCategories as sc on sc.ServiceCategory = tmp.ServiceCategory
		inner join Users as adm on adm.[Login] = tmp.[AdminLogin] AND adm.PasswordHash = tmp.AdminPasswordHash
		inner join UserRoles as ur on (adm.UserRoleId = ur.UserRoleId AND ur.UserRole = 'Administrator')	

		begin transaction
--insert Service 
			insert into dbo.Services
			(
				ServiceName,
				ServiceStatusId,
				Comment,
				Price,
				ServiceCategoryId,
				[Description]			
			)
			select				
				ServiceName,
				ServiceStatusId,
				Comment,
				Price,
				ServiceCategoryId,
				[Description]			
			from #CreateServiceData

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