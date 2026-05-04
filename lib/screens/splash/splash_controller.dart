import 'package:asha_pay/asha_pay.dart';

class SplashController extends GetxController {

  Future<void> navigatePage() async {
      Future.delayed(const Duration(seconds: 1), () async {
        Get.offAll(()=> const LoginScreen());
        if (PrefService.getString(PrefKeys.accessToken).isNotEmpty) {
          Get.offAll(()=> DashboardScreen());
        }else{
          Get.offAll(()=> const LoginScreen());
        }
      });
  }
}
