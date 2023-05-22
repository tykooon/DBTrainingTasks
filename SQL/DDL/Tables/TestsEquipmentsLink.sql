use MedCenterDB
go

if OBJECT_ID('dbo.TestsEquipmentsLink', 'U') is not null
	drop table dbo.TestsEquipmentsLink
go

create table dbo.TestsEquipmentsLink
(
	EquipmentId		int			not null,
	TestId			int			not null,

	constraint PK_TestsEquipmentsLink primary key (TestId, EquipmentId)
);
go