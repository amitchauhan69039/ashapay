import 'package:asha_pay/asha_pay.dart';
import 'package:asha_pay/model/MemberModel.dart';
import 'package:asha_pay/model/family_model.dart';
import 'package:asha_pay/screens/home/api/programsApi.dart';

class FamilyController extends GetxController {
  static const String familySearchID = "familySearchID";

  bool isLoading = false;
  bool hasSearched = false;

  List<MemberModel> membersList = [];
  List<FamilyData> familyList = [];

  final TextEditingController searchCtrl = TextEditingController();

  String? familyIdError;

  @override
  void onInit() {
    super.onInit();
    searchCtrl.text = "6XGZ0695";

    searchCtrl.addListener(() {
      if (familyIdError != null) {
        familyIdError = null;
        update([familySearchID]);
      }
    });
  }

  /// 🔍 SEARCH
  Future<void> searchFamily() async {
    final familyID = searchCtrl.text.trim();

    if (familyID.isEmpty) {
      familyIdError = "Family ID डालें";
      update([familySearchID]);
      return;
    }

    familyIdError = null;
    isLoading = true;
    hasSearched = true;
    update([familySearchID]);

    try {
      final response = await ProgramsApi.getFamilyMembers(familyID) ?? [];

      familyList =
          response.where((e) => e.familyId == familyID).toList();

      /// 🔥 MAP API → membersList
      membersList.clear();

      if (familyList.isNotEmpty && familyList[0].members != null) {
        for (var m in familyList[0].members!) {
          final model = MemberModel();

          model.memberId = m.memberId; // ✅ important

          model.nameCtrl.text = m.memberName ?? "";
          model.genderCtrl.text = m.gender ?? "";
          model.dobCtrl.text = m.dob ?? "";
          model.abhaCtrl.text = m.abhaId ?? "";
          model.aadharCtrl.text = m.addharId ?? "";

          // existing me mother name nahi hota
          model.motherCtrl.text = "";

          membersList.add(model);
        }
      }

      if (membersList.isEmpty) {
        Get.snackbar("No Data", "इस ID का कोई परिवार नहीं मिला");
      }

    } catch (e) {
      print(e);
    }

    isLoading = false;
    update([familySearchID]);
  }

  /// ➕ ADD MEMBER
  void addNewMember() {
    if (!validateLastMember()) return;

    /// 🔥 prevent empty spam
    if (membersList.isNotEmpty) {
      final last = membersList.last;

      final isExisting =
          last.memberId != null && last.memberId!.isNotEmpty;

      if (!isExisting &&
          last.motherCtrl.text.trim().isEmpty) {
        return;
      }
    }

    membersList.add(MemberModel());
    update([familySearchID]);
  }

  /// ✅ LAST MEMBER VALIDATION
  bool validateLastMember() {
    if (membersList.isEmpty) return true;

    final m = membersList.last;

    final isExisting =
        m.memberId != null && m.memberId!.isNotEmpty;

    // skip existing
    if (isExisting) return true;

    // 🔥 SAME validation as validateMembers
    if (m.nameCtrl.text.trim().isEmpty ||
        m.motherCtrl.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "नाम और माँ का नाम भरना आवश्यक है",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    return true;
  }

  /// 📦 FINAL VALIDATION (SAVE TIME)
  bool validateMembers() {
    for (var m in membersList) {
      final isExisting =
          m.memberId != null && m.memberId!.isNotEmpty;

      /// skip existing
      if (isExisting) continue;

      /// validate new
      if (m.nameCtrl.text.trim().isEmpty ||
          m.motherCtrl.text.trim().isEmpty) {
        Get.snackbar(
          "Error",
          "Name & Mother's Name required",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }
    }
    return true;
  }

  /// 📦 PAYLOAD (API READY)
  Map<String, dynamic> buildPayload() {
    return {
      "familyId": searchCtrl.text.trim(),
      "createdUser": 0,
      "members": membersList.map((m) {
        return {
          "value": m.nameCtrl.text.trim(),
          "text": m.motherCtrl.text.trim(),
          "gender": m.genderCtrl.text.trim(),
          "dob": m.dobCtrl.text.trim(),
          "aabhaId": m.abhaCtrl.text.trim(),
          "aadharId": m.aadharCtrl.text.trim(),
        };
      }).toList()
    };
  }

  Future<void> saveFamily() async {
    if (!validateMembers()) return;

    isLoading = true;
    update([familySearchID]);

    try {
      final payload = buildPayload();

      final success = await ProgramsApi.addFamilyMembers(payload);

      if (success) {
        Get.snackbar(
          "सफल",
          "परिवार सफलतापूर्वक जोड़ दिया गया",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // 🔥 optional: reload data
        await searchFamily();

      } else {
        Get.snackbar(
          "त्रुटि",
          "डेटा सेव नहीं हुआ",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

    } catch (e) {
      Get.snackbar(
        "त्रुटि",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    isLoading = false;
    update([familySearchID]);
  }
}