

import 'package:country_picker/country_picker.dart';
import 'package:asha_pay/common/user.dart';
import 'package:asha_pay/asha_pay.dart';

void toastMsg(String msg, {gravity = ToastGravity.CENTER}) {
  Fluttertoast.showToast(msg: msg, gravity: gravity, timeInSecForIosWeb: 4);
}

class CommonTextFiled extends StatelessWidget {
  final String? heading;
  final TextEditingController? controller;
  final String? hintText;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixTap;
  final VoidCallback? onTap;
  bool secureText;
  bool isNumberOnly;
  TextInputType? textInputType;
  bool isMobileNumber;
  String errorText;
  final int maxLines;
  final bool isEnabled;
  final bool isReadOnly;
  final Function(String)? onChanged;

  CommonTextFiled({
    Key? key,
    this.isEnabled = true,
    this.isReadOnly = false,
    this.secureText = false,
    this.maxLines = 1,
    this.textInputType,
    this.isMobileNumber = false,
    this.heading,
    this.isNumberOnly = false,
    this.controller,
    this.hintText,
    this.suffixIcon,
    this.errorText = "",
    this.onSuffixTap,
    this.onTap,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (heading != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              heading ?? "",
              style: styleW500S14,
            ),
          ),
        inkWell(
          onTap: onTap,
          child: SizedBox(
            height: maxLines > 1 ? 40 * maxLines.toDouble() : 50,
            child: TextFormField(
              keyboardType: textInputType,
              inputFormatters: [
                if (isNumberOnly) FilteringTextInputFormatter.digitsOnly,
                if (isMobileNumber) LengthLimitingTextInputFormatter(10),
              ],
              obscureText: secureText,
              obscuringCharacter: '*',
              controller: controller,
              onChanged: onChanged,
              enabled: isEnabled,
              readOnly: isReadOnly,
              style: styleW400S14,
              cursorColor: ColorRes.white,
              // minLines: 1,
              maxLines: maxLines,
              decoration: InputDecoration(
                border: outlineInputBorder(errorText.isNotEmpty
                    ? ColorRes.appBlackColor
                    : ColorRes.greyColor),
                enabledBorder: outlineInputBorder(errorText.isNotEmpty
                    ? ColorRes.appBlackColor
                    : ColorRes.greyColor),
                disabledBorder: outlineInputBorder(errorText.isNotEmpty
                    ? ColorRes.appBlackColor
                    : ColorRes.greyColor),
                focusedBorder: outlineInputBorder(errorText.isNotEmpty
                    ? ColorRes.appBlackColor
                    : ColorRes.greyColor),
                hintText: hintText,
                hintStyle: styleW400S14.copyWith(color: ColorRes.greyColor),
                fillColor: ColorRes.white,
                suffixIcon: inkWell(
                  onTap: onSuffixTap,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 13.0),
                    child: suffixIcon,
                  ),
                ),
                suffixIconConstraints: const BoxConstraints(
                  maxWidth: 35,
                ),
                filled: true,
              ),
            ),
          ),
        ),
        ErrorText(errorText: errorText),
      ],
    );
  }
}


OutlineInputBorder outlineInputBorder(Color borderColor) => OutlineInputBorder(
  borderRadius: const BorderRadius.all(Radius.circular(10)),
  // borderSide: BorderSide(color: Color(0XFF898989)),
  borderSide: BorderSide(color: borderColor),
);

class CommonListTileWithScroll extends StatelessWidget {
  final String? iconName;
  final String? textName;
  final VoidCallback? onListTileTap;
  final bool? isAdded;
  final List<String>? title;

  const CommonListTileWithScroll({
    super.key,
    this.iconName,
    this.textName,
    this.onListTileTap,
    this.isAdded,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        appSizedBox(height: 13),
        inkWell(
          onTap: onListTileTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset(
                      iconName ?? "",
                      height: 22,
                      width: 22,
                      color: ColorRes.appBlackColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      textName ?? "",
                      style: styleW500S14,
                    ),
                  ],
                ),
              ),
              (title?.isNotEmpty ?? false) ?
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: (title?.length ?? 0) > 2 ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                              title?.length ?? 0, (index) {
                            return Text(
                              "${title?[index]},",
                              style: styleW400S14.copyWith(
                                  color: ColorRes.appBlackColor),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                            );
                          }).toList(),
                        ),
                      ): Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            (title?.length ?? 0) > 1 ? "${title?[0]}," : "${title?[0]}",
                            style: styleW400S14.copyWith(
                                color: ColorRes.appBlackColor),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                          ),
                          if((title?.length ?? 0) > 1)
                            Text(
                              "${title?[1]}",
                              style: styleW400S14.copyWith(
                                  color: ColorRes.appBlackColor),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                            )
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Image.asset(
                      AssetRes.rightArrowIcon,
                      height: 12,
                      width: 10,
                    ),
                  ],
                ),
              ):Expanded(child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "add".tr,
                    style: styleW400S14.copyWith(
                        color: ColorRes.appBlackColor),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                  const SizedBox(width: 13),
                  Image.asset(
                    AssetRes.rightArrowIcon,
                    height: 12,
                    width: 10,
                  ),
                ],

              ))
            ],
          ),
        ),
      ],
    );
  }
}

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String value;
  final Function(String?) onChanged;

  CustomDropdown({required this.items, required this.value, required this.onChanged});

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Full width
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: ColorRes.appBlackColor),
        color: ColorRes.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: widget.value,
          icon: Icon(Icons.keyboard_arrow_down),
          iconSize: 24,
          elevation: 16,
          style: styleW400S14,
          onChanged: widget.onChanged,
          items: widget.items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class CommonDropDownContainer extends StatelessWidget {
  final Function(String?) onChanged;
  final List<String> dropDownList;
  final String? dropDownValue;
  final String hintText;

  const CommonDropDownContainer(
      {Key? key,
        required this.onChanged,
        required this.dropDownList,
        required this.dropDownValue,
        this.hintText = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: Get.width,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorRes.greyColor),
        color: ColorRes.greyColor.withOpacity(0.27),
      ),
      child: DropdownButton<String>(
        value: dropDownValue,
        hint: Text(
          hintText ?? "",
          style: styleW400S14,
        ),
        underline: const SizedBox(),
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: ColorRes.appBlackColor,
        ),
        items: dropDownList.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(
              items,
              style: styleW400S14,
            ),
          );
        }).toList(),
        dropdownColor: ColorRes.greyColor,
        borderRadius: BorderRadius.circular(10),
        isExpanded: true,
        isDense: true,
        onChanged: onChanged,
      ),
    );
  }
}

class ErrorText extends StatelessWidget {
  final String? errorText;

  const ErrorText({super.key, this.errorText});

  @override
  Widget build(BuildContext context) {
    if ((errorText ?? '').isEmpty) {
      return const SizedBox();
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 3.0),
        child: Text(
          errorText ?? "",
          style: styleW500S14.copyWith(color: ColorRes.appRedColor),
        ),
      );
    }
  }
}

class CommonTextField extends StatelessWidget {
  final String? heading;
  final TextEditingController? controller;
  final TextEditingController? contryCodeController;
  final String? hintText;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixTap;
  final VoidCallback? onTap;
  bool secureText;
  bool isNumberOnly;
  TextInputType? textInputType;
  bool isMobileNumber;
  String errorText;
  final int maxLines;
  final bool isEnabled;
  final bool isReadOnly;
  final Function(String)? onChanged;
  final bool showCountry;
  bool isPersonName;
  bool isOnlyNumber;

  CommonTextField({
    Key? key,
    this.isEnabled = true,
    this.isReadOnly = false,
    this.secureText = false,
    this.maxLines = 1,
    this.textInputType,
    this.isMobileNumber = false,
    this.heading,
    this.isNumberOnly = false,
    this.controller,
    this.contryCodeController,
    this.hintText,
    this.suffixIcon,
    this.errorText = "",
    this.onSuffixTap,
    this.onTap,
    this.onChanged,
    this.showCountry = false,
    this.isPersonName = false,
    this.isOnlyNumber = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (heading != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              heading ?? "",
              style: styleW500S14.copyWith(color: ColorRes.appBlackColor),
            ),
          ),
        InkWell(
          onTap: onTap,
          child: SizedBox(
            height: maxLines > 1 ? 40 * maxLines.toDouble() : 50,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    // Set the background color for the entire container
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorRes.white),
                      color: ColorRes.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        if (!showCountry) appSizedBox(width: 8.0),
                        if (showCountry) ...[
                          // Show country picker if showCountry is true
                          InkWell(
                            onTap: () {
                              _showCountryPicker(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  Text(
                                      '+91',
                                      style: styleW400S14.copyWith(color: ColorRes.appBlackColor),
                                      textAlign: TextAlign.center
                                  ),
                                  const Icon(Icons.keyboard_arrow_down),
                                ],
                              ),
                            ),
                          ),
                          appSizedBox(width: 8.0),
                        ],
                        Expanded(
                          child: TextFormField(
                            keyboardType: textInputType,
                            inputFormatters: [
                              if (isNumberOnly) FilteringTextInputFormatter.digitsOnly,
                              if (isMobileNumber) LengthLimitingTextInputFormatter(10),
                              if (isPersonName) LengthLimitingTextInputFormatter(15),
                              if(isOnlyNumber) FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                            ],
                            obscureText: secureText,
                            obscuringCharacter: '*',
                            controller: controller,
                            onChanged: onChanged,
                            enabled: isEnabled,
                            readOnly: isReadOnly,
                            style: styleW400S14.copyWith(color: ColorRes.appBlackColor),
                            cursorColor: Colors.black,
                            maxLines: maxLines,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: hintText,
                              hintStyle: styleW400S14.copyWith(color: ColorRes.greyColor),
                              //  filled: true,
                              //  fillColor: Colors.grey.withOpacity(0.27),

                              suffixIcon: InkWell(
                                onTap: onSuffixTap,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 13.0),
                                  child: suffixIcon,
                                ),
                              ),
                              suffixIconConstraints: const BoxConstraints(
                                maxWidth: 35,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ErrorText(errorText: errorText),
      ],
    );
  }

  void _showCountryPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        contryCodeController!.text = country.phoneCode ?? '';
        print("Selected country: ${country.name}");
      },
    );
  }
}

class CommonOTPField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;

  CommonOTPField({
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 55,
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          onChanged: (value) {
            if (value.length == 1 && nextFocusNode != null) {
              // Move focus to the next field
              FocusScope.of(context).requestFocus(nextFocusNode);
            }
          },
          keyboardType: TextInputType.number,
          maxLength: 1,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            counterText: "",
            contentPadding: EdgeInsets.zero,
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class TitleData {
  final String title;
  final String imageUrl;
  final double? imageSize;

  TitleData({
    required this.title,
    required this.imageUrl,
    this.imageSize
  });
}

class CommonGridTile extends StatefulWidget {
  final String heading;
  final List<TitleData> titlesData;
  final bool allowMultipleSelection;
  final bool showHeading;
  final Function(List<String>)? onTitlesTap;
  double? horizontalPadding;
  double? verticalPadding;

  CommonGridTile({
    required this.heading,
    required this.titlesData,
    this.allowMultipleSelection = false,
    this.showHeading = true,
    this.onTitlesTap,
    this.horizontalPadding,
    this.verticalPadding
  });

  @override
  _CommonGridTileState createState() => _CommonGridTileState();
}

class _CommonGridTileState extends State<CommonGridTile> {
  List<String> selectedTitles = [];

  @override
  Widget build(BuildContext context) {
    int itemsPerRow = (widget.titlesData.length <= 4) ? 2 : 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showHeading)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.horizontalPadding, vertical: 1.h),
            child: Text(
              widget.heading,
              style: styleW400S16.copyWith(color: ColorRes.appBlackColor),
            ),
          ),
        Container(
          child:  Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.horizontalPadding, vertical: 1.h),
              child:
              Wrap(
                spacing: 10.0, // Adjust the spacing between items
                runSpacing: 10.0, // Adjust the run spacing
                children: List.generate(
                  widget.titlesData.length,
                      (index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          if (widget.allowMultipleSelection) {
                            // Toggle multi-selection
                            if (selectedTitles.contains(widget.titlesData[index].title)) {
                              selectedTitles.remove(widget.titlesData[index].title);
                            } else {
                              selectedTitles.add(widget.titlesData[index].title);
                            }
                          } else {
                            // Single selection
                            selectedTitles = [widget.titlesData[index].title];
                          }
                        });

                        // Notify the parent widget about the selected titles
                        if (widget.onTitlesTap != null) {
                          widget.onTitlesTap!(selectedTitles);
                        }
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: AnimatedContainer(
                        width: (MediaQuery.of(context).size.width - (AppPadding.horizontalPadding * 2) - 20) / 3, // Ad
                        duration: const Duration(milliseconds: 200),
                        padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding ?? 2.w, vertical: widget.verticalPadding ?? 1.h),
                        decoration: BoxDecoration(
                          color: ColorRes.white,
                          border: selectedTitles.contains(widget.titlesData[index].title)
                              ? Border.all(color: ColorRes.appBlueColor, width: 2)
                              : Border.all(color: Colors.transparent, width: 2),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [commonBoxShadow()],
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                              widget.titlesData[index].imageUrl,
                              width: widget.titlesData[index].imageSize ?? 10.w,
                              height: widget.titlesData[index].imageSize ?? 10.w,
                            ),
                            appSizedBox(height: 1.h),
                            Text(
                              widget.titlesData[index].title,
                              maxLines: 1,
                              style: styleW300S14.copyWith(color: ColorRes.appBlackColor),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
          ),
        ),
      ],
    );
  }
}

class CommonListTile extends StatefulWidget {
  final String heading;
  final List<TitleData> titlesData;
  final bool allowMultipleSelection;
  final bool showHeading;
  final Function(List<String>)? onTitlesTap;
  double? horizontalPadding;
  double? verticalPadding;

  CommonListTile({
    required this.heading,
    required this.titlesData,
    this.allowMultipleSelection = false,
    this.showHeading = true,
    this.onTitlesTap,
    this.horizontalPadding,
    this.verticalPadding
  });

  @override
  _CommonListTileState createState() => _CommonListTileState();
}

class _CommonListTileState extends State<CommonListTile> {
  List<String> selectedTitles = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showHeading)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.horizontalPadding, vertical: 1.h),
            child: Text(
              widget.heading,
              style: styleW400S16.copyWith(color: ColorRes.appBlackColor),
            ),
          ),
        Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: EdgeInsets.only(left: AppPadding.horizontalPadding),
              child: Row(
                children: [
                  for (int i = 0; i < widget.titlesData.length; i++)
                    Container(
                      margin: EdgeInsets.only(right: 10, bottom: 10), // Adjust the margin as needed
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (widget.allowMultipleSelection) {
                              // Toggle multi-selection
                              if (selectedTitles.contains(widget.titlesData[i].title)) {
                                selectedTitles.remove(widget.titlesData[i].title);
                              } else {
                                selectedTitles.add(widget.titlesData[i].title);
                              }
                            } else {
                              // Single selection
                              selectedTitles = [widget.titlesData[i].title];
                            }
                          });

                          // Notify the parent widget about the selected titles
                          if (widget.onTitlesTap != null) {
                            widget.onTitlesTap!(selectedTitles);
                          }
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding ?? 4.5.w, vertical: widget.verticalPadding ?? 1.h),
                          decoration: BoxDecoration(color: ColorRes.white,
                              border: selectedTitles.contains(widget.titlesData[i].title)
                                  ? Border.all(color: ColorRes.appBlueColor, width: 2)
                                  : Border.all(color: Colors.transparent, width: 2),
                              borderRadius: BorderRadius.circular(10), boxShadow: [
                                commonBoxShadow(),
                              ]),
                          child: Column(
                            children: [
                              Image.asset(
                                widget.titlesData[i].imageUrl,
                                width: widget.titlesData[i].imageSize ?? 10.w,
                                height: widget.titlesData[i].imageSize ?? 10.w,
                              ),
                              appSizedBox(height: 1.h),
                              Text(
                                widget.titlesData[i].title,
                                maxLines: 1,
                                style: styleW300S14.copyWith(
                                    color: ColorRes.appBlackColor
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                ],
              ),
            ),
          ),
        ),
      ],

    );
  }
}
