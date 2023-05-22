use MedCenterDB
go

if OBJECT_ID('dbo.EquipmentsServicesLink', 'U') is not null
	drop table dbo.EquipmentsServicesLink
go

create table dbo.EquipmentsServicesLink
(
	EquipmentId		int			not null,
	ServiceId		int			not null,

	constraint PK_EquipmentsServicesLink primary key (EquipmentId, ServiceId)
);
go