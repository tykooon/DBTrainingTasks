use MedCenterDB
go

declare @editVisitJson nvarchar(max) = 
N'
{
  "Staffer": {
    "Login": "Kheidor",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "VisitInfo": {
    "ScheduledDateTime": "2022-10-22T09:30:00",
	"InternalComment": "Hard accessible region", 
	"Summary": "Nothing exceptional is found",
	"VisitStatus": { "VisitStatus": "Finished" }
  }
}
'
exec dbo.usp_EditVisit 
	@editVisitJson
go
--------------------------------------------------------

declare @editVisitJson nvarchar(max) = 
N'
{
  "Staffer": {
    "Login": "Kheidor",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "VisitInfo": {
    "ScheduledDateTime": "2022-10-22T10:00:00",
	"InternalComment": "Inadequate reactions", 
	"Summary": "Left ventricular mass index is normal",
	"VisitStatus": { "VisitStatus": "Finished" }
  }
}
'
exec dbo.usp_EditVisit 
	@editVisitJson
go
--------------------------------------------------------

declare @editVisitJson nvarchar(max) = 
N'
{
  "Staffer": {
    "Login": "Kheidor",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "VisitInfo": {
    "ScheduledDateTime": "2022-10-22T10:30:00",
	"InternalComment": "(No)", 
	"Summary": "No changes",
	"VisitStatus": { "VisitStatus": "Finished" }
  }
}
'
exec dbo.usp_EditVisit 
	@editVisitJson
go
--------------------------------------------------------

declare @editVisitJson nvarchar(max) = 
N'
{
  "Staffer": {
    "Login": "Kheidor",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "VisitInfo": {
    "ScheduledDateTime": "2022-10-22T09:00:00",
	"InternalComment": "(No)", 
	"Summary": "Singular Rare Extrasistoles",
	"VisitStatus": { "VisitStatus": "Finished" }
  }
}
'
exec dbo.usp_EditVisit 
	@editVisitJson
go
--------------------------------------------------------