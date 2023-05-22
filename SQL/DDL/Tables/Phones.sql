use MedCenterDB
go

if OBJECT_ID('dbo.Phones', 'U') is not null
	drop table dbo.Phones
go

create table dbo.Phones
(
	PhoneId			int				not null identity,
	PhoneNumber		nvarchar(20)	not null,

	constraint PK_Phones primary key (PhoneId)
);
go