import 'package:asha_pay/asha_pay.dart';
import 'package:intl/intl.dart';
import '../home/api/programsApi.dart';

class MonthlyActivityController extends GetxController {
  bool isLoading = false;

  TextEditingController dateController = TextEditingController();

  TextEditingController agendaController = TextEditingController();

  String selectedPlace = "";
  String activity = "";
  String programId = "";

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
    /// Validation for activity 6,7,8
    if (activity == "6" || activity == "7" || activity == "8") {
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

    /// Agenda validation only for activity 7
    if (activity == "7" && agendaController.text.trim().isEmpty) {
      Get.snackbar(
        "Validation",
        "Please enter agenda",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading = true;
    update(['monthly_activity']);

    try {

      DateTime parsedDate =
      DateFormat("d-M-yyyy")
          .parse(dateController.text);

      String formattedDate =
      parsedDate.toIso8601String();
      /// API Body
      Map<String, dynamic> body = {
        "location": (activity == "6" || activity == "7" || activity == "8")
            ? selectedPlace : "",
        "programId":int.tryParse(programId,) ?? 0 ,
        "activityId": int.tryParse(activity,) ?? 0,
        "agendaOfMeeting": activity == "7" ? agendaController.text.trim() : "",
        "status": 0,
        "date":
        formattedDate,
      };

      print(
        "BODY => $body",
      );

      final success = await ProgramsApi.addAshaMeetingActivity(
        body,
      );

      if (success) {
        Get.snackbar(
          "Success",
          "Saved successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        /// Clear fields
        dateController.clear();
        agendaController.clear();
        selectedPlace = "";
        update(['monthly_activity']);
      } else {
        Get.snackbar(
          "Error",
          "Save failed",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    isLoading = false;
    update(['monthly_activity']);
  }

  @override
  void onClose() {
    dateController.dispose();
    agendaController.dispose();
    super.onClose();
  }
}
