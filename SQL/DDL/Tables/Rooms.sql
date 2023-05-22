use MedCenterDB
go

if OBJECT_ID('dbo.Rooms', 'U') is not null
	drop table dbo.Rooms
go

create table dbo.Rooms
(
	RoomId						int				not null identity,
	RoomName					nvarchar(20)	not null,
	RoomTypeId					tinyint			not null,
	RoomStateId					tinyint			not null,
	LastUpdateDateTime			datetime2		not null,
	RoomNotes					nvarchar(100)	null,

	constraint PK_Rooms primary key (RoomId)
);
go