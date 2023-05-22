use MedCenterDB
go

begin -- USER AUTHORIZATION
declare @json nvarchar(max) =
N'
{
  "Guest": { 
    "IpAddress": "22.34.45.34",
    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
    "SessionDateTime": "2022-09-27T19:35:33.6578067+03:00"
  },
  "User": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
    }
}
'

exec dbo.usp_UserAuthorization
	@json
end
go