import 'dart:ui';
import 'package:asha_pay/asha_pay.dart';
import 'package:asha_pay/screens/home/entryProgram_screen.dart';
import 'package:asha_pay/screens/home/familySearchScreen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DateTime? lastBackPressTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();

        if (lastBackPressTime == null ||
            now.difference(lastBackPressTime!) > const Duration(seconds: 2)) {
          lastBackPressTime = now;

          Get.snackbar(
            "Exit",
            "बाहर निकलने के लिए फिर से back दबाएं",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black,
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );

          return false; // ❌ exit mat karo
        }

        return true; // ✅ exit app
      },

      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetRes.login_bg),
                fit: BoxFit.cover,
              ),
            ),

            child: Stack(
              children: [

                /// 🔹 MAIN CONTENT
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// 🔹 HEADER
                    Container(
                      padding: const EdgeInsets.only(
                          top: 30, left: 16, right: 16, bottom: 10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          /// 🔹 TEXT
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("नमस्ते, Nirmala!",
                                    style: styleW600S16),
                                appSizedBox(height: 5),
                                Text(
                                  "हमारे पोर्टल ASHAPAY पर आपका स्वागत है!",
                                  style: styleW400S12.copyWith(
                                      color: Colors.grey),
                                ),
                                appSizedBox(height: 10),

                                /// 🔹 DATE
                                Row(
                                  children: [
                                    Image.asset(
                                      AssetRes.calendarIcon,
                                      height: 14,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      "27 अप्रैल 2026, 3:40",
                                      style: styleW600S12.copyWith(
                                          color: Colors.grey),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),

                          /// 🔹 AVATAR + LOGOUT
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                AssetImage(AssetRes.avtarIcon),
                              ),
                              appSizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  showLogoutDialog(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorRes.appRedColor,
                                  shape: const StadiumBorder(),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2),
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  "Logout",
                                  style: styleW400S12.copyWith(
                                      color: ColorRes.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    appSizedBox(height: 20),

                    /// 🔹 TITLE
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text("आशा कार्य"),
                    ),

                    appSizedBox(height: 10),

                    /// 🔹 CARDS
                    dashboardCard(
                      title: "एंट्री दर्ज करें",
                      iconPath: AssetRes.enterIcon,
                      onTap: () {
                        Get.to(() => AshaProgramScreen());
                      },
                    ),

                    dashboardCard(
                      iconPath: AssetRes.userlistIcon,
                      title: "परिवार को सूचीबद्ध करें",
                      onTap: () {
                        Get.to(() => FamilySearchScreen());
                      },
                    ),

                    const Spacer(),
                  ],
                ),

                /// 🔹 BOTTOM IMAGE
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
          ),
        ),
      ),
    );
  }

  /// 🔹 CARD WIDGET
  Widget dashboardCard({
    required String iconPath,
    required String title,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: ColorRes.appBlueColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(
                    iconPath,
                    height: 22,
                    width: 22,
                  ),
                ),
                appSizedBox(width: 15),
                Expanded(
                  child: Text(title, style: styleW400S16),
                ),
                Image.asset(
                  AssetRes.dotsIcon,
                  height: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.transparent,
    builder: (context) {
      return Stack(
        children: [

          // 🔹 Blur + Dark Overlay
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(
              color: Colors.black.withOpacity(0.1),
            ),
          ),

          // 🔹 Your Dialog (same as before)
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Material(
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "Logout",
                      style: styleW600S16
                    ),

                    appSizedBox(height: 8),

                    Text(
                      "Are you sure you want to logout?",
                      style: styleW400S14.copyWith(color: Colors.grey)
                    ),

                    appSizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              await PrefService.clear();

                              Get.offAll(() => LoginScreen());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade300,
                              shape: StadiumBorder(),
                              elevation: 0,
                            ),
                            child: Text(
                              "OK",
                              style: styleW500S14.copyWith(color: Colors.black),
                            ),
                          ),
                        ),

                        appSizedBox(width: 10),

                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade300,
                              shape: StadiumBorder(),
                              elevation: 0,
                            ),
                            child: Text(
                              "Cancel",
                              style: styleW500S14.copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}