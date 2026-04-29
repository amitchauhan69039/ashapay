import 'package:asha_pay/asha_pay.dart';
import 'package:sms_autofill/sms_autofill.dart';

class VerificationScreen extends StatefulWidget {
  final String enc_key;
  final String phoneNumber;

  const VerificationScreen({Key? key, required this.enc_key, required this.phoneNumber}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final AuthController controller = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    _listenForSms();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();

    super.dispose();
  }

  void _listenForSms() async {
    controller.enteredOTP = "";
    await SmsAutoFill().unregisterListener();
    SmsAutoFill().listenForCode;
  }

  @override
  Widget build(BuildContext context) {
   /* controller.otpReceived = widget.otp;
    // toastMsg("otp${widget.otp}");
 controller.phoneNumberController.text = widget.phoneNumber;

*/

   /* if (!controller.timerStarted) {
      controller.timerTap();
      controller.timerStarted = true;
    }*/
    return Scaffold(
      backgroundColor: ColorRes.appBlueColor,
      body: GetBuilder<AuthController>(
        id: 'verify',
        builder: (controller) {
          return StackedLoader(
            loading: controller.verifyLoader,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
                // Other Elements Centered at the Bottom with Padding
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.horizontalPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo or Additional Image
                      Image.asset(
                        AssetRes.splashLogo,
                        width: 90.0,
                      ),
                      appSizedBox(height: 20),

                      /*Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppPadding.horizontalPadding),
                      child: TextField(
                        controller: _otpController,
                        decoration: InputDecoration(
                          labelText: 'Enter OTP',
                          border: OutlineInputBorder(),
                        ),
                      )),*/

                      Center(
                        child: Text(
                          'enter_verification_code'.tr,
                          textAlign: TextAlign.center,
                          style: styleW400S21.copyWith(color: ColorRes.white),
                        ),
                      ),
                      appSizedBox(height: 10),
                      Center(
                        child: Text(
                          '${'we_have_sent_code'.tr} ${widget.phoneNumber}',
                          textAlign: TextAlign.center,
                          style: styleW400S14.copyWith(color: ColorRes.white),
                        ),
                      ),
                      appSizedBox(height: 30),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppPadding.horizontalPadding),
                          child: GetBuilder<AuthController>(
                              id: "auto_fill_otp",
                              builder: (controller) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    appSizedBox(
                                      height: 58,
                                      width: Get.width * 0.7,
                                      child: PinFieldAutoFill(
                                        codeLength: 4,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                        ],
                                        currentCode: controller.enteredOTP,
                                        decoration: BoxLooseDecoration(
                                          textStyle: styleW500S18.copyWith(fontSize: 22,color: ColorRes.white),
                                          radius: const Radius.circular(10),
                                          strokeColorBuilder: const FixedColorBuilder(ColorRes.white),
                                        ),
                                        // defaultPinTheme: PinTheme(
                                        //     textStyle: styleW600S14.copyWith(
                                        //         color: ColorRes.appBlackColor),
                                        //     height: 6.7733.h,
                                        //     width: 18.6666.w,
                                        //     // margin: const EdgeInsets.only(right: 3),
                                        /*decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: ColorRes.white,
                                                  border: Border.all(
                                                      color: ColorRes.borderColor,
                                                      width: 2))),*/
                                        // validator: (s) {
                                        //   controller.enteredOTP = s.toString();
                                        //   // return controller.verifyOtpError.toString();
                                        // },
                                        // pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                                        // showCursor: true,
                                        // onCompleted: (pin) => print(pin),
                                        //  onCodeChanged: controller.checkOtpMatch,
                                        onCodeSubmitted: (val) {
                                          controller.enteredOTP = val;
                                          print("onCodeSubmitted $val");
                                        },
                                      ),
                                    ),
                                    ErrorText(errorText: controller.verifyOtpError),
                                  ],
                                );
                              })),
                      appSizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          inkWell(
                              onTap: controller.showTimer
                                  ? null
                                  : controller.onResendOtp,
                              child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: 'resend_otp'.tr,
                                      style: styleW400S14.copyWith(
                                          color: ColorRes.white)),
                                  TextSpan(
                                    text: controller.showTimer
                                        ? " ${controller.otpTimer.toString()} sec"
                                        : "",
                                    style: styleW400S14.copyWith(color: ColorRes.white),
                                  )
                                ]),
                              ))
                        ],
                      ),
                      appSizedBox(height: 30),
                      // Button
                      AppButton(
                        onButtonTap: ()=> controller.checkOtpMatch(controller.enteredOTP),
                        buttonName: ('submit'.tr ?? '').toUpperCase(),
                      ),
                    ],
                  ),
                )
                // Visibility(
                //   visible: controller.verify_loader,
                //   child: Positioned(
                //     bottom: 80,
                //     left: 0,
                //     right: 0,
                //     child: SmallLoader(),
                //   ),
                // )
              ],
            ),
          );
        },
      ),
    );
  }
}