using MedCenterDB.DbObjects;
using MedCenterDB.Helpers.JsonConverters;
using MedCenterDB.Helpers.References;
using System.Runtime.CompilerServices;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace MedCenterDB.Helpers;

public class JsonMaker
{
    private string _filePath;
    private JsonSerializerOptions _options;

    public JsonMaker()
    {
        _filePath = Path.Combine(Directory.GetCurrentDirectory(), "JsonFiles");
        if (!Directory.Exists(_filePath))
        {
            Directory.CreateDirectory(_filePath);
        }
        _options = new JsonSerializerOptions()
        {
            WriteIndented = true,
            DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull,
            Converters = { new JsonDecimalConverter(), new JsonServiceListConverter() }
        };
    }

    public void UserToJson(User user)
    {
        if (user == null || string.IsNullOrWhiteSpace(user.Login))
        {
            throw new ArgumentNullException(nameof(user));
        }

        var fileFullName = Path.Combine(_filePath, user.Login+".json");

        var json = JsonSerializer.Serialize(user, _options);
        File.WriteAllText(fileFullName, json);
    }

    public void NewUserRegistrationJson(Guest guest, User user, string fileName)
    {
        ArgumentNullException.ThrowIfNull(guest);
        ArgumentNullException.ThrowIfNull(user);

        var guestTmp = guest.Clone();
        var userTmp = user.Clone();

        userTmp.UserRole = null;
        userTmp.AdminApprover = null;
        guestTmp.AuthorizedUser = null;
        //user.LastActiveDateTime = null;
        //user.RegisterDateTime = null;

        var fileFullName = Path.Combine(_filePath, fileName + ".json");

        var data = new NewUserRegistrationData(guestTmp, userTmp);
        var json = JsonSerializer.Serialize(data, _options);
        File.WriteAllText(fileFullName, json);
    }

    public void UserAuthorizationJson(Guest guest, User user, string fileName = "temp")
    {
        ArgumentNullException.ThrowIfNull(guest);
        ArgumentNullException.ThrowIfNull(user);

        var guestTmp = guest.Clone();
        var userTmp = user.Clone();

        userTmp.OnlyLoginAndPassword();
        guestTmp.AuthorizedUser = null;

        var fileFullName = Path.Combine(_filePath, fileName + ".json");
        var data = new UserAuthorizationData(guestTmp, userTmp);
        var json = JsonSerializer.Serialize(data, _options);
        File.WriteAllText(fileFullName, json);
    }

    public void InitializeAdministratorJson(User user, string fileName = "temp")
    {
        ArgumentNullException.ThrowIfNull(user);

        var userTmp = user.Clone();

        userTmp.OnlyLogin();

        var fileFullName = Path.Combine(_filePath, fileName + ".json");
        var data = new InitializeAdministratorData(userTmp);
        var json = JsonSerializer.Serialize(data, _options);
        File.WriteAllText(fileFullName, json);
    }

    public void ApproveAsAdministratorJson(User user, User approver, string fileName = "temp")
    {
        ArgumentNullException.ThrowIfNull(approver);
        ArgumentNullException.ThrowIfNull(user);

        var approverTmp = approver.Clone();
        var userTmp = user.Clone();

        userTmp.OnlyLogin();
        approverTmp.OnlyLoginAndPassword();

        var fileFullName = Path.Combine(_filePath, fileName + ".json");
        var data = new ApproveAsAdministratorData(userTmp, approverTmp);
        var json = JsonSerializer.Serialize(data, _options);
        File.WriteAllText(fileFullName, json);
    }

    public void RegisterUserAsStafferJson(User user, Staffer staffer, User registrator, string fileName = "temp")
    {
        ArgumentNullException.ThrowIfNull(staffer);
        ArgumentNullException.ThrowIfNull(user);
        ArgumentNullException.ThrowIfNull(registrator);

        var stafferTmp = staffer.Clone();
        var registratorTmp = registrator.Clone();
        var userTmp = user.Clone();


        registratorTmp.OnlyLoginAndPassword();
        userTmp.OnlyLogin();
        stafferTmp.User = null;
        stafferTmp.StafferRegistrator = null;

        var fileFullName = Path.Combine(_filePath, fileName + ".json");
        var data = new RegisterUserAsStafferData(userTmp, stafferTmp, registratorTmp);
        var json = JsonSerializer.Serialize(data, _options);
        File.WriteAllText(fileFullName, json);
    }

    public void RegisterUserAsPatientJson(User user, Patient patient, User registrator, string fileName = "temp")
    {
        ArgumentNullException.ThrowIfNull(patient);
        ArgumentNullException.ThrowIfNull(user);
        ArgumentNullException.ThrowIfNull(registrator);

        var patientTmp = patient.Clone();
        var registratorTmp = registrator.Clone();
        var userTmp = user.Clone();


        registratorTmp.OnlyLoginAndPassword();
        userTmp.OnlyLogin();
        patientTmp.User = null;
        patientTmp.PatientRegistrator = null;

        var fileFullName = Path.Combine(_filePath, fileName + ".json");
        var data = new RegisterUserAsPatientData(userTmp, patientTmp, registratorTmp);
        var json = JsonSerializer.Serialize(data, _options);
        File.WriteAllText(fileFullName, json);
    }

    public void CreateServiceJson(User user, Service service, string fileName = "temp")
    {
        ArgumentNullException.ThrowIfNull(service);
        ArgumentNullException.ThrowIfNull(user);

        var serviceTmp = service.Clone();
        var userTmp = user.Clone();

        userTmp.OnlyLoginAndPassword();
        var fileFullName = Path.Combine(_filePath, fileName + ".json");

        var data = new CreateServiceData(userTmp, serviceTmp);
        var json = JsonSerializer.Serialize(data, _options);
        File.WriteAllText(fileFullName, json);
    }

    public void CreateRoomJson(User user, Room room, string fileName = "temp")
    {
        ArgumentNullException.ThrowIfNull(room);
        ArgumentNullException.ThrowIfNull(user);

        var roomTmp = room.Clone();
        var userTmp = user.Clone();

        userTmp.OnlyLoginAndPassword();
        var fileFullName = Path.Combine(_filePath, fileName + ".json");

        var data = new CreateRoomData(userTmp, roomTmp);
        var json = JsonSerializer.Serialize(data, _options);
        File.WriteAllText(fileFullName, json);
    }

    public void CreateEquipmentJson(User user, Equipment equipment, string fileName = "temp")
    {
        ArgumentNullException.ThrowIfNull(equipment);
        ArgumentNullException.ThrowIfNull(user);

        var equipmentTmp = equipment.Clone();
        var userTmp = user.Clone();

        userTmp.OnlyLoginAndPassword();
        equipmentTmp.LastEditor = equipmentTmp.LastEditor?.Clone();
        equipmentTmp.LastEditor?.OnlyLoginAndPassword();

        var fileFullName = Path.Combine(_filePath, fileName + ".json");
        var data = new CreateEquipmentData(userTmp, equipmentTmp);
        var json = JsonSerializer.Serialize(data, _options);
        File.WriteAllText(fileFullName, json);
    }

    public void SetServicesForEquipmentJson(User user, List<Equipment> equipments, List<Service> services, string fileName = "temp")
    {
        ArgumentNullException.ThrowIfNull(equipments);
        ArgumentNullException.ThrowIfNull(user);
        ArgumentNullException.ThrowIfNull(services);

        var servicesTmp = services.Select(x => x.Clone()).ToList();
        var equipmentsTmp = equipments.Select(x => x.Clone()).ToList();
        var userTmp = user.Clone();

        servicesTmp.ForEach(x => x.OnlyName());
        userTmp.OnlyLoginAndPassword();
        equipmentsTmp.ForEach(x => x.OnlyNumber());

        var fileFullName = Path.Combine(_filePath, fileName + ".json");
        var data = new SetServicesForEquipmentData(userTmp, equipmentsTmp, servicesTmp);
        var json = JsonSerializer.Serialize(data, _options);
        File.WriteAllText(fileFullName, json);
    }

    public void AssignEquipmentsToRoomJson(User user, Room room, List<Equipment> equipments, string fileName = "temp")
    {
        ArgumentNullException.ThrowIfNull(equipments);
        ArgumentNullException.ThrowIfNull(user);
        ArgumentNullException.ThrowIfNull(room);

        var roomTmp = room.Clone();
        var equipmentsTmp = equipments.Select(x => x.Clone()).ToList();
        var userTmp = user.Clone();

        roomTmp.OnlyName();
        userTmp.OnlyLoginAndPassword();
        equipmentsTmp.ForEach(x => x.OnlyNumber());

        var fileFullName = Path.Combine(_filePath, fileName + ".json");
        var data = new AssignEquipmentsToRoomData(userTmp, roomTmp, equipmentsTmp);
        var json = JsonSerializer.Serialize(data, _options);
        File.WriteAllText(fileFullName, json);
    }

    public void ScheduleVisitJson(User registrator, Service baseService, User specialist, Visit visit, User patient, Room room, User[] assistants, string fileName = "temp")
    {
        ArgumentNullException.ThrowIfNull(registrator);
        ArgumentNullException.ThrowIfNull(specialist);
        ArgumentNullException.ThrowIfNull(visit);
        ArgumentNullException.ThrowIfNull(room);
        ArgumentNullException.ThrowIfNull(baseService);

        var registratorTmp = registrator.Clone();
        registratorTmp.OnlyLoginAndPassword();
        var baseServiceTmp = baseService.Clone();
        baseServiceTmp.OnlyName();
        var specialistTmp = specialist.Clone();
        specialistTmp.OnlyLogin();
        var roomTmp = room.Clone();
        roomTmp.OnlyName();
        List<User> assistsTmp = null;
        if (assistants != null)
        {
            assistsTmp = new ();
            foreach (var assistant in assistants)
            {
                var assistantTmp = assistant.Clone();
                assistantTmp.OnlyLogin();
                assistsTmp.Add(assistantTmp);
            }
        }
        var visitTmp = visit.Clone();
        visitTmp.OnlyValues();
        visitTmp.RecordDateTime = null;

        var fileFullName = Path.Combine(_filePath, fileName + ".json");
        var data = new ScheduleVisitData(registratorTmp, baseServiceTmp, specialistTmp, visitTmp, assistsTmp, roomTmp);
        var json = JsonSerializer.Serialize(data, _options);
        File.WriteAllText(fileFullName, json);
    }

    public void AddRatingJson(User patient, User staffer, Rating rating, string fileName = "temp")
    {
        ArgumentNullException.ThrowIfNull(patient);
        ArgumentNullException.ThrowIfNull(staffer);
        ArgumentNullException.ThrowIfNull(rating);

        var patientTmp = patient.Clone();
        var stafferTmp = staffer.Clone();
        var ratingTmp = rating.Clone();

        patientTmp.OnlyLoginAndPassword();
        stafferTmp.OnlyLogin();
        ratingTmp.Staffer = null;
        ratingTmp.Patient = null;

        var fileFullName = Path.Combine(_filePath, fileName + ".json");
        var data = new AddRatingToStafferData(patientTmp, stafferTmp, ratingTmp);
        var json = JsonSerializer.Serialize(data, _options);
        File.WriteAllText(fileFullName, json);
    }

    public void RecordToVisitByPatientJson(User patient, Visit visit, string fileName = "temp")
    {
        ArgumentNullException.ThrowIfNull(patient);
        ArgumentNullException.ThrowIfNull(visit);

        var patientTmp = patient.Clone();
        patientTmp.OnlyLoginAndPassword();
        var specialistTmp = visit.Specialist.Clone();
        specialistTmp.OnlyLogin();
        var visitTmp = new Visit() { ScheduledDateTime = visit.ScheduledDateTime };
        visitTmp.Specialist = specialistTmp;

        var fileFullName = Path.Combine(_filePath, fileName + ".json");
        var data = new RecordToVisitByPatientData(patientTmp, visitTmp);
        var json = JsonSerializer.Serialize(data, _options);
        File.WriteAllText(fileFullName, json);
    }

    public void RecordToVisitByStafferJson(User staffer, User patient, Visit visit, string fileName = "temp")
    {
        ArgumentNullException.ThrowIfNull(staffer);
        ArgumentNullException.ThrowIfNull(patient);
        ArgumentNullException.ThrowIfNull(visit);

        var stafferTmp = staffer.Clone();
        stafferTmp.OnlyLoginAndPassword();
        var patientTmp = patient.Clone();
        patientTmp.OnlyLogin();
        var specialistTmp = visit.Specialist.Clone();
        specialistTmp.OnlyLogin();
        var visitTmp = new Visit() { ScheduledDateTime = visit.ScheduledDateTime };
        visitTmp.Specialist = specialistTmp;

        var fileFullName = Path.Combine(_filePath, fileName + ".json");
        var data = new RecordToVisitByStafferData(stafferTmp, patientTmp, visitTmp);
        var json = JsonSerializer.Serialize(data, _options);
        File.WriteAllText(fileFullName, json);
    }



    #region Records
    public record class NewUserRegistrationData(Guest Guest, User User);
    public record class InitializeAdministratorData(User User);
    public record class UserAuthorizationData(Guest Guest, User User);
    public record class ApproveAsAdministratorData(User User, User Approver);
    public record class CreateServiceData(User Admin, Service Service);
    public record class CreateEquipmentData(User Admin, Equipment Equipment);
    public record class CreateRoomData(User Admin, Room Room);
    public record class RegisterUserAsPatientData(User User, Patient PatientInfo, User Registrator);
    public record class RegisterUserAsStafferData(User User, Staffer StafferInfo, User Registrator);
    public record class AddRatingToStafferData(User Patient, User Staffer, Rating RatingInfo);
    public record class SetServicesForEquipmentData(User Admin, List<Equipment> Equipments, List<Service> Services);
    public record class AssignEquipmentsToRoomData(User Admin, Room Room, List<Equipment> Equipments);
    public record class ScheduleVisitData(User Staffer, Service BaseService, User Specialist, Visit VisitInfo, List<User> Assistants, Room Room);
    public record class RecordToVisitByPatientData(User Patient, Visit Visit);
    public record class RecordToVisitByStafferData(User Staffer, User Patient, Visit Visit);
    public record class EditVisitData(Staffer Specialist, Visit Visit);
    public record class PlanTestData(Staffer Specialist, Test Visit);
    public record class MakeTestData(Staffer Specialist, Test Test);
    public record class EditTestResultData(Staffer Specialist, Test Test);
    public record class ViewResultData(Patient Patient, Visit Visit);
    public record class AcceptPaymentData(Staffer Staffer, Visit Visit);
    #endregion

}
