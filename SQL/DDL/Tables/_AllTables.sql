use MedCenterDB
go

if OBJECT_ID('dbo.Equipments', 'U') is not null
	drop table dbo.Equipments
go

create table dbo.Equipments
(
	EquipmentId					int				not null identity,
	InventaryNumber				nvarchar(15)	not null,
	EquipmentName				nvarchar(100)	not null,
	EquipmentRoom				int				null,
	EquipmentTypeId				tinyint			not null,
	EquipmentStateId			tinyint			not null,
	RegistrationDateTime		datetime2		not null,
	EquipmentNote				nvarchar(200)	null,
	LastEditor					int				not null,

	constraint PK_Equipments primary key (EquipmentId)
);
go
use MedCenterDB
go

if OBJECT_ID('dbo.EquipmentsServicesLink', 'U') is not null
	drop table dbo.EquipmentsServicesLink
go

create table dbo.EquipmentsServicesLink
(
	EquipmentId		int			not null,
	ServiceId		int			not null,

	constraint PK_EquipmentsServicesLink primary key (EquipmentId, ServiceId)
);
go
use MedCenterDB
go

if OBJECT_ID('dbo.EquipmentStates', 'U') is not null
	drop table dbo.EquipmentStates
go

create table dbo.EquipmentStates
(
	EquipmentStateId		tinyint			not null identity,
	EquipmentState			nvarchar(30)	not null,

	constraint PK_EquipmentStates primary key (EquipmentStateId)
);
go
use MedCenterDB
go

if OBJECT_ID('dbo.EquipmentTypes', 'U') is not null
	drop table dbo.EquipmentTypes
go

create table dbo.EquipmentTypes
(
	EquipmentTypeId			tinyint			not null identity,
	EquipmentType			nvarchar(30)	not null,

	constraint PK_EquipmentTypes primary key (EquipmentTypeId)
);
go
use MedCenterDB
go

if OBJECT_ID('dbo.Genders', 'U') is not null
	drop table dbo.Genders
go

create table dbo.Genders
(
	GenderId		tinyint			not null identity,
	GenderName		nvarchar(30)	not null,

	constraint PK_Genders primary key (GenderId)
);
go
use MedCenterDB
go

if OBJECT_ID('dbo.Guests', 'U') is not null
	drop table dbo.Guests
go

create table dbo.Guests
(
	GuestId					int				not null identity,
	IPAddress				nvarchar(15)    not null,
	SessionDateTime			datetime2		not null,
	BrowserUserAgent		nvarchar(200)	not null,
	AuthorizedUser			int				not null,

	constraint PK_Guests primary key (GuestId)
);
go
use MedCenterDB
go

if OBJECT_ID('dbo.MedicalCategories', 'U') is not null
	drop table dbo.MedicalCategories
go

create table dbo.MedicalCategories
(
	MedicalCategoryId			tinyint			not null identity,
	MedicalCategory				nvarchar(30)	not null,

	constraint PK_MedicalCategories primary key (MedicalCategoryId)
);
go
use MedCenterDB
go

if OBJECT_ID('dbo.Patients', 'U') is not null
	drop table dbo.Patients
go

create table dbo.Patients
(
	PatientId					int				not null identity,
	PatientUserId				int				not null,
	PatientPassport				nvarchar(10)	not null,
	PatientHomeAddress			nvarchar(100)	not null,
	PatientStatusId				tinyint			not null,
	InsurancePolicy				nvarchar(30)	null,
	Photo						nvarchar(200)	null, 
	ChronicDeseases				nvarchar(200)	null,
	IndividualNotes				nvarchar(200)	null,
	InnerComment				nvarchar(200)	null,
	RegisterDateTime			datetime2		not null,
	PatientRegistrator			int				not null,

	constraint PK_Patients primary key (PatientId)
);
go
use MedCenterDB
go

if OBJECT_ID('dbo.PatientStatuses', 'U') is not null
	drop table dbo.PatientStatuses
go

create table dbo.PatientStatuses
(
	PatientStatusId		tinyint			not null identity,
	PatientStatus		nvarchar(30)	not null,

	constraint PK_PatientStatuses primary key (PatientStatusId)
);
go
use MedCenterDB
go

if OBJECT_ID('dbo.PaymentStates', 'U') is not null
	drop table dbo.PaymentStates
go

create table dbo.PaymentStates
(
	PaymentStateId		tinyint			not null identity,
	PaymentState		nvarchar(30)	not null,

	constraint PK_PaymentStates primary key (PaymentStateId)
);
go
use MedCenterDB
go

if OBJECT_ID('dbo.Phones', 'U') is not null
	drop table dbo.Phones
go

create table dbo.Phones
(
	PhoneId			int				not null identity,
	PhoneNumber		nvarchar(20)	not null,

	constraint PK_Phones primary key (PhoneId)
);
go
use MedCenterDB
go

if OBJECT_ID('dbo.Ratings', 'U') is not null
	drop table dbo.Ratings
go

create table dbo.Ratings
(
	RatingId			int				not null identity,
	PatientId			int				not null,
	StafferId			int				not null,
	RatingValue			tinyint			not null,
	RatingComment		nvarchar(250)	null,
	RatingDateTime		datetime2		not null,

	constraint PK_Ratings primary key (RatingId)
);
go
use MedCenterDB
go

if OBJECT_ID('dbo.Rooms', 'U') is not null
	drop table dbo.Rooms
go

create table dbo.Rooms
(
	RoomId						int				not null identity,
	RoomName					nvarchar(20)	not null,
	RoomTypeId					tinyint			not null,
	RoomStateId					tinyint			not null,
	LastUpdateDateTime			datetime2		not null,
	RoomNotes					nvarchar(100)	null,

	constraint PK_Rooms primary key (RoomId)
);
go
use MedCenterDB
go

if OBJECT_ID('dbo.RoomStates', 'U') is not null
	drop table dbo.RoomStates
go

create table dbo.RoomStates
(
	RoomStateId			tinyint			not null identity,
	RoomState			nvarchar(30)	not null,

	constraint PK_RoomStates primary key (RoomStateId)
);
go
use MedCenterDB
go

if OBJECT_ID('dbo.RoomTypes', 'U') is not null
	drop table dbo.RoomTypes
go

create table dbo.RoomTypes
(
	RoomTypeId		tinyint			not null identity,
	RoomType		nvarchar(30)	not null,

	constraint PK_RoomTypes primary key (RoomTypeId)
);
go
use MedCenterDB
go

if OBJECT_ID('dbo.ServiceCategories', 'U') is not null
	drop table dbo.ServiceCategories
go

create table dbo.ServiceCategories
(
	ServiceCategoryId			tinyint			not null identity,
	ServiceCategory			nvarchar(30)	not null,

	constraint PK_ServiceCategories primary key (ServiceCategoryId)
);
go
use MedCenterDB
go

if OBJECT_ID('dbo.Services', 'U') is not null
	drop table dbo.Services
go

create table dbo.Services
(
	ServiceId					int				not null identity,
	ServiceName					nvarchar(50)	not null,
	ServiceStatusId				tinyint			not null,
	Comment						nvarchar(150)	null,
	Price						money			null,
	ServiceCategoryId			tinyint			not null, 
	[Description]				nvarchar(200)	null,

	constraint PK_Services primary key (ServiceId)
);
go
use MedCenterDB
go

if OBJECT_ID('dbo.ServiceStatuses', 'U') is not null
	drop table dbo.ServiceStatuses
go

create table dbo.ServiceStatuses
(
	ServiceStatusId				tinyint			not null identity,
	ServiceStatus				nvarchar(30)	not null,

	constraint PK_ServiceStatuses primary key (ServiceStatusId)
);
go
use MedCenterDB
go

if OBJECT_ID('dbo.Specialities', 'U') is not null
	drop table dbo.Specialities
go

create table dbo.Specialities
(
	SpecialityId			tinyint			not null identity,
	Speciality				nvarchar(30)	not null,

	constraint PK_Specialities primary key (SpecialityId)
);
go
use MedCenterDB
go

if OBJECT_ID('dbo.StafferGroups', 'U') is not null
	drop table dbo.StafferGroups
go

create table dbo.StafferGroups
(
	StafferGroupId			tinyint			not null identity,
	StafferGroup			nvarchar(30)	not null,

	constraint PK_StafferGroups primary key (StafferGroupId)
);
go
use MedCenterDB
go

if OBJECT_ID('dbo.Staffers', 'U') is not null
	drop table dbo.Staffers
go

create table dbo.Staffers
(
	StafferId					int				not null identity,
	StafferUserId				int			not null,
	StafferGroupId				tinyint			not null,
	StafferPassport				nvarchar(10)	not null,
	StafferHomeAddress			nvarchar(100)	not null,
	ShortSummary				nvarchar(200)	null,
	SpecialityId				tinyint			not null,
	MedicalCategoryId			tinyint			not null,
	Photo						nvarchar(200)	null, 
	PersonalNotes				nvarchar(200)	null,
	RegisterDateTime			datetime2		not null,
	StafferRegistrator			int				not null,

	constraint PK_Staffers primary key (StafferId)
);
go
use MedCenterDB
go

if OBJECT_ID('dbo.StaffersVisitsLink', 'U') is not null
	drop table dbo.StaffersVisitsLink
go

create table dbo.StaffersVisitsLink
(
	StafferId		int			not null,
	VisitId			int			not null,

	constraint PK_StaffersVisitsLink primary key (StafferId, VisitId)
)
go
use MedCenterDB
go

if OBJECT_ID('dbo.Tests', 'U') is not null
	drop table dbo.Tests
go

create table dbo.Tests
(
	TestId					int				not null identity,
	VisitId					int				not null,
	ServiceId				int				not null,
	TestTypeId				tinyint			not null, 
	TestStateId				tinyint			not null,
	Result					nvarchar(300)	null,
	TestComment				nvarchar(200)	null,

	constraint PK_Tests primary key (TestId)
);
go
use MedCenterDB
go

if OBJECT_ID('dbo.TestsEquipmentsLink', 'U') is not null
	drop table dbo.TestsEquipmentsLink
go

create table dbo.TestsEquipmentsLink
(
	EquipmentId		int			not null,
	TestId			int			not null,

	constraint PK_TestsEquipmentsLink primary key (TestId, EquipmentId)
);
go
use MedCenterDB
go

if OBJECT_ID('dbo.TestStates', 'U') is not null
	drop table dbo.TestStates
go

create table dbo.TestStates
(
	TestStateId		tinyint			not null identity,
	TestState		nvarchar(30)	not null,

	constraint PK_TestStates primary key (TestStateId)
);
go
use MedCenterDB
go

if OBJECT_ID('dbo.TestTypes', 'U') is not null
	drop table dbo.TestTypes
go

create table dbo.TestTypes
(
	TestTypeId		tinyint			not null identity,
	TestType		nvarchar(30)	not null,

	constraint PK_TestTypes primary key (TestTypeId)
);
go
use MedCenterDB
go

if OBJECT_ID('dbo.UserRoles', 'U') is not null
	drop table dbo.UserRoles
go

create table dbo.UserRoles
(
	UserRoleId		tinyint			not null identity,
	UserRole		nvarchar(20)	not null,

	constraint PK_UserRoles primary key (UserRoleId)
);
go
use MedCenterDB
go

if OBJECT_ID('dbo.Users', 'U') is not null
	drop table dbo.Users
go

create table dbo.Users
(
	UserId					int				not null identity,
	[Login]					nvarchar(20)	not null,
	Email					nvarchar(50)	null,
	PasswordHash			char(64)		not null,
	FullName				nvarchar(100)	not null,
	GenderId				tinyint			not null, 
	DateOfBirth				date			not null,
	UserRoleId				tinyint			not null,
	RegisterDateTime		datetime2		not null,
	LastActiveDateTime		datetime2		not null,
	AdminApprover			int				null,

	constraint PK_Users primary key (UserId)
);
go
use MedCenterDB
go

if OBJECT_ID('dbo.UsersPhonesLink', 'U') is not null
	drop table dbo.UsersPhonesLink
go

create table dbo.UsersPhonesLink
(
	UserId		int			not null,
	PhoneId		int			not null,

	constraint PK_UsersPhonesLink primary key (UserId, PhoneId)
);
go
use MedCenterDB
go

if OBJECT_ID('dbo.Visits', 'U') is not null
	drop table dbo.Visits
go

create table dbo.Visits
(
	VisitId					int			not null identity,
	BaseService				int				not null,
	Specialist				int				not null,
	ScheduledDateTime		datetime2		not null,
	RecordedPatient			int				null,
	PreliminaryNotes		nvarchar(300)	null,
	VisitRoom				int				not null,
	Summary					nvarchar(300)	null,
	TotalPrice				money			null,
	PaymentStateId			tinyint			not null,
	VisitTypeId				tinyint			not null, 
	VisitStatusId			tinyint			not null,
	InternalComment			nvarchar(200)	null,
	RecordDateTime			datetime2		null,

	constraint PK_Visits primary key (VisitId)
);
go
use MedCenterDB
go

if OBJECT_ID('dbo.VisitStatuses', 'U') is not null
	drop table dbo.VisitStatuses
go

create table dbo.VisitStatuses
(
	VisitStatusId		tinyint			not null identity,
	VisitStatus			nvarchar(30)	not null,

	constraint PK_VisitStatuses primary key (VisitStatusId)
);
go
use MedCenterDB
go

if OBJECT_ID('dbo.VisitTypes', 'U') is not null
	drop table dbo.VisitTypes
go

create table dbo.VisitTypes
(
	VisitTypeId			tinyint			not null identity,
	VisitType			nvarchar(30)	not null,

	constraint PK_VisitTypes primary key (VisitTypeId)
);
go
