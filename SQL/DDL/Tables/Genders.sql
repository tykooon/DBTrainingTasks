use MedCenterDB
go

if OBJECT_ID('dbo.Genders', 'U') is not null
	drop table dbo.Genders
go

create table dbo.Genders
(
	GenderId		tinyint			not null identity,
	GenderName		nvarchar(30)	not null,

	constraint PK_Genders primary key (GenderId)
);
go