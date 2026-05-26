import 'package:asha_pay/asha_pay.dart';
import 'package:asha_pay/model/family_model.dart';
import 'package:asha_pay/screens/home/api/programsApi.dart';

import '../../model/family_activity_model.dart';
import '../../model/get_mother_child_model.dart';
import '../../model/married_female_list_model.dart';

class ParivarKiSuchiController extends GetxController {
  bool loader = false;

  MarriedFemaleListModel? marriedFemaleListModel;


  @override
  void onInit() {
    super.onInit();

  }




  Future<void> getMarriedFemaleListWihfamilyId(String familyId) async {
    loader = true;
    Map<String, String> body = {
      "familyid": familyId,
    };
    update(['vaccination_list']);
    try {
      MarriedFemaleListModel? model = await ProgramsApi.getMarriedFemaleListWihfamilyId(body);

      if (model != null) {
        if (model.status!.toLowerCase() == "success") {
          marriedFemaleListModel=model;
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