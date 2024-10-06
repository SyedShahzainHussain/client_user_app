import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/button.dart';
import 'package:my_app/config/image_string.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/extension/localization_extension.dart';
import 'package:my_app/extension/media_query_extension.dart';

class PlaceOrderScreen extends StatelessWidget {
  const PlaceOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PopScope(
            canPop: false,
        onPopInvokedWithResult: (didPop,_) {
          if (!didPop) {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteName.entryScreenName, (route) => false);
          }
        },
          child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
          Column(
            children: [
              Center(
                child: Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: const BoxDecoration(
                      color: Color(0xffFF9D01), shape: BoxShape.circle),
                  child: const Center(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                context.localizations!.thank_you_for_placing_the_order,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  color: Colors.black,
                  letterSpacing: 2
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                context.localizations!.we_get_to_you_as_soon_as_possible,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 17.sp,
                  color: const Color(0xff8E8E93),
                  letterSpacing: 0.90
                ),
              ),
            ],
          ),
          Image.asset(
            ImageString.placeOrder,
            width: double.infinity,
            height:context.height*.2,
            fit: BoxFit.fill,
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 24.w),
            child: Button(
              showRadius: true,
              title: context.localizations!.go_home,
              onTap: () {
                 Navigator.pushNamedAndRemoveUntil(context,
                                RouteName.entryScreenName, (route) => false);
              },
            ),
          )
                ],
              )),
        ));
  }
}
