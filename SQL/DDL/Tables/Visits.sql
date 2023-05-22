use MedCenterDB
go

if OBJECT_ID('dbo.Visits', 'U') is not null
	drop table dbo.Visits
go

create table dbo.Visits
(
	VisitId					int			not null identity,
	BaseService				int				not null,
	Specialist				int				not null,
	ScheduledDateTime		datetime2		not null,
	RecordedPatient			int				null,
	PreliminaryNotes		nvarchar(300)	null,
	VisitRoom				int				not null,
	Summary					nvarchar(300)	null,
	TotalPrice				money			null,
	PaymentStateId			tinyint			not null,
	VisitTypeId				tinyint			not null, 
	VisitStatusId			tinyint			not null,
	InternalComment			nvarchar(200)	null,
	RecordDateTime			datetime2		null,

	constraint PK_Visits primary key (VisitId)
);
go