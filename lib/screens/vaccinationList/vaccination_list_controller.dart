import 'package:asha_pay/asha_pay.dart';
import 'package:asha_pay/model/family_model.dart';
import 'package:asha_pay/screens/home/api/programsApi.dart';

import '../../model/family_activity_model.dart' hide Members;
import '../../model/get_family_activity_model.dart';
import '../../model/get_mother_child_model.dart';

class VaccinationListController extends GetxController {
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
      Members? selectedMember;

      //=========================
      // Get selected member
      //=========================

      for (var activity in familyActivityModel?.data?.activities ?? []) {
        if (activity.activityId == 2) {
          if (selectedIndex >= 0 && selectedIndex < activity.members.length) {
            selectedMember = activity.members[selectedIndex];
          }
          break;
        }
      }

      if (selectedMember == null) {
        toastMsg("Please select member");
        loader = false;
        update(['asha_gatividhi']);
        return;
      }

      //=========================
      // Vaccination list
      //=========================

      List<Map<String, dynamic>> vaccinationList = [];

      for (var vaccination in selectedMember.vaccinations ?? []) {
        for (int i = 0; i < (vaccination.vaccines?.length ?? 0); i++) {
          final vaccine = vaccination.vaccines![i];

          // Same key used in UI
          String key = "${vaccination.ageStage}-$i";

          // Selected date from UI
          String selectedDate = selectedDates[key] ?? "";

          vaccinationList.add({
            "vaccineType": vaccination.ageStage ?? "",

            "vaccineName": vaccine.name ?? "",

            // Completed if date selected
            "action": selectedDate.isNotEmpty
                ? "Completed"
                : (vaccine.action ?? "Pending"),

            // Send selected date
            "date":
                selectedDate.isNotEmpty ? selectedDate : (vaccine.date ?? ""),
          });
        }
      }

      //=========================
      // Body Parameter
      //=========================

      Map<String, dynamic> body = {
        "programId": 1,
        "familyId": familyData?.familyId ?? "",
        "activities": [
          {
            "activityId": 2,
            "members": [
              {
                "memberId": selectedMember.memberId ?? "",
                "memberName": selectedMember.memberName ?? "",
                "spouseName": "",
                "deathDate": "",
                "lmpDate": "",
                "dateOfReg": "",
                "action": "",
                "vaccinations": vaccinationList,
              }
            ]
          }
        ]
      };

      debugPrint(
        "Vaccination Body => $body",
      );

      final success = await ProgramsApi.addAshaMembersActivity(
        body,
      );

      print("सफल kjfj $success");
      if (success) {
        Get.back();
        Get.snackbar(
          "सफल",
          "गतिविधि सफलतापूर्वक जोड़ दिया गया",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );


      } else {
        Get.snackbar(
          "त्रुटि",
          "डेटा सेव नहीं हुआ",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint(
        "Submit Error => $e",
      );
    }

    loader = false;
    update(['vaccination_list']);
  }
}
