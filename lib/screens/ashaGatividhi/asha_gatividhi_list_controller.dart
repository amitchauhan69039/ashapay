import 'package:asha_pay/asha_pay.dart';
import 'package:asha_pay/model/family_model.dart' hide Members;
import 'package:asha_pay/screens/home/api/programsApi.dart';

import '../../model/activity_data_model.dart';
import '../../model/family_activity_model.dart';
import '../../model/get_family_activity_model.dart';

class AshaGatividhiListController extends GetxController {
  bool loader = false;

  ActivityDataModel? activityDataModel;


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

}