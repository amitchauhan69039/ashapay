import 'package:intl/intl.dart';
import 'package:asha_pay/asha_pay.dart';

class HomeController extends GetxController {
  bool loader = false;
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
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
}
