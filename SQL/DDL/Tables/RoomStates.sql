use MedCenterDB
go

if OBJECT_ID('dbo.RoomStates', 'U') is not null
	drop table dbo.RoomStates
go

create table dbo.RoomStates
(
	RoomStateId			tinyint			not null identity,
	RoomState			nvarchar(30)	not null,

	constraint PK_RoomStates primary key (RoomStateId)
);
go