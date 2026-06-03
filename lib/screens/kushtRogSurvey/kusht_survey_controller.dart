import 'package:asha_pay/model/family_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home/api/programsApi.dart';

class KushtSurveyController extends GetxController {
  RxString answer = "".obs;

  Rxn<FamilyMembers> selectedMember = Rxn<FamilyMembers>();

  List<FamilyMembers> memberList = [];

  final remarksController = TextEditingController();

  bool loader = false;

  void setFamilyMembers(FamilyData familyData) {
    memberList = familyData.members ?? [];
  }

  Future<void> submitSurvey(
      FamilyData familyData,
      int programId,
      int activityId,
      ) async {
    if (answer.value == "YES" && selectedMember.value == null) {
      Get.snackbar(
        "Alert",
        "कृपया रोगी का चयन करें",
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    loader = true;
    update(["tb_survey"]);

    Map<String, dynamic> body = {
      "programId": programId,
      "activityId": activityId,
      "familyId": familyData.familyId,
      "sampleStatus": answer.value,

      /// अगर YES है तो member id जाएगी
      "member_Id": answer.value == "YES"
          ? selectedMember.value?.memberId
          : "",

      /// optional
      "patientStatus": answer.value,
    };

    debugPrint("TB BODY : $body");

    try {
      final response =
      await ProgramsApi.addIndependentProgramSurvey(body);

      debugPrint("TB RESPONSE : $response");

      if (response != null && response["status"] == "Success") {
        Get.back();
        Get.snackbar(
          "Success",
          response["message"] ?? "Survey submitted successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Future.delayed(const Duration(milliseconds: 800), () {
          Get.back();
        });
      } else {
        Get.snackbar(
          "Error",
          response?["message"] ?? "Something went wrong",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint("TB ERROR : $e");

      Get.snackbar(
        "Error",
        "Something went wrong",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    loader = false;
    update(["tb_survey"]);
  }

  @override
  void onClose() {
    remarksController.dispose();
    super.onClose();
  }
}