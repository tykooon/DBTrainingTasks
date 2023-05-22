use MedCenterDB
go

declare @json nvarchar(max) =
N'
{
  "Viewer": {
		"Login": "Tykooon",
		"PasswordHash": "20e0dckdjc02kdcjlaksdca"     
	},
  "Filters": {
  "EndDateTime": "2022-11-30T12:00:00"

  },
  "VisitOptions": "AllRecords",
  "OrderTarget": "Date",
  "OrderType": "Asc"
}
'

exec dbo.usp_ViewVisits
	@json
go
