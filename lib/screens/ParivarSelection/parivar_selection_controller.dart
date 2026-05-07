import 'package:asha_pay/asha_pay.dart';
import 'package:asha_pay/model/family_model.dart';
import 'package:asha_pay/screens/home/api/programsApi.dart';

class ParivarSelectionController extends GetxController {
  bool loader = false;

  List<FamilyData> familyList = [];
  final TextEditingController searchCtrl = TextEditingController();

  @override
  void onInit() {
    super.onInit();

  }


  Future<void> getFamily() async {
    loader = true;
    update(['parivar_selection']);
    try {
      // 🔥 API call
      familyList = await ProgramsApi.getAllFamilyMembers() ?? [];


    } catch (e) {
      print(e);
    }

    loader = false;
    update(['parivar_selection']);
  }
}