use MedCenterDB
go

if OBJECT_ID('dbo.ServiceCategories', 'U') is not null
	drop table dbo.ServiceCategories
go

create table dbo.ServiceCategories
(
	ServiceCategoryId			tinyint			not null identity,
	ServiceCategory			nvarchar(30)	not null,

	constraint PK_ServiceCategories primary key (ServiceCategoryId)
);
go