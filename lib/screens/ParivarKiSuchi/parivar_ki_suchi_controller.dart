import 'package:asha_pay/asha_pay.dart';
import 'package:asha_pay/model/family_model.dart';
import 'package:asha_pay/screens/home/api/programsApi.dart';

import '../../model/family_activity_model.dart';
import '../../model/get_mother_child_model.dart';

class ParivarKiSuchiController extends GetxController {
  bool loader = false;
  GetMotherChildModel? motherChildModel;


  @override
  void onInit() {
    super.onInit();

  }


  Future<void> getMotherChildListWithId(String familyId) async {
    loader = true;
    Map<String, String> body = {
      "familyid": familyId,
    };
    update(['vaccination_list']);
    try {
      GetMotherChildModel? model = await ProgramsApi.getMotherChildListWithId(body);

      if (model != null) {
        if (model.status!.toLowerCase() == "success") {
          motherChildModel=model;
        } else {
          toastMsg( 'Something went wrong');
        }
      }
    } catch (e) {
      debugPrint("Unexpected response format: ${e.toString()}");
    }

    loader = false;
    update(['vaccination_list']);
  }


}