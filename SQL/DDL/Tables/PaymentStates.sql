use MedCenterDB
go

if OBJECT_ID('dbo.PaymentStates', 'U') is not null
	drop table dbo.PaymentStates
go

create table dbo.PaymentStates
(
	PaymentStateId		tinyint			not null identity,
	PaymentState		nvarchar(30)	not null,

	constraint PK_PaymentStates primary key (PaymentStateId)
);
go