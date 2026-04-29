
import 'package:get/get.dart';
import 'package:asha_pay/asha_pay.dart';

extension SizerExt on num {
  /// Calculates the height depending on the device's screen size
  ///
  /// Eg: 20.h -> will take 20% of the screen's height
  double get h => this * Get.height / 100;

  /// Calculates the width depending on the device's screen size
  ///
  /// Eg: 20.w -> will take 20% of the screen's width
  double get w => this * Get.width / 100;

  /// Calculates the sp (Scalable Pixel) depending on the device's screen size
  double get sp => this * (Get.width / 3) / 100;
}

Widget appSizedBox({double? width ,double? height,Widget? child}){
  return SizedBox(
    height: height,
    width: width,
    child: child,
  );
}




class AppPadding{
  static double horizontalPadding = 6.4.w;
  static double verticalPadding = 3.0.w;
  static double appHorizontalPadding = 4.w;

}

//----------Height-----------//
// size 19 = 2.3664.h;
// size 20 = 2.6155.h;
// size 21 = 2.6155.h;
// size 22 = 2.74.h;
// size 23 = 2.865.h;

//----------Width-----------//
// size 19 = 4.8346.w;
// size 20 = 5.089.w;
// size 21 = 5.3435.w;
// size 22 = 5.598.w;
// size 23 = 5.853.w;