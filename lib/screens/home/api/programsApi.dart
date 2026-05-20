import 'package:asha_pay/asha_pay.dart';
import 'package:asha_pay/model/family_model.dart';
import '../../../model/family_activity_model.dart';
import '../../../model/get_family_activity_model.dart';

class ProgramsApi{

  static Future<List<FamilyData>?> getFamilyMembers(Map<String, dynamic> body) async {
    try {
      final response = await HttpService.getApi(
        url: EndPoints.getFamilyMembers,
        queryParams: body
      );

      if (response != null) {
        print("Get Family Response: ${response.body}");
        print("Status Code: ${response.statusCode}");

        if (response.statusCode == 200) {
          final responseBody = json.decode(response.body);

          // 🔥 Parse using model
          FamilyModel model = FamilyModel.fromJson(responseBody);

          print("test");
          print(model.data?.first.members?.length);

          return model.data ?? [];
        } else {
          return [];
        }
      }
    } catch (e) {
      toastMsg(e.toString());
      debugPrint(e.toString());
      return [];
    }

    return [];
  }

  static Future<List<FamilyData>?> getAllFamilyMembers() async {
    try {
      final response = await HttpService.getApi(url: EndPoints.getFamilyMembers);

      print("Respose: ${response}");

      if (response != null) {
        print("Get Family Response: ${response.body}");
        print("Status Code: ${response.statusCode}");

        if (response.statusCode == 200) {
          final responseBody = json.decode(response.body);

          // 🔥 Parse using model
          FamilyModel model = FamilyModel.fromJson(responseBody);

          return model.data ?? [];
        } else {
          return [];
        }
      }
    } catch (e) {
      toastMsg(e.toString());
      debugPrint(e.toString());
      return [];
    }

    return [];
  }

  static Future<List<ProgramsData>?> getPrograms() async {
    try {
      final response = await HttpService.getApi(
        url: EndPoints.getPrograms,
      );

      print("Respose: ${response}");

      if (response != null) {
        print("Get Programs Response: ${response.body}");
        print("Status Code: ${response.statusCode}");

        if (response.statusCode == 200) {
          final responseBody = json.decode(response.body);

          // 🔥 Parse using model
          ProgramsModel model = ProgramsModel.fromJson(responseBody);

          return model.data ?? [];
        } else {
          return [];
        }
      }
    } catch (e) {
      toastMsg(e.toString());
      debugPrint(e.toString());
      return [];
    }

    return [];
  }

  static Future<GetFamilyActivityModel?> getActivitybyFamilyId(Map<String, String> body) async {
    try {
      final response = await HttpService.getApi(
          url: EndPoints.getActivitybyFamilyId,
          queryParams: body
      );

      print("Respose: ${response}");


      if (response != null && response.statusCode == 200) {
        final responseBody = response.body;
        try {
          GetFamilyActivityModel model = getFamilyActivityModelFromJson(responseBody);
          return model;
        } catch (e) {
          throw Exception("Unexpected response format: $responseBody");
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  static Future<bool> addFamilyMembers(Map<String, dynamic> body) async {
    try {
      final response = await HttpService.postApi(
        url: EndPoints.addFamilyMembers,
        body: body,
      );

      print("AddFamilyMembers body: $body");
      print("AddFamilyMembers response: ${response?.body}");

      if (response != null && response.statusCode == 200) {
        return true; // ✅ success
      }

    } catch (e) {
      throw Exception(e.toString());
    }

    return false;
  }

  static Future<bool> addNewFamily(Map<String, dynamic> body) async {
    try {
      final response = await HttpService.postApi(
        url: EndPoints.addNewFamily,
        body: body,
      );

      print("AddNewFamily body: $body");
      print("AddNewFamily response: ${response?.body}");

      if (response != null && response.statusCode == 200) {
        return true; // ✅ success
      }

    } catch (e) {
      throw Exception(e.toString());
    }

    return false;
  }

  static Future<bool> addAshaMembersActivity(Map<String, dynamic> body) async {
    try {
      final response = await HttpService.postApi(
        url: EndPoints.addAshaMemberActivity,
        body: body,
      );

      print("addAshaMemberActivity body: $body");
      print("addAshaMemberActivity response: ${response?.body}");

      if (response != null && response.statusCode == 200) {
        return true;
      }

    } catch (e) {
      throw Exception(e.toString());
    }

    return false;
  }

  static Future<GetFamilyActivityModel?> getMotherChildListWithId(Map<String, String> body) async {
    try {
      final response = await HttpService.getApi(
          url: EndPoints.getMotherChildListWithId,
          queryParams: body
      );

      print("Respose: ${response}");




      if (response != null && response.statusCode == 200) {
        final responseBody = response.body;
        try {
          print("Get Programs Response: ${response.body}");
          print("Status Code: ${response.statusCode}");

          GetFamilyActivityModel model = getFamilyActivityModelFromJson(responseBody);
          return model;
        } catch (e) {
          throw Exception("Unexpected response format: $responseBody");
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }
}