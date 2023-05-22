use [MedCenterDB]
go

if OBJECT_ID('dbo.usp_SetServicesForEquipments', 'P') is not null
    drop procedure dbo.usp_SetServicesForEquipments
go
---------------------------------------------------------------------------------------
-- procedure assigns list of services to each equipment in list
-- created by:   Alexander Tykoun
-- created date: 10/07/2022
-- sample call: 
-- exec dbo.usp_SetServicesForEquipments @params =
--N'
--{
--  "Admin": {
--    "Login": "Tykooon",
--    "PasswordHash": "20e0dckdjc02kdcjlaksdca" },
--  "Equipments": [
--    { "InventaryNumber": "PC111-222" },
--    { "InventaryNumber": "PC333-444" },
--    { "InventaryNumber": "PC555-666" },
--    { "InventaryNumber": "PC777-888" },
--    { "InventaryNumber": "PC999-000" }                    ],
--  "Services": [
--    { "ServiceName": "Therapist Consultation" },
--    { "ServiceName": "Cardiologist Consultation" }        ]
--}
--'
---------------------------------------------------------------------------------------





create proc [dbo].[usp_SetServicesForEquipments](
    @setServicesForEquipmentJson nvarchar(max)
)
as
begin
	if (ISJSON(@setServicesForEquipmentJson) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try

--		if OBJECT_ID('tempdb..#NewUserRegistrationData', 'U') is  not null
--		drop table #NewUserRegistrationData;
		
		create table #SetServicesForEquipmentsData
		(	
			EquipmentId				int,
			ServiceId				int
		);

		with cte_SetServicesForEquipments
		(
			AdminLogin,
			AdminPass,
			InventaryNumber,
			ServiceName
		) as
		(
			select 
				AdminLogin,
				AdminPass,
				InventaryNumber,
				ServiceName
			from openjson(@setServicesForEquipmentJson)
			with
			(			
				AdminLogin				nvarchar(20)		N'$.Admin.Login',
				AdminPass				char(64)			N'$.Admin.PasswordHash',
				[Equipments]		    nvarchar(max)		N'$.Equipments' as json,
				[Services]				nvarchar(max)		N'$.Services' as json
			)
			outer apply openjson([Services]) with
					(
						ServiceName			nvarchar(50)	N'$.ServiceName'
					)
			outer apply openjson([Equipments]) with
					(
						InventaryNumber		nvarchar(15)	N'$.InventaryNumber'
					)
		)

	insert into #SetServicesForEquipmentsData
		(
			EquipmentId,
			ServiceId
		)
		select
			e.EquipmentId,
			s.ServiceId
		from cte_SetServicesForEquipments as tmp
			inner join [Equipments] as e on e.InventaryNumber = tmp.InventaryNumber
			inner join [Services] as s on s.ServiceName = tmp.ServiceName
			inner join Users as adm on adm.[Login] = tmp.[AdminLogin] AND adm.PasswordHash = tmp.AdminPass
			inner join UserRoles as ur on (adm.UserRoleId = ur.UserRoleId AND ur.UserRole = 'Administrator')	

		begin transaction

--insert EquipmentsServicesLink

			insert into dbo.EquipmentsServicesLink
			(
				EquipmentId,
				ServiceId
			)
			select 
				tmp.EquipmentId,
				tmp.ServiceId
			from #SetServicesForEquipmentsData as tmp			
			left join dbo.EquipmentsServicesLink as esl
				   on esl.EquipmentId = tmp.EquipmentId AND
				      esl.ServiceId  = tmp.ServiceId
			where esl.EquipmentId is null AND esl.ServiceId is null AND
				  tmp.EquipmentId is not null AND tmp.ServiceId is not null			  				   				   

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

