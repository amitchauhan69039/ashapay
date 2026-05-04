import 'package:asha_pay/asha_pay.dart';
import 'package:asha_pay/model/family_model.dart';
import 'package:asha_pay/screens/home/api/programsApi.dart';

class FamilyController extends GetxController {
  bool isLoading = false;
  List<FamilyData> familyList = [];
  final TextEditingController searchCtrl = TextEditingController();

  Future<void> searchFamily(String familyID) async {
    isLoading = true;
    update();
    try {
      // 🔥 API call
      familyList = await ProgramsApi.getFamilyMembers(familyID) ?? [];

    } catch (e) {
      print(e);
    }

    isLoading = false;
    update();
  }
}