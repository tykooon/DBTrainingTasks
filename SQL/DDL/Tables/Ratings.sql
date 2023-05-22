use MedCenterDB
go

if OBJECT_ID('dbo.Ratings', 'U') is not null
	drop table dbo.Ratings
go

create table dbo.Ratings
(
	RatingId			int				not null identity,
	PatientId			int				not null,
	StafferId			int				not null,
	RatingValue			tinyint			not null,
	RatingComment		nvarchar(250)	null,
	RatingDateTime		datetime2		not null,

	constraint PK_Ratings primary key (RatingId)
);
go