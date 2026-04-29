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
commonBoxShadow(){
  return BoxShadow(
    offset: const Offset(0,4),
    color: ColorRes.black.withOpacity(0.25),
    blurRadius: 4,
    spreadRadius: 0,
  );
}
headerText(String headerTitle) {
  return Padding(
    padding: EdgeInsets.only(bottom: 1.h),
    child: Text(
      headerTitle,
      style: styleW600S18,
    ),
  );
}
commonSmallDivider({Color? dividerColor}){
  return Center(
      child: Container(
        height: 4.0,
        width: 25.w,
        decoration: BoxDecoration(
          color: dividerColor ?? Colors.black,
          borderRadius: BorderRadius.circular(5.0),
        ),
      )
  );
}
class RatingBar extends StatelessWidget {
  final double rating;
  final int maxRating;
  final IconData filledIcon;
  final IconData emptyIcon;
  final double iconSize;
  final Color filledColor;
  final Color emptyColor;

  RatingBar({
    required this.rating,
    this.maxRating = 5,
    this.filledIcon = Icons.star,
    this.emptyIcon = Icons.star,
    this.iconSize = 24.0,
    this.filledColor = Colors.yellow,
    this.emptyColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        maxRating,
            (index) {
          IconData icon = index < rating
              ? filledIcon
              : emptyIcon;

          Color color = index < rating
              ? filledColor
              : emptyColor;

          return Icon(
            icon,
            size: iconSize,
            color: color,
          );
        },
      ),
    );
  }
}

