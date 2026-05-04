import 'package:asha_pay/asha_pay.dart';

bool _openAppDialog = false;

class AppUpGrader extends StatefulWidget {
  final Widget child;

  const AppUpGrader({Key? key, required this.child}) : super(key: key);

  @override
  State<AppUpGrader> createState() => _AppUpGraderState();
}

class _AppUpGraderState extends State<AppUpGrader> {
  String version = "";
  String buildNumber = "";
  String minVersion = "";
  String minBuildNumber = "";
  PackageInfo? packageInfo;
  List<Map<String, dynamic>> currentApiList = [];
  List<Map<String, dynamic>> minApiList = [];
  Map<String, dynamic> minData = {};

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getVersion();
    });

    super.initState();
  }

  Future<void> getVersion() async {
    if (_openAppDialog) {
      return;
    }
    _openAppDialog = true;
    try {
      init();
    } catch (e) {
      // showSnackBar(context, e.toString());
    }
  }
  init() async{
    await getData();
  }

  Future<void> getData() async {
    // CollectionReference collectionRef = FirebaseFirestore.instance.collection('appVersioning');
    // DocumentSnapshot querySnapshot = await collectionRef.doc(Platform.isAndroid ? "android" : "ios").get();
    // Map<String, dynamic> allData = querySnapshot.data() as Map<String, dynamic>;
    // Map<String, dynamic> currentData = allData['current'];
   // minData = allData['min'];
    // print("currentData=>${currentData}");
    // print("minData=>${minData}");
    // if(allData.isNotEmpty){
    // getVersionMap(currentData);
    // getMinVersionMap(minData);
    //   await checkAppVersion();
    // }else{
    //   getData();
    // }
    // print("minData=>${minData}");
  }

  void getVersionMap(dynamic data) {
    version = data["version"].toString();
    buildNumber = data["build"].toString();


  }
  void getMinVersionMap(dynamic data) {
    minVersion = data["version"].toString();
    minBuildNumber = data["build"].toString();

  }

  Future<void> checkAppVersion() async {
    packageInfo = await PackageInfo.fromPlatform();
    if (!isShowDialog()) {
      // openDialog();
    }
  }
bool isForceUpdate(dynamic data){
  String apiVersion = minVersion.toString();
  String apiBuild = minBuildNumber.toString();
  String appVersion = packageInfo?.version.toString() ?? '';
  String appBuild = packageInfo?.buildNumber.toString() ?? '';

  if (appVersion.isEmpty ||
      apiBuild.isEmpty ||
      appVersion.isEmpty ||
      appBuild.isEmpty) {
    return false;
  }

  List<int> apiVersionList =
  apiVersion.split(".").map<int>((e) => int.parse(e.toString())).toList();
  List<int> appVersionList =
  appVersion.split(".").map<int>((e) => int.parse(e.toString())).toList();

  for (int i = 0; i < apiVersionList.length; i++) {
    if (appVersionList[i] > apiVersionList[i]) {
      return false;
    }
    if (appVersionList[i] < apiVersionList[i]) {
      return true;
    }
  }
  int apiBuildNumber = int.parse(apiBuild);
  int appBuildNumber = int.parse(appBuild);

  if (appBuildNumber < apiBuildNumber) {
    return true;
  } else {
    return false;
  }
}

  // void openDialog() {
  //
  //   showDialog(
  //     // barrierDismissible: kDebugMode,
  //     barrierDismissible: !isForceUpdate(minData),
  //     context: context,
  //     builder: (con) => Dialog(
  //       backgroundColor: Colors.black.withOpacity(0.4),
  //       insetPadding: const EdgeInsets.symmetric(horizontal: 6.4),
  //       child: const AppUpgradeDialog(),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  bool isShowDialog() {
    String apiVersion = version.toString();
    String apiBuild = buildNumber.toString();
    String appVersion = packageInfo?.version.toString() ?? '';
    String appBuild = packageInfo?.buildNumber.toString() ?? '';

    if (appVersion.isEmpty || apiBuild.isEmpty || appVersion.isEmpty || appBuild.isEmpty) {
      return false;
    }

    List<int> apiVersionList = apiVersion.split(".").map<int>((e) => int.parse(e.toString())).toList();
    List<int> appVersionList = appVersion.split(".").map<int>((e) => int.parse(e.toString())).toList();


    for (int i = 0; i < apiVersionList.length; i++) {
      if (appVersionList[i] > apiVersionList[i]) {
        return false;
      }
      if (appVersionList[i] < apiVersionList[i]) {
        return true;
      }
    }
    int apiBuildNumber = int.parse(apiBuild);
    int appBuildNumber = int.parse(appBuild);

    if (appBuildNumber < apiBuildNumber) {
      return true;
    } else {
      return false;
    }
  }
}

class AppUpgradeDialog extends StatelessWidget {
  const AppUpgradeDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.33),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorRes.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Image.asset(
            AssetRes.forceUpdateImage,
            height: 112.5,
          ),
          const SizedBox(height: 10),
          Text(
            "New version available",
            textAlign: TextAlign.center,
            style: styleW600S16.copyWith(color: ColorRes.black),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              "Looks like you have an older\n"
              "version of the app.\n"
              " Please update to get latest\n"
              " features and best experience.",
              textAlign: TextAlign.center,
              style: styleW400S14.copyWith(color: ColorRes.black),
            ),
          ),
          const SizedBox(height: 20),
          AppButton(
            // borderRadius: 5,
            buttonName: "Update Now",
           /* onButtonTap: () {
              // String url = Platform.isAndroid
              //     ? "https://play.google.com/store/apps/details?id=com.coreyo.user"
              //     : "https://apps.apple.com/app/id6476030826";
              // launchUrl(Uri.parse(url));
            },*/
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
