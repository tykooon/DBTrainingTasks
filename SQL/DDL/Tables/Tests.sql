use MedCenterDB
go

if OBJECT_ID('dbo.Tests', 'U') is not null
	drop table dbo.Tests
go

create table dbo.Tests
(
	TestId					int				not null identity,
	VisitId					int				not null,
	ServiceId				int				not null,
	TestTypeId				tinyint			not null, 
	TestStateId				tinyint			not null,
	Result					nvarchar(300)	null,
	TestComment				nvarchar(200)	null,

	constraint PK_Tests primary key (TestId)
);
go