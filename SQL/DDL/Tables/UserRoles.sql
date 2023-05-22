use MedCenterDB
go

if OBJECT_ID('dbo.UserRoles', 'U') is not null
	drop table dbo.UserRoles
go

create table dbo.UserRoles
(
	UserRoleId		tinyint			not null identity,
	UserRole		nvarchar(20)	not null,

	constraint PK_UserRoles primary key (UserRoleId)
);
go