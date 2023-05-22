use MedCenterDB
go

declare @AcceptPaymentJson nvarchar(max) = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "VisitInfo": {
	"Specialist" : { "Login": "Kheidor" },
    "ScheduledDateTime": "2022-10-22T09:00:00"
  }
}
'

exec dbo.usp_AcceptPayment
	@AcceptPaymentJson
go
--------------------------------------------------------------

declare @AcceptPaymentJson nvarchar(max) = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "VisitInfo": {
	"Specialist" : { "Login": "Kheidor" },
    "ScheduledDateTime": "2022-10-22T09:30:00"
  }
}
'

exec dbo.usp_AcceptPayment
	@AcceptPaymentJson
go
--------------------------------------------------------------


declare @AcceptPaymentJson nvarchar(max) = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "VisitInfo": {
	"Specialist" : { "Login": "Kheidor" },
    "ScheduledDateTime": "2022-10-22T10:00:00"
  }
}
'

exec dbo.usp_AcceptPayment
	@AcceptPaymentJson
go
--------------------------------------------------------------


declare @AcceptPaymentJson nvarchar(max) = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "VisitInfo": {
	"Specialist" : { "Login": "Kheidor" },
    "ScheduledDateTime": "2022-10-22T10:30:00"
  }
}
'

exec dbo.usp_AcceptPayment
	@AcceptPaymentJson
go
--------------------------------------------------------------


