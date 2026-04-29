import 'package:asha_pay/asha_pay.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashController controller = Get.put(SplashController());

  @override
  void initState() {
    controller.navigatePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: ColorRes.appBlueColor
            ),
          ),
          // Centered logo
          // Center(
          //   child: Image.asset(
          //     AssetRes.splashLogo,
          //     height: 16.h,
          //   ),
          // ),
        ],
      ),
    );
  }
}
