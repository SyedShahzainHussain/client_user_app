import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/common/button.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/image_string.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/extension/localization_extension.dart';
import 'package:my_app/extension/media_query_extension.dart';

class SubmitOrderScreen extends StatelessWidget {
  const SubmitOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteName.entryScreenName, (route) => false);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: SizedBox(
              width: double.infinity,
              child: Card(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: context.height * 0.05.h,
                    ),
                    Container(
                      width: 70.w,
                      height: 70.h,
                      decoration: const BoxDecoration(
                          color: AppColors.redColor, shape: BoxShape.circle),
                      child: IconButton(
                          onPressed: null,
                          icon: Image.asset(
                            ImageString.checkImage,
                            width: 30.w,
                            height: 30.h,
                          )),
                    ),
                    SizedBox(
                      height: context.height * 0.025.h,
                    ),
                    Text(
                      " ${context.localizations!.success} !",
                      style: GoogleFonts.poppins(
                        color: AppColors.redColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 25.sp,
                      ),
                    ),
                    SizedBox(
                      height: context.height * 0.015.h,
                    ),
                    SizedBox(
                      width: context.width * .5,
                      child: Text(
                        context.localizations!.your_payment_was_successful,
                        style: GoogleFonts.roboto(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff808080)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: context.height * 0.035.h,
                    ),
                    SizedBox(
                        width: context.width * .5,
                        child: Button(
                          title: context.localizations!.go_back,
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(context,
                                RouteName.entryScreenName, (route) => false);
                          },
                          showRadius: true,
                        )),
                    SizedBox(
                      height: context.height * 0.04.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
