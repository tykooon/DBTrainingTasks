use MedCenterDB
go

if OBJECT_ID('dbo.TestStates', 'U') is not null
	drop table dbo.TestStates
go

create table dbo.TestStates
(
	TestStateId		tinyint			not null identity,
	TestState		nvarchar(30)	not null,

	constraint PK_TestStates primary key (TestStateId)
);
go