use MedCenterDB
go

declare @stafferRegisterJson nvarchar(max) =
N'
{
  "User": {
    "Login": "Kovboy"
  },
  "StafferInfo": {
    "StafferPassport": "MP1234567",
    "StafferGroup": {
      "StafferGroup": "Receptionists"
    },
    "MedicalCategory": {
      "MedicalCategory": "No Category"
    },
    "StafferHomeAddress": "Minsk, Chapaeva 5, off.417",
    "ShortSummary": "Education: Belarusian State University, Bachelor of Philology. Expierience: 5 years.",
    "Speciality": {
      "Speciality": "Non-Medical"
    },
    "Photo": "https://robohash.org/set_set1/bgset_bg2/2294dhdg",
    "RegisterDateTime": "2022-10-06T14:57:29.3237698+03:00",
    "PersonalNotes": "Monday - permanent day-off"
  },
  "Registrator": {
    "Login": "Kalabukh",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  }
}
'

exec dbo.usp_RegisterUserAsStaffer
		@stafferRegisterJson
go

declare @stafferRegisterJson nvarchar(max) =
N'
{
  "User": {
    "Login": "Volosevich76"
  },
  "StafferInfo": {
    "StafferPassport": "MP7654321",
    "StafferGroup": {
      "StafferGroup": "Medical Staff"
    },
    "MedicalCategory": {
      "MedicalCategory": "First Category"
    },
    "StafferHomeAddress": "Minsk, Chapaeva 5, off.409",
    "ShortSummary": "Education: Belarusian State University Of Informatics and Radioelectronics, Master Degree. Expierience: 12 years.",
    "Speciality": {
      "Speciality": "Cardiology"
    },
    "Photo": "https://robohash.org/set_set1/bgset_bg2/Alexandra",
    "RegisterDateTime": "2022-10-06T14:57:29.3238207+03:00",
    "PersonalNotes": "Don\u0027t work after 18:00"
  },
  "Registrator": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  }
}
'
exec dbo.usp_RegisterUserAsStaffer
		@stafferRegisterJson
go

declare @stafferRegisterJson nvarchar(max) =
N'
{
  "User": {
    "Login": "Kheidor"
  },
  "StafferInfo": {
    "StafferPassport": "MP9876543",
    "StafferGroup": {
      "StafferGroup": "Medical Staff"
    },
    "MedicalCategory": {
      "MedicalCategory": "Highest Category"
    },
    "StafferHomeAddress": "Minsk, Chapaeva 5, off.400",
    "ShortSummary": "Education: Belarusian State University Of Informatics and Radioelectronics, Master Degree. Expierience: 12 years.",
    "Speciality": {
      "Speciality": "Therapy"
    },
    "Photo": "https://robohash.org/set_set1/bgset_bg2/Igor",
    "RegisterDateTime": "2022-10-06T14:57:29.3238379+03:00"
  },
  "Registrator": {
    "Login": "Kalabukh",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  }
}
'
exec dbo.usp_RegisterUserAsStaffer
		@stafferRegisterJson
go

declare @stafferRegisterJson nvarchar(max) =
N'
{
  "User": {
    "Login": "Oleg66"
  },
  "StafferInfo": {
    "StafferPassport": "MP3456789",
    "StafferGroup": {
      "StafferGroup": "Administration"
    },
    "MedicalCategory": {
      "MedicalCategory": "Second Category"
    },
    "StafferHomeAddress": "Minsk, Chapaeva 5, off.400",
    "ShortSummary": "Education: Belarusian State University, Expierience: 22 years.",
    "Speciality": {
      "Speciality": "Non-Medical"
    },
    "Photo": "https://robohash.org/set_set1/bgset_bg2/Oleg",
    "RegisterDateTime": "2022-10-06T14:21:06.0606289+03:00"
  },
  "Registrator": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  }
}
'
exec dbo.usp_RegisterUserAsStaffer
		@stafferRegisterJson
go

declare @stafferRegisterJson nvarchar(max) =
N'
{
  "User": {
    "Login": "Sidor86"
  },
  "StafferInfo": {
    "StafferPassport": "MP1357986",
    "StafferGroup": {
      "StafferGroup": "Medical Staff"
    },
    "MedicalCategory": {
      "MedicalCategory": "Second Category"
    },
    "StafferHomeAddress": "Minsk, Chapaeva 5, off.401",
    "ShortSummary": "Education: Belarusian State University, Expierience: 16 years.",
    "Speciality": {
      "Speciality": "Nursing"
    },
    "Photo": "https://robohash.org/set_set1/bgset_bg2/Alexei",
    "RegisterDateTime": "2022-10-06T14:57:29.323865+03:00"
  },
  "Registrator": {
    "Login": "Kalabukh",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  }
}
'
exec dbo.usp_RegisterUserAsStaffer
		@stafferRegisterJson
go

--------------------------

declare @stafferRegisterJson nvarchar(max) =
N'
{
  "User": {
    "Login": "ValeraP"
  },
  "StafferInfo": {
    "StafferPassport": "MP0394833",
    "StafferGroup": {
      "StafferGroup": "Medical Staff"
    },
    "MedicalCategory": {
      "MedicalCategory": "First Category"
    },
    "StafferHomeAddress": "Krakow, Poland",
    "ShortSummary": "Education: BSUIR, Expierience: 20 years.",
    "Speciality": {
      "Speciality": "Nursing"
    },
    "Photo": "https://robohash.org/set_set1/bgset_bg2/Valera",
    "RegisterDateTime": "2022-10-02T14:57:29.323865+03:00"
  },
  "Registrator": {
    "Login": "Kalabukh",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  }
}
'
exec dbo.usp_RegisterUserAsStaffer
		@stafferRegisterJson
go