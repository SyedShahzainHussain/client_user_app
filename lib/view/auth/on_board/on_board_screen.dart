import 'package:flutter/material.dart';
import 'package:my_app/common/button.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/image_string.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/extension/localization_extension.dart';
import 'package:my_app/extension/media_query_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            ImageString.logoImage,
            height: context.height * .3,
            alignment: Alignment.lerp(
              const Alignment(1.34, 0),
              const Alignment(0, 0),
              0.0,
            )!,
          ),
          SizedBox(
            height: 5.h,
          ),
          Image.asset(
            ImageString.burgerImage,
            height: context.height * .35,
            
          ),
          SizedBox(
            height: context.height * .04,
          ),
          Center(
            child: Text(
              context.localizations!.onBoardTitle,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 24.sp,
                color: AppColors.primaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: context.height * .04,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Button(
              title: context.localizations!.onBoardButton,
              onTap: () {
                Navigator.pushNamed(context, RouteName.signUpScreenName);
              },
            ),
          )
        ],
      ),
    ));
  }
}
