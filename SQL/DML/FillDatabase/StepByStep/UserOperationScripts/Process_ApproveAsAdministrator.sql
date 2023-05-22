declare @ApproveAsAdminJson nvarchar(max) =
N'
{
  "User": {
    "Login": "Kalabukh",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Approver": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  }
}
'

exec usp_ApproveAsAdministrator
	@ApproveAsAdminJson
