use MedCenterDB
go

if OBJECT_ID('dbo.usp_ViewVisits', 'P') is not null
    drop procedure dbo.usp_ViewVisits
go

---------------------------------------------------------------------------------------
-- procedure edits selected data of visit
-- created by:   Alexander Tykoun
-- created date: 10/17/2022
-- sample call: 
-- exec dbo.usp_ViewVisits @params =
--N'{
--  "Viewer": {
--		"Login": "ViewerLogin",
--		"PasswordHash": "00000PASSHASH00000"     
--	},
--  "Filters": {
--  "Specialists":[												--optional
--			{   "Login": "StafferLogin1"		  },			--optional
--		    {	"Login": "StafferLogin2"	  }  	],			--optional
--		"Patient": {	"Login": "PatientLogin"	},				--optional
--		"StartDateTime": "2022-07-19T09:45:24.6821586+03:00",	--optional
--		"EndDateTime": "2022-11-19T09:45:24.6821586+03:00",		--optional	
--		"Rooms": [
--			{	"RoomName": "Cabinet 1" 	  },				--optional
--			{ 	"RoomName": "Cabinet 2" 	  }		],			--optional	
--		"Service": "ServiceName"								--optional
--  },
--  "VisitOptions": "AllRecords/OnlyEmpty/OnlyRecorded",		--optional
--  "OrderTarget": "Date/Specialist/Room/Service",				--optional
--  "OrderType": "Asc/Desc"										--optional
--}'
---------------------------------------------------------------------------------------

create proc dbo.usp_ViewVisits(
    @Json nvarchar(max)
)
as
begin
	if (ISJSON(@Json) < 1)
	begin
		print 'JSON syntax is not valid.'
		return
	end

	begin try

		--if OBJECT_ID('tempdb..#tempJson', 'U') is  not null
		--drop table #tempJson;

            create table #tempJson
            (
				ViewerUserId			int,
                ViewerLogin				nvarchar(20),
				SpecialistId			int,
				SpecialistFullName		nvarchar(30),
				PatientId				int,
				FilterStartDateTime		nvarchar(30),
				FilterEndDateTime		nvarchar(30),
				RoomId					int,
				RoomName				nvarchar(20),
				ServiceId				int,
				ServiceName				nvarchar(50),
				OrderTarget				nvarchar(15),
				OrderType				nvarchar(5),
				IsViewerAdmin			bit,
				IsViewerPatient			bit,
				IsViewerStaffer			bit,
				IsAllSpecialists		bit, 
				VisitOptions			tinyint,
				IsAllRooms				bit,
				IsAllServices			bit
            );

            with cte_jsonData 
			(
				ViewerLogin,	
				ViewerPass,		
				Specialist,	
				StartDateTime,	
				EndDateTime,
				PatientLogin,
				RoomName,			
				ServiceName,	
				OrderTarget,	
				OrderType,
				AllSpecialistsFlag,
				VisitOptions,
				AllRoomsFlag,
				AllServicesFlag
			) as
			(
                select 
					ViewerLogin,	
					ViewerPass,
					SpecialistLogin,	
					StartDateTime,	
					EndDateTime,	
					PatientLogin,
					RoomName,			
					ServiceName,	
					OrderTarget,	
					OrderType,
					case when len(SpecialistsJson) >0 then 0 else 1 end,
					case when PatientLogin is not null then 0 
						 when VisitOptions = 'AllRecords' then 1 
						 when VisitOptions = 'OnlyEmpty' then 2 
						 else 3 end,	   -- Only Visits with Patients 
					case when len(RoomsJson) >0 then 0 else 1 end,		
					case when ServiceName is null then 1 else 0 end

                from OPENJSON(@Json) with
                (
					 ViewerLogin		nvarchar(20)	N'$.Viewer.Login',
					 ViewerPass			char(64)		N'$.Viewer.PasswordHash',
					 SpecialistsJson	nvarchar(max)	N'$.Filters.Specialists' as json,
					 StartDateTime		datetime2(0)	N'$.Filters.StartDateTime',
					 EndDateTime		datetime2(0)	N'$.Filters.EndDateTime',
					 PatientLogin		nvarchar(20)	N'$.Filters.Patient.Login',
					 RoomsJson			nvarchar(max)	N'$.Filters.Rooms' as json,
					 ServiceName		nvarchar(50)	N'$.Filters.Service.ServiceName',
					 VisitOptions		nvarchar(25)	N'$.VisitOptions',
					 OrderTarget		nvarchar(50)	N'$.OrderTarget',
					 OrderType			nvarchar(10)	N'$.OrderType'
				)
				outer apply openjson(SpecialistsJson) with 
				(
					SpecialistLogin		nvarchar(20)	N'$.Login'
				) as specs
				outer apply openjson(RoomsJson) with 
				(
					RoomName		nvarchar(20)	N'$.RoomName'
				) as rooms
            )						
            insert into #tempJson 
			(	
				ViewerUserId,
				ViewerLogin,
                SpecialistId,
				SpecialistFullName,
				PatientId,
				FilterStartDateTime,
				FilterEndDateTime,
				RoomId,
				RoomName,
				ServiceId,
				ServiceName,
				OrderTarget,
				OrderType,
				IsViewerAdmin,
				IsViewerPatient,
				IsViewerStaffer,
				IsAllSpecialists, 
				VisitOptions,
				IsAllRooms,
				IsAllServices )
            select 
				vu.UserId,
				vu.[Login],
                spec_st.StafferId,
				spec_us.FullName,
				pat_filt.PatientId,
				convert(nvarchar(30), StartDateTime),
				convert(nvarchar(30), EndDateTime),
				ro.RoomId,
				ro.RoomName,
				serv.ServiceId,
				serv.ServiceName,
				filt.OrderTarget,
				filt.OrderType,
				case when ur.UserRole = 'Administrator' then 1 else 0 end,
				case when pat.PatientId is not null then 1 else 0 end,
				case when staff.StafferId is not null then 1 else 0 end,
				filt.AllSpecialistsFlag,
				filt.VisitOptions,
				filt.AllRoomsFlag,
				filt.AllServicesFlag
			from cte_JsonData as filt
			inner join Users as vu on vu.[Login] = filt.ViewerLogin AND vu.PasswordHash = filt.ViewerPass
			inner join UserRoles as ur on vu.UserRoleId = ur.UserRoleId
			left join Patients as pat on vu.UserId = pat.PatientUserId
			left join Staffers as staff on vu.UserId = staff.StafferUserId
			left join Users as spec_us on filt.Specialist = spec_us.[Login]
			left join Staffers as spec_st on spec_us.UserId = spec_st.StafferUserId
			left join Users as pat_us on filt.PatientLogin = pat_us.[Login]
			left join Patients as pat_filt on pat_us.UserId = pat_filt.PatientUserId
			left join Rooms as ro on filt.RoomName = ro.RoomName
			left join [Services] as serv on filt.ServiceName = serv.ServiceName;

			declare @innerJoinClause nvarchar(300) = ''
			declare @andPart nvarchar(5) = ''
			declare @whereClause nvarchar (200) = ''
			declare @orderClause nvarchar (200) = ''
			declare @selectPart nvarchar (200) = ''
			declare @patientFilter nvarchar (40) = ''

------------------ JSON ENTREES FILTER
			if ((select top(1) IsAllSpecialists from #tempJson)=0)
			begin 
				set @innerJoinClause = CONCAT(@innerJoinClause, @andPart, 'v.Specialist = tmp.SpecialistId')
				set @andPart = ' AND '
			end
			
			if ((select top(1) VisitOptions from #tempJson)=0)
			begin 
				set @innerJoinClause = CONCAT(@innerJoinClause, @andPart, 'v.RecordedPatient = tmp.PatientId')
				set @andPart = ' AND '
			end

			if ((select top(1) IsAllRooms from #tempJson)=0)
			begin 
				set @innerJoinClause = CONCAT(@innerJoinClause, @andPart, 'v.VisitRoom = tmp.RoomId')
				set @andPart = ' AND '
			end

			if ((select top(1) IsAllServices from #tempJson)=0)
			begin 
				set @innerJoinClause = CONCAT(@innerJoinClause, @andPart, 'v.BaseService = tmp.ServiceId')
			end

			if (len(@innerJoinClause) > 0 )
			begin
				set @innerJoinClause = CONCAT('inner join dbo.#tempJson as tmp on ', @innerJoinClause)
			end

-------------------- TIME FILTER
			set @andPart = ''
			if ((select distinct FilterStartDateTime from #tempJson) is not null)
			begin
				set @whereClause = CONCAT(@whereClause, @andPart, 'v.ScheduledDateTime >= (select top(1) FilterStartDateTime from #tempJson)')
				set @andPart = ' AND '
			end

			if ((select distinct FilterEndDateTime from #tempJson) is not null)
			begin
				set @whereClause = CONCAT(@whereClause, @andPart, 'v.ScheduledDateTime <= (select top(1) FilterEndDateTime from #tempJson)')
			end

			if (len(@whereClause) > 0 )
			begin
				set @whereClause = CONCAT('where ', @whereClause)
			end

			if ((select top(1) IsViewerAdmin from #tempJson)=1)
			begin
				set @selectPart = ', le.EquipmentList,	ISNULL(la.AssistantList,'' '') as Assistants'
			end

			set @patientFilter = case 
			when (select top(1) VisitOptions from #tempJson)=2 then 'where vf.Patient is null '
			when (select top(1) VisitOptions from #tempJson)=3 then 'where vf.Patient is not null '
			else ''  	   end

			set @orderClause = lower((select top(1) OrderTarget from #tempJson))
			set @orderClause = case 
				when @orderClause='date' then 'order by vf.VisitDateTime '
				when @orderClause='specialist' then 'order by vf.Specialist '
				when @orderClause='room' then 'order by vf.Room '
				when @orderClause='service' then 'order by vf.Service '
				else ''  	   end
			if (len(@orderClause) > 0 AND lower((select top(1) OrderType from #tempJson)) in ('asc','desc'))
			begin
				set @orderClause = CONCAT(@orderClause, (select top(1) OrderType from #tempJson))
			end

	begin transaction

		declare @sqlScript nvarchar(max) =
'with cte_VisitsFiltered	(
		VisitId,
		Specialist, 
		RoomId,
		Room, 
		[Service], 
		PatientId,
		Patient, 
		VisitDateTime,
		VisitStatus,
		PaymentState
		)
as( select
		VisitId,
		u_st.FullName,
		r.RoomId,
		r.RoomName,
		serv.ServiceName,
		pat.PatientId,
		u_pat.FullName,
		CONVERT(datetime2(0), v.ScheduledDateTime),
		vs.VisitStatus,
		ps.PaymentState
	from Visits as v
	INNER_JOIN_CLAUSE
	inner join Rooms as r on v.VisitRoom = r.RoomId
	inner join Staffers as st on st.StafferId = v.Specialist
	inner join Users as u_st on u_st.UserId = st.StafferUserId
	inner join [Services] as serv on serv.ServiceId = v.BaseService
	inner join VisitStatuses as vs on v.VisitStatusId = vs.VisitStatusId
	inner join PaymentStates as ps on v.PaymentStateId = ps.PaymentStateId
	left join Patients as pat on pat.PatientId = v.RecordedPatient
	left join Users as u_pat on u_pat.UserId = pat.PatientUserId
	WHERE_CLAUSE
),
cte_ListEquip 
	(	VisitId,
		EquipmentList )
as(
	select 
		cte.VisitId,
		STRING_AGG(eq.EquipmentName, '', '')
	from cte_VisitsFiltered as cte 
	inner join Equipments as eq on eq.EquipmentRoom = cte.RoomId
	Group by cte.VisitId 
	),
cte_ListAssist
	(	VisitId,
		AssistantList  )
as(
	select	
		cte2.VisitId,
		STRING_AGG(us_as.FullName, '', '')
	from cte_VisitsFiltered as cte2
	inner join StaffersVisitsLink as svl on svl.VisitId = cte2.VisitId
	inner join Staffers as as_st on svl.StafferId = as_st.StafferId
	inner join Users as us_as on as_st.StafferUserId = us_as.UserId
	Group by cte2.VisitId
	)
select 
		CONVERT(date, vf.VisitDateTime) as VisitDate,
		FORMAT(vf.VisitDateTime,''HH:mm'') as VisitTime,
		vf.Specialist,
		vf.Room,
		vf.Patient,
		vf.[Service] ADMIN_EXTENSION , 
		vf.VisitStatus, 
		vf.PaymentState
from cte_VisitsFiltered as vf
left join cte_ListEquip as le on vf.VisitId = le.VisitId
left join cte_ListAssist as la on vf.VisitId = la.VisitId
PATIENT_FILTER
ORDER_CLAUSE 
'

set @sqlScript = REPLACE(@sqlScript, 'INNER_JOIN_CLAUSE', @innerJoinClause )
set @sqlScript = REPLACE(@sqlScript, 'WHERE_CLAUSE', @whereClause )
set @sqlScript = REPLACE(@sqlScript, 'ADMIN_EXTENSION', @selectPart )
set @sqlScript = REPLACE(@sqlScript, 'PATIENT_FILTER', @patientFilter )
set @sqlScript = REPLACE(@sqlScript, 'ORDER_CLAUSE', @orderClause )


exec(@sqlScript)
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