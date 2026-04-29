import 'package:asha_pay/screens/auth/verification_screen.dart';
import 'package:asha_pay/asha_pay.dart';

class AuthController extends GetxController {
  bool loader = false;
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

    print("aaaaaa ${loginValidation()}" );
    if(loginValidation()){
      print("aaaaaa");
      FocusManager.instance.primaryFocus?.unfocus();
      loader = true;
      update(['login']);

      String deviceId=await getDeviceId();

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

          } else {

            toastMsg( model.message ?? 'Something went wrong');
          }
        }
      } catch (e) {
        debugPrint("Unexpected response format: ${e.toString()}");
      }

      loader = false;
      update(['login']);
    }

  }

  checkOtpMatch(String enteredOTP) {
    Get.offAll(()=> HomeScreen());
  }
}
