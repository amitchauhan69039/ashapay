

import 'package:country_picker/country_picker.dart';
import 'package:asha_pay/common/user.dart';
import 'package:asha_pay/asha_pay.dart';

void toastMsg(String msg, {gravity = ToastGravity.CENTER}) {
  Fluttertoast.showToast(msg: msg, gravity: gravity, timeInSecForIosWeb: 4);
}

class CommonTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? suffixIcon;
  final bool secureText;
  final TextInputType? textInputType;
  final bool isNumberOnly;
  final bool isPassword;
  final VoidCallback? onSuffixTap;

  final Color? fillColor;
  final bool showBorder;

  final String? errorText; // 🔥 NEW

  const CommonTextField({
    super.key,
    this.controller,
    this.hintText,
    this.suffixIcon,
    this.secureText = false,
    this.textInputType,
    this.isNumberOnly = false,
    this.isPassword = false,
    this.onSuffixTap,
    this.fillColor,
    this.showBorder = false,
    this.errorText, // 🔥
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: fillColor ?? Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: showBorder
                ? Border.all(
              color: (errorText != null && errorText!.isNotEmpty)
                  ? Colors.red // 🔥 error border
                  : Colors.grey.shade300,
            )
                : null,
          ),
          child: TextField(
            controller: controller,
            obscureText: secureText,
            keyboardType: textInputType,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),

              // 🔥 suffix icon with tap
              suffixIcon: suffixIcon != null
                  ? GestureDetector(
                onTap: onSuffixTap,
                child: suffixIcon,
              )
                  : null,
            ),
          ),
        ),

        // 🔥 ERROR TEXT SHOW
        if (errorText != null && errorText!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 5),
            child: Text(
              errorText!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}

class CommonHeader extends StatelessWidget {
  final String title;
  final bool showBack;

  const CommonHeader({
    super.key,
    required this.title,
    this.showBack = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          showBack
              ? GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          )
              : const SizedBox(width: 24),

          Expanded(
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),

          const SizedBox(width: 24), // balance
        ],
      ),
    );
  }
}
