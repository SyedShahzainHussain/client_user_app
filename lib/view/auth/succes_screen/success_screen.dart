import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/button.dart';
import 'package:my_app/common/custom_appbar.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/image_string.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/extension/localization_extension.dart';
import 'package:my_app/extension/media_query_extension.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(),
        body: PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            if (!didPop) {
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteName.loginScreenName, (route) => false);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Column(
              children: [
                SizedBox(
                  height: 12.sp,
                ),
                Image.asset(
                  ImageString.successImage,
                  width: double.infinity,
                  height: context.height * .35,
                ),
                SizedBox(
                  height: context.height * 0.05,
                ),
                Center(
                  child: Text(
                    context.localizations!.success,
                    style: TextStyle(
                      color: AppColors.secondaryTextColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 24.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: context.height * 0.02,
                ),
                FittedBox(
                  child: Text(
                    context.localizations!.yourPasswordResendSuccess,
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  height: context.height * 0.005,
                ),
                FittedBox(
                  child: Text(
                    context.localizations!.dontForgetThePasswordAgain,
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                    ),
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  height: context.height * 0.05,
                ),
                Button(
                  title: context.localizations!.goMoodyAgain,
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RouteName.loginScreenName, (route) => false);
                  },
                  showRadius: false,
                )
              ],
            ),
          ),
        ));
  }
}
