import 'package:asha_pay/asha_pay.dart';

import '../home/api/programsApi.dart';

class MonthlyActivityController extends GetxController {
  bool isLoading = false;

  TextEditingController dateController = TextEditingController();
  TextEditingController agendaController = TextEditingController();
  String selectedPlace = "";
  String activity = "";

  List<String> lmpDates = [];
  List<String> regDates = [];

  List<String> selectedMembers = [];
  List<String> selectedCouplesMembers = [];

  String lmp1 = '';
  String reg1 = '';
  String lmp2 = '';
  String reg2 = '';

  bool selectedNo1 = true;
  bool selectedNo2 = true;
  bool selectedNo3 = true;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> addAshaMeetingActivity() async {
    // if (!validateMembers()) return;

    if (activity == "6") {
      if (dateController.text.trim().isEmpty) {
        Get.snackbar(
          "Validation",
          "Please select date",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      if (selectedPlace.trim().isEmpty) {
        Get.snackbar(
          "Validation",
          "Please select place",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
    }

    if (activity == "7") {
      if (dateController.text.trim().isEmpty) {
        Get.snackbar(
          "Validation",
          "Please select date",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      if (selectedPlace.trim().isEmpty) {
        Get.snackbar(
          "Validation",
          "Please select place",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      if (agendaController.text.trim().isEmpty) {
        Get.snackbar(
          "Validation",
          "Please enter agenda",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
    }


    if (activity == "8") {
      if (dateController.text.trim().isEmpty) {
        Get.snackbar(
          "Validation",
          "Please select date",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      if (selectedPlace.trim().isEmpty) {
        Get.snackbar(
          "Validation",
          "Please select place",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
    }

    isLoading = true;
    update(['monthly_activity']);

    try {
      Map<String, dynamic> body = {};

      final success = await ProgramsApi.addAshaMeetingActivity(body);

      if (success) {
        Get.snackbar("Success", "Family saved successfully",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Error", "Save failed");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }

    isLoading = false;
    update(['monthly_activity']);
  }
}
