use MedCenterDB
go

-- Duplicate Passport ERROR
declare @stafferRegisterJson nvarchar(max) =
'
{
  "User": {
      "Login": "Kovboy"   },
  "Staffer": {
    "StafferPassport": "MP1234567",
    "StafferGroup":    {  "StafferGroup": "Receptionists" },
    "MedicalCategory": {  "MedicalCategory": "No Category" },
    "StafferHomeAddress": "Minsk, Chapaeva 5, off.417",
    "ShortSummary": "Education: Belarusian State University, Bachelor of Philology. Expierience: 5 years.",
    "Speciality": { "Speciality": "Non-Medical" }	 	},
  "Registrator": {
      "Login": "Kalabukh",
      "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"   }
}
'
exec dbo.usp_RegisterUserAsStaffer
		@stafferRegisterJson
-- **********************************************


go