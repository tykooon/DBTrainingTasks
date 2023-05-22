use MedCenterDB
go

exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "EquipmentStates": [
    {
      "EquipmentState": "In Service"
    },
    {
      "EquipmentState": "Out Of Service" 
    },
    {
      "EquipmentState": "On Repair" 
    },
    {
      "EquipmentState": "Disposed" 
    }
  ] 
}
'
go
 
exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "EquipmentTypes": [
    {
      "EquipmentType": "Personal Computer"
    },
    {
      "EquipmentType": "Ultrasound" 
    },
    {
      "EquipmentType": "X-Ray" 
    },
    {
      "EquipmentType": "Laser Surgery" 
    },
    {
      "EquipmentType": "Analyzer" 
    },
    {
      "EquipmentType": "Office Technic" 
    }
  ] 
}
'
go
 
exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "Genders": [
    {
      "GenderName": "Undefined"
    },
    {
      "GenderName": "Male" 
    },
    {
      "GenderName": "Female" 
    }
  ] 
}
'
go
 
exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "MedicalCategories": [
    {
      "MedicalCategory": "No Category"
    },
    {
      "MedicalCategory": "Second Category"
    },
    {
      "MedicalCategory": "First Category"
    },
    {
      "MedicalCategory": "Highest Category"
    }
  ] 
}
'
go
 
exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "PatientStatuses": [
    {
      "PatientStatus": "VIP"
    },
    {
      "PatientStatus": "Discount" 
    },
    {
      "PatientStatus": "Regular" 
    },
    {
      "PatientStatus": "Social" 
    }
  ] 
}
'
go
 
exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "PaymentStates": [
	{
      "PaymentState": "Not Paid"
    },
    {
      "PaymentState": "Completely Paid"
    },
    {
      "PaymentState": "Rejected" 
    },
    {
      "PaymentState": "Delayed" 
    }
  ] 
}
'
go
 
exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "RoomStates": [
    {
      "RoomState": "Accessible"
    },
    {
      "RoomState": "Non-Accessible" 
    },
    {
      "RoomState": "Renovation" 
    },
    {
      "RoomState": "Abolished" 
    }
  ] 
}
'
go
 
exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "RoomTypes": [
    {
      "RoomType": "Common Area"
    },
    {
      "RoomType": "Doctor''s office" 
    },
    {
      "RoomType": "Service Space" 
    },
    {
      "RoomType": "Laboratory" 
    },
    {
      "RoomType": "Surgery" 
    }
  ] 
}
'
go
 
exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "ServiceCategories": [
    {
      "ServiceCategory": "Consultation"
    },
    {
      "ServiceCategory": "Examination"
    },
    {
      "ServiceCategory": "Test"
    },
    {
      "ServiceCategory": "Manipulation"
    },
    {
      "ServiceCategory": "Operation"
    },
    {
      "ServiceCategory": "Rehabilitation"
    }
  ] 
}
'
go
 
exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "ServiceStatuses": [
    {
      "ServiceStatus": "Accessible"
    },
    {
      "ServiceStatus": "Suspended"
    },
    {
      "ServiceStatus": "Depricated"
    },
    {
      "ServiceStatus": "On Demand"
    }
  ] 
}
'
go
 
exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "Specialities": [
    {
      "Speciality": "Non-Medical"
    },
    {
      "Speciality": "Nursing"
    },
    {
      "Speciality": "Surgery"
    },
    {
      "Speciality": "Therapy"
    },
    {
      "Speciality": "Otorhinolaryngology"
    },
    {
      "Speciality": "Cardiology"
    }
  ] 
}
'
go
 
exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "StafferGroups": [
    {
      "StafferGroup": "Receptionists"
    },
    {
      "StafferGroup": "Medical Staff"
    },
    {
      "StafferGroup": "Administration"
    },
    {
      "StafferGroup": "Technical Staff"
    },
    {
      "StafferGroup": "Non-Staff"
    }
  ] 
}
'
go
 
exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "TestStates": [
    {
      "TestState": "Planned"
    },
    {
      "TestState": "Started" 
    },
    {
      "TestState": "Canceled" 
    },
    {
      "TestState": "Postponed" 
    },
    {
      "TestState": "Completed" 
    },
    {
      "TestState": "Failed" 
    }
  ] 
}
'
go
 
exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "TestTypes": [
    {
      "TestType": "Ultrasonic"
    },
    {
      "TestType": "X-Ray" 
    },
    {
      "TestType": "Blood Analysis" 
    },
    {
      "TestType": "Urine Analysis" 
    },
    {
      "TestType": "Cytology" 
    }
  ] 
}
'
go
 
exec dbo.usp_ImportNewRefenencesFromJson
	@json =
	'
		{
			"UserRoles":
			[
				{
			      "UserRole": "Administrator"
			    },
			    {
			      "UserRole": "Advanced" 
			    },
			    {
			      "UserRole": "Regular" 
			    }
			] 
		}
	'
go
 
exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "VisitStatuses": [
    {
      "VisitStatus": "Planned"
    },
    {
      "VisitStatus": "Canceled" 
    },
    {
      "VisitStatus": "Postponed" 
    },
    {
      "VisitStatus": "Rejected" 
    },
    {
      "VisitStatus": "Finished" 
    },
    {
      "VisitStatus": "Extended" 
    }
  ] 
}
'
go
 
exec dbo.usp_ImportNewRefenencesFromJson
	@json =
'
{
 "VisitTypes": [
    {
      "VisitType": "Consultation"
    },
    {
      "VisitType": "Examination" 
    },
    {
      "VisitType": "Test Taking" 
    },
    {
      "VisitType": "Operation" 
    }
  ] 
}
'
go

begin --USER REGISTRATION
declare @newUserRegisrtationJson nvarchar(max);

set @newUserRegisrtationJson =
'
{
  "Guest": {
    "IpAddress": "22.34.25.34",
    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
    "SessionDateTime": "2022-09-27T19:35:33.6578067+03:00"
  },
  "User": {
	"Login": "Kalabukh",
	"Email": "eugenkalabukhov@coherentsolutions.com",
	"PasswordHash": "20e0wetwdckdjc02kdcjlaksdca",
	"FullName": "Eugen Kalabukhov",
	"Gender": {
	  "GenderName": "Male"
	},
	"DateOfBirth": "12/23/1972",
	"Phones": [
	 {
	   "PhoneNumber": "\u002B375297013414"
	 }
	],
    "RegisterDateTime": "2022-09-04T11:51:00.9086322+03:00",
    "LastActiveDateTime": "2022-10-01T11:51:00.9159824+03:00"
  }
}
'
exec dbo.usp_NewUserRegistration
	@newUserRegisrtationJson

set @newUserRegisrtationJson =
'
{
  "Guest": {
    "IpAddress": "122.38.15.34",
    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
    "SessionDateTime": "2022-09-27T19:35:33.6578067+03:00"
  },
  "User": {
    "Login": "Kheidor",
    "Email": "igorkheidorov@coherentsolutions.com",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca",
    "FullName": "Igor Kheidorov",
    "Gender": {
      "GenderName": "Male"
    },
    "DateOfBirth": "6/15/1974",
    "Phones": [
      {
        "PhoneNumber": "\u002B375296210031"
      }
    ],
    "RegisterDateTime": "2021-03-04T11:51:00.9086322+03:00",
    "LastActiveDateTime": "2022-10-03T11:51:00.9159824+03:00"
  }
}
'

exec dbo.usp_NewUserRegistration
	@newUserRegisrtationJson

set @newUserRegisrtationJson =
'
{
  "Guest": {
    "IpAddress": "122.34.95.4",
    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
    "SessionDateTime": "2022-09-27T19:35:33.6578067+03:00"
  },
  "User": {
    "Login": "Kovboy",
    "Email": "nastyakovbovich@coherentsolutions.com",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca",
    "FullName": "Nastya Kovbovich",
    "Gender": {
      "GenderName": "Female"
    },
    "DateOfBirth": "6/15/1999",
    "Phones": [
      {
        "PhoneNumber": "\u002B375336277743"
      },
      {
        "PhoneNumber": "\u002B16122791213"
      }
    ],
    "RegisterDateTime": "2022-08-04T11:51:00.9086322+03:00"
  }
}
'

exec dbo.usp_NewUserRegistration
	@newUserRegisrtationJson

set @newUserRegisrtationJson =
'
{
  "Guest": {
    "IpAddress": "28.47.25.134",
    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
    "SessionDateTime": "2022-09-27T19:35:33.6578067+03:00"
  },
  "User": {
    "Login": "Oleg66",
    "Email": "olegfridlyand@coherentsolutions.com",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca",
    "FullName": "Oleg Fridlyand",
    "Gender": {
      "GenderName": "Male"
    },
    "DateOfBirth": "6/15/1966",
    "Phones": [
        {
          "PhoneNumber": "\u002B375291225543"
        },
        {
          "PhoneNumber": "\u002B16122360502"
        }
      ],
    "RegisterDateTime": "2022-10-01T11:51:00.9086322+03:00"
  }
}
'


exec dbo.usp_NewUserRegistration
	@newUserRegisrtationJson

set @newUserRegisrtationJson =
'
{
  "Guest": {
    "IpAddress": "116.34.25.34",
    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
    "SessionDateTime": "2022-10-02T20:57:59.0862273+03:00"
  },
  "User": {
    "Login": "Tykooon",
    "Email": "alexandertykun@coherentsolutions.com",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca",
    "FullName": "Alex Tykoun",
    "Gender": {
      "GenderName": "Male"
    },
    "DateOfBirth": "10/13/1977",
    "Phones": [
      {
        "PhoneNumber": "\u002B375296480979"
      },
      {
        "PhoneNumber": "\u002B375173074754"
      }
    ],
    "RegisterDateTime": "2022-10-02T11:51:00.9086322+03:00",
    "LastActiveDateTime": "2022-10-03T11:51:00.9159824+03:00"
  }
}
'


exec dbo.usp_NewUserRegistration
	@newUserRegisrtationJson

set @newUserRegisrtationJson =
'
{
  "Guest": {
    "IpAddress": "212.14.125.4",
    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
    "SessionDateTime": "2022-10-02T20:57:59.0862827+03:00"
  },
  "User": {
    "Login": "Sidor86",
    "Email": "alexandrasidorovich@coherentsolutions.com",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca",
    "FullName": "Alexandra Sidorovich",
    "Gender": {
      "GenderName": "Female"
    },
    "DateOfBirth": "10/26/1986",
    "Phones": [
      {
        "PhoneNumber": "\u002B375295103565"
      }
    ],
    "RegisterDateTime": "2022-09-08T11:51:00.9086322+03:00",
    "LastActiveDateTime": "2022-10-02T11:51:00.9159824+03:00"
  }
}
'

exec dbo.usp_NewUserRegistration
	@newUserRegisrtationJson

	set @newUserRegisrtationJson =
'
{
  "Guest": {
    "IpAddress": "62.53.89.234",
    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
    "SessionDateTime": "2022-10-02T20:57:59.0862829+03:00"
  },
  "User": {
    "Login": "Volosevich76",
    "Email": "alexeyvolosevich@coherentsolutions.com",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca",
    "FullName": "Alexei Volosevich",
    "Gender": {
      "GenderName": "Male"
    },
    "DateOfBirth": "06/15/1976",
    "Phones": [
      {
        "PhoneNumber": "\u002B375296208259"
      }
    ],
    "RegisterDateTime": "2022-07-04T11:51:00.9086322+03:00",
    "LastActiveDateTime": "2022-09-03T11:51:00.9159824+03:00"
  }
}'


exec dbo.usp_NewUserRegistration
	@newUserRegisrtationJson

set @newUserRegisrtationJson =
N'
{
  "Guest": {
    "IpAddress": "62.13.89.214",
    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
    "SessionDateTime": "2022-10-10T18:35:24.6772797+03:00"
  },
  "User": {
    "Login": "Liviu",
    "Email": "LiviuLupanciuc@coherentsolutions.com",
    "PasswordHash": "20e0we45744sdgs43aksdca",
    "FullName": "Liviu Lupanciuc",
    "Gender": {
      "GenderName": "Male"
    },
    "DateOfBirth": "4/15/1999",
    "Phones": [
      {
        "PhoneNumber": "\u002B373(68)936625"
      }
    ],
    "RegisterDateTime": "2022-10-10T18:35:24.6821586+03:00",
    "LastActiveDateTime": "2022-10-10T18:35:24.6821587+03:00"
  }
}
'
exec dbo.usp_NewUserRegistration
	@newUserRegisrtationJson
-----------------------------------

set @newUserRegisrtationJson =
N'
{
  "Guest": {
    "IpAddress": "142.34.25.44",
    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
    "SessionDateTime": "2022-10-10T18:35:24.6772336+03:00"
  },
  "User": {
    "Login": "GoodGuy",
    "Email": "KirillGuydo@coherentsolutions.com",
    "PasswordHash": "20e0wetw346345kdcjlaksdca",
    "FullName": "Kirill Guydo",
    "Gender": {
      "GenderName": "Male"
    },
    "DateOfBirth": "4/3/2004",
    "Phones": [
      {
        "PhoneNumber": "\u002B375(29)3084851"
      }
    ],
    "RegisterDateTime": "2022-10-10T18:35:24.6821578+03:00",
    "LastActiveDateTime": "2022-10-10T18:35:24.6821578+03:00"
  }
}
'
exec dbo.usp_NewUserRegistration
	@newUserRegisrtationJson
-----------------------------------

set @newUserRegisrtationJson =
N'
{
  "Guest": {
    "IpAddress": "172.14.127.4",
    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
    "SessionDateTime": "2022-10-10T18:35:24.6772796+03:00"
  },
  "User": {
    "Login": "Malets",
    "Email": "VadimMaletsky@coherentsolutions.com",
    "PasswordHash": "20e0we457445345kdcjlaksdca",
    "FullName": "Vadim Maletsky",
    "Gender": {
      "GenderName": "Male"
    },
    "DateOfBirth": "2/7/1998",
    "Phones": [
      {
        "PhoneNumber": "\u002B375(29)6662103"
      }
    ],
    "RegisterDateTime": "2022-10-10T18:35:24.6821583+03:00",
    "LastActiveDateTime": "2022-10-10T18:35:24.6821583+03:00"
  }
}
'
exec dbo.usp_NewUserRegistration
	@newUserRegisrtationJson
-----------------------------------

set @newUserRegisrtationJson =
N'
{
  "Guest": {
    "IpAddress": "192.124.127.4",
    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
    "SessionDateTime": "2022-10-10T18:35:24.6772796+03:00"
  },
  "User": {
    "Login": "Gavr",
    "Email": "timofeygavrilenko@coherentsolutions.com",
    "PasswordHash": "20e0we4572346345cjlaksdca",
    "FullName": "Timofey Gavrilenko",
    "Gender": {
      "GenderName": "Male"
    },
    "DateOfBirth": "4/12/1973",
    "Phones": [
      {
        "PhoneNumber": "\u002B375(44) 5860643"
      }
    ],
    "RegisterDateTime": "2022-09-10T18:35:24.6821583+03:00",
    "LastActiveDateTime": "2022-10-10T18:35:24.6821583+03:00"
  }
}
'
exec dbo.usp_NewUserRegistration
	@newUserRegisrtationJson
-----------------------------------

set @newUserRegisrtationJson =
N'
{
  "Guest": {
    "IpAddress": "172.14.17.44",
    "BrowserUserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36",
    "SessionDateTime": "2022-10-10T18:35:24.6772796+03:00"
  },
  "User": {
    "Login": "ValeraP",
    "Email": "ValeryPrytkov@coherentsolutions.com",
    "PasswordHash": "20e0we457445345kdcjla2t351a",
    "FullName": "Valery Prytkov",
    "Gender": {
      "GenderName": "Male"
    },
    "DateOfBirth": "5/1/1969",
    "Phones": [
      {
        "PhoneNumber": "\u002B48517251998"
      },
	  {
        "PhoneNumber": "\u002B375(29)3495574"
      }
    ],
    "RegisterDateTime": "2022-10-03T18:35:24.6821583+03:00"
  }
}
'
exec dbo.usp_NewUserRegistration
	@newUserRegisrtationJson
end
go


begin --INITIALIZE ADMIN
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
end
go


begin --APPROVE AS ADMIN
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
end 
go


begin -- ADD STAFFERS

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

set @stafferRegisterJson =
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

set @stafferRegisterJson =
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

set @stafferRegisterJson =
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

set @stafferRegisterJson =
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
--------------------------

set @stafferRegisterJson =
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
end
go


begin -- ADD PATIENTS
delete Patients

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
----------------------------------------------------------

set @patientRegisterJson =
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
----------------------------------------------------------

set @patientRegisterJson =
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
----------------------------------------------------------

set @patientRegisterJson =
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
----------------------------------------------------------

set @patientRegisterJson =
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
end
go


begin --CREATE SERVICES
declare @json nvarchar(max) =
N'
{
  "Admin": {
    "Login": "Kalabukh",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Service": {
    "ServiceName": "Cardiologist Consultation",
    "ServiceStatus": {
      "ServiceStatus": "Accessible"
    },
    "Comment": "Only Wednesday and Friday",
    "Price": 45.5,
    "ServiceCategory": {
      "ServiceCategory": "Consultation"
    },
    "Description": "Common survey, Cardiography included"
  }
}
'
exec dbo.usp_CreateService
	@json
------------------------------------------------------
set @json =
N'
{
  "Admin": {
    "Login": "Kalabukh",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Service": {
    "ServiceName": "Therapist Consultation",
    "ServiceStatus": {
      "ServiceStatus": "Accessible"
    },
    "Comment": "Not available on Sunday and Saturday",
    "Price": 43.5,
    "ServiceCategory": {
      "ServiceCategory": "Consultation"
    },
    "Description": "Common procedures, Blood Pressure, Survey"
  }
}
'
exec dbo.usp_CreateService
	@json
------------------------------------------------------
set @json =
N'

{
  "Admin": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  },
  "Service": {
    "ServiceName": "Common Blood Test",
    "ServiceStatus": {
      "ServiceStatus": "Accessible"
    },
    "Comment": "Everuday, till 11:00",
    "Price": 10,
    "ServiceCategory": {
      "ServiceCategory": "Test"
    },
    "Description": "Common Blood Formula, Hemoglobine"
  }
}
'
exec dbo.usp_CreateService
	@json
------------------------------------------------------
set @json =
N'

{
  "Admin": {
    "Login": "Kalabukh",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Service": {
    "ServiceName": "Biochemical Blood Test",
    "ServiceStatus": {
      "ServiceStatus": "Accessible"
    },
    "Comment": "",
    "Price": 15.8,
    "ServiceCategory": {
      "ServiceCategory": "Test"
    },
    "Description": "Cholesterine, ASAT, ALAT, Proteine"
  }
}
'
exec dbo.usp_CreateService
	@json
------------------------------------------------------
set @json =
N'

{
  "Admin": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  },
  "Service": {
    "ServiceName": "Liver USI",
    "ServiceStatus": {
      "ServiceStatus": "Accessible"
    },
    "Comment": "Not available after 15:00",
    "Price": 55.5,
    "ServiceCategory": {
      "ServiceCategory": "Examination"
    },
    "Description": "Ultrasonic examination of liver"
  }
}
'
exec dbo.usp_CreateService
	@json
------------------------------------------------------
set @json =
N'

{
  "Admin": {
    "Login": "Kalabukh",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Service": {
    "ServiceName": "Heart USI",
    "ServiceStatus": {
      "ServiceStatus": "Accessible"
    },
    "Comment": "",
    "Price": 60.5,
    "ServiceCategory": {
      "ServiceCategory": "Examination"
    },
    "Description": "Ultrasonic examination of heart"
  }
}
'
exec dbo.usp_CreateService
	@json
end
go

begin --CREATE ROOMS
declare @json nvarchar(max) =
'
{
  "Admin": {
    "Login": "Kalabukh",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Room": {
    "RoomName": "Reception",
    "RoomState": {
      "RoomState": "Accessible"
    },
    "RoomType": {
      "RoomType": "Common Area"
    },
    "RoomNotes": "Main Reception",
    "LastUpdateDateTime": "2022-10-06T19:49:53.1999334+03:00"
  }
}'
exec dbo.usp_CreateRoom
	@json
---------------------------------------------------
set @json =
N'
{
  "Admin": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  },
  "Room": {
    "RoomName": "Cabinet 5",
    "RoomState": {
      "RoomState": "Accessible"
    },
    "RoomType": {
      "RoomType": "Service Space"
    },
    "RoomNotes": "Director and Administration",
    "LastUpdateDateTime": "2022-10-06T19:22:42.6276382+03:00"
  }
}
'

exec dbo.usp_CreateRoom
	@json
------------------------------------------------------
set @json =
N'
{
  "Admin": {
    "Login": "Kalabukh",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Room": {
    "RoomName": "Cabinet 1",
    "RoomState": {
      "RoomState": "Accessible"
    },
    "RoomType": {
      "RoomType": "Doctor\u0027s Office"
    },
    "RoomNotes": "Cardiological Office",
    "LastUpdateDateTime": "2022-10-06T19:22:42.6276194+03:00"
  }
}
'

exec dbo.usp_CreateRoom
	@json
------------------------------------------------------
set @json =
N'
{
  "Admin": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  },
  "Room": {
    "RoomName": "Cabinet 3",
    "RoomState": {
      "RoomState": "Accessible"
    },
    "RoomType": {
      "RoomType": "Doctor\u0027s Office"
    },
    "RoomNotes": "X-Ray Room",
    "LastUpdateDateTime": "2022-10-06T19:22:42.6276197+03:00"
  }
}
'

exec dbo.usp_CreateRoom
	@json
------------------------------------------------------
set @json =
N'
{
  "Admin": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  },
  "Room": {
    "RoomName": "Cabinet 2",
    "RoomState": {
      "RoomState": "Accessible"
    },
    "RoomType": {
      "RoomType": "Doctor\u0027s Office"
    },
    "RoomNotes": "Ultrasound Room",
    "LastUpdateDateTime": "2022-10-06T19:22:42.6276196+03:00"
  }
}
'

exec dbo.usp_CreateRoom
	@json
------------------------------------------------------
set @json =
N'
{
  "Admin": {
    "Login": "Kalabukh",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Room": {
    "RoomName": "Cabinet 4",
    "RoomState": {
      "RoomState": "Accessible"
    },
    "RoomType": {
      "RoomType": "Laboratory"
    },
    "RoomNotes": "Test Laboratory",
    "LastUpdateDateTime": "2022-10-06T19:22:42.6276292+03:00"
  }
}
'

exec dbo.usp_CreateRoom
	@json
end
go

begin --CREATE EQUIPMENTS
declare @json nvarchar(max) =
N'
{
  "Admin": {
    "Login": "Kalabukh",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Equipment": {
    "EquipmentName": "Computer Dell",
    "InventaryNumber": "PC111-222",
    "EquipmentState": {
      "EquipmentState": "In Service"
    },
    "EquipmentType": {
      "EquipmentType": "Personal Computer"
    },
    "EquipmentNote": "Windows 10, Intel Core i5",
    "Services": [
      {
        "ServiceName": "Therapist Consultation"
      },
      {
        "ServiceName": "Cardiologist Consultation"
      }
    ],
    "EquipmentRoom": {
      "RoomName": "Cabinet 1"
    },
    "RegistrationDateTime": "2022-10-06T19:22:42.6603694+03:00"
  }
}
'
exec dbo.usp_CreateEquipment
		@json
-------------------------------------------------------------------------

set @json =
N'
{
  "Admin": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  },
  "Equipment": {
    "EquipmentName": "Computer Lenovo",
    "InventaryNumber": "PC333-444",
    "EquipmentState": {
      "EquipmentState": "In Service"
    },
    "EquipmentType": {
      "EquipmentType": "Personal Computer"
    },
    "EquipmentNote": "Windows 11, Intel Core i9",
    "Services": [
      {
        "ServiceName": "Therapist Consultation"
      },
      {
        "ServiceName": "Cardiologist Consultation"
      }
    ],
    "EquipmentRoom": {
      "RoomName": "Cabinet 5"
    },
    "RegistrationDateTime": "2022-10-06T19:22:42.6604042+03:00"
  }
}
'
exec dbo.usp_CreateEquipment
		@json
--------------------------------------------------------------
set @json =
N'
{
  "Admin": {
    "Login": "Kalabukh",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Equipment": {
    "EquipmentName": "Laptop HP",
    "InventaryNumber": "PC555-666",
    "EquipmentState": {
      "EquipmentState": "In Service"
    },
    "EquipmentType": {
      "EquipmentType": "Personal Computer"
    },
    "EquipmentNote": "Windows 10, AMD, 200GB",
    "Services": [
      {
        "ServiceName": "Therapist Consultation"
      }
    ],
    "EquipmentRoom": {
      "RoomName": "Cabinet 4"
    },
    "RegistrationDateTime": "2022-10-06T19:22:42.6604048+03:00"
  }
}
'
exec dbo.usp_CreateEquipment
		@json
--------------------------------------------------------------
set @json =
N'
{
  "Admin": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  },
  "Equipment": {
    "EquipmentName": "BPL H-RAD 32 High Frequency X Ray",
    "InventaryNumber": "XR222-333",
    "EquipmentState": {
      "EquipmentState": "In Service"
    },
    "EquipmentType": {
      "EquipmentType": "X-Ray"
    },
    "EquipmentNote": "User configurable anatomic programming with 216 program options. 40 to 125 in steps of 1kVp only",
    "EquipmentRoom": {
      "RoomName": "Cabinet 3"
    },
    "RegistrationDateTime": "2022-10-06T19:22:42.6604234+03:00"
  }
}
'
exec dbo.usp_CreateEquipment
		@json
--------------------------------------------------------------
set @json =
N'
{
  "Admin": {
    "Login": "Kalabukh",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Equipment": {
    "EquipmentName": "GE Voluson S8 Ultrasound",
    "InventaryNumber": "US111-222",
    "EquipmentState": {
      "EquipmentState": "In Service"
    },
    "EquipmentType": {
      "EquipmentType": "Ultrasound"
    },
    "EquipmentNote": "For women\u2019s health applications, obstetrics, gynecology, fertility. Secondary applications: general imaging, adult and pediatric cardiology, and neonatal cardiology.",
    "Services": [
      {
        "ServiceName": "Liver USI"
      },
      {
        "ServiceName": "Heart USI"
      }
    ],
    "EquipmentRoom": {
      "RoomName": "Cabinet 2"
    },
    "RegistrationDateTime": "2022-10-06T19:22:42.6604149+03:00"
  }
}
'
exec dbo.usp_CreateEquipment
		@json
--------------------------------------------------------------
set @json =
N'
{
  "Admin": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  },
  "Equipment": {
    "EquipmentName": "Mindray BC-1800 Hematology Analyzer",
    "InventaryNumber": "BA444-555",
    "EquipmentState": {
      "EquipmentState": "In Service"
    },
    "EquipmentType": {
      "EquipmentType": "Analyzer"
    },
    "EquipmentNote": "Fully Automated hematology analyzer. 3 Part differentiation of WBC 19 Parameters \u002B 3 histograms.",
    "Services": [
      {
        "ServiceName": "Common Blood Test"
      },
      {
        "ServiceName": "Biochemical Blood Test"
      }
    ],
    "EquipmentRoom": {
      "RoomName": "Cabinet 4"
    },
    "RegistrationDateTime": "2022-10-06T19:22:42.6604315+03:00"
  }
}
'
exec dbo.usp_CreateEquipment
		@json
--------------------------------------------------------------
set @json =N'
{
  "Admin": {
    "Login": "Kalabukh",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Equipment": {
    "EquipmentName": "Intel Pentium",
    "InventaryNumber": "PC777-888",
    "EquipmentState": {
      "EquipmentState": "In Service"
    },
    "EquipmentType": {
      "EquipmentType": "Personal Computer"
    },
    "EquipmentNote": "Windows 7, Intel, 4GB RAM",
    "RegistrationDateTime": "2022-10-07T12:35:15.0620365+03:00"
  }
}
'
exec dbo.usp_CreateEquipment
		@json
-------------------------------------------------------------------------
set @json =
N'
{
  "Admin": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  },
  "Equipment": {
    "EquipmentName": "Acer",
    "InventaryNumber": "PC999-000",
    "EquipmentState": {
      "EquipmentState": "In Service"
    },
    "EquipmentType": {
      "EquipmentType": "Personal Computer"
    },
    "EquipmentNote": "Windows 8, AMD, 3TB",
    "RegistrationDateTime": "2022-10-07T12:42:31.3480969+03:00",
    "LastEditor": {
      "Login": "Kalabukh",
      "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
    }
  }
}
'
exec dbo.usp_CreateEquipment
		@json
--------------------------------------------------------------------
set @json =
N'
{
  "Admin": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  },
  "Equipment": {
    "EquipmentName": "zPOS D2s",
    "InventaryNumber": "CD-01-101",
    "EquipmentState": {
      "EquipmentState": "In Service"
    },
    "EquipmentType": {
      "EquipmentType": "Office Technic"
    },
    "EquipmentNote": "Main Cash Desk on Reception",
    "RegistrationDateTime": "2022-10-07T15:42:49.1462638+03:00"
  }
}
'
exec dbo.usp_CreateEquipment
		@json
end
go

begin --ASSIGN EQUIPMENTS TO ROOM
declare @json nvarchar(max) =
N'
{
  "Admin": {
    "Login": "Kalabukh",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Room": {
    "RoomName": "Reception"
  },
  "Equipments": [
    {
      "InventaryNumber": "PC777-888"
    },
    {
      "InventaryNumber": "CD-01-101"
    }
  ]
}
'
exec dbo.usp_AssignEquipmentsToRoom
   @json
set @json =
N'
{
  "Admin": {
    "Login": "Kalabukh",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Room": {
    "RoomName": "Cabinet 2"
  },
  "Equipments": [
    {
      "InventaryNumber": "PC999-000"
    }
  ]
}
'
exec dbo.usp_AssignEquipmentsToRoom
   @json
end 
go

begin --SET SERVICES FOR EQUIPMENTS
declare @json nvarchar(max) =
N'
{
  "Admin": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  },
  "Equipments": [
    {
      "InventaryNumber": "PC111-222"
    },
    {
      "InventaryNumber": "PC333-444"
    },
    {
      "InventaryNumber": "PC555-666"
    },
    {
      "InventaryNumber": "PC777-888"
    },
    {
      "InventaryNumber": "PC999-000"
    }
  ],
  "Services": [
    {
      "ServiceName": "Therapist Consultation"
    },
    {
      "ServiceName": "Cardiologist Consultation"
    }
  ]
}
'
exec usp_SetServicesForEquipments
		@json
end
go


begin --Volosevich 08.11.2022 Cardio 
declare @scheduleVisitJson nvarchar(max) = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "BaseService": {
    "ServiceName": "Cardiologist Consultation"
  },
  "Specialist": {
    "Login": "Volosevich76"
  },
  "VisitInfo": {
    "ScheduledDateTime": "2022-11-08T12:00:00",
    "PreliminaryNotes": " ",
    "TotalPrice": 0,
    "PaymentState": {
      "PaymentState": "Not Paid"
    },
    "VisitStatus": {
      "VisitStatus": "Planned"
    },
    "VisitType": {
      "VisitType": "Consultation"
    }
  },
  "Assistants": [
    {
      "Login": "Sidor86"
    }
  ],
  "Room": {
    "RoomName": "Cabinet 1"
  }
}
'
exec dbo.usp_ScheduleVisit
	@scheduleVisitJson
-------------------------------------------------------------------------

set @scheduleVisitJson = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "BaseService": {
    "ServiceName": "Cardiologist Consultation"
  },
  "Specialist": {
    "Login": "Volosevich76"
  },
  "VisitInfo": {
    "ScheduledDateTime": "2022-11-08T12:20:00",
    "PreliminaryNotes": " ",
    "TotalPrice": 0,
    "PaymentState": {
      "PaymentState": "Not Paid"
    },
    "VisitStatus": {
      "VisitStatus": "Planned"
    },
    "VisitType": {
      "VisitType": "Consultation"
    }
  },
  "Assistants": [
    {
      "Login": "Sidor86"
    }
  ],
  "Room": {
    "RoomName": "Cabinet 1"
  }
}
'
exec dbo.usp_ScheduleVisit
	@scheduleVisitJson
-------------------------------------------------------------------------

set @scheduleVisitJson = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "BaseService": {
    "ServiceName": "Cardiologist Consultation"
  },
  "Specialist": {
    "Login": "Volosevich76"
  },
  "VisitInfo": {
    "ScheduledDateTime": "2022-11-08T12:40:00",
    "PreliminaryNotes": " ",
    "TotalPrice": 0,
    "PaymentState": {
      "PaymentState": "Not Paid"
    },
    "VisitStatus": {
      "VisitStatus": "Planned"
    },
    "VisitType": {
      "VisitType": "Consultation"
    }
  },
  "Assistants": [
    {
      "Login": "Sidor86"
    }
  ],
  "Room": {
    "RoomName": "Cabinet 1"
  }
}
'
exec dbo.usp_ScheduleVisit
	@scheduleVisitJson
-------------------------------------------------------------------------

set @scheduleVisitJson = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "BaseService": {
    "ServiceName": "Cardiologist Consultation"
  },
  "Specialist": {
    "Login": "Volosevich76"
  },
  "VisitInfo": {
    "ScheduledDateTime": "2022-11-08T13:00:00",
    "PreliminaryNotes": " ",
    "TotalPrice": 0,
    "PaymentState": {
      "PaymentState": "Not Paid"
    },
    "VisitStatus": {
      "VisitStatus": "Planned"
    },
    "VisitType": {
      "VisitType": "Consultation"
    }
  },
  "Assistants": [
    {
      "Login": "Sidor86"
    }
  ],
  "Room": {
    "RoomName": "Cabinet 1"
  }
}
'
exec dbo.usp_ScheduleVisit
	@scheduleVisitJson
-------------------------------------------------------------------------

set @scheduleVisitJson = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "BaseService": {
    "ServiceName": "Cardiologist Consultation"
  },
  "Specialist": {
    "Login": "Volosevich76"
  },
  "VisitInfo": {
    "ScheduledDateTime": "2022-11-08T13:20:00",
    "PreliminaryNotes": " ",
    "TotalPrice": 0,
    "PaymentState": {
      "PaymentState": "Not Paid"
    },
    "VisitStatus": {
      "VisitStatus": "Planned"
    },
    "VisitType": {
      "VisitType": "Consultation"
    }
  },
  "Assistants": [
    {
      "Login": "Sidor86"
    }
  ],
  "Room": {
    "RoomName": "Cabinet 1"
  }
}
'
exec dbo.usp_ScheduleVisit
	@scheduleVisitJson
-------------------------------------------------------------------------

set @scheduleVisitJson = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "BaseService": {
    "ServiceName": "Cardiologist Consultation"
  },
  "Specialist": {
    "Login": "Volosevich76"
  },
  "VisitInfo": {
    "ScheduledDateTime": "2022-11-08T13:40:00",
    "PreliminaryNotes": " ",
    "TotalPrice": 0,
    "PaymentState": {
      "PaymentState": "Not Paid"
    },
    "VisitStatus": {
      "VisitStatus": "Planned"
    },
    "VisitType": {
      "VisitType": "Consultation"
    }
  },
  "Assistants": [
    {
      "Login": "Sidor86"
    }
  ],
  "Room": {
    "RoomName": "Cabinet 1"
  }
}
'
exec dbo.usp_ScheduleVisit
	@scheduleVisitJson
-------------------------------------------------------------------------
end
go

begin --Kheidorov 22.10.2022 USI 
declare @scheduleVisitJson nvarchar(max) = 
N'
{
  "Staffer": {
    "Login": "Kheidor",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "BaseService": {
    "ServiceName": "Heart USI"
  },
  "Specialist": {
    "Login": "Kheidor"
  },
  "VisitInfo": {
    "ScheduledDateTime": "2022-10-22T09:00:00",
    "PreliminaryNotes": "No food at least 2 hours before.",
    "TotalPrice": 0,
    "PaymentState": {
      "PaymentState": "Not Paid"
    },
    "VisitStatus": {
      "VisitStatus": "Planned"
    },
    "VisitType": {
      "VisitType": "Examination"
    }
  },
  "Assistants": [
    {
      "Login": "Sidor86"
    }
  ],
  "Room": {
    "RoomName": "Cabinet 2"
  }
}
'
exec dbo.usp_ScheduleVisit
	@scheduleVisitJson
-------------------------------------------------------------------------

set @scheduleVisitJson = 
N'
{
  "Staffer": {
    "Login": "Kheidor",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "BaseService": {
    "ServiceName": "Heart USI"
  },
  "Specialist": {
    "Login": "Kheidor"
  },
  "VisitInfo": {
    "ScheduledDateTime": "2022-10-22T09:30:00",
    "PreliminaryNotes": "No food at least 2 hours before.",
    "TotalPrice": 0,
    "PaymentState": {
      "PaymentState": "Not Paid"
    },
    "VisitStatus": {
      "VisitStatus": "Planned"
    },
    "VisitType": {
      "VisitType": "Examination"
    }
  },
  "Assistants": [
    {
      "Login": "Sidor86"
    }
  ],
  "Room": {
    "RoomName": "Cabinet 2"
  }
}
'
exec dbo.usp_ScheduleVisit
	@scheduleVisitJson
-------------------------------------------------------------------------

set @scheduleVisitJson = 
N'
{
  "Staffer": {
    "Login": "Kheidor",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "BaseService": {
    "ServiceName": "Heart USI"
  },
  "Specialist": {
    "Login": "Kheidor"
  },
  "VisitInfo": {
    "ScheduledDateTime": "2022-10-22T10:00:00",
    "PreliminaryNotes": "No food at least 2 hours before.",
    "TotalPrice": 0,
    "PaymentState": {
      "PaymentState": "Not Paid"
    },
    "VisitStatus": {
      "VisitStatus": "Planned"
    },
    "VisitType": {
      "VisitType": "Examination"
    }
  },
  "Assistants": [
    {
      "Login": "Sidor86"
    }
  ],
  "Room": {
    "RoomName": "Cabinet 2"
  }
}
'
exec dbo.usp_ScheduleVisit
	@scheduleVisitJson
-------------------------------------------------------------------------

set @scheduleVisitJson = 
N'
{
  "Staffer": {
    "Login": "Kheidor",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "BaseService": {
    "ServiceName": "Heart USI"
  },
  "Specialist": {
    "Login": "Kheidor"
  },
  "VisitInfo": {
    "ScheduledDateTime": "2022-10-22T10:30:00",
    "PreliminaryNotes": "No food at least 2 hours before.",
    "TotalPrice": 0,
    "PaymentState": {
      "PaymentState": "Not Paid"
    },
    "VisitStatus": {
      "VisitStatus": "Planned"
    },
    "VisitType": {
      "VisitType": "Examination"
    }
  },
  "Assistants": [
    {
      "Login": "Sidor86"
    }
  ],
  "Room": {
    "RoomName": "Cabinet 2"
  }
}
'
exec dbo.usp_ScheduleVisit
	@scheduleVisitJson
end
go

begin --Oleg 17.11.2022 Therapy 
declare @scheduleVisitJson nvarchar(max) = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "BaseService": {
    "ServiceName": "Therapist Consultation"
  },
  "Specialist": {
    "Login": "Oleg66"
  },
  "VisitInfo": {
    "ScheduledDateTime": "2022-11-17T12:00:00",
    "PreliminaryNotes": "",
    "PaymentState": {
      "PaymentState": "Not Paid"
    },
    "VisitStatus": {
      "VisitStatus": "Planned"
    },
    "VisitType": {
      "VisitType": "Consultation"
    }
  },
  "Assistants": [
    {
      "Login": "ValeraP"
    }
  ],
  "Room": {
    "RoomName": "Cabinet 5"
  }
}
'
exec dbo.usp_ScheduleVisit
	@scheduleVisitJson
-----------------------------------------------------------------------
set @scheduleVisitJson  = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "BaseService": {
    "ServiceName": "Therapist Consultation"
  },
  "Specialist": {
    "Login": "Oleg66"
  },
  "VisitInfo": {
    "ScheduledDateTime": "2022-11-17T12:20:00",
    "PreliminaryNotes": "",
    "PaymentState": {
      "PaymentState": "Not Paid"
    },
    "VisitStatus": {
      "VisitStatus": "Planned"
    },
    "VisitType": {
      "VisitType": "Consultation"
    }
  },
  "Assistants": [
    {
      "Login": "ValeraP"
    },
	{
      "Login": "Volosevich76"
    }
  ],
  "Room": {
    "RoomName": "Cabinet 5"
  }
}
'
exec dbo.usp_ScheduleVisit
	@scheduleVisitJson
-------------------------------------------------------------------------
set @scheduleVisitJson  = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "BaseService": {
    "ServiceName": "Therapist Consultation"
  },
  "Specialist": {
    "Login": "Oleg66"
  },
  "VisitInfo": {
    "ScheduledDateTime": "2022-11-17T12:40:00",
    "PreliminaryNotes": "",
    "PaymentState": {
      "PaymentState": "Not Paid"
    },
    "VisitStatus": {
      "VisitStatus": "Planned"
    },
    "VisitType": {
      "VisitType": "Consultation"
    }
  },
  "Assistants": [
    {
      "Login": "ValeraP"
    },
	{
      "Login": "Volosevich76"
    }
  ],
  "Room": {
    "RoomName": "Cabinet 5"
  }
}
'
exec dbo.usp_ScheduleVisit
	@scheduleVisitJson
-----------------------------------------------------------------------
set @scheduleVisitJson  = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "BaseService": {
    "ServiceName": "Therapist Consultation"
  },
  "Specialist": {
    "Login": "Oleg66"
  },
  "VisitInfo": {
    "ScheduledDateTime": "2022-11-17T13:00:00",
    "PreliminaryNotes": "",
    "PaymentState": {
      "PaymentState": "Not Paid"
    },
    "VisitStatus": {
      "VisitStatus": "Planned"
    },
    "VisitType": {
      "VisitType": "Consultation"
    }
  },
  "Assistants": [
    {
      "Login": "ValeraP"
    },
	{
      "Login": "Volosevich76"
    }
  ],
  "Room": {
    "RoomName": "Cabinet 5"
  }
}
'
exec dbo.usp_ScheduleVisit
	@scheduleVisitJson
-----------------------------------------------------------------------
set @scheduleVisitJson  = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "BaseService": {
    "ServiceName": "Therapist Consultation"
  },
  "Specialist": {
    "Login": "Oleg66"
  },
  "VisitInfo": {
    "ScheduledDateTime": "2022-11-17T13:20:00",
    "PreliminaryNotes": "",
    "PaymentState": {
      "PaymentState": "Not Paid"
    },
    "VisitStatus": {
      "VisitStatus": "Planned"
    },
    "VisitType": {
      "VisitType": "Consultation"
    }
  },
  "Assistants": [
    {
      "Login": "ValeraP"
    },
	{
      "Login": "Volosevich76"
    }
  ],
  "Room": {
    "RoomName": "Cabinet 5"
  }
}
'
exec dbo.usp_ScheduleVisit
	@scheduleVisitJson
-----------------------------------------------------------------------
set @scheduleVisitJson  = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "BaseService": {
    "ServiceName": "Therapist Consultation"
  },
  "Specialist": {
    "Login": "Oleg66"
  },
  "VisitInfo": {
    "ScheduledDateTime": "2022-11-17T13:40:00",
    "PreliminaryNotes": "",
    "PaymentState": {
      "PaymentState": "Not Paid"
    },
    "VisitStatus": {
      "VisitStatus": "Planned"
    },
    "VisitType": {
      "VisitType": "Consultation"
    }
  },
  "Assistants": [
    {
      "Login": "ValeraP"
    },
	{
      "Login": "Volosevich76"
    }
  ],
  "Room": {
    "RoomName": "Cabinet 5"
  }
}
'
exec dbo.usp_ScheduleVisit
	@scheduleVisitJson
end
go

begin --Sidorovich 21.11.2022 Blood Test
declare @scheduleVisitJson nvarchar(max) = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "BaseService": {
    "ServiceName": "Biochemical Blood Test"
  },
  "Specialist": {
    "Login": "Sidor86"
  },
  "VisitInfo": { 
    "ScheduledDateTime": "2022-11-21T08:00:00",
    "PreliminaryNotes": "",
    "PaymentState": {
      "PaymentState": "Not Paid"
    },
    "VisitStatus": {
      "VisitStatus": "Planned"
    },
    "VisitType": {
      "VisitType": "Test Taking"
    }
  },
  "Room": {
    "RoomName": "Cabinet 4"
  }
}
'
exec dbo.usp_ScheduleVisit
	@scheduleVisitJson
-----------------------------------------------------------------------
set @scheduleVisitJson  = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "BaseService": {
    "ServiceName": "Biochemical Blood Test"
  },
  "Specialist": {
    "Login": "Sidor86"
  },
  "VisitInfo": { 
    "ScheduledDateTime": "2022-11-21T08:05:00",
    "PreliminaryNotes": "",
    "PaymentState": {
      "PaymentState": "Not Paid"
    },
    "VisitStatus": {
      "VisitStatus": "Planned"
    },
    "VisitType": {
      "VisitType": "Test Taking"
    }
  },
  "Room": {
    "RoomName": "Cabinet 4"
  }
}
'
exec dbo.usp_ScheduleVisit
	@scheduleVisitJson
-----------------------------------------------------------------------
set @scheduleVisitJson  = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "BaseService": {
    "ServiceName": "Biochemical Blood Test"
  },
  "Specialist": {
    "Login": "Sidor86"
  },
  "VisitInfo": { 
    "ScheduledDateTime": "2022-11-21T08:10:00",
    "PreliminaryNotes": "",
    "PaymentState": {
      "PaymentState": "Not Paid"
    },
    "VisitStatus": {
      "VisitStatus": "Planned"
    },
    "VisitType": {
      "VisitType": "Test Taking"
    }
  },
  "Room": {
    "RoomName": "Cabinet 4"
  }
}
'
exec dbo.usp_ScheduleVisit
	@scheduleVisitJson
-----------------------------------------------------------------------
set @scheduleVisitJson  = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "BaseService": {
    "ServiceName": "Biochemical Blood Test"
  },
  "Specialist": {
    "Login": "Sidor86"
  },
  "VisitInfo": { 
    "ScheduledDateTime": "2022-11-21T08:15:00",
    "PreliminaryNotes": "",
    "PaymentState": {
      "PaymentState": "Not Paid"
    },
    "VisitStatus": {
      "VisitStatus": "Planned"
    },
    "VisitType": {
      "VisitType": "Test Taking"
    }
  },
  "Room": {
    "RoomName": "Cabinet 4"
  }
}
'
exec dbo.usp_ScheduleVisit
	@scheduleVisitJson
-----------------------------------------------------------------------
set @scheduleVisitJson  = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "BaseService": {
    "ServiceName": "Biochemical Blood Test"
  },
  "Specialist": {
    "Login": "Sidor86"
  },
  "VisitInfo": { 
    "ScheduledDateTime": "2022-11-21T08:20:00",
    "PreliminaryNotes": "",
    "PaymentState": {
      "PaymentState": "Not Paid"
    },
    "VisitStatus": {
      "VisitStatus": "Planned"
    },
    "VisitType": {
      "VisitType": "Test Taking"
    }
  },
  "Room": {
    "RoomName": "Cabinet 4"
  }
}
'
exec dbo.usp_ScheduleVisit
	@scheduleVisitJson
-----------------------------------------------------------------------
set @scheduleVisitJson  = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "BaseService": {
    "ServiceName": "Biochemical Blood Test"
  },
  "Specialist": {
    "Login": "Sidor86"
  },
  "VisitInfo": { 
    "ScheduledDateTime": "2022-11-21T08:25:00",
    "PreliminaryNotes": "",
    "PaymentState": {
      "PaymentState": "Not Paid"
    },
    "VisitStatus": {
      "VisitStatus": "Planned"
    },
    "VisitType": {
      "VisitType": "Test Taking"
    }
  },
  "Room": {
    "RoomName": "Cabinet 4"
  }
}
'
exec dbo.usp_ScheduleVisit
	@scheduleVisitJson
-----------------------------------------------------------------------
set @scheduleVisitJson  = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "BaseService": {
    "ServiceName": "Biochemical Blood Test"
  },
  "Specialist": {
    "Login": "Sidor86"
  },
  "VisitInfo": { 
    "ScheduledDateTime": "2022-11-21T08:30:00",
    "PreliminaryNotes": "",
    "PaymentState": {
      "PaymentState": "Not Paid"
    },
    "VisitStatus": {
      "VisitStatus": "Planned"
    },
    "VisitType": {
      "VisitType": "Test Taking"
    }
  },
  "Room": {
    "RoomName": "Cabinet 4"
  }
}
'
exec dbo.usp_ScheduleVisit
	@scheduleVisitJson
-----------------------------------------------------------------------
set @scheduleVisitJson  = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "BaseService": {
    "ServiceName": "Biochemical Blood Test"
  },
  "Specialist": {
    "Login": "Sidor86"
  },
  "VisitInfo": { 
    "ScheduledDateTime": "2022-11-21T08:35:00",
    "PreliminaryNotes": "",
    "PaymentState": {
      "PaymentState": "Not Paid"
    },
    "VisitStatus": {
      "VisitStatus": "Planned"
    },
    "VisitType": {
      "VisitType": "Test Taking"
    }
  },
  "Room": {
    "RoomName": "Cabinet 4"
  }
}
'
exec dbo.usp_ScheduleVisit
	@scheduleVisitJson
-----------------------------------------------------------------------
set @scheduleVisitJson  = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "BaseService": {
    "ServiceName": "Biochemical Blood Test"
  },
  "Specialist": {
    "Login": "Sidor86"
  },
  "VisitInfo": { 
    "ScheduledDateTime": "2022-11-21T08:40:00",
    "PreliminaryNotes": "",
    "PaymentState": {
      "PaymentState": "Not Paid"
    },
    "VisitStatus": {
      "VisitStatus": "Planned"
    },
    "VisitType": {
      "VisitType": "Test Taking"
    }
  },
  "Room": {
    "RoomName": "Cabinet 4"
  }
}
'
exec dbo.usp_ScheduleVisit
	@scheduleVisitJson
-----------------------------------------------------------------------
set @scheduleVisitJson  = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "BaseService": {
    "ServiceName": "Biochemical Blood Test"
  },
  "Specialist": {
    "Login": "Sidor86"
  },
  "VisitInfo": { 
    "ScheduledDateTime": "2022-11-21T08:45:00",
    "PreliminaryNotes": "",
    "PaymentState": {
      "PaymentState": "Not Paid"
    },
    "VisitStatus": {
      "VisitStatus": "Planned"
    },
    "VisitType": {
      "VisitType": "Test Taking"
    }
  },
  "Room": {
    "RoomName": "Cabinet 4"
  }
}
'
exec dbo.usp_ScheduleVisit
	@scheduleVisitJson
-----------------------------------------------------------------------
set @scheduleVisitJson  = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "BaseService": {
    "ServiceName": "Biochemical Blood Test"
  },
  "Specialist": {
    "Login": "Sidor86"
  },
  "VisitInfo": { 
    "ScheduledDateTime": "2022-11-21T08:50:00",
    "PreliminaryNotes": "",
    "PaymentState": {
      "PaymentState": "Not Paid"
    },
    "VisitStatus": {
      "VisitStatus": "Planned"
    },
    "VisitType": {
      "VisitType": "Test Taking"
    }
  },
  "Room": {
    "RoomName": "Cabinet 4"
  }
}
'
exec dbo.usp_ScheduleVisit
	@scheduleVisitJson
-----------------------------------------------------------------------
set @scheduleVisitJson  = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "BaseService": {
    "ServiceName": "Biochemical Blood Test"
  },
  "Specialist": {
    "Login": "Sidor86"
  },
  "VisitInfo": { 
    "ScheduledDateTime": "2022-11-21T08:55:00",
    "PreliminaryNotes": "",
    "PaymentState": {
      "PaymentState": "Not Paid"
    },
    "VisitStatus": {
      "VisitStatus": "Planned"
    },
    "VisitType": {
      "VisitType": "Test Taking"
    }
  },
  "Room": {
    "RoomName": "Cabinet 4"
  }
}
'
exec dbo.usp_ScheduleVisit
	@scheduleVisitJson
-----------------------------------------------------------------------
end
go

begin -- Records to Volosevich 08-11
declare @json nvarchar(max) =
N'
{
  "Patient": {
    "Login": "GoodGuy",
    "PasswordHash": "20e0wetw346345kdcjlaksdca"
  },
  "Visit": {
    "Specialist": {
      "Login": "Volosevich76"
    },
    "ScheduledDateTime": "2022-11-08T12:00:00"
  }
}
'
exec dbo.usp_RecordToVisit	@json
-------------------------------------------------------
set @json =
N'
{
  "Patient": {
    "Login": "Malets",
    "PasswordHash": "20e0we457445345kdcjlaksdca"
  },
  "Visit": {
    "Specialist": {
      "Login": "Volosevich76"
    },
    "ScheduledDateTime": "2022-11-08T12:40:00"
  }
}
'
exec dbo.usp_RecordToVisit	@json
-------------------------------------------------------
set @json =
N'
{
  "Staffer": {
    "Login": "Kheidor",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Patient": {
    "Login": "Tykooon"
  },
  "Visit": {
    "Specialist": {
      "Login": "Volosevich76"
    },
    "ScheduledDateTime": "2022-11-08T13:40:00"
  }
}
'
exec dbo.usp_RecordToVisitByStaffer	@json
---------------------------------------------------------
set @json =
N'
{
  "Staffer": {
    "Login": "Sidor86",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Patient": {
    "Login": "Liviu"
  },
  "Visit": {
    "Specialist": {
      "Login": "Volosevich76"
    },
    "ScheduledDateTime": "2022-11-08T13:00:00"
  }
}
'
exec dbo.usp_RecordToVisitByStaffer	@json
-------------------------------------------------------
end
go

begin -- Records to Kheidorov 22-10
declare @json nvarchar(max) =
N'
{
  "Staffer": {
    "Login": "Sidor86",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Patient": {
    "Login": "Tykooon"
  },
  "Visit": {
    "Specialist": {
      "Login": "Kheidor"
    },
    "ScheduledDateTime": "2022-10-22T09:30:00"
  }
}
'
exec dbo.usp_RecordToVisit	@json
--------------------------------------------------------
set @json =
N'
{
  "Staffer": {
    "Login": "Volosevich76",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Patient": {
    "Login": "GoodGuy"
  },
  "Visit": {
    "Specialist": {
      "Login": "Kheidor"
    },
    "ScheduledDateTime": "2022-10-22T10:30:00"
  }
}
'
exec dbo.usp_RecordToVisit	@json
---------------------------------------
set @json =
N'
{
  "Patient": {
    "Login": "Malets",
    "PasswordHash": "20e0we457445345kdcjlaksdca"
  },
  "Visit": {
    "Specialist": {
      "Login": "Kheidor"
    },
    "ScheduledDateTime": "2022-10-22T09:00:00"
  }
}
'
exec dbo.usp_RecordToVisit	@json
-------------------------------------------------
set @json =
N'
{
  "Patient": {
    "Login": "Liviu",
    "PasswordHash": "20e0we45744sdgs43aksdca"
  },
  "Visit": {
    "Specialist": {
      "Login": "Kheidor"
    },
    "ScheduledDateTime": "2022-10-22T10:00:00"
  }
}
'
exec dbo.usp_RecordToVisit	@json
end
go

begin -- Records to Oleg 17-11
--"Specialist": { "Login": "Oleg66" },
--  "VisitInfo": { "ScheduledDateTime": "2022-11-17T12:00:00"  }
declare @json nvarchar(max) =
N'
{
  "Staffer": {
    "Login": "Sidor86",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Patient": {
    "Login": "Tykooon"
  },
  "Visit": {
    "Specialist": {
      "Login": "Oleg66"
    },
    "ScheduledDateTime": "2022-11-17T12:00:00"
  }
}
'
exec dbo.usp_RecordToVisit	@json
--------------------------------------------------------
set @json =
N'
{
  "Staffer": {
    "Login": "Volosevich76",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Patient": {
    "Login": "Malets"
  },
  "Visit": {
    "Specialist": {
      "Login": "Oleg66"
    },
    "ScheduledDateTime": "2022-11-17T12:20:00"
  }
}
'
exec dbo.usp_RecordToVisit	@json
---------------------------------------
set @json =
N'
{
  "Staffer": {
    "Login": "Volosevich76",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Patient": {
    "Login": "Liviu"
  },
  "Visit": {
    "Specialist": {
      "Login": "Oleg66"
    },
    "ScheduledDateTime": "2022-11-17T13:00:00"
  }
}
'
exec dbo.usp_RecordToVisit	@json
---------------------------------------
set @json =
N'
{
  "Staffer": {
    "Login": "Volosevich76",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Patient": {
    "Login": "GoodGuy"
  },
  "Visit": {
    "Specialist": {
      "Login": "Oleg66"
    },
    "ScheduledDateTime": "2022-11-17T13:20:00"
  }
}
'
exec dbo.usp_RecordToVisit	@json
---------------------------------------
set @json =
N'
{
  "Staffer": {
    "Login": "Volosevich76",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Patient": {
    "Login": "Gavr"
  },
  "Visit": {
    "Specialist": {
      "Login": "Oleg66"
    },
    "ScheduledDateTime": "2022-11-17T13:40:00"
  }
}
'
exec dbo.usp_RecordToVisit	@json
---------------------------------------
end
go

begin -- Records to BloodTest 21-11
--"Specialist": { "Login": "Sidor86" },
--  "VisitInfo": { "ScheduledDateTime": "2022-11-21T08:00:00"  }
declare @json nvarchar(max) =
N'
{
  "Staffer": {
    "Login": "Sidor86",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Patient": {
    "Login": "Tykooon"
  },
  "Visit": {
    "Specialist": {
      "Login": "Sidor86"
    },
    "ScheduledDateTime": "2022-11-21T08:30:00"
  }
}
'
exec dbo.usp_RecordToVisit	@json
--------------------------------------------------------
set @json =
N'
{
  "Staffer": {
    "Login": "Volosevich76",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Patient": {
    "Login": "Malets"
  },
  "Visit": {
    "Specialist": {
      "Login": "Sidor86"
    },
    "ScheduledDateTime": "2022-11-21T08:15:00"
  }
}
'
exec dbo.usp_RecordToVisit	@json
---------------------------------------
set @json =
N'
{
  "Staffer": {
    "Login": "Volosevich76",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Patient": {
    "Login": "Liviu"
  },
  "Visit": {
    "Specialist": {
      "Login": "Sidor86"
    },
    "ScheduledDateTime": "2022-11-21T08:00:00"
  }
}
'
exec dbo.usp_RecordToVisit	@json
---------------------------------------
set @json =
N'
{
  "Staffer": {
    "Login": "Volosevich76",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Patient": {
    "Login": "GoodGuy"
  },
  "Visit": {
    "Specialist": {
      "Login": "Sidor86"
    },
    "ScheduledDateTime": "2022-11-21T08:55:00"
  }
}
'
exec dbo.usp_RecordToVisit	@json
---------------------------------------
set @json =
N'
{
  "Staffer": {
    "Login": "Volosevich76",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "Patient": {
    "Login": "Gavr"
  },
  "Visit": {
    "Specialist": {
      "Login": "Sidor86"
    },
    "ScheduledDateTime": "2022-11-21T08:40:00"
  }
}
'
exec dbo.usp_RecordToVisit	@json
---------------------------------------
end
go

begin -- Edit Visits
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
--------------------------------------------------------
set @editVisitJson  = 
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
--------------------------------------------------------
set @editVisitJson  = 
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
--------------------------------------------------------
set @editVisitJson  = 
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
end
go

begin -- Accept Payment
declare @AcceptPaymentJson nvarchar(max) = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "VisitInfo": {
	"Specialist" : { "Login": "Kheidor" },
    "ScheduledDateTime": "2022-10-22T09:00:00"
  }
}
'

exec dbo.usp_AcceptPayment
	@AcceptPaymentJson
--------------------------------------------------------------
set @AcceptPaymentJson = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "VisitInfo": {
	"Specialist" : { "Login": "Kheidor" },
    "ScheduledDateTime": "2022-10-22T09:30:00"
  }
}
'

exec dbo.usp_AcceptPayment
	@AcceptPaymentJson
--------------------------------------------------------------
set @AcceptPaymentJson = 
N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "VisitInfo": {
	"Specialist" : { "Login": "Kheidor" },
    "ScheduledDateTime": "2022-10-22T10:00:00"
  }
}
'

exec dbo.usp_AcceptPayment
	@AcceptPaymentJson
--------------------------------------------------------------
set @AcceptPaymentJson = N'
{
  "Staffer": {
    "Login": "Kovboy",
    "PasswordHash": "20e0wetwdckdjc02kdcjlaksdca"
  },
  "VisitInfo": {
	"Specialist" : { "Login": "Kheidor" },
    "ScheduledDateTime": "2022-10-22T10:30:00"
  }
}
'

exec dbo.usp_AcceptPayment
	@AcceptPaymentJson
end
go

begin -- Add Rating
declare @json nvarchar(max) =
N'
{
  "Patient": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  },
  "Staffer": {
    "Login": "Sidor86"
  },
  "RatingInfo": {
    "RatingValue": 10,
    "RatingDateTime": "2022-10-10T16:38:57.7621259+03:00",
    "RatingComment": "Cooool!"
  }
}
'
exec dbo.usp_AddRatingToStaffer	@json
-------------------------------------------------
set @json =
N'
{
  "Patient": {
    "Login": "GoodGuy",
    "PasswordHash": "20e0wetw346345kdcjlaksdca"
  },
  "Staffer": {
    "Login": "Oleg66"
  },
  "RatingInfo": {
    "RatingValue": 10,
    "RatingDateTime": "2022-10-11T11:44:56.7798749+03:00",
    "RatingComment": "Perfect!"
  }
}
'
exec dbo.usp_AddRatingToStaffer	@json
-------------------------------------------------
set @json =
N'
{
  "Patient": {
    "Login": "GoodGuy",
    "PasswordHash": "20e0wetw346345kdcjlaksdca"
  },
  "Staffer": {
    "Login": "Volosevich76"
  },
  "RatingInfo": {
    "RatingValue": 9,
    "RatingDateTime": "2022-10-11T11:44:56.780127+03:00",
    "RatingComment": "Very good!"
  }
}
'
exec dbo.usp_AddRatingToStaffer	@json
-------------------------------------------------
set @json =N'
{
  "Patient": {
    "Login": "GoodGuy",
    "PasswordHash": "20e0wetw346345kdcjlaksdca"
  },
  "Staffer": {
    "Login": "Kheidor"
  },
  "RatingInfo": {
    "RatingValue": 7,
    "RatingDateTime": "2022-10-11T11:44:56.7803208+03:00",
    "RatingComment": "Normal!"
  }
}
'
exec dbo.usp_AddRatingToStaffer	@json
-----------------------------------------
set @json = N'
{
  "Patient": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  },
  "Staffer": {
    "Login": "Volosevich76"
  },
  "RatingInfo": {
    "RatingValue": 9,
    "RatingDateTime": "2022-10-10T16:38:57.7674564+03:00",
    "RatingComment": "Nice!"
  }
}
'
exec dbo.usp_AddRatingToStaffer	@json
-------------------------------------------------
set @json =
N'
{
  "Patient": {
    "Login": "Tykooon",
    "PasswordHash": "20e0dckdjc02kdcjlaksdca"
  },
  "Staffer": {
    "Login": "Kheidor"
  },
  "RatingInfo": {
    "RatingValue": 7,
    "RatingDateTime": "2022-10-10T16:38:57.7679638+03:00",
    "RatingComment": "Not Bad!"
  }
}
'
exec dbo.usp_AddRatingToStaffer	@json
-------------------------------------------------
set @json =
N'
{
  "Patient": {
    "Login": "Liviu",
    "PasswordHash": "20e0we45744sdgs43aksdca"
  },
  "Staffer": {
    "Login": "Sidor86"
  },
  "RatingInfo": {
    "RatingValue": 9,
    "RatingDateTime": "2022-10-11T11:44:56.7448175+03:00",
    "RatingComment": "Wow!"
  }
}
'
exec dbo.usp_AddRatingToStaffer	@json
-------------------------------------------------
set @json =
N'
{
  "Patient": {
    "Login": "Liviu",
    "PasswordHash": "20e0we45744sdgs43aksdca"
  },
  "Staffer": {
    "Login": "Volosevich76"
  },
  "RatingInfo": {
    "RatingValue": 8,
    "RatingDateTime": "2022-10-11T11:44:56.7781922+03:00",
    "RatingComment": "Good!"
  }
}
'
exec dbo.usp_AddRatingToStaffer	@json
-------------------------------------------------
set @json =
N'
{
  "Patient": {
    "Login": "Liviu",
    "PasswordHash": "20e0we45744sdgs43aksdca"
  },
  "Staffer": {
    "Login": "Kovboy"
  },
  "RatingInfo": {
    "RatingValue": 6,
    "RatingDateTime": "2022-10-11T11:44:56.7785701+03:00",
    "RatingComment": "Some Questions!"
  }
}
'
exec dbo.usp_AddRatingToStaffer	@json
-------------------------------------------------
set @json =
N'
{
  "Patient": {
    "Login": "Malets",
    "PasswordHash": "20e0we457445345kdcjlaksdca"
  },
  "Staffer": {
    "Login": "Kheidor"
  },
  "RatingInfo": {
    "RatingValue": 9,
    "RatingDateTime": "2022-10-11T11:44:56.7788391+03:00",
    "RatingComment": "Great!"
  }
}
'
exec dbo.usp_AddRatingToStaffer	@json
-------------------------------------------------
set @json =
N'
{
  "Patient": {
    "Login": "Malets",
    "PasswordHash": "20e0we457445345kdcjlaksdca"
  },
  "Staffer": {
    "Login": "Sidor86"
  },
  "RatingInfo": {
    "RatingValue": 10,
    "RatingDateTime": "2022-10-11T11:44:56.7791315+03:00",
    "RatingComment": "Best!"
  }
}
'
exec dbo.usp_AddRatingToStaffer	@json
-------------------------------------------------
set @json =
N'
{
  "Patient": {
    "Login": "Malets",
    "PasswordHash": "20e0we457445345kdcjlaksdca"
  },
  "Staffer": {
    "Login": "Oleg66"
  },
  "RatingInfo": {
    "RatingValue": 10,
    "RatingDateTime": "2022-10-11T11:44:56.7796351+03:00",
    "RatingComment": "No Questions!"
  }
}
'
exec dbo.usp_AddRatingToStaffer	@json
end
go
