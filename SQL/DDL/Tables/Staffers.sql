use MedCenterDB
go

if OBJECT_ID('dbo.Staffers', 'U') is not null
	drop table dbo.Staffers
go

create table dbo.Staffers
(
	StafferId					int				not null identity,
	StafferUserId				int			not null,
	StafferGroupId				tinyint			not null,
	StafferPassport				nvarchar(10)	not null,
	StafferHomeAddress			nvarchar(100)	not null,
	ShortSummary				nvarchar(200)	null,
	SpecialityId				tinyint			not null,
	MedicalCategoryId			tinyint			not null,
	Photo						nvarchar(200)	null, 
	PersonalNotes				nvarchar(200)	null,
	RegisterDateTime			datetime2		not null,
	StafferRegistrator			int				not null,

	constraint PK_Staffers primary key (StafferId)
);
go