use MedCenterDB
go

if OBJECT_ID('dbo.EquipmentTypes', 'U') is not null
	drop table dbo.EquipmentTypes
go

create table dbo.EquipmentTypes
(
	EquipmentTypeId			tinyint			not null identity,
	EquipmentType			nvarchar(30)	not null,

	constraint PK_EquipmentTypes primary key (EquipmentTypeId)
);
go