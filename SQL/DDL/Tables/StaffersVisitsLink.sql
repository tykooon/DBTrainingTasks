use MedCenterDB
go

if OBJECT_ID('dbo.StaffersVisitsLink', 'U') is not null
	drop table dbo.StaffersVisitsLink
go

create table dbo.StaffersVisitsLink
(
	StafferId		int			not null,
	VisitId			int			not null,

	constraint PK_StaffersVisitsLink primary key (StafferId, VisitId)
)
go