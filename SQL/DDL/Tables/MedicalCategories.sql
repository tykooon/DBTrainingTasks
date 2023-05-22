use MedCenterDB
go

if OBJECT_ID('dbo.MedicalCategories', 'U') is not null
	drop table dbo.MedicalCategories
go

create table dbo.MedicalCategories
(
	MedicalCategoryId			tinyint			not null identity,
	MedicalCategory				nvarchar(30)	not null,

	constraint PK_MedicalCategories primary key (MedicalCategoryId)
);
go