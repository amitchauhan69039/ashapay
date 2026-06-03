import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/family_model.dart';
import '../home/api/programsApi.dart';

class IodineSurveyController extends GetxController {
  RxString answer = "".obs;

  final remarksController = TextEditingController();

  bool loader = false;

  Future<void> submitSurvey(
      FamilyData familyData,
      int programId,
      int activityId,
      ) async {
    loader = true;
    update(["iodine_survey"]);

    Map<String, dynamic> body = {
      "programId": programId,
      "activityId": activityId,
      "familyId": familyData.familyId,
      "sampleStatus": answer.value,
      "member_Id": ""
    };

    debugPrint("IODINE BODY : $body");

    try {
      final response =
      await ProgramsApi.addIndependentProgramSurvey(body);

      debugPrint("FINAL RESPONSE : $response");

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
      debugPrint("ERROR : $e");

      Get.snackbar(
        "Error",
        "Something went wrong",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    loader = false;
    update(["iodine_survey"]);
  }

  @override
  void onClose() {
    remarksController.dispose();
    super.onClose();
  }
}