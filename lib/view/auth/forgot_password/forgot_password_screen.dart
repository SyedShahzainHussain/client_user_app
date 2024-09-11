import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/button.dart';
import 'package:my_app/common/custom_appbar.dart';
import 'package:my_app/common/text_field_widget.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/extension/localization_extension.dart';
import 'package:my_app/extension/media_query_extension.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: FittedBox(
                    child: Text(
                      context.localizations!.forgotPassword,
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 24.sp,
                          color: AppColors.secondaryTextColor),
                      maxLines: 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: context.height * 0.02,
                ),
                Text(
                  context.localizations!.forgotPasswordSubTitle,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: AppColors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: context.height * 0.20,
                ),
                TextFieldWidget(
                    isElevation: false,
                    hintText: context.localizations!.emailIdOrPhoneNumber,
                    textEditingController: emailIdController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "${context.localizations!.emailIdOrPhoneNumber} is requried";
                      }
                      return null;
                    }),
                SizedBox(
                  height: context.height * 0.03,
                ),
                Button(
                  title: context.localizations!.submit,
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.otpScreenName);
                  },
                  showRadius: false,
                )
              ],
            ),
          ),
        ));
  }
}
