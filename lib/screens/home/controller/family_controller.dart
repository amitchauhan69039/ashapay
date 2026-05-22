import 'package:asha_pay/asha_pay.dart';
import 'package:asha_pay/model/family_model.dart';
import 'package:asha_pay/screens/home/api/programsApi.dart';

class FamilyController extends GetxController {
  static const String familySearchID = "familySearchID";
  bool isLoading = false;
  bool hasSearched = false;
  String currentFamilyId = "";
  /// 🔥 MAIN DATA
  List<FamilyData> familyList = [];
  final TextEditingController searchCtrl = TextEditingController();
  String? familyIdError;
  /// STATUS MAP
  Map<int, String> memberStatus = {};

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

  bool get hasNewMembers {

    if (familyList.isEmpty) return false;

    final members =
        familyList.first.members ?? [];

    return members.any((m) {

      return m.memberId == null ||
          m.memberId!.isEmpty;

    });
  }

  /// 🔍 SEARCH FAMILY
  Future<void> searchFamily(String familyID) async {
    currentFamilyId = familyID;
    /// VALIDATION
    if (familyID.isEmpty) {
      familyIdError = "Family ID डालें";
      update([familySearchID]);
      return;
    }

   // if (isLoading) return;

    isLoading = true;

    hasSearched = true;

    /// CLEAR OLD DATA
    familyList.clear();

    update([familySearchID]);

    try {

      final body = {
        "familyid": familyID,
      };

      /// API CALL
      List<FamilyData>? response = await ProgramsApi.getFamilyMembers(body);

      print("RESPONSE LENGTH: ${response!.length}");

      /// STORE FULL LIST
      if (response.isNotEmpty) {

        familyList.addAll(response);

        print("FAMILY LIST LENGTH: ${familyList.length}");

        /// PRINT ALL DATA
        for (var family in familyList) {

          print("Family ID: ${family.familyId}");

          if (family.members != null &&
              family.members!.isNotEmpty) {

            print("MEMBERS COUNT: ${family.members!.length}");

            for (var member in family.members!) {

              print("ID: ${member.id}");
              print("Member Name: ${member.memberName}");
              print("Member ID: ${member.memberId}");
              print("Age: ${member.age}");
              print("Gender: ${member.gender}");
              print("Aadhar: ${member.addharId}");
              print("----------------------");
            }
          }
        }

      } else {
        print("NO DATA FOUND");
      }

    } catch (e) {
      print("ERROR: $e");

    } finally {
      isLoading = false;
      update([familySearchID]);
    }
  }

  /* Future<void> searchFamily() async {

    final familyID = searchCtrl.text.trim();

    if (familyID.isEmpty) {

      familyIdError = "Family ID डालें";

      update([familySearchID]);

      return;
    }

    if (isLoading) return;

    isLoading = true;

    hasSearched = true;

    /// 🔥 CLEAR OLD
    familyList.clear();

    update([familySearchID]);

    try {

      final body = {"familyid": familyID};

      final response = await ProgramsApi.getFamilyMembers(body);

      print(
          "🔥 RESPONSE: ${response?.map((e) => e.toJson()).toList()}"
      );

      if (response != null && response.isNotEmpty) {

        /// 🔥 DIRECT ASSIGN
        familyList = List<FamilyData>.from(response);

        print(
          "🔥 FAMILY COUNT: ${familyList.length}",
        );

        print(
          "🔥 MEMBERS COUNT: ${familyList.first.members?.length}",
        );

      } else {

        familyList = [];
      }

    } catch (e) {

      print("❌ ERROR: $e");

      familyList = [];

      Get.snackbar(
        "Error",
        "Data load failed",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    isLoading = false;

    update([familySearchID]);
  }
*/
  /// ➕ ADD NEW MEMBER
  void addNewMember() {

    if (familyList.isEmpty) return;

    familyList.first.members ??= [];

    final members =
    familyList.first.members!;

    /// 🔥 VALIDATE LAST MEMBER
    if (members.isNotEmpty) {

      final last = members.last;

      final isExisting =
          last.memberId != null &&
              last.memberId!.isNotEmpty;

      if (!isExisting &&
          (last.memberName ?? "")
              .trim()
              .isEmpty) {

        Get.snackbar(
          "Error",
          "पहले नाम भरें",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );

        return;
      }
    }

    /// 🔥 NEW MEMBER
    members.add(

      FamilyMembers(
        memberName: "",
        //relation: "",
        gender: "",
        dob: "",
        abhaId: "",
        addharId: "",
      ),
    );

    update([familySearchID]);
  }

  /// ✅ VALIDATE ALL MEMBERS
  bool validateMembers() {

    if (familyList.isEmpty) {

      Get.snackbar(
        "Error",
        "कोई सदस्य नहीं मिला",
      );

      return false;
    }

    final members =
        familyList.first.members ?? [];

    for (var m in members) {

      final isExisting =
          m.memberId != null &&
              m.memberId!.isNotEmpty;

      /// 🔥 OLD MEMBER SKIP
      if (isExisting) continue;

      if ((m.memberName ?? "")
          .trim()
          .isEmpty) {

        Get.snackbar(

          "Error",

          "नाम भरना आवश्यक है",

          backgroundColor: Colors.red,

          colorText: Colors.white,
        );

        return false;
      }
    }

    return true;
  }

  Map<String, dynamic> buildPayload() {
    final members = familyList.first.members ?? [];

    /// ONLY NEW MEMBERS
    final newMembers = members.where((m) {

      return m.memberId == null ||
          m.memberId!.isEmpty;

    }).toList();

    return {
      "familyId": searchCtrl.text.trim(),
      "createdUser": 0,
      "members": newMembers.map((m) {
        final index = members.indexOf(m);
        return {
          "memberName": m.memberName ?? "",
          "memberId": "",
          "gender": m.gender ?? "",
          "dob": m.dob ?? "",
          "aabhaId": m.abhaId ?? "",
          "aadharId": m.addharId ?? "",
          "status": memberStatus[index] ?? "",
        };

      }).toList(),
    };
  }

  /// 💾 SAVE FAMILY
  Future<void> saveFamily() async {

    if (!validateMembers()) return;

    isLoading = true;

    update([familySearchID]);

    try {
      final payload = buildPayload();

      print(
        "🔥 SAVE PAYLOAD: $payload",
      );

      final success =
      await ProgramsApi.addFamilyMembers(payload);

      if (success) {

        Get.snackbar(
          "सफल",
          "परिवार सफलतापूर्वक जोड़ दिया गया",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        familyList.clear();
        update([familySearchID]);

        print("currentFamilyId: $currentFamilyId");

        await Future.delayed(const Duration(milliseconds: 300));
        await reloadFamily();

      } else {
        Get.snackbar("त्रुटि", "डेटा सेव नहीं हुआ",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

    } catch (e) {
      print("❌ SAVE ERROR: $e");
      Get.snackbar(
        "त्रुटि", e.toString(),
        backgroundColor: Colors.red,
        colorText:  Colors.white,
      );
    }

    isLoading = false;

    update([familySearchID]);
  }

  Future<void> reloadFamily() async {

    if (currentFamilyId == null || currentFamilyId!.isEmpty) {
      print("❌ No familyId for reload");
      return;
    }

    await searchFamily(currentFamilyId!);
  }
}