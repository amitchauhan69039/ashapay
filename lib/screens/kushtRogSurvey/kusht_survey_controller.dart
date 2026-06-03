import 'package:asha_pay/model/family_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home/api/programsApi.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KushtSurveyController extends GetxController {
  RxString answer = "".obs;

  Rxn<FamilyMembers> selectedMember = Rxn<FamilyMembers>();

  List<FamilyMembers> memberList = [];

  final remarksController = TextEditingController();

  RxString diseaseType = "".obs;
  RxString treatmentStartDate = "".obs;
  RxString treatmentEndDate = "".obs;
  RxString medicineTaken = "".obs;
  RxString patientStatus = "".obs;

  bool loader = false;

  void setFamilyMembers(FamilyData familyData) {
    memberList = familyData.members ?? [];
  }

  Future<void> submitSurvey(
      FamilyData familyData,
      int programId,
      int activityId,
      bool showTreatmentFields,
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

    if (showTreatmentFields) {
      if (diseaseType.value.isEmpty) {
        Get.snackbar("Alert", "कृपया रोग का प्रकार चुनें");
        return;
      }

      if (treatmentStartDate.value.isEmpty) {
        Get.snackbar("Alert", "कृपया इलाज शुरू होने की तारीख चुनें");
        return;
      }

      if (medicineTaken.value.isEmpty) {
        Get.snackbar("Alert", "कृपया दवाई की स्थिति चुनें");
        return;
      }

      if (patientStatus.value.isEmpty) {
        Get.snackbar("Alert", "कृपया Patient Status चुनें");
        return;
      }
    }

    loader = true;
    update(["kusht_survey"]);

    final now = DateTime.now();

    Map<String, dynamic> body = {
      "programId": programId,
      "activityId": activityId,
      "familyId": familyData.familyId ?? "",
      // "districtId": familyData.districtId ?? 0,
      // "blockId": familyData.blockId ?? 0,
      // "chcId": familyData.chcId ?? 0,
      // "phcId": familyData.phcId ?? 0,
     // "villageId": familyData.villageId ?? 0,
      "sampleStatus": answer.value,
      "collectionDate": now.toIso8601String(),
      "resultDate": now.toIso8601String(),
      "member_Id": selectedMember.value?.memberId ?? "",
      "diseaseType": showTreatmentFields ? diseaseType.value : "",
      "treatmentStartDate":
      showTreatmentFields ? treatmentStartDate.value : null,
      "treatmentEndDate":
      showTreatmentFields ? treatmentEndDate.value : null,
      "monitoringMonth": now.month.toString(),
      "monitoringYear": now.year,
      "medicineTaken":
      showTreatmentFields ? medicineTaken.value == "YES" : false,
      "monitoringDate": now.toIso8601String(),
      "patientStatus":
      showTreatmentFields ? patientStatus.value : answer.value,
    };

    debugPrint("KUSHT BODY : $body");

    try {
      final response =
      await ProgramsApi.addIndependentProgramSurvey(body);

      debugPrint("KUSHT RESPONSE : $response");

      if (response != null && response["status"] == "Success") {
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
      debugPrint("KUSHT ERROR : $e");

      Get.snackbar(
        "Error",
        "Something went wrong",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    loader = false;
    update(["kusht_survey"]);
  }

  @override
  void onClose() {
    remarksController.dispose();
    super.onClose();
  }
}