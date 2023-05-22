use MedCenterDB
go

delete Ratings
delete StaffersVisitsLink
delete Visits

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
