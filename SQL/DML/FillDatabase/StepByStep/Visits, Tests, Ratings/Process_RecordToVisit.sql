use MedCenterDB
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