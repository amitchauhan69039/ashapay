import 'package:asha_pay/model/family_model.dart';
import 'package:asha_pay/screens/home/api/programsApi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TBTreatmentController extends GetxController {
  Rxn<FamilyMembers> selectedMember = Rxn<FamilyMembers>();

  List<FamilyMembers> memberList = [];

  RxString tbCategory = "".obs;
  RxString treatmentStartDate = "".obs;
  RxString treatmentEndDate = "".obs;
  RxString medicineTaken = "".obs;
  RxString patientStatus = "".obs;

  bool loader = false;

  void setFamilyMembers(FamilyData familyData) {
    memberList = familyData.members ?? [];
  }

  Future<void> submitTreatment(
      FamilyData familyData,
      int programId,
      int activityId,
      ) async {
    if (selectedMember.value == null) {
      Get.snackbar("Alert", "कृपया रोगी चुनें");
      return;
    }

    if (tbCategory.value.isEmpty) {
      Get.snackbar("Alert", "कृपया TB Category चुनें");
      return;
    }

    if (treatmentStartDate.value.isEmpty) {
      Get.snackbar("Alert", "कृपया Treatment Start Date चुनें");
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

    loader = true;
    update(["tb_treatment"]);

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
      "sampleStatus": tbCategory.value,
      "collectionDate": now.toIso8601String(),
      "resultDate": now.toIso8601String(),
      "member_Id": selectedMember.value?.memberId ?? "",
      "diseaseType": "TB",
      "treatmentStartDate": treatmentStartDate.value,
      "treatmentEndDate":
      treatmentEndDate.value.isEmpty ? null : treatmentEndDate.value,
      "monitoringMonth": now.month.toString(),
      "monitoringYear": now.year,
      "medicineTaken": medicineTaken.value == "YES",
      "monitoringDate": now.toIso8601String(),
      "patientStatus": patientStatus.value,
    };

    debugPrint("TB TREATMENT BODY : $body");

    try {
      final response =
      await ProgramsApi.addIndependentProgramSurvey(body);

      if (response != null && response["status"] == "Success") {
        Get.snackbar(
          "Success",
          response["message"] ?? "Saved successfully",
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
        );
      }
    } catch (e) {
      debugPrint("TB TREATMENT ERROR : $e");
      Get.snackbar("Error", "Something went wrong");
    }

    loader = false;
    update(["tb_treatment"]);
  }
}