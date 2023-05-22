use MedCenterDB
go

if OBJECT_ID('dbo.Patients', 'U') is not null
	drop table dbo.Patients
go

create table dbo.Patients
(
	PatientId					int				not null identity,
	PatientUserId				int				not null,
	PatientPassport				nvarchar(10)	not null,
	PatientHomeAddress			nvarchar(100)	not null,
	PatientStatusId				tinyint			not null,
	InsurancePolicy				nvarchar(30)	null,
	Photo						nvarchar(200)	null, 
	ChronicDeseases				nvarchar(200)	null,
	IndividualNotes				nvarchar(200)	null,
	InnerComment				nvarchar(200)	null,
	RegisterDateTime			datetime2		not null,
	PatientRegistrator			int				not null,

	constraint PK_Patients primary key (PatientId)
);
go