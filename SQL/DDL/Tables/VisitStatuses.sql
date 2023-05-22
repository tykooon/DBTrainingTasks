use MedCenterDB
go

if OBJECT_ID('dbo.VisitStatuses', 'U') is not null
	drop table dbo.VisitStatuses
go

create table dbo.VisitStatuses
(
	VisitStatusId		tinyint			not null identity,
	VisitStatus			nvarchar(30)	not null,

	constraint PK_VisitStatuses primary key (VisitStatusId)
);
go