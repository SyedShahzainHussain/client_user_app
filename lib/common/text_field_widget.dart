
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/config/colors.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool isElevation;
  final TextInputType? keyboardType;
  final bool obSecure;
  const TextFieldWidget({
    super.key,
    required this.hintText,
    required this.textEditingController,
    required this.validator,
     this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.isElevation = true,
    this.obSecure =false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation:  isElevation ?  4.0:0.0,
      child: TextFormField(
        obscureText: obSecure,
        style: const TextStyle(color: AppColors.secondaryTextColor),
        keyboardType: keyboardType,
        controller: textEditingController,
        validator: validator,
        
        cursorColor: AppColors.secondaryTextColor,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              color: AppColors.lightGrey),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          fillColor: Colors.grey.shade100,
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: AppColors.darkGrey.withOpacity(0.25))),
          border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: AppColors.darkGrey.withOpacity(0.25))),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: AppColors.darkGrey.withOpacity(0.25))),
          errorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: AppColors.darkGrey.withOpacity(0.25))),
        ),
      ),
    );
  }
}
