use MedCenterDB
go


-- Wrong Login
declare @json nvarchar(max) =
N'
{
  "User": {
    "Login": "Tykun"
    }
}
'
exec dbo.usp_InitializeAdministrator
	@json
go

--****************************************************
-- Wrong JSON
declare @json nvarchar(max) =
N'
{
  "User": {
    "Nickname": "Tykooon",
	"PasswordHash": "@#%232352342#41@43@35"
    }
}
'
exec dbo.usp_InitializeAdministrator
	@json
go
