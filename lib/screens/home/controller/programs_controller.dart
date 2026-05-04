import 'package:asha_pay/asha_pay.dart';
import 'package:asha_pay/screens/home/api/programsApi.dart';

class ProgramsController extends GetxController {
  bool loader = false;
  String? caseStatus;
  List<ProgramsData>? programsList = [];

  ProgramsController();

  @override
  void onInit() {
    super.onInit();
    getPrograms();
  }

  Future<void> getPrograms() async {
    loader = true;
    update();

    programsList = await ProgramsApi.getPrograms();
    print(programsList);

    loader = false;
    update();
  }

}

