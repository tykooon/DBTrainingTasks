use MedCenterDB
go

if OBJECT_ID('dbo.PatientStatuses', 'U') is not null
	drop table dbo.PatientStatuses
go

create table dbo.PatientStatuses
(
	PatientStatusId		tinyint			not null identity,
	PatientStatus		nvarchar(30)	not null,

	constraint PK_PatientStatuses primary key (PatientStatusId)
);
go