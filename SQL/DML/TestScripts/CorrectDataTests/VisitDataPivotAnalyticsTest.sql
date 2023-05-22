use MedCenterDB
go

declare @Json nvarchar(max) =
N'
{
	"Viewer": {
		 "Login": "Kalabukh",
		 "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
		},
	"ServiceCategories":	[	
			"Operation",
			"Test"			],	
	"PatientStatuses":		[	
			"Social",
			"VIP"			],	
	"EndDateTime": "2022-11-26T09:45:24.6821586+03:00",
	"ShowNullRows": 1,
	"ShowNullCols": 1
}
'

exec usp_VisitDataPivotAnalytics
	@Json
go

declare @Json nvarchar(max) =
N'
{
	"Viewer": {
		 "Login": "Kalabukh",
		 "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
		},
	"EndDateTime": "2022-11-26T09:45:24.6821586+03:00",
	"TargetOutput": "Visits",
	"ShowNullRows": 1,
	"ShowNullCols": 1
}
'

exec usp_VisitDataPivotAnalytics
	@Json
go
	
	declare @Json nvarchar(max) =
N'
{
	"Viewer": {
		 "Login": "Kalabukh",
		 "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
		},
	"EndDateTime": "2022-11-26T09:45:24.6821586+03:00",
	"ShowNullRows": 0,
	"ShowNullCols": 0
}
'

exec usp_VisitDataPivotAnalytics
	@Json
go