use MedCenterDB
go

if OBJECT_ID('dbo.ServiceStatuses', 'U') is not null
	drop table dbo.ServiceStatuses
go

create table dbo.ServiceStatuses
(
	ServiceStatusId				tinyint			not null identity,
	ServiceStatus				nvarchar(30)	not null,

	constraint PK_ServiceStatuses primary key (ServiceStatusId)
);
go