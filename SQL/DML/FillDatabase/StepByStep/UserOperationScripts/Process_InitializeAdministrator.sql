use MedCenterDB
go

declare @json nvarchar(max) =
N'
{
  "User": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
    }
}
'

exec dbo.usp_InitializeAdministrator
	@json
