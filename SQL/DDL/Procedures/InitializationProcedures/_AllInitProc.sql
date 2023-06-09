use MedCenterDB
go

if OBJECT_ID('dbo.usp_ImportNewRefenencesFromJson', 'P') is not null
    drop procedure dbo.usp_ImportNewRefenencesFromJson
go

---------------------------------------------------------------------------------------
-- procedure imports new values fron incoming JSON-parameter into any Reference Table
-- created by: Alexander Tykoun
-- created date: 09/30/2022
-- sample call: 
-- exec dbo.usp_ImportNewRefenencesFromJson 
-- @params =
-- N'
--{
-- "RoomTypes": [
--		{
--			"RoomType": "Common Area"
--		},
--		{
--			"RoomType": "Reception" 
--		}
--   ] 
--}
--'
---------------------------------------------------------------------------------------

create proc usp_ImportNewRefenencesFromJson(
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

-- Extract from json names of Reference Table and Reference Value
		declare @tablename nvarchar(30),
				@fieldname nvarchar(30),
				@pk_name   nvarchar(30)
		
		select @tablename = [key]
		from openjson(@json)

		select @fieldname = [key]
		from openjson(@json, '$.'+@tablename+'[0]')
			
-- МОЖНО ДОБАВИТЬ ПРОВЕРКУ 
--		if OBJECT_ID('dbo.'+@tablename, 'U') is null
--		return

-- Get primary key's name 
		set @pk_name = (
		select c.column_name 
		from  INFORMATION_SCHEMA.TABLE_CONSTRAINTS t
		join INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE c
		on c.constraint_name = t.constraint_name
		where c.table_name = @tablename
		and t.constraint_type='PRIMARY KEY')

-- Import values fron JSON into temporal table
		if OBJECT_ID('tempdb..#RefTempTable', 'U') is  not null
		drop table #RefTempTable;
				
		create table #RefTempTable
		(
				RefName		nvarchar(30)
		)

		insert into #RefTempTable(
				RefName
			)				
		select m.[value]
		from openjson(@json,'$.'+@tablename) as t
		outer apply
			openjson(t.[value]) as m;

-- Preparing script for data insert

		declare @sqlscript nvarchar(300)
		set @sqlscript = 
		'
			insert into dbo.REFTABLE (REPLACENAME)
			select temp.RefName
			from #RefTempTable temp
			left join dbo.REFTABLE rt on rt.REPLACENAME = temp.RefName
			where rt.PKNAME is null and
			temp.RefName is not null
		'
		
		set @sqlscript = replace(@sqlscript,'REFTABLE',@tablename)
		set @sqlscript = replace(@sqlscript,'REPLACENAME',@fieldname)
		set @sqlscript = replace(@sqlscript,'PKNAME',@pk_name)

-- Inserting

		begin transaction
			
			exec (@sqlscript)

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
use MedCenterDB
go

if OBJECT_ID('dbo.usp_ImportPhonesFromJson', 'P') is not null
    drop procedure dbo.usp_ImportPhonesFromJson
go

---------------------------------------------------------------------------------------
-- procedure imports new phone numbers from incoming JSON-parameter into table dbo.Phones
-- created by:   Alexander Tykoun
-- created date: 09/29/2022
-- sample call: 
-- exec dbo.usp_ImportPhonesFromJson @params =
--N'
--[
--  {
--    "PhoneNumber": "\u002B3752911111111"
--  },
--  {
--    "PhoneNumber": "\u002B3753322222222"
--  }
--]
--'
---------------------------------------------------------------------------------------

create proc dbo.usp_ImportPhonesFromJson(
    @arrayOfJsonPhohes nvarchar(max)
)
as
begin
	if (ISJSON(@arrayOfJsonPhohes) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try
	    
		if OBJECT_ID('tempdb..#Phones', 'U') is  not null
		drop table #Phones;
				
		create table #Phones
		(	
			PhoneNumber			nvarchar(20)
		)
		
		insert into #Phones (PhoneNumber)
		select PhoneNumber
		from openjson(@arrayOfJsonPhohes)
		with
		(
			PhoneNumber		nvarchar(20)	N'$.PhoneNumber'
		)

		insert into dbo.Phones (PhoneNumber)
		select ph_tmp.PhoneNumber
		from #Phones ph_tmp
		left join dbo.Phones ph on ph.PhoneNumber = ph_tmp.PhoneNumber
		where ph.PhoneId is null and
		ph_tmp.PhoneNumber is not null

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go
use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParseEquipmentStatesInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParseEquipmentStatesInitialization
go

create procedure dbo.usp_JsonParseEquipmentStatesInitialization
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

		with cte_EquipmentStates([EquipmentState]) as
		(
			select [EquipmentState]
			from OPENJSON(@json) with 
			(
				EquipmentStates nvarchar(max) '$.EquipmentStates' as json
			)
			outer apply
			OPENJSON(EquipmentStates) with
			(
				[EquipmentState] nvarchar(20) '$.EquipmentState'
			)
		)
		insert into dbo.EquipmentStates ([EquipmentState])
		select [EquipmentState]
		from cte_EquipmentStates

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go
use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParseEquipmentTypesInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParseEquipmentTypesInitialization
go

create procedure dbo.usp_JsonParseEquipmentTypesInitialization
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

		with cte_EquipmentTypes([EquipmentType]) as
		(
			select [EquipmentType]
			from OPENJSON(@json) with 
			(
				EquipmentTypes nvarchar(max) '$.EquipmentTypes' as json
			)
			outer apply
			OPENJSON(EquipmentTypes) with
			(
				[EquipmentType] nvarchar(20) '$.EquipmentType'
			)
		)
		insert into dbo.EquipmentTypes ([EquipmentType])
		select [EquipmentType]
		from cte_EquipmentTypes

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go
use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParseGendersInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParseGendersInitialization
go

create procedure dbo.usp_JsonParseGendersInitialization
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

		with cte_Genders([GenderName]) as
		(
			select [GenderName]
			from OPENJSON(@json) with 
			(
				Genders nvarchar(max) '$.Genders' as json
			)
			outer apply
			OPENJSON(Genders) with
			(
				[GenderName] nvarchar(20) '$.GenderName'
			)
		)
		insert into dbo.Genders ([GenderName])
		select [GenderName]
		from cte_Genders

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go
use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParseMedicalCategoriesInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParseMedicalCategoriesInitialization
go

create procedure dbo.usp_JsonParseMedicalCategoriesInitialization
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

		with cte_MedicalCategories([MedicalCategory]) as
		(
			select [MedicalCategory]
			from OPENJSON(@json) with 
			(
				MedicalCategories nvarchar(max) '$.MedicalCategories' as json
			)
			outer apply
			OPENJSON(MedicalCategories) with
			(
				[MedicalCategory] nvarchar(20) '$.MedicalCategory'
			)
		)
		insert into dbo.MedicalCategories ([MedicalCategory])
		select [MedicalCategory]
		from cte_MedicalCategories

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go
use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParsePatientStatusesInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParsePatientStatusesInitialization
go

create procedure dbo.usp_JsonParsePatientStatusesInitialization
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

		with cte_PatientStatuses([PatientStatus]) as
		(
			select [PatientStatus]
			from OPENJSON(@json) with 
			(
				PatientStatuses nvarchar(max) '$.PatientStatuses' as json
			)
			outer apply
			OPENJSON(PatientStatuses) with
			(
				[PatientStatus] nvarchar(20) '$.PatientStatus'
			)
		)
		insert into dbo.PatientStatuses ([PatientStatus])
		select [PatientStatus]
		from cte_PatientStatuses

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go
use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParsePaymentStatesInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParsePaymentStatesInitialization
go

create procedure dbo.usp_JsonParsePaymentStatesInitialization
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

		with cte_PaymentStates([PaymentState]) as
		(
			select [PaymentState]
			from OPENJSON(@json) with 
			(
				PaymentStates nvarchar(max) '$.PaymentStates' as json
			)
			outer apply
			OPENJSON(PaymentStates) with
			(
				[PaymentState] nvarchar(20) '$.PaymentState'
			)
		)
		insert into dbo.PaymentStates ([PaymentState])
		select [PaymentState]
		from cte_PaymentStates

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go
use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParseRoomStatesInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParseRoomStatesInitialization
go

create procedure dbo.usp_JsonParseRoomStatesInitialization
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

		with cte_RoomStates([RoomState]) as
		(
			select [RoomState]
			from OPENJSON(@json) with 
			(
				RoomStates nvarchar(max) '$.RoomStates' as json
			)
			outer apply
			OPENJSON(RoomStates) with
			(
				[RoomState] nvarchar(20) '$.RoomState'
			)
		)
		insert into dbo.RoomStates ([RoomState])
		select [RoomState]
		from cte_RoomStates

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go
use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParseRoomTypesInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParseRoomTypesInitialization
go

create procedure dbo.usp_JsonParseRoomTypesInitialization
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

		with cte_RoomTypes([RoomType]) as
		(
			select [RoomType]
			from OPENJSON(@json) with 
			(
				RoomTypes nvarchar(max) '$.RoomTypes' as json
			)
			outer apply
			OPENJSON(RoomTypes) with
			(
				[RoomType] nvarchar(20) '$.RoomType'
			)
		)
		insert into dbo.RoomTypes ([RoomType])
		select [RoomType]
		from cte_RoomTypes

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go
use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParseServiceCategoriesInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParseServiceCategoriesInitialization
go

create procedure dbo.usp_JsonParseServiceCategoriesInitialization
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

		with cte_ServiceCategories([ServiceCategory]) as
		(
			select [ServiceCategory]
			from OPENJSON(@json) with 
			(
				ServiceCategories nvarchar(max) '$.ServiceCategories' as json
			)
			outer apply
			OPENJSON(ServiceCategories) with
			(
				[ServiceCategory] nvarchar(20) '$.ServiceCategory'
			)
		)
		insert into dbo.ServiceCategories ([ServiceCategory])
		select [ServiceCategory]
		from cte_ServiceCategories

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go
use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParseServiceStatusesInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParseServiceStatusesInitialization
go

create procedure dbo.usp_JsonParseServiceStatusesInitialization
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

		with cte_ServiceStatuses([ServiceStatus]) as
		(
			select [ServiceStatus]
			from OPENJSON(@json) with 
			(
				ServiceStatuses nvarchar(max) '$.ServiceStatuses' as json
			)
			outer apply
			OPENJSON(ServiceStatuses) with
			(
				[ServiceStatus] nvarchar(20) '$.ServiceStatus'
			)
		)
		insert into dbo.ServiceStatuses ([ServiceStatus])
		select [ServiceStatus]
		from cte_ServiceStatuses

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go
use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParseSpecialitiesInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParseSpecialitiesInitialization
go

create procedure dbo.usp_JsonParseSpecialitiesInitialization
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

		with cte_Specialities([Speciality]) as
		(
			select [Speciality]
			from OPENJSON(@json) with 
			(
				Specialities nvarchar(max) '$.Specialities' as json
			)
			outer apply
			OPENJSON(Specialities) with
			(
				[Speciality] nvarchar(20) '$.Speciality'
			)
		)
		insert into dbo.Specialities ([Speciality])
		select [Speciality]
		from cte_Specialities

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go
use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParseStafferGroupsInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParseStafferGroupsInitialization
go

create procedure dbo.usp_JsonParseStafferGroupsInitialization
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

		with cte_StafferGroups([StafferGroup]) as
		(
			select [StafferGroup]
			from OPENJSON(@json) with 
			(
				StafferGroups nvarchar(max) '$.StafferGroups' as json
			)
			outer apply
			OPENJSON(StafferGroups) with
			(
				[StafferGroup] nvarchar(20) '$.StafferGroup'
			)
		)
		insert into dbo.StafferGroups ([StafferGroup])
		select [StafferGroup]
		from cte_StafferGroups

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go
use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParseTestStatesInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParseTestStatesInitialization
go

create procedure dbo.usp_JsonParseTestStatesInitialization
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

		with cte_TestStates([TestState]) as
		(
			select [TestState]
			from OPENJSON(@json) with 
			(
				TestStates nvarchar(max) '$.TestStates' as json
			)
			outer apply
			OPENJSON(TestStates) with
			(
				[TestState] nvarchar(20) '$.TestState'
			)
		)
		insert into dbo.TestStates ([TestState])
		select [TestState]
		from cte_TestStates

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go
use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParseTestTypesInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParseTestTypesInitialization
go

create procedure dbo.usp_JsonParseTestTypesInitialization
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

		with cte_TestTypes([TestType]) as
		(
			select [TestType]
			from OPENJSON(@json) with 
			(
				TestTypes nvarchar(max) '$.TestTypes' as json
			)
			outer apply
			OPENJSON(TestTypes) with
			(
				[TestType] nvarchar(20) '$.TestType'
			)
		)
		insert into dbo.TestTypes ([TestType])
		select [TestType]
		from cte_TestTypes

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go
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
use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParseVisitStatusesInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParseVisitStatusesInitialization
go

create procedure dbo.usp_JsonParseVisitStatusesInitialization
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

		with cte_VisitStatuses([VisitStatus]) as
		(
			select [VisitStatus]
			from OPENJSON(@json) with 
			(
				VisitStatuses nvarchar(max) '$.VisitStatuses' as json
			)
			outer apply
			OPENJSON(VisitStatuses) with
			(
				[VisitStatus] nvarchar(20) '$.VisitStatus'
			)
		)
		insert into dbo.VisitStatuses ([VisitStatus])
		select [VisitStatus]
		from cte_VisitStatuses

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go
use MedCenterDB
go

if OBJECT_ID('dbo.usp_JsonParseVisitTypesInitialization', 'P') is not null
	drop procedure dbo.usp_JsonParseVisitTypesInitialization
go

create procedure dbo.usp_JsonParseVisitTypesInitialization
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

		with cte_VisitTypes([VisitType]) as
		(
			select [VisitType]
			from OPENJSON(@json) with 
			(
				VisitTypes nvarchar(max) '$.VisitTypes' as json
			)
			outer apply
			OPENJSON(VisitTypes) with
			(
				[VisitType] nvarchar(20) '$.VisitType'
			)
		)
		insert into dbo.VisitTypes ([VisitType])
		select [VisitType]
		from cte_VisitTypes

	end try

	begin catch
	
		select	ERROR_NUMBER() AS [error number], 
				ERROR_MESSAGE() AS [error message]

	end catch
end
go
