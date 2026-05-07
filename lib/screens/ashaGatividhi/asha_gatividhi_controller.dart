import 'package:asha_pay/asha_pay.dart';
import 'package:asha_pay/model/family_model.dart';
import 'package:asha_pay/screens/home/api/programsApi.dart';

import '../../model/family_activity_model.dart';

class AshaGatividhiController extends GetxController {
  bool loader = false;
  FamilyActivityModel? familyActivityModel;
  final TextEditingController searchCtrl = TextEditingController();
  FamilyData? familyData;

  @override
  void onInit() {
    super.onInit();

  }


  Future<void> getActivitybyFamilyId(String familyId) async {

    loader = true;
    Map<String,String> body = {
      "familyid": familyId,
      "Programid": "1",
    };
    update(['asha_gatividhi']);
    try {
      FamilyActivityModel? model = await ProgramsApi.getActivitybyFamilyId(body);

      if (model != null) {
        if (model.status!.toLowerCase() == "success") {

        } else {
          toastMsg( model.message ?? 'Something went wrong');
        }
      }
    } catch (e) {
      debugPrint("Unexpected response format: ${e.toString()}");
    }

    loader = false;
    update(['asha_gatividhi']);
  }

}