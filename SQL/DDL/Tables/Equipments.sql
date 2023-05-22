use MedCenterDB
go

if OBJECT_ID('dbo.Equipments', 'U') is not null
	drop table dbo.Equipments
go

create table dbo.Equipments
(
	EquipmentId					int				not null identity,
	InventaryNumber				nvarchar(15)	not null,
	EquipmentName				nvarchar(100)	not null,
	EquipmentRoom				int				null,
	EquipmentTypeId				tinyint			not null,
	EquipmentStateId			tinyint			not null,
	RegistrationDateTime		datetime2		not null,
	EquipmentNote				nvarchar(200)	null,
	LastEditor					int				not null,

	constraint PK_Equipments primary key (EquipmentId)
);
go