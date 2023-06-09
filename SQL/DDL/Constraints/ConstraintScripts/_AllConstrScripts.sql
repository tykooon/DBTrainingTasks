use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.Equipments',
	@fields = 'InventaryNumber',
	@constraintName = 'AK_Equipments_InventaryNumber'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Equipments',
	@targetFields = 'EquipmentStateId',
	@parentTableName = 'dbo.EquipmentStates',
	@parentFields = 'EquipmentStateId',
	@constraintName = 'FK_Equipments_EquipmentStateId'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Equipments',
	@targetFields = 'EquipmentTypeId',
	@parentTableName = 'dbo.EquipmentTypes',
	@parentFields = 'EquipmentTypeId',
	@constraintName = 'FK_Equipments_EquipmentTypeId'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Equipments',
	@targetFields = 'EquipmentRoom',
	@parentTableName = 'dbo.Rooms',
	@parentFields = 'RoomId',
	@constraintName = 'FK_Equipments_EquipmentRoom'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Equipments',
	@targetFields = 'LastEditor',
	@parentTableName = 'dbo.Users',
	@parentFields = 'UserId',
	@constraintName = 'FK_Equipments_LastEditor'
go

exec dbo.usp_AddCheckConstraint
	@tableName = 'dbo.Equipments',
	@condition = 'RegistrationDateTime <= SYSDATETIME()',
	@constraintName = 'CK_Equipments_RegistrationDateTime'
go
use MedCenterDB
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.EquipmentsServicesLink',
	@targetFields = 'EquipmentId',
	@parentTableName = 'dbo.Equipments',
	@parentFields = 'EquipmentId',
	@constraintName = 'FK_EquipmentsServicesLink_Equipments'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.EquipmentsServicesLink',
	@targetFields = 'ServiceId',
	@parentTableName = 'dbo.Services',
	@parentFields = 'ServiceId',
	@constraintName = 'FK_EquipmentsServicesLink_Services'
go
use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.EquipmentStates',
	@fields = 'EquipmentState',
	@constraintName = 'AK_EquipmentStates_EquipmentState'
go
use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.EquipmentTypes',
	@fields = 'EquipmentType',
	@constraintName = 'AK_EquipmentTypes_EquipmentType'
go
use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.Genders',
	@fields = 'GenderName',
	@constraintName = 'AK_Genders_GenderName'
go
use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.Guests',
	@fields = 'IPAddress, SessionDateTime, BrowserUserAgent',
	@constraintName = 'AK_Guests_IPAddress_SessionDateTime_BrowserUserAgent'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Guests',
	@targetFields = 'AuthorizedUser',
	@parentTableName = 'dbo.Users',
	@parentFields = 'UserId',
	@constraintName = 'FK_Guests_Users'
go

exec dbo.usp_AddCheckConstraint
	@tableName = 'dbo.Guests',
	@condition = 'SessionDateTime <= SYSDATETIME()',
	@constraintName = 'CK_Guests_SessionDateTime'
go
use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.MedicalCategories',
	@fields = 'MedicalCategory',
	@constraintName = 'AK_MedicalCategories_MedicalCategory'
go
use MedCenterDB
go

--ВОПРОС ПРО ЗНАЧЕНИЯ ПО УМОЛЧАНИЮ ДЛЯ КЛАССИФИЦИРУЮЩИХ ПОЛЕЙ

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.Patients',
	@fields = 'PatientPassport',
	@constraintName = 'AK_Patients_PatientPassport'
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.Patients',
	@fields = 'PatientUserId',
	@constraintName = 'AK_Patients_PatientUserId'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Patients',
	@targetFields = 'PatientUserId',
	@parentTableName = 'dbo.Users',
	@parentFields = 'UserId',
	@constraintName = 'FK_Patients_Users'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Patients',
	@targetFields = 'PatientStatusId',
	@parentTableName = 'dbo.PatientStatuses',
	@parentFields = 'PatientStatusId',
	@constraintName = 'FK_Patients_PatientStatuses'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Patients',
	@targetFields = 'PatientRegistrator',
	@parentTableName = 'dbo.Staffers',
	@parentFields = 'StafferId',
	@constraintName = 'FK_Patients_Staffers'
go

exec dbo.usp_AddCheckConstraint
	@tableName = 'dbo.Patients',
	@condition = 'RegisterDateTime <= SYSDATETIME()',
	@constraintName = 'CK_Patients_RegisterDateTime'
go

exec dbo.usp_AddDefaultConstraint
	@tableName = 'dbo.Patients',
	@field = 'RegisterDateTime',
	@value = 'SYSDATETIME()',
	@constraintName = 'DF_Patients_RegisterDateTime'
go
use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.PatientStatuses',
	@fields = 'PatientStatus',
	@constraintName = 'AK_PatientStatuses_PatientStatus'
go
use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.PaymentStates',
	@fields = 'PaymentState',
	@constraintName = 'AK_PaymentStates_PaymentState'
go
use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.Phones',
	@fields = 'PhoneNumber',
	@constraintName = 'AK_Phones_PhoneNumber'
go
use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.Ratings',
	@fields = 'PatientId, StafferId',
	@constraintName = 'AK_Ratings_PatientId_StafferId'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Ratings',
	@targetFields = 'PatientId',
	@parentTableName = 'dbo.Patients',
	@parentFields = 'PatientId',
	@constraintName = 'FK_Ratings_Patients'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Ratings',
	@targetFields = 'StafferId',
	@parentTableName = 'dbo.Staffers',
	@parentFields = 'StafferId',
	@constraintName = 'FK_Ratings_Staffers'
go

exec dbo.usp_AddCheckConstraint
	@tableName = 'dbo.Ratings',
	@condition = 'RatingDateTime <= SYSDATETIME()',
	@constraintName = 'CK_Ratings_RatingDateTime'
go
use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.Rooms',
	@fields = 'RoomName',
	@constraintName = 'AK_Rooms_RoomName'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Rooms',
	@targetFields = 'RoomStateId',
	@parentTableName = 'dbo.RoomStates',
	@parentFields = 'RoomStateId',
	@constraintName = 'FK_Rooms_RoomStateId'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Rooms',
	@targetFields = 'RoomTypeId',
	@parentTableName = 'dbo.RoomTypes',
	@parentFields = 'RoomTypeId',
	@constraintName = 'FK_Rooms_RoomTypeId'
go

exec dbo.usp_AddCheckConstraint
	@tableName = 'dbo.Rooms',
	@condition = 'LastUpdateDateTime <= SYSDATETIME()',
	@constraintName = 'CK_Rooms_LastUpdateDateTime'
go
use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.RoomStates',
	@fields = 'RoomState',
	@constraintName = 'AK_RoomStates_RoomState'
go
use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.RoomTypes',
	@fields = 'RoomType',
	@constraintName = 'AK_RoomTypes_RoomType'
go
use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.ServiceCategories',
	@fields = 'ServiceCategory',
	@constraintName = 'AK_ServiceCategories_ServiceCategory'
go
use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.Services',
	@fields = 'ServiceName',
	@constraintName = 'AK_Services_ServiceName'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Services',
	@targetFields = 'ServiceStatusId',
	@parentTableName = 'dbo.ServiceStatuses',
	@parentFields = 'ServiceStatusId',
	@constraintName = 'FK_Services_ServiceStatuses'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Services',
	@targetFields = 'ServiceCategoryId',
	@parentTableName = 'dbo.ServiceCategories',
	@parentFields = 'ServiceCategoryId',
	@constraintName = 'FK_Services_ServiceCategories'
go
use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.ServiceStatuses',
	@fields = 'ServiceStatus',
	@constraintName = 'AK_ServiceStatuses_ServiceStatus'
go
use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.Specialities',
	@fields = 'Speciality',
	@constraintName = 'AK_Specialities_Speciality'
go
use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.StafferGroups',
	@fields = 'StafferGroup',
	@constraintName = 'AK_StafferGroups_StafferGroup'
go
use MedCenterDB
go

-- НАДО ЛИ ЗДЕСЬ ПРОВЕРЯТЬ ЗНАЧЕНИЕ КОНКРЕТНОГО ПОЛЯ UserRoles У StafferRegistrator, ПРИ СОЗДАНИИ

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.Staffers',
	@fields = 'StafferPassport',
	@constraintName = 'AK_Staffers_StafferPassport'
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.Staffers',
	@fields = 'StafferUserId',
	@constraintName = 'AK_Staffers_StafferUserId'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Staffers',
	@targetFields = 'StafferUserId',
	@parentTableName = 'dbo.Users',
	@parentFields = 'UserId',
	@constraintName = 'FK_Staffers_Users'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Staffers',
	@targetFields = 'StafferGroupId',
	@parentTableName = 'dbo.StafferGroups',
	@parentFields = 'StafferGroupId',
	@constraintName = 'FK_Staffers_StafferGroups'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Staffers',
	@targetFields = 'SpecialityId',
	@parentTableName = 'dbo.Specialities',
	@parentFields = 'SpecialityId',
	@constraintName = 'FK_Staffers_Specialities'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Staffers',
	@targetFields = 'MedicalCategoryId',
	@parentTableName = 'dbo.MedicalCategories',
	@parentFields = 'MedicalCategoryId',
	@constraintName = 'FK_Staffers_MedicalCategories'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Staffers',
	@targetFields = 'StafferRegistrator',
	@parentTableName = 'dbo.Users',
	@parentFields = 'UserId',
	@constraintName = 'FK_Staffers_AdminUsers'
go

exec dbo.usp_AddCheckConstraint
	@tableName = 'dbo.Staffers',
	@condition = 'RegisterDateTime <= SYSDATETIME()',
	@constraintName = 'CK_Staffers_RegisterDateTime'
go

exec dbo.usp_AddDefaultConstraint
	@tableName = 'dbo.Staffers',
	@field = 'RegisterDateTime',
	@value = 'SYSDATETIME()',
	@constraintName = 'DF_Staffers_RegisterDateTime'
go
use MedCenterDB
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.StaffersVisitsLink',
	@targetFields = 'StafferId',
	@parentTableName = 'dbo.Staffers',
	@parentFields = 'StafferId',
	@constraintName = 'FK_StaffersVisitsLink_Users'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.StaffersVisitsLink',
	@targetFields = 'VisitId',
	@parentTableName = 'dbo.Visits',
	@parentFields = 'VisitId',
	@constraintName = 'FK_StaffersVisitsLink_Phones'
go
use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.Tests',
	@fields = 'ServiceId, VisitId',
	@constraintName = 'AK_Tests_ServiceId_VisitId'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Tests',
	@targetFields = 'ServiceId',
	@parentTableName = 'dbo.Services',
	@parentFields = 'ServiceId',
	@constraintName = 'FK_Tests_Services'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Tests',
	@targetFields = 'VisitId',
	@parentTableName = 'dbo.Visits',
	@parentFields = 'VisitId',
	@constraintName = 'FK_Tests_Visits'
go


exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Tests',
	@targetFields = 'TestStateId',
	@parentTableName = 'dbo.TestStates',
	@parentFields = 'TestStateId',
	@constraintName = 'FK_Tests_TestStates'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Tests',
	@targetFields = 'TestTypeId',
	@parentTableName = 'dbo.TestTypes',
	@parentFields = 'TestTypeId',
	@constraintName = 'FK_Tests_TestTypes'
go

use MedCenterDB
go

-- ВОПРОС ПРО СОСТАВНОЙ КЛЮЧ В ЛИНКОВОЧНОЙ ТАБЛИЦЕ

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.TestsEquipmentsLink',
	@targetFields = 'EquipmentId',
	@parentTableName = 'dbo.Equipments',
	@parentFields = 'EquipmentId',
	@constraintName = 'FK_TestsEquipmentsLink_Equipments'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.TestsEquipmentsLink',
	@targetFields = 'TestId',
	@parentTableName = 'dbo.Tests',
	@parentFields = 'TestId',
	@constraintName = 'FK_TestsEquipmentsLink_Tests'
go
use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.TestStates',
	@fields = 'TestState',
	@constraintName = 'AK_TestStates_TestState'
go
use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.TestTypes',
	@fields = 'TestType',
	@constraintName = 'AK_TestTypes_TestType'
go
use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.UserRoles',
	@fields = 'UserRole',
	@constraintName = 'AK_UserRoles_UserRole'
go
use MedCenterDB
go

-- СОМНЕНИЯ ПО DF ДЛЯ LastActiveDateTime

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.Users',
	@fields = 'Login',
	@constraintName = 'AK_Users_Login'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Users',
	@targetFields = 'GenderId',
	@parentTableName = 'dbo.Genders',
	@parentFields = 'GenderId',
	@constraintName = 'FK_Users_Genders'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Users',
	@targetFields = 'UserRoleId',
	@parentTableName = 'dbo.UserRoles',
	@parentFields = 'UserRoleId',
	@constraintName = 'FK_Users_UserRoles'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Users',
	@targetFields = 'AdminApprover',
	@parentTableName = 'dbo.Users',
	@parentFields = 'UserId',
	@constraintName = 'FK_Users_AdminApprovers'
go

exec dbo.usp_AddCheckConstraint
	@tableName = 'dbo.Users',
	@condition = 'RegisterDateTime <= SYSDATETIME()',
	@constraintName = 'CK_Users_RegisterDateTime'
go

exec dbo.usp_AddCheckConstraint
	@tableName = 'dbo.Users',
	@condition = 'LastActiveDateTime >= RegisterDateTime',
	@constraintName = 'CK_Users_LastActiveDateTime_RegisterDateTime'
go

exec dbo.usp_AddCheckConstraint
	@tableName = 'dbo.Users',
	@condition = 'LastActiveDateTime <= SYSDATETIME()',
	@constraintName = 'CK_Users_LastActiveDateTime_SysDateTime'
go

exec dbo.usp_AddCheckConstraint
	@tableName = 'dbo.Users',
	@condition = '(0+ format(GETDATE(),''yyyyMMdd'') - format(DateOfBirth,''yyyyMMdd'') ) /10000 >= 18',
	@constraintName = 'CK_Users_DateOfBirth'
go

exec dbo.usp_AddDefaultConstraint
	@tableName = 'dbo.Users',
	@field = 'RegisterDateTime',
	@value = 'SYSDATETIME()',
	@constraintName = 'DF_Users_RegisterDateTime'
go

exec dbo.usp_AddDefaultConstraint
	@tableName = 'dbo.Users',
	@field = 'LastActiveDateTime',
	@value = 'SYSDATETIME()',
	@constraintName = 'DF_Users_LastActiveDateTime'
go
use MedCenterDB
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.UsersPhonesLink',
	@targetFields = 'UserId',
	@parentTableName = 'dbo.Users',
	@parentFields = 'UserId',
	@constraintName = 'FK_UsersPhonesLink_Users'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.UsersPhonesLink',
	@targetFields = 'PhoneId',
	@parentTableName = 'dbo.Phones',
	@parentFields = 'PhoneId',
	@constraintName = 'FK_UsersPhonesLink_Phones'
go
use MedCenterDB
go

-- ДОБАВИТЬ ЛИ ПРОВЕРКУ ЗАПЛАНИРОВАННОГО ВРЕМЕНИ ВИЗИТА (ВЫХОДНЫЕ ДНИ, РАБОЧЕЕ ВРЕМЯ)

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.Visits',
	@fields = 'Specialist, ScheduledDateTime',
	@constraintName = 'AK_Visits_Specialist_ScheduledDateTime'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Visits',
	@targetFields = 'BaseService',
	@parentTableName = 'dbo.Services',
	@parentFields = 'ServiceId',
	@constraintName = 'FK_Visits_BaseService'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Visits',
	@targetFields = 'Specialist',
	@parentTableName = 'dbo.Staffers',
	@parentFields = 'StafferId',
	@constraintName = 'FK_Visits_Specialist'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Visits',
	@targetFields = 'RecordedPatient',
	@parentTableName = 'dbo.Patients',
	@parentFields = 'PatientId',
	@constraintName = 'FK_Visits_RecordedPatient'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Visits',
	@targetFields = 'VisitRoom',
	@parentTableName = 'dbo.Rooms',
	@parentFields = 'RoomId',
	@constraintName = 'FK_Visits_Rooms'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Visits',
	@targetFields = 'PaymentStateId',
	@parentTableName = 'dbo.PaymentStates',
	@parentFields = 'PaymentStateId',
	@constraintName = 'FK_Visits_PaymentStates'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Visits',
	@targetFields = 'VisitStatusId',
	@parentTableName = 'dbo.VisitStatuses',
	@parentFields = 'VisitStatusId',
	@constraintName = 'FK_Visits_VisitStates'
go

exec dbo.usp_AddForeignKey
	@targetTableName = 'dbo.Visits',
	@targetFields = 'VisitTypeId',
	@parentTableName = 'dbo.VisitTypes',
	@parentFields = 'VisitTypeId',
	@constraintName = 'FK_Visits_VisitTypes'
go

--exec dbo.usp_AddCheckConstraint
--	@tableName = 'dbo.Visits',
--	@condition = 'RecordDateTime <= ScheduledDateTime',
--	@constraintName = 'CK_Visits_RecordDateTime'
--go
use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.VisitStatuses',
	@fields = 'VisitStatus',
	@constraintName = 'AK_VisitStatuses_VisitStatus'
go
use MedCenterDB
go

exec dbo.usp_AddAlternateKey
	@tableName = 'dbo.VisitTypes',
	@fields = 'VisitType',
	@constraintName = 'AK_VisitTypes_VisitType'
go
