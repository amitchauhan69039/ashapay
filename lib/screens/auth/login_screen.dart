import 'package:asha_pay/asha_pay.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController controller = Get.put(AuthController());
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GetBuilder<AuthController>(
          id: 'login',
          builder: (controller) {
            return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetRes.login_bg),
                    fit: BoxFit.cover,
                  ),
                ),
              child: Stack(
                children: [

                  Padding(
                    padding: const EdgeInsets.only(top: 80, left: 15, right: 15),
                    child: Column(
                      children: [
                        /// Logo
                        Image.asset(
                          AssetRes.asha_logo,
                          height: 100,
                        ),

                        appSizedBox(height: 1.h),

                        Text(
                          "ASHA Pay",
                          style: styleW700S20.copyWith(color: ColorRes.appBlueColor)
                        ),

                        appSizedBox(height: 5.h),

                        /// Mobile Field
                        CommonTextField(
                          controller: controller.phoneNumberController,
                          hintText: "Username",
                          textInputType: TextInputType.phone,
                          isNumberOnly: true,
                          suffixIcon: const Icon(Icons.person_outline, size: 20),
                        ),

                        appSizedBox(height: 2.h),

                        CommonTextField(
                          controller: controller.passwordController,
                          hintText: "Password",
                          secureText: !isPasswordVisible,
                          isPassword: true,
                          suffixIcon: Icon(
                            isPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            size: 20,
                          ),
                          onSuffixTap: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),

                        appSizedBox(height: 3.h),

                        AppButton(
                          buttonName: controller.isLoading ? "Loading..." : "लॉग इन",
                          isEnabled: !controller.isLoading,
                          onTap: () async {
                            if (controller.isLoading) return;

                            controller.isLoading = true;
                            controller.update();

                            await controller.loginApi();

                            controller.isLoading = false;
                            controller.update();
                          },
                        ),

                      ],
                    ),

                  ),

                  Positioned(
                    bottom: 0,
                    left: 15,
                    right: 15,
                    child: IgnorePointer(
                      child: Image.asset(
                        AssetRes.ladies_harayana_map_area,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

}
