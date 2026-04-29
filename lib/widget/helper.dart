import 'package:get/get.dart';
import 'package:asha_pay/asha_pay.dart';

void successToast(String msg) {
  Get.snackbar(
    "Success !!!",
    msg,
    duration: 5.seconds,
    backgroundColor: ColorRes.green,
    colorText: ColorRes.white,
    mainButton: TextButton(
      onPressed: Get.back,
      child: const Icon(
        Icons.close,
        color: ColorRes.white,
      ),
    ),
  );
}

void catchToast(String msg) {
  Get.snackbar(
    "Error !!!",
    msg,
    duration: 10.seconds,
    backgroundColor: ColorRes.appRedColor,
    colorText: ColorRes.white,
    mainButton: TextButton(
      onPressed: Get.back,
      child: const Icon(
        Icons.close,
        color: ColorRes.white,
      ),
    ),
  );
}

void errorToast(String msg) {
  Get.snackbar(
    "Error !!!",
    msg,
    duration: 10.seconds,
    backgroundColor: ColorRes.appRedColor,
    colorText: ColorRes.white,
    mainButton: TextButton(
      onPressed: Get.back,
      child: const Icon(
        Icons.close,
        color: ColorRes.white,
      ),
    ),
  );
  print("debugMsg=>$msg");
}


String oldHeight = "";
String newHeight = "";
String convertHeightToFeetAndInches(int heightInCm) {
  double heightInFeet = heightInCm / 30.50;

  int feet = heightInFeet.toInt();
  double remainingInches =
      (double.parse(heightInFeet.toStringAsFixed(2)) - feet) * 12;

  int inches = remainingInches.round();
  newHeight = "($feet'$inches'')";
  if(newHeight == oldHeight){
    return "";
  }else{
    oldHeight = newHeight;
     return newHeight;
  }
}
String showConvertHeightToFeetAndInches(int heightInCm) {
  double heightInFeet = heightInCm / 30.50;

  int feet = heightInFeet.toInt();
  double remainingInches = (double.parse(heightInFeet.toStringAsFixed(2)) - feet) * 12;

  int inches = remainingInches.round();
  newHeight = "($feet'$inches'')";
  return newHeight;
}
