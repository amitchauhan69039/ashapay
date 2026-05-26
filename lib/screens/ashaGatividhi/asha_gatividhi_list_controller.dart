import 'package:asha_pay/asha_pay.dart';
import 'package:asha_pay/model/family_model.dart' hide Members;
import 'package:asha_pay/screens/home/api/programsApi.dart';

import '../../model/activity_data_model.dart';
import '../../model/family_activity_model.dart';
import '../../model/get_family_activity_model.dart';
import '../../model/get_mother_child_model.dart';

class AshaGatividhiListController extends GetxController {
  bool loader = false;

  ActivityDataModel? activityDataModel;
  GetMotherChildModel? motherChildModel;


  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getAshaActivityMaster(String programmeId) async {
    loader = true;
    update(['asha_gatividhi_list']);
    Map<String,String> body = {
      "programid": programmeId,
      };

    activityDataModel = await ProgramsApi.getAshaActivityMaster(body);
    print(activityDataModel);

    loader = false;
    update(['asha_gatividhi_list']);
  }

  Future<void> getMotherChildListWithId(String familyId) async {
    loader = true;
    Map<String, String> body = {
      "familyid": familyId,
    };
    update(['asha_gatividhi_list']);
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
    update(['asha_gatividhi_list']);
  }

}