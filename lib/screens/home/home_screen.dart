import 'package:asha_pay/asha_pay.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          CommonMenuAppbar(
            title: "Test User",
            rightWidget: CustomPopupMenu(
              onSelected: (item) {
                switch (item) {
                  case 0:
                    signOut(context);
                    break;
                }
              },
            ),
          ),
          // GridView with 2 columns
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.horizontalPadding),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: gridItems.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                     // Get.to(() => ApplicationsScreen(title: gridItems[index].title));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: gridItems[index].color,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: EdgeInsets.all(2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  flex: 8,
                                  child:  Text(
                                    '${gridItems[index].title} : ',
                                    style: styleW400S14.copyWith(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  )
                              ),
                              Expanded(  flex: 2,
                                  child: Text(
                                    '${gridItems[index].titleValue}',
                                    style: styleW400S14.copyWith(color: Colors.white),
                                  )),
                            ],
                          ),
                          Text(
                            '${"trial".tr} : ${gridItems[index].trial}',
                            textAlign: TextAlign.center,
                            style: styleW400S14.copyWith(color: Colors.white),
                          ),
                          Text(
                            '${"without_trial".tr} : ${gridItems[index].withoutTrial}',
                            textAlign: TextAlign.center,
                            style: styleW400S14.copyWith(color: Colors.white),
                          )
                        ],
                      ),
                    )
                  );
                }
            )
          ),
        ],
      ),
    );
  }

}

class GridItem {
  final Color color;
  final String title;
  final String titleValue;
  final String trial;
  final String withoutTrial;

  GridItem({required this.color, required this.title,  required this.titleValue, required this.trial, required this.withoutTrial});
}

// Inside your widget class
List<GridItem> gridItems = [
  GridItem(color: Colors.blue, title: "total_application".tr, titleValue: '1', trial: '7', withoutTrial: '9'),
  GridItem(color: Colors.green, title: "new_application".tr, titleValue: '1', trial: '7', withoutTrial: '9'),
  GridItem(color: Colors.pink, title: "pending_application".tr, titleValue: '1', trial: '7', withoutTrial: '9'),
  GridItem(color: Colors.blueGrey, title: "disposed_off_application".tr, titleValue: '1', trial: '7', withoutTrial: '9'),
  GridItem(color: Colors.deepOrange, title: "rejected_application".tr, titleValue: '1', trial: '7', withoutTrial: '9'),
  GridItem(color: Colors.brown, title: "sine_die_application".tr, titleValue: '1', trial: '7', withoutTrial: '9'),

];

class CustomPopupMenu extends StatelessWidget {
  final Function(int) onSelected;

  const CustomPopupMenu({Key? key, required this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: Icon(Icons.more_vert, color: Colors.white, size: 24),
      itemBuilder: (context) => [
        PopupMenuItem<int>(value: 0, child: Row(
          children: [
            Text("logout".tr, style: styleW400S15),
          ],
        )),
      ],
      onSelected: (item) => onSelected(item),
    );
  }
}

signOut(context){
  return  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
          insetPadding: const EdgeInsets.all(15),
          child: Wrap(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: ColorRes.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: ColorRes.greyColor,
                      spreadRadius: 0,
                      blurRadius: 4.7,
                    ),

                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('are_you_sure_you_want_to_sign_out'.tr, style: styleW500S15),
                    appSizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor:
                          Colors.transparent,
                          onTap: Get.back,
                          child:  Container(
                            alignment: Alignment.center,
                            width: 70,
                            height: 35,
                            // padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: ColorRes.appRedColor,
                            ),
                            child: Text('cancel'.tr,
                                style: styleW500S15.copyWith(color: ColorRes.white))
                          ),
                        ),
                        appSizedBox(width: 2.5.w),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            Get.back();
                            await PrefService.set(PrefKeys.userId, "");
                            Get.offAll(() => const LoginScreen());
                          },
                          child: AppButton(buttonName: 'yes'.tr,
                            buttonHeight: 35,
                            buttonWidth: 70,
                            borderRadius: 5,
                            textColor: ColorRes.white,
                            backgroundColor: ColorRes.appBlueColor
                          ),

                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ));
    },
  );
}
