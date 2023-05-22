use MedCenterDB
go

if OBJECT_ID('dbo.RoomTypes', 'U') is not null
	drop table dbo.RoomTypes
go

create table dbo.RoomTypes
(
	RoomTypeId		tinyint			not null identity,
	RoomType		nvarchar(30)	not null,

	constraint PK_RoomTypes primary key (RoomTypeId)
);
go