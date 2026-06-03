class EndPoints {
  static const baseUrl = 'http://117.239.183.134:8080/api/';

  //--------------------------------- endpoints ---------------------------------
  static const login = baseUrl+'Auth/login';
  static const getPrograms = baseUrl+'Asha/GetAshaProgramMaster';
  static const getAshaIndependentProgramMaster = baseUrl+'Asha/GetAshaIndependentProgramMaster';
  static const getAshaActivityMaster = baseUrl+'Asha/GetAshaActivityMaster';
  static const getFamilyMembers = baseUrl+'Asha/ListFamilyWithMembers';
  static const getFamilyMembersWithID = baseUrl+'Asha/ListFamilyMembersWithId';
  static const getActivitybyFamilyId = baseUrl+'Asha/GetActivitybyFamilyId';
  static const addFamilyMembers = baseUrl+'Asha/AddFamilyMembers';
  static const addAshaMemberActivity = baseUrl+'Asha/AddAshaMemberActivity';
  static const addAshaMeetingActivity = baseUrl+'Asha/AddAshaMeetingActivity';
  static const getMotherChildListWithId = baseUrl+'Asha/GetMotherChildListWithId';
  static const getMarriedFemaleListWihfamilyId = baseUrl+'Asha/GetMarriedFemaleListWihfamilyId';

  static const addNewFamily = baseUrl+'Asha/AddNewFamily';

}

