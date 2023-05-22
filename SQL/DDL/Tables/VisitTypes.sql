use MedCenterDB
go

if OBJECT_ID('dbo.VisitTypes', 'U') is not null
	drop table dbo.VisitTypes
go

create table dbo.VisitTypes
(
	VisitTypeId			tinyint			not null identity,
	VisitType			nvarchar(30)	not null,

	constraint PK_VisitTypes primary key (VisitTypeId)
);
go