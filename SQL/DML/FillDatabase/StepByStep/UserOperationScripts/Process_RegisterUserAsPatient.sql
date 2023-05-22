use MedCenterDB
go

--delete Patients

declare @patientRegisterJson nvarchar(max) =
N'
{
  "User": {
    "Login": "Tykooon"
  },
  "PatientInfo": {
    "PatientPassport": "MP1357911",
    "PatientStatus": {
      "PatientStatus": "VIP"
    },
    "PatientHomeAddress": "Minsk, Chapaeva 5, off.417",
    "InsurancePolicy": "Task, DS034252321",
    "Photo": "https://robohash.org/set_set1/bgset_bg2/AlexanderTykoun",
    "ChronicDeseases": "Hypertesia",
    "RegisterDateTime": "2022-10-07T18:52:40.4914321+03:00",
    "IndividualNotes": "No Allergy to Medicine",
    "InnerComment": "No Comments"
  },
  "Registrator": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  }
}
'

exec dbo.usp_RegisterUserAsPatient
	@patientRegisterJson
go
----------------------------------------------------------

declare @patientRegisterJson nvarchar(max) =
N'
{
  "User": {
    "Login": "GoodGuy"
  },
  "PatientInfo": {
    "PatientPassport": "MP9786754",
    "PatientStatus": {
      "PatientStatus": "Regular"
    },
    "PatientHomeAddress": "Minsk, Chapaeva 5, off.317",
    "Photo": "https://robohash.org/set_set1/bgset_bg2/Guydo",
    "ChronicDeseases": "Miopia",
    "RegisterDateTime": "2022-10-10T17:54:16.7995554+03:00",
    "IndividualNotes": " ",
    "InnerComment": "No Comments"
  },
  "Registrator": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  }
}
'

exec dbo.usp_RegisterUserAsPatient
	@patientRegisterJson
go
----------------------------------------------------------

declare @patientRegisterJson nvarchar(max) =
N'
{
  "User": {
    "Login": "Malets"
  },
  "PatientInfo": {
    "PatientPassport": "MP8463756",
    "PatientStatus": {
      "PatientStatus": "Regular"
    },
    "PatientHomeAddress": "Minsk, Chapaeva 5, off.117",
    "InsurancePolicy": "Task, DS033754321",
    "Photo": "https://robohash.org/set_set1/bgset_bg2/Maletsky",
    "ChronicDeseases": " ",
    "RegisterDateTime": "2022-10-10T17:54:16.7995561+03:00",
    "IndividualNotes": " ",
    "InnerComment": "No Comments"
  },
  "Registrator": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  }
}
'

exec dbo.usp_RegisterUserAsPatient
	@patientRegisterJson
go
----------------------------------------------------------

declare @patientRegisterJson nvarchar(max) =
N'
{
  "User": {
    "Login": "Liviu"
  },
  "PatientInfo": {
    "PatientPassport": "MP1113423",
    "PatientStatus": {
      "PatientStatus": "Discount"
    },
    "PatientHomeAddress": "Minsk, Chapaeva 7, off.417",
    "InsurancePolicy": " ",
    "Photo": "https://robohash.org/set_set1/bgset_bg2/Liviu",
    "ChronicDeseases": "No",
    "RegisterDateTime": "2022-10-10T17:54:16.7995787+03:00",
    "IndividualNotes": "No registration in Minsk",
    "InnerComment": "No Comments"
  },
  "Registrator": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  }
}
'

exec dbo.usp_RegisterUserAsPatient
	@patientRegisterJson
go
----------------------------------------------------------

declare @patientRegisterJson nvarchar(max) =
N'
{
  "User": {
    "Login": "Gavr"
  },
  "PatientInfo": {
    "PatientPassport": "MP0203042",
    "PatientStatus": {
      "PatientStatus": "Regular"
    },
    "PatientHomeAddress": "Minsk, Chapaeva 7, off.417",
    "InsurancePolicy": " ",
    "Photo": "https://robohash.org/set_set1/bgset_bg2/Gavrilenko",
    "ChronicDeseases": "No info",
    "RegisterDateTime": "2022-09-10T17:54:16.7995787+03:00",
    "IndividualNotes": "Registred in Minsk",
    "InnerComment": "No Essential Comments"
  },
  "Registrator": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  }
}
'

exec dbo.usp_RegisterUserAsPatient
	@patientRegisterJson
go
----------------------------------------------------------