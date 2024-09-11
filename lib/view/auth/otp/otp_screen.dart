import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/button.dart';
import 'package:my_app/common/custom_appbar.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/extension/localization_extension.dart';
import 'package:my_app/extension/media_query_extension.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

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
                    context.localizations!.enterOtp,
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
              FittedBox(
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: context.localizations!.fourDigitCode,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: AppColors.black,
                      )),
                  TextSpan(
                      text: " +91 9876543210",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: AppColors.secondaryTextColor,
                      )),
                ])),
              ),
              SizedBox(
                height: context.height * 0.05,
              ),
              Pinput(
                autofocus: true,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                focusedPinTheme: PinTheme(
                    width: 56,
                    height: 56,
                    textStyle: TextStyle(
                      color: AppColors.secondaryTextColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 32.sp,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: AppColors.secondaryTextColor,
                    ))),
                defaultPinTheme: PinTheme(
                    width: 56,
                    height: 56,
                    textStyle: TextStyle(
                      color: AppColors.secondaryTextColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 32.sp,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: AppColors.secondaryTextColor,
                    ))),
                submittedPinTheme: PinTheme(
                    width: 56,
                    height: 56,
                    textStyle: TextStyle(
                      color: AppColors.secondaryTextColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 32.sp,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: AppColors.secondaryTextColor,
                    ))),
              ),
              SizedBox(
                height: context.height * 0.05,
              ),
              Button(
                title:context.localizations!.verify,
                onTap: () {
                  Navigator.pushNamed(context, RouteName.resetScreenName);
                },
                showRadius: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
