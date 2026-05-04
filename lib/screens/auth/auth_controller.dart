import 'package:asha_pay/asha_pay.dart';

class AuthController extends GetxController {
  bool isLoading = false;
  bool verifyLoader = false;
  String phoneNumberErrorText = "";
  String passwordErrorText = "";
  bool rememberPassword = false;
  String enteredOTP ="";
  String verifyOtpError= "";
  int otpTimer = 120;
  Timer? timer;
  bool showTimer = true;
  bool timerStarted = false;
  String otpReceived = "";
  String resentOtp = "";
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController pinEditingController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    passwordController.text = "nirmaladevi";
    phoneNumberController.text = "7027818670";
  }
  
  onResendOtp() async {
    pinEditingController.clear();
    verifyOtpError = "";
    verifyLoader = true;
    update(['verify']);


    // Wait for the resendOtp function to complete
   // await resendOtp();

    verifyLoader = false;
    update(['verify']);
  }

  timerTap() {
    otpTimer = 120;
    showTimer = true;
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      otpTimer--;
      if (otpTimer == 0) {
        showTimer = false;
        timer!.cancel();
      }
      update(['verify']);
    });
  }

  loginValidation(){

    bool isValidate=false;

    if(phoneNumberController.text.isEmpty){
      phoneNumberErrorText = "Please enter mobile number".tr;
      toastMsg(phoneNumberErrorText);
    }else if (phoneNumberController.text.length != 10) {
      phoneNumberErrorText = "Invalid mobile number".tr;
      toastMsg(phoneNumberErrorText);
    }else if(passwordController.text.isEmpty){
      passwordErrorText = "Please enter password".tr;
      toastMsg(passwordErrorText);
    } else{
      isValidate=true;
    }

    update(['login']);
    return isValidate;
  }


  Future<void> loginApi() async {
    if(loginValidation()){
      FocusManager.instance.primaryFocus?.unfocus();
      isLoading = true;
      update(['login']);

      String deviceId = await getDeviceId();

      Map<String,String> loginBody = {
        "username": phoneNumberController.text.toString().trim(),
        "password": passwordController.text.toString().trim(),
        "deviceID": deviceId,
        "fcmToken": "",
      };
      try {
        LoginModel? model = await AuthApi.userLogin(loginBody);

        if (model != null) {
          if (model.status == "success") {
            final data = model.data;

            if (data != null) {
              await PrefService.set(PrefKeys.isLogin, true);

              await PrefService.set(PrefKeys.accessToken, data.token ?? "");
              await PrefService.set(PrefKeys.userId, data.id ?? 0);
              await PrefService.set(PrefKeys.userName, data.username ?? "");
              await PrefService.set(PrefKeys.roleId, data.roleid ?? 0);
              await PrefService.set(PrefKeys.name, data.name ?? "");
              await PrefService.set(PrefKeys.mobileNo, data.mobileNo ?? "");
              await PrefService.set(PrefKeys.gender, data.gender ?? "");

              Get.offAll(DashboardScreen());
            }
          } else {
            toastMsg( model.message ?? 'Something went wrong');
          }
        }
      } catch (e) {
        debugPrint("Unexpected response format: ${e.toString()}");
      }

      isLoading = false;
      update(['login']);
    }

  }

}
