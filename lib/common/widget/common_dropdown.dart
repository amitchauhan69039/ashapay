import 'package:asha_pay/asha_pay.dart';

commonDropDown({String? suffixIcon,String? bottomSheetTitle,
  List<String>? dropDownList,
  String? selectedValue,
  String? withoutSelectedValue,
  Function? onChanged,
}){
  return inkWell(
    onTap: (){
      Get.bottomSheet(
        Wrap(
          children: [
            Container(
              width: Get.width,
              padding: EdgeInsets.all(AppPadding.appHorizontalPadding),
              color: ColorRes.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(bottomSheetTitle ?? "",style: styleW400S15.copyWith(color: ColorRes.appBlueColor)),
                      inkWell(
                          onTap: Get.back,
                          child: const Icon(Icons.close,color: ColorRes.black,size: 25,))
                    ],
                  ),
                  appSizedBox(height: 2.h),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: dropDownList?.length ?? 0,
                    itemBuilder: (context, index) {
                         return inkWell(
                           onTap: (){
                               Get.back();
                             if(onChanged != null){
                               onChanged(dropDownList?[index],index);
                             }
                           },
                           child: Column(
                             children: [

                               Padding(
                                 padding: const EdgeInsets.symmetric(vertical: 10),
                                 child: Text(
                                     dropDownList?[index] ?? "",
                                   style: styleW400S14.copyWith(color: selectedValue == dropDownList?[index] ? ColorRes.appBlueColor : ColorRes.black),
                                 ),
                               ),
                               Container(
                                 height: 1,
                                 color: ColorRes.black,
                               )
                             ],
                           ),
                         );
                    },)
                ],
              ),
            ),
          ],
        )
      );
    },
    child: Container(
      width: Get.width,
      padding: const EdgeInsets.only(left: 15, right: 15,top: 14,bottom: 14),
      decoration: BoxDecoration(
        border: Border.all(color: ColorRes.black),
        color: ColorRes.white,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Row(
        children: [
          if(suffixIcon != null)
          Image.asset(
            suffixIcon ?? AssetRes.categoriesIcon,
            height: 18,
            width: 20,
            color: ColorRes.black,
          ),
          appSizedBox(width: 2.w),
          Expanded(child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(selectedValue ?? (withoutSelectedValue ?? ""),style: styleW400S14.copyWith(color: selectedValue != null ? ColorRes.black : ColorRes.black)),
              Image.asset(AssetRes.downArrowIcon)
            ],

          ))
        ],
      ),
    ),
  );
}

