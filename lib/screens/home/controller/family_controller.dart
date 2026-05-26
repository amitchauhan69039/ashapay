import 'package:asha_pay/asha_pay.dart';
import 'package:asha_pay/model/family_model.dart';
import 'package:asha_pay/screens/home/api/programsApi.dart';

class FamilyController extends GetxController {
  static const String familySearchID = "familySearchID";

  bool isLoading = false;
  bool hasSearched = false;

  String currentFamilyId = "";

  List<FamilyData> familyList = [];

  final TextEditingController searchCtrl = TextEditingController();

  String? familyIdError;

  /// safer than index map
  Map<String, String> memberStatus = {};

  @override
  void onInit() {
    super.onInit();
    searchCtrl.text = "6XGZ0695";
  }

  bool get hasNewMembers {
    if (familyList.isEmpty) return false;

    final members = familyList.first.members ?? [];

    return members.any((m) => m.memberId == null || m.memberId!.isEmpty);
  }

  /// ================= SEARCH =================
  Future<void> searchFamily(String familyID) async {
    if (familyID.isEmpty) {
      familyIdError = "Family ID डालें";
      update([familySearchID]);
      return;
    }

    isLoading = true;
    hasSearched = true;

    familyList.clear();
    update([familySearchID]);

    try {
      final body = {"familyid": familyID};

      final response = await ProgramsApi.getFamilyMembers(body);

      if (response != null && response.isNotEmpty) {
        familyList.addAll(response);
        currentFamilyId = familyID;
      }

    } catch (e) {
      Get.snackbar("Error", e.toString());
    }

    isLoading = false;
    update([familySearchID]);
  }

  /// ================= ADD MEMBER =================
  void addNewMember() {
    if (familyList.isEmpty) return;

    final members = familyList.first.members ?? [];
    familyList.first.members ??= members;

    if (members.isNotEmpty) {
      final last = members.last;

      if ((last.memberId ?? "").isEmpty &&
          (last.memberName ?? "").trim().isEmpty) {
        Get.snackbar("Error", "पहले पिछला सदस्य भरें");
        return;
      }
    }

    members.add(
      FamilyMembers(
        memberName: "",
        gender: "",
        dob: "",
        abhaId: "",
        addharId: "",
      ),
    );

    update([familySearchID]);
  }

  /// ================= VALIDATION =================
  bool validateMembers() {
    if (familyList.isEmpty) {
      Get.snackbar("Error", "कोई सदस्य नहीं मिला");
      return false;
    }

    final members = familyList.first.members ?? [];

    for (var m in members) {
      final isExisting = (m.memberId ?? "").isNotEmpty;
      if (isExisting) continue;

      if ((m.memberName ?? "").trim().isEmpty) {
        Get.snackbar("Error", "नाम भरें");
        return false;
      }

      if ((m.dob ?? "").isEmpty) {
        Get.snackbar("Error", "जन्म तिथि चुनें");
        return false;
      }

      if ((m.gender ?? "").isEmpty) {
        Get.snackbar("Error", "लिंग चुनें");
        return false;
      }

     /* if ((m.addharId ?? "").isEmpty) {
        Get.snackbar("Error", "आधार नंबर भरें");
        return false;
      }*/
    }

    return true;
  }

  bool isExistingMember(FamilyMembers m) {
    return (m.memberId != null && m.memberId!.isNotEmpty);
  }

  /// ================= PAYLOAD =================
  Map<String, dynamic> buildPayload() {
    final members = familyList.first.members ?? [];

    final newMembers = members.where((m) => (m.memberId ?? "").isEmpty).toList();

    return {
      "familyId": searchCtrl.text.trim(),
      "createdUser": 0,
      "members": newMembers.map((m) {
        final key = m.hashCode.toString();

        return {
          "memberName": m.memberName ?? "",
          "memberId": "",
          "gender": m.gender ?? "",
          "dob": m.dob ?? "",
          "abhaId": m.abhaId ?? "",
          "aadharId": m.addharId ?? "",
          "status": memberStatus[key] ?? "",
        };
      }).toList(),
    };
  }

  /// ================= SAVE =================
  Future<void> saveFamily() async {
    if (!validateMembers()) return;

    isLoading = true;
    update([familySearchID]);

    try {
      final payload = buildPayload();

      final success =
      await ProgramsApi.addFamilyMembers(payload);

      if (success) {
        Get.snackbar("Success", "Family saved successfully",
            backgroundColor: Colors.green,
            colorText: Colors.white);

        familyList.clear();
        memberStatus.clear();

        await reloadFamily();
      } else {
        Get.snackbar("Error", "Save failed");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }

    isLoading = false;
    update([familySearchID]);
  }

  Future<void> reloadFamily() async {
    if (currentFamilyId.isEmpty) return;
    await searchFamily(currentFamilyId);
  }
}