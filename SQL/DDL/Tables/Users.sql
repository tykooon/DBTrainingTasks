use MedCenterDB
go

if OBJECT_ID('dbo.Users', 'U') is not null
	drop table dbo.Users
go

create table dbo.Users
(
	UserId					int				not null identity,
	[Login]					nvarchar(20)	not null,
	Email					nvarchar(50)	null,
	PasswordHash			char(64)		not null,
	FullName				nvarchar(100)	not null,
	GenderId				tinyint			not null, 
	DateOfBirth				date			not null,
	UserRoleId				tinyint			not null,
	RegisterDateTime		datetime2		not null,
	LastActiveDateTime		datetime2		not null,
	AdminApprover			int				null,

	constraint PK_Users primary key (UserId)
);
go