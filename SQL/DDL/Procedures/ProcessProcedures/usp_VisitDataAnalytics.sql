use MedCenterDB
go

if OBJECT_ID('dbo.usp_VisitDataAnalytics', 'P') is not null
    drop procedure dbo.usp_VisitDataAnalytics
go

---------------------------------------------------------------------------------------
-- procedure sort data of visits by two categories: Service Category and Patient Status
-- created by:   Alexander Tykoun
-- created date: 10/20/2022
-- sample call: 
-- exec dbo.usp_VisitDataAnalytics @params =
--N'{
--  "Viewer": {
--		"Login": "ViewerLogin",
--		"PasswordHash": "00000PASSHASH00000"     
--	},
--	"ServiceCategories": [									--optional. null = ALL
--			"Category1",
--			"Category2",  ],
--	"PatientStatuses": [									--optional. null = ALL
--			"Status1",
--			"Status2",  ],
--	"StartDateTime": "2022-07-19T09:45:24.6821586+03:00",	--optional. null = from Start 
--	"EndDateTime": "2022-11-19T09:45:24.6821586+03:00",		--optional. null = till Today	
--  "ShowNullRows": "0/1",									--optional. null = 0 (false) 
--  "ShowNullCols": "0/1"									--optional. null = 0 (false)
--}'
---------------------------------------------------------------------------------------

create proc dbo.usp_VisitDataAnalytics(
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
            create table #tempJson2
            (
				ServiceCategory			nvarchar(30),
				PatientStatus			nvarchar(30),
				FilterStartDateTime		datetime2(0),
				FilterEndDateTime		datetime2(0),
				TargetOutput			nvarchar(30),
				IsAllCategories			bit, 
				IsAllStatuses			bit, 
				ShowNullRows			bit,
				ShowNullCols			bit
            );

            with cte_jsonData 
			(
				ViewerLogin,	
				ViewerPass,		
				StartDateTime,	
				EndDateTime,
				ServiceCategory,
				PatientStatus,			
				IsAllCategories,
				IsAllStatuses,
				TargetOutput,
				ShowNullRows,
				ShowNullCols
			) as
			(
                select 
					ViewerLogin,	
					ViewerPass,
					ISNULL(StartDateTime, (select MIN(ScheduledDateTime) from Visits)),	
					ISNULL(EndDateTime, SYSDATETIME()),	
					ServiceCategory,	
					PatientStatus,	
					case when len(ServiceCategoriesJson) >0 then 0 else 1 end,
					case when len(PatientStatusesJson) >0 then 0 else 1 end,		
					ISNULL(TargetOutput, 'TotalIncome'),
					ShowNullRows,
					ShowNullCols
                from OPENJSON(@Json) with
                (
					 ViewerLogin			nvarchar(20)	N'$.Viewer.Login',
					 ViewerPass				char(64)		N'$.Viewer.PasswordHash',
					 ServiceCategoriesJson	nvarchar(max)	N'$.ServiceCategories' as json,
					 PatientStatusesJson	nvarchar(max)	N'$.PatientStatuses' as json,
					 StartDateTime			datetime2(0)	N'$.StartDateTime',
					 EndDateTime			datetime2(0)	N'$.EndDateTime',
					 TargetOutput			nvarchar(30)	N'$.TargetOutput',
					 ShowNullRows			bit				N'$.ShowNullRows',
					 ShowNullCols			bit				N'$.ShowNullCols'
				)
				outer apply openjson(ServiceCategoriesJson) with 
				(
					ServiceCategory		nvarchar(30)	N'$'
				) as scat
				outer apply openjson(PatientStatusesJson) with 
				(
					PatientStatus		nvarchar(20)	N'$'
				) as pstat
            )
		
            insert into #tempJson2 
			(	
				ServiceCategory,
				PatientStatus,	
				FilterStartDateTime,
				FilterEndDateTime,
				IsAllCategories,
				IsAllStatuses,	
				TargetOutput,
				ShowNullRows,
				ShowNullCols				
			)
            select 
				filt.ServiceCategory,
				filt.PatientStatus,
				filt.StartDateTime,
				filt.EndDateTime,
				filt.IsAllCategories,
				filt.IsAllStatuses,
				filt.TargetOutput,
				filt.ShowNullRows,
				filt.ShowNullCols
			from cte_JsonData as filt
			inner join Users as vu on vu.[Login] = filt.ViewerLogin AND vu.PasswordHash = filt.ViewerPass
			inner join UserRoles as ur on vu.UserRoleId = ur.UserRoleId
			where ur.UserRole = 'Administrator'

			if not exists (select #tempJson2.FilterEndDateTime,
			                      #tempJson2.FilterStartDateTime 
                           from #tempJson2
                           where #tempJson2.FilterStartDateTime < #tempJson2.FilterEndDateTime)
            begin
                print 'Error. Transaction aborted.'
                return
            end

			create table #tempServiceCategories
            (
                ServiceCategoryId	tinyint,
				ServiceCategory		nvarchar(30)
            )

            create table #tempPatientStatuses
            (
                PatientStatusId		tinyint,
				PatientStatus		nvarchar(30)
            )

            create table #tempRawData
            (
                ServiceCategoryId   tinyint,
				ServiceCategory		nvarchar(30),
                PatientStatusId		tinyint,
				PatientStatus		nvarchar(30),
				VisitId				int,
                VisitStatus			nvarchar(30),
				PaymentState		nvarchar(30),
				VisitDateTime		datetime2,
				TotalPrice			money,
				PatientId			int
            );

			if 1 = (select distinct IsAllCategories
                       from #tempJson2)
				begin
					insert into #tempServiceCategories (ServiceCategoryId, ServiceCategory)
					select ServiceCategoryId, ServiceCategory
					from ServiceCategories ;
	            end
            else
		        begin
				    insert into #tempServiceCategories (ServiceCategoryId, ServiceCategory)
					select distinct sc.ServiceCategoryId, sc.ServiceCategory
					from ServiceCategories as sc
					inner join #tempJson2 as tmp on (sc.ServiceCategory = tmp.ServiceCategory);
				end

			if 1 = (select distinct IsAllStatuses
                       from #tempJson2)
				begin
					insert into #tempPatientStatuses (PatientStatusId, PatientStatus)
					select PatientStatusId, PatientStatus
					from PatientStatuses ;
	            end
            else
		        begin
				    insert into #tempPatientStatuses (PatientStatusId, PatientStatus)
					select  distinct ps.PatientStatusId, ps.PatientStatus
					from PatientStatuses as ps
					inner join #tempJson2 as tmp on (ps.PatientStatus = tmp.PatientStatus);
				end

            if 1 = (select distinct #tempJson2.ShowNullRows from #tempJson2)
            begin
                -- all Rows
                insert into #tempRawData (
					ServiceCategoryId,
					ServiceCategory,
					PatientStatusId,
					PatientStatus,
					VisitId,
					VisitDateTime,
					PatientId,
					TotalPrice,
					VisitStatus,
					PaymentState )
                select sc_tmp.ServiceCategoryId,
					   sc_tmp.ServiceCategory,
                       ps.PatientStatusId,
					   ps.PatientStatus,
					   v.VisitId,
                       v.ScheduledDateTime,
					   v.RecordedPatient,
					   v.TotalPrice,
					   vs.VisitStatus,
					   pay.PaymentState
				from #tempServiceCategories as sc_tmp
				left outer join
                     (ServiceCategories as sc
					 inner join [Services] as serv on serv.ServiceCategoryId = sc.ServiceCategoryId
					 inner join Visits as v on v.BaseService = serv.ServiceId
					 inner join Patients as pat on pat.PatientId = v.RecordedPatient
					 inner join PatientStatuses as ps on (pat.PatientStatusId = ps.PatientStatusId)
					 inner join VisitStatuses as vs on v.VisitStatusId = vs.VisitStatusId
					 inner join PaymentStates as pay on v.PaymentStateId = pay.PaymentStateId					 
					 )
                         on (sc_tmp.ServiceCategoryId = sc.ServiceCategoryId)
                where ((v.ScheduledDateTime >= (select distinct FilterStartDateTime from #tempJson2)) and
                        (v.ScheduledDateTime <= (select distinct FilterEndDateTime from #tempJson2)) 
						OR v.ScheduledDateTime is null) 
            end
            else
            begin
                insert into #tempRawData (
					ServiceCategoryId,
					ServiceCategory,
					PatientStatusId,
					PatientStatus,
					VisitId,
					VisitDateTime,
					PatientId,
					TotalPrice,
					VisitStatus,
					PaymentState )
                select sc_tmp.ServiceCategoryId,
					   sc_tmp.ServiceCategory,	
                       ps.PatientStatusId,
					   ps.PatientStatus,
					   v.VisitId,
                       v.ScheduledDateTime,
					   v.RecordedPatient,
					   v.TotalPrice,
					   v.VisitStatusId,
					   v.PaymentStateId
				from #tempServiceCategories as sc_tmp
				inner join ServiceCategories as sc on sc_tmp.ServiceCategoryId = sc.ServiceCategoryId
				inner join [Services] as serv on serv.ServiceCategoryId = sc.ServiceCategoryId
				inner join Visits as v on v.BaseService = serv.ServiceId
				inner join Patients as pat on pat.PatientId = v.RecordedPatient
				inner join PatientStatuses as ps on (pat.PatientStatusId = ps.PatientStatusId)
	    		inner join VisitStatuses as vs on v.VisitStatusId = vs.VisitStatusId
				inner join PaymentStates as pay on v.PaymentStateId = pay.PaymentStateId					 
				where (v.ScheduledDateTime >= (select distinct FilterStartDateTime from #tempJson2)) and
                      (v.ScheduledDateTime <= (select distinct FilterEndDateTime from #tempJson2))
            end


	begin transaction				
	 declare @ResultQuery nvarchar(max) =
	 N'(select #tempRawData.ServiceCategory as ''Service Category'',
                        SUM(ISNULL(#tempRawData.TotalPrice,0)) as ''Total'' 
						{SUBQUERY}
                 from #tempRawData
				{WHERE_PART}
				group by #tempRawData.ServiceCategory)
				union all
                (select ''OVERALL'' as ''Service Category'',
                        SUM(ISNULL(#tempRawData.TotalPrice,0)) as ''Total''
						{SUBQUERY}
                 from #tempRawData				
				{WHERE_PART}
	 )'

	declare @ResultSubquery nvarchar(max)
	if 1 = (select distinct ShowNullCols from #tempJson2)
    begin
		set @ResultSubquery  = 
		 (select STRING_AGG(CONCAT(
			'SUM(iif(#tempRawData.PatientStatus in (N''',
			#tempPatientStatuses.PatientStatus,
			'''), #tempRawData.TotalPrice, 0)) as ''',
			#tempPatientStatuses.PatientStatus,
			''''),
			', ')
		 from #tempPatientStatuses)
	end
	else
	begin
		set @ResultSubquery  = 
		 (select STRING_AGG(CONCAT(
			'SUM(iif(#tempRawData.PatientStatus in (N''',
			#tempPatientStatuses.PatientStatus,
			'''), #tempRawData.TotalPrice, 0)) as ''',
			#tempPatientStatuses.PatientStatus,
			''''),
			', ')
		 from #tempPatientStatuses
		 where (#tempPatientStatuses.PatientStatus in (select distinct #tempRawData.PatientStatus
                                                       from #tempRawData
                                                       where (#tempRawData.PatientStatus is not null)))
		 )
	end

	if @ResultSubquery is not null
	set @ResultSubquery = CONCAT(', ', @ResultSubquery) 
	else
	set @ResultSubquery = ' '

	 declare @WherePart nvarchar(max) = 
	 (select STRING_AGG(CONCAT('N''', 
							    #tempPatientStatuses.PatientStatus,
								''''),	
								', ') 
	  from #tempPatientStatuses)
	  if @WherePart is not null 
		set @WherePart = CONCAT('where #tempRawData.PatientStatus in (', @WherePart, ')  OR #tempRawData.PatientStatus is null')
	else 
		set @WherePart = ' '

     set @ResultQuery = replace(@ResultQuery, N'{SUBQUERY}', @ResultSubquery)
	 set @ResultQuery = replace(@ResultQuery, N'{WHERE_PART}', @WherePart)

	 if 'Visits' = (select distinct TargetOutput from #tempJson2)
		set @ResultQuery = replace(@ResultQuery, N'#tempRawData.TotalPrice', 'iif(#tempRawData.VisitId is null, 0, 1)')

	exec (@ResultQuery)
		
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