import 'package:asha_pay/asha_pay.dart';
import 'package:asha_pay/screens/home/api/programsApi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddFamilyController extends GetxController {

  /// 🔹 TEXT CONTROLLERS
  final headNameCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final villageCtrl = TextEditingController();
  final membersCtrl = TextEditingController();
  final childrenCtrl = TextEditingController();
  final dobCtrl = TextEditingController();
  final ageCtrl = TextEditingController();

  /// 🔹 DROPDOWN
  String? selectedRation;
  String? selectedIncome;
  String? selectedGender;

  final rationList = ["APL", "BPL", "AAY", "NFSA", "कोई नहीं"];
  final incomeList = ["Low Income", "Middle Income", "High Income"];
  final genderList = ["Male", "Female", "Other"];

  /// 🔹 LOADING
  bool isLoading = false;

  /// 🔹 DROPDOWN UPDATE
  void changeRation(String? value) {
    selectedRation = value;
    update();
  }

  void changeIncome(String? value) {
    selectedIncome = value;
    update();
  }

  void changeGender(String? value) {
    selectedGender = value;
    update();
  }

  /// 🔹 DOB PICKER (yyyy/MM/dd)
  Future<void> pickDob(BuildContext context) async {

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1990),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      dobCtrl.text = DateFormat('yyyy/MM/dd').format(picked);

      calculateAge(picked);

      update();
    }
  }

  /// 🔹 AGE CALCULATION
  void calculateAge(DateTime dob) {

    final today = DateTime.now();

    int age = today.year - dob.year;

    if (today.month < dob.month ||
        (today.month == dob.month && today.day < dob.day)) {
      age--;
    }

    ageCtrl.text = age.toString();
    update();
  }

  /// 🔹 VALIDATION
  bool validateForm() {

    if (headNameCtrl.text.trim().isEmpty) {
      Get.snackbar("Error", "मुखिया का नाम डालें");
      return false;
    }

    if (mobileCtrl.text.trim().length != 10) {
      Get.snackbar("Error", "Valid मोबाइल नंबर डालें");
      return false;
    }

    if (addressCtrl.text.trim().isEmpty) {
      Get.snackbar("Error", "पता डालें");
      return false;
    }

    if (villageCtrl.text.trim().isEmpty) {
      Get.snackbar("Error", "गांव डालें");
      return false;
    }

    if (selectedGender == null) {
      Get.snackbar("Error", "लिंग चुनें");
      return false;
    }

    if (dobCtrl.text.isEmpty) {
      Get.snackbar("Error", "DOB चुनें");
      return false;
    }

    if (selectedRation == null) {
      Get.snackbar("Error", "राशन कार्ड चुनें");
      return false;
    }

    if (selectedIncome == null) {
      Get.snackbar("Error", "आय वर्ग चुनें");
      return false;
    }

    return true;
  }

  /// 🔹 API CALL
  Future<void> addNewFamily() async {

    if (!validateForm()) return;

    isLoading = true;
    update();

    try {

      final payload = {
        "headName": headNameCtrl.text.trim(),
        "mobileNo": mobileCtrl.text.trim(),
        "address": addressCtrl.text.trim(),
        "village": villageCtrl.text.trim(),
        "gender": selectedGender ?? "",
        "age": ageCtrl.text.trim(),
        "dob": dobCtrl.text.trim(), // yyyy/MM/dd
        "rationCardType": selectedRation ?? "",
        "incomeGroup": selectedIncome ?? "",
        "createdUser": 3089, // replace with login userId
      };

      final success = await ProgramsApi.addNewFamily(payload);

      if (success) {

        Get.snackbar(
          "सफल",
          "परिवार सफलतापूर्वक जोड़ दिया गया",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        clearForm();

        Get.to(()=> DashboardScreen());

      } else {
        Get.snackbar("त्रुटि", "डेटा सेव नहीं हुआ");
      }

    } catch (e) {
      Get.snackbar("त्रुटि", e.toString());
    }

    isLoading = false;
    update();
  }

  /// 🔹 CLEAR FORM
  void clearForm() {

    headNameCtrl.clear();
    mobileCtrl.clear();
    addressCtrl.clear();
    villageCtrl.clear();
    membersCtrl.clear();
    childrenCtrl.clear();
    dobCtrl.clear();
    ageCtrl.clear();

    selectedGender = null;
    selectedRation = null;
    selectedIncome = null;

    update();
  }

  @override
  void onClose() {
    headNameCtrl.dispose();
    mobileCtrl.dispose();
    addressCtrl.dispose();
    villageCtrl.dispose();
    membersCtrl.dispose();
    childrenCtrl.dispose();
    dobCtrl.dispose();
    ageCtrl.dispose();
    super.onClose();
  }
}