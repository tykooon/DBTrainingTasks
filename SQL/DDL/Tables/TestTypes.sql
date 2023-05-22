use MedCenterDB
go

if OBJECT_ID('dbo.TestTypes', 'U') is not null
	drop table dbo.TestTypes
go

create table dbo.TestTypes
(
	TestTypeId		tinyint			not null identity,
	TestType		nvarchar(30)	not null,

	constraint PK_TestTypes primary key (TestTypeId)
);
go