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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [

                        const SizedBox(height: 100),

                        /// Logo
                        Image.asset(
                          AssetRes.asha_logo,
                          height: 120,
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          "ASHA Pay",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),

                        const SizedBox(height: 70),

                        /// Mobile Field
                        TextField(
                          controller: controller.phoneNumberController,
                          decoration: InputDecoration(
                            hintText: "Enter Mobile Number",
                            suffixIcon: const Icon(Icons.person),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.9),
                            contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(color: Colors.blue),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),


                        TextField(
                          controller: controller.passwordController,
                          obscureText: !isPasswordVisible,
                          decoration: InputDecoration(
                            hintText: "Password",
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.9),
                            contentPadding: const EdgeInsets.symmetric(vertical: 18,horizontal: 15),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),


                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                controller.loginApi();
                                },
                              child: Text(
                                "लॉग इन",
                                style: GoogleFonts.notoSansDevanagari(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),


                        const Spacer(),
                      ],
                    ),

                  ),


                  Positioned(
                    bottom: 45,
                    left: 20,
                    right: 20,
                    child: Image.asset(
                      AssetRes.ladies_harayana_map_area,
                      fit: BoxFit.contain,
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
