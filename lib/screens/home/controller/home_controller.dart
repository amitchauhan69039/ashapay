import 'package:intl/intl.dart';
import 'package:asha_pay/asha_pay.dart';

import '../api/programsApi.dart';

class HomeController extends GetxController {
  bool loader = false;
  List<ProgramsData>? programsList = [];
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getAshaIndependentProgramMaster();
    fromDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    toDateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());

  }

  selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    controller.text = DateFormat('dd/MM/yyyy').format(picked!);
  }



  Future<void> getAshaIndependentProgramMaster() async {
    loader = true;
    update(['home_screen']);

    programsList = await ProgramsApi.getAshaIndependentProgramMaster();
    print(programsList);

    loader = false;
    update(['home_screen']);
  }

}
