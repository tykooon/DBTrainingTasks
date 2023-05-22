use MedCenterDB
go

if OBJECT_ID('dbo.StafferGroups', 'U') is not null
	drop table dbo.StafferGroups
go

create table dbo.StafferGroups
(
	StafferGroupId			tinyint			not null identity,
	StafferGroup			nvarchar(30)	not null,

	constraint PK_StafferGroups primary key (StafferGroupId)
);
go