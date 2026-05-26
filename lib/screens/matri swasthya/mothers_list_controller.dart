import 'package:asha_pay/asha_pay.dart';
import 'package:asha_pay/model/family_model.dart';
import 'package:asha_pay/screens/home/api/programsApi.dart';

import '../../model/family_activity_model.dart' hide Members;
import '../../model/get_family_activity_model.dart';
import '../../model/get_mother_child_model.dart';

class MothersListController extends GetxController {
  bool loader = false;
  GetFamilyActivityModel? familyActivityModel;
  GetMotherChildModel? motherChildModel;
  final TextEditingController searchCtrl = TextEditingController();
  FamilyData? familyData;
  Map<String, String> selectedDates = {};
  int selectedIndex = -1;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getActivitybyFamilyId(String familyId) async {
    loader = true;
    Map<String, String> body = {
      "familyid": familyId,
      "Programid": "1",
    };
    update(['vaccination_list']);
    try {
      GetFamilyActivityModel? model =
          await ProgramsApi.getActivitybyFamilyId(body);

      if (model != null) {
        if (model.status!.toLowerCase() == "success") {
          familyActivityModel = model;
        } else {
          toastMsg(model.message ?? 'Something went wrong');
        }
      }
    } catch (e) {
      debugPrint("Unexpected response format: ${e.toString()}");
    }

    loader = false;
    update(['vaccination_list']);
  }

  Future<void> getMotherChildListWithId(String familyId) async {
    loader = true;
    Map<String, String> body = {
      "familyid": familyId,
    };
    update(['vaccination_list']);
    try {
      GetMotherChildModel? model = await ProgramsApi.getMotherChildListWithId(body);

      if (model != null) {
        if (model.status!.toLowerCase() == "success") {
           motherChildModel=model;
        } else {
          toastMsg( 'Something went wrong');
        }
      }
    } catch (e) {
      debugPrint("Unexpected response format: ${e.toString()}");
    }

    loader = false;
    update(['vaccination_list']);
  }

  Future<void> dataSubmit() async {
    loader = true;
    update(['vaccination_list']);

    try {
      final pregnantWomen = motherChildModel?.data?.pregnantWomens ?? [];

      if (pregnantWomen.isEmpty) {
        toastMsg("No Mother Found");
        loader = false;
        update(['vaccination_list']);
        return;
      }

      List<Map<String, dynamic>> members = [];

      for (var mother in pregnantWomen) {
        List<Map<String, dynamic>> vaccinationList = [];

        for (int i = 0; i < (mother.vaccinationDetail?.length ?? 0);
          i++) {
          final vaccine = mother.vaccinationDetail![i];

          String key = "${mother.memberId}_${vaccine.vaccinationName}_$i";

          String selectedDate = selectedDates[key] ?? "";

          vaccinationList.add({
          //  "vaccineType": vaccine.vaccinationName ?? "",

            "vaccineName": vaccine.vaccinationName ?? "",

            "action": selectedDate.isNotEmpty
                ? "Completed"
                : (vaccine.vacStatus ?? "Pending"),

            "date": selectedDate,
          });
        }

        members.add({
          "memberId": mother.memberId ?? "",

          "memberName": mother.name ?? "",

          "spouseName": "",

          "deathDate": "",

          "lmpDate": mother.lmpWeeks ?? "",

          "dateOfReg": "",

          "action": "",

          "vaccinations": vaccinationList,
        });
      }

      Map<String, dynamic> body = {
        "programId": 1,

        "familyId": familyData?.familyId ?? "",

        "activities": [
          {
            "activityId": 2,

            "members": members,
          }
        ]
      };

      debugPrint("BODY => $body");

      final success =
      await ProgramsApi.addAshaMembersActivity(body);

      if (success) {
        Get.back();

        Get.snackbar(
          "Success",
          "Data Saved Successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Error",
          "Data not saved",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint("Submit Error => $e");
    }

    loader = false;
    update(['vaccination_list']);
  }
}
