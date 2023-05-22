use MedCenterDB
go

if OBJECT_ID('dbo.UsersPhonesLink', 'U') is not null
	drop table dbo.UsersPhonesLink
go

create table dbo.UsersPhonesLink
(
	UserId		int			not null,
	PhoneId		int			not null,

	constraint PK_UsersPhonesLink primary key (UserId, PhoneId)
);
go