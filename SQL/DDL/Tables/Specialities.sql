use MedCenterDB
go

if OBJECT_ID('dbo.Specialities', 'U') is not null
	drop table dbo.Specialities
go

create table dbo.Specialities
(
	SpecialityId			tinyint			not null identity,
	Speciality				nvarchar(30)	not null,

	constraint PK_Specialities primary key (SpecialityId)
);
go