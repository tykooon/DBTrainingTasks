use MedCenterDB
go

if OBJECT_ID('dbo.EquipmentStates', 'U') is not null
	drop table dbo.EquipmentStates
go

create table dbo.EquipmentStates
(
	EquipmentStateId		tinyint			not null identity,
	EquipmentState			nvarchar(30)	not null,

	constraint PK_EquipmentStates primary key (EquipmentStateId)
);
go