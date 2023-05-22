using MedCenterDB.DbObjects;
using MedCenterDB.DbObjects.Infos;
using MedCenterDB.Helpers;

var j = new JsonMaker();

// ------- USERS
//j.UserToJson(Users.Tykoun);
//j.UserToJson(Users.Sidorovich);
//j.UserToJson(Users.Kalabuhov);
//j.UserToJson(Users.Kovbovich);
//j.UserToJson(Users.Kheidorov);
//j.UserToJson(Users.Volosevich);
//j.UserToJson(Users.Fridlyand);


//------ REGISTRATION
//j.NewUserRegistrationJson(Guests.Guest1, Users.Tykoun, "NewUserRegistrationData1");
//j.NewUserRegistrationJson(Guests.Guest2, Users.Sidorovich, "NewUserRegistrationData2");
//j.NewUserRegistrationJson(Guests.Guest3, Users.Volosevich, "NewUserRegistrationData3");
//j.NewUserRegistrationJson(Guests.Guest1, Users.Guydo, "NewUserRegistrationData8");
//j.NewUserRegistrationJson(Guests.Guest2, Users.Maletsky, "NewUserRegistrationData9");
//j.NewUserRegistrationJson(Guests.Guest3, Users.Liviu, "NewUserRegistrationData10");




//------- AUTHORIZATION
//j.UserAuthorizationJson(Guests.Guest2, Users.Sidorovich, "UserAuthorizationData1");
//j.UserAuthorizationJson(Guests.Guest2, Users.Sidorovich, "UserAuthorizationData1");

// ------- INITIAL ADMIN
//j.InitializeAdministratorJson(Users.Tykoun, "InitializeAdministratorData");

// ------ APPROVE AS ADMIN
//j.ApproveAsAdministratorJson(Users.Kalabuhov, Users.Tykoun, "ApproveAsAdministrator");

// ------ STAFFERS
//j.RegisterAsStafferJson(Users.Kovbovich, Staffers.Receptionist1, Users.Kalabuhov, "RegisterAsStafferData1");
//j.RegisterAsStafferJson(Users.Volosevich, Staffers.Doctor1, Users.Tykoun, "RegisterAsStafferData2");
//j.RegisterAsStafferJson(Users.Kheidorov, Staffers.Doctor2, Users.Kalabuhov, "RegisterAsStafferData3");
//j.RegisterAsStafferJson(Users.Fridlyand, Staffers.Director, Users.Tykoun, "RegisterAsStafferData4");
//j.RegisterAsStafferJson(Users.Sidorovich, Staffers.Assistant, Users.Kalabuhov, "RegisterAsStafferData5");

// ------ PATIENTS
//j.RegisterUserAsPatientJson(Users.Tykoun, Patients.Patient1, Users.Kovbovich, "RegisterUserAsPatientData1");
//j.RegisterUserAsPatientJson(Users.Guydo, Patients.Patient2, Users.Kovbovich, "RegisterUserAsPatientData2");
//j.RegisterUserAsPatientJson(Users.Maletsky, Patients.Patient3, Users.Kovbovich, "RegisterUserAsPatientData3");
//j.RegisterUserAsPatientJson(Users.Liviu, Patients.Patient4, Users.Kovbovich, "RegisterUserAsPatientData4");

// ------ SERVICES
//j.CreateServiceJson(Users.Kalabuhov, Services.CardioConsultation, "CreateSevice1");
//j.CreateServiceJson(Users.Kalabuhov, Services.TherapistConsultation, "CreateSevice2");
//j.CreateServiceJson(Users.Tykoun, Services.BloodTest1, "CreateSevice3");
//j.CreateServiceJson(Users.Kalabuhov, Services.BloodTest2, "CreateSevice4");
//j.CreateServiceJson(Users.Tykoun, Services.UlrtasoundLiver, "CreateSevice5");
//j.CreateServiceJson(Users.Kalabuhov, Services.UlrtasoundHeart, "CreateSevice6");

// ------ ROOMS
//j.CreateRoomJson(Users.Tykoun, Rooms.BossRoom, "CreateRoom1");
//j.CreateRoomJson(Users.Kalabuhov, Rooms.Cabinet1, "CreateRoom2");
//j.CreateRoomJson(Users.Tykoun, Rooms.CabinetXRay, "CreateRoom3");
//j.CreateRoomJson(Users.Tykoun, Rooms.CabinetUS, "CreateRoom4");
//j.CreateRoomJson(Users.Kalabuhov, Rooms.CabinetTest, "CreateRoom5");
//j.CreateRoomJson(Users.Kalabuhov, Rooms.Reception, "CreateRoom0");

// ------ EQUIPMENTS
//j.CreateEquipmentJson(Users.Kalabuhov, Equipments.PC1, "CreateEquipment1");
//j.CreateEquipmentJson(Users.Tykoun, Equipments.PC2, "CreateEquipment2");
//j.CreateEquipmentJson(Users.Kalabuhov, Equipments.PC3, "CreateEquipment3");
//j.CreateEquipmentJson(Users.Tykoun, Equipments.XRay, "CreateEquipment4");
//j.CreateEquipmentJson(Users.Kalabuhov, Equipments.Ultrasound1, "CreateEquipment5");
//j.CreateEquipmentJson(Users.Tykoun, Equipments.BloodAnalyzer1, "CreateEquipment6");
//j.CreateEquipmentJson(Users.Kalabuhov, Equipments.PC4, "CreateEquipment7");
//j.CreateEquipmentJson(Users.Tykoun, Equipments.PC5, "CreateEquipment8");
//j.CreateEquipmentJson(Users.Tykoun, Equipments.CashDesk1, "CreateEquipment9");

// ----- SET SERVICES FOR EQUIPMENTS
//var equips = new List<Equipment>() { Equipments.PC1, Equipments.PC2, Equipments.PC3, Equipments.PC4, Equipments.PC5 };
//var servs = new List<Service>() { Services.TherapistConsultation, Services.CardioConsultation };
//j.SetServicesForEquipmentJson(Users.Tykoun, equips, servs, "SetSetvicesFor EquipmentData");

// ----- ASSIGN EQUIPMENTS TO ROOM
//j.AssignEquipmentsToRoomJson(Users.Kalabuhov, Rooms.Reception,
//    new List<Equipment>() { Equipments.PC4, Equipments.CashDesk1 }, "AssignEquipmentsToRoomData");


//------SCHEDULE VISITS----------------------
//for (int i = 0; i < 6; i++)
//{
//    j.ScheduleVisitJson(Users.Kovbovich,
//                        Visits.Cardio0811[i].BaseService,
//                        Visits.Cardio0811[i].Specialist,
//                        Visits.Cardio0811[i],
//                        null,
//                        Visits.Cardio0811[i].VisitRoom,
//                        new User[] { Users.Sidorovich },
//                        "Visit_Cardio0811Data" + i
//                        );
//}
//for (int i = 0; i < 4; i++)
//{
//    j.ScheduleVisitJson(Users.Kheidorov,
//                        Visits.Ultrasound0911[i].BaseService,
//                        Visits.Ultrasound0911[i].Specialist,
//                        Visits.Ultrasound0911[i],
//                        null,
//                        Visits.Ultrasound0911[i].VisitRoom,
//                        new User[] { Users.Sidorovich },
//                        "Visit_Ultrasound0911Data" + i
//                        );
//}

// ------ RECORD TO VISIT BY PATIENT
//j.RecordToVisitByPatientJson(Users.Guydo, Visits.Cardio0811[0], "RecToVisitByPatientData1");
//j.RecordToVisitByPatientJson(Users.Maletsky, Visits.Cardio0811[2], "RecToVisitByPatientData2");
//j.RecordToVisitByPatientJson(Users.Maletsky, Visits.Ultrasound0911[0], "RecToVisitByPatientData3");
//j.RecordToVisitByPatientJson(Users.Liviu, Visits.Ultrasound0911[2], "RecToVisitByPatientData4");
//j.RecordToVisitByStafferJson(Users.Sidorovich, Users.Tykoun, Visits.Ultrasound0911[1], "RecToVisitByStafferData1");
//j.RecordToVisitByStafferJson(Users.Volosevich, Users.Guydo, Visits.Ultrasound0911[3], "RecToVisitByStafferData2");
//j.RecordToVisitByStafferJson(Users.Kheidorov, Users.Tykoun, Visits.Cardio0811[5], "RecToVisitByStafferData3");
//j.RecordToVisitByStafferJson(Users.Sidorovich, Users.Liviu, Visits.Cardio0811[2], "RecToVisitByStafferData4");


// ----- ADD RATINGS
//j.AddRatingJson(Users.Tykoun, Users.Sidorovich,
//    new Rating() { RatingValue = 10, RatingComment = "Cooool!" }, "AddRatingData1");
//j.AddRatingJson(Users.Tykoun, Users.Volosevich,
//    new Rating() { RatingValue = 9, RatingComment = "Nice!" }, "AddRatingData2");
//j.AddRatingJson(Users.Tykoun, Users.Kheidorov,
//    new Rating() { RatingValue = 7, RatingComment = "Not Bad!" }, "AddRatingData3");
//j.AddRatingJson(Users.Liviu, Users.Sidorovich,
//    new Rating() { RatingValue = 9, RatingComment = "Wow!" }, "AddRatingData4");
//j.AddRatingJson(Users.Liviu, Users.Volosevich,
//    new Rating() { RatingValue = 8, RatingComment = "Good!" }, "AddRatingData5");
//j.AddRatingJson(Users.Liviu, Users.Kovbovich,
//    new Rating() { RatingValue = 6, RatingComment = "Some Questions!" }, "AddRatingData6");
//j.AddRatingJson(Users.Maletsky, Users.Kheidorov,
//    new Rating() { RatingValue = 9, RatingComment = "Great!" }, "AddRatingData7");
//j.AddRatingJson(Users.Maletsky, Users.Sidorovich,
//    new Rating() { RatingValue = 10, RatingComment = "Best!" }, "AddRatingData8");
//j.AddRatingJson(Users.Maletsky, Users.Fridlyand,
//    new Rating() { RatingValue = 10, RatingComment = "No Questions!" }, "AddRatingData9");
//j.AddRatingJson(Users.Guydo, Users.Fridlyand,
//    new Rating() { RatingValue = 10, RatingComment = "Perfect!" }, "AddRatingData10");
//j.AddRatingJson(Users.Guydo, Users.Volosevich,
//    new Rating() { RatingValue = 9, RatingComment = "Very good!" }, "AddRatingData11");
//j.AddRatingJson(Users.Guydo, Users.Kheidorov,
//    new Rating() { RatingValue = 7, RatingComment = "Normal!" }, "AddRatingData12");


