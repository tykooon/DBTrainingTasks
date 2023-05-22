use MedCenterDB
go

if OBJECT_ID('dbo.Services', 'U') is not null
	drop table dbo.Services
go

create table dbo.Services
(
	ServiceId					int				not null identity,
	ServiceName					nvarchar(50)	not null,
	ServiceStatusId				tinyint			not null,
	Comment						nvarchar(150)	null,
	Price						money			null,
	ServiceCategoryId			tinyint			not null, 
	[Description]				nvarchar(200)	null,

	constraint PK_Services primary key (ServiceId)
);
go