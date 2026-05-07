import 'package:asha_pay/asha_pay.dart';
import 'package:asha_pay/model/family_model.dart';

import '../../../model/family_activity_model.dart';

class ProgramsApi{

  static Future<List<FamilyData>?> getFamilyMembers(String familyID) async {
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

  static Future<FamilyActivityModel?> getActivitybyFamilyId(Map<String, String> body) async {
    try {
      final response = await HttpService.getApi(
          url: EndPoints.getActivitybyFamilyId,
          queryParams: body
      );

      print("Respose: ${response}");


      if (response != null && response.statusCode == 200) {
        final responseBody = response.body;
        try {
          FamilyActivityModel model = familyActivityModelFromJson(responseBody);
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