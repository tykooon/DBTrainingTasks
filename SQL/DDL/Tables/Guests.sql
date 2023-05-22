use MedCenterDB
go

if OBJECT_ID('dbo.Guests', 'U') is not null
	drop table dbo.Guests
go

create table dbo.Guests
(
	GuestId					int				not null identity,
	IPAddress				nvarchar(15)    not null,
	SessionDateTime			datetime2		not null,
	BrowserUserAgent		nvarchar(200)	not null,
	AuthorizedUser			int				not null,

	constraint PK_Guests primary key (GuestId)
);
go