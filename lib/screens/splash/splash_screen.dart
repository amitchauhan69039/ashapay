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
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetRes.login_bg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Centered logo
          Center(
            child: Image.asset(
              AssetRes.asha_logo,
              height: 16.h,
            ),
          ),
        ],
      ),
    );
  }
}

