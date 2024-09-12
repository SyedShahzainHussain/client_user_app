import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/image_string.dart';
import 'package:my_app/extension/media_query_extension.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: context.height - kToolbarHeight - kBottomNavigationBarHeight,
          color: AppColors.redColor.withOpacity(0.9),
          child: SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                    top: 0,
                    left: -100,
                    child: Image.asset(
                      ImageString.burgerImage,
                      height: context.height * .3,
                      opacity: const AlwaysStoppedAnimation(0.5),
                    )),
                Positioned(
                    top: 0,
                    right: -100,
                    child: Image.asset(
                      ImageString.burgerImage,
                      height: context.height * .3,
                      opacity: const AlwaysStoppedAnimation(0.5),
                    )),
                Positioned(
                  top: context.height * .20,
                  child: Container(
                    height: context.height,
                    width: context.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35.r),
                          topRight: Radius.circular(35.r),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 70.h,
                          ),
                          const TextFormWidget2(
                            labelText: "Name",
                          ),
                          SizedBox(
                            height: context.height * 0.03,
                          ),
                          const TextFormWidget2(
                            labelText: "Email",
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: context.height * 0.03,
                          ),
                          const TextFormWidget2(
                            labelText: "Delivery address",
                            keyboardType: TextInputType.streetAddress,
                          ),
                          SizedBox(
                            height: context.height * 0.03,
                          ),
                          const TextFormWidget2(
                            labelText: "Password",
                            obSecure: true,
                            keyboardType: TextInputType.visiblePassword,
                          ),
                          SizedBox(
                            height: context.height * 0.05,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(
                              color: Color(0xffE8E8E8),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Payment Details",
                                      style: GoogleFonts.roboto(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xff808080)),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Color(0xff808080)))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order history",
                                      style: GoogleFonts.roboto(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xff808080)),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Color(0xff808080)))
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: context.height * .10,
                  child: Container(
                    width: 140.w,
                    height: 140.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.redColor, width: 4),
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.transparent,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(
                        ImageString.girlImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.white,
                        )))
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(22),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 70.h,
                decoration: BoxDecoration(
                  color: AppColors.lightoffblack,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Edit Profile",
                          style: GoogleFonts.roboto(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: IconButton(
                            onPressed: null,
                            icon: SvgPicture.asset(ImageString.edit)),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(context, RouteName.orderScreenName);
                },
                child: Container(
                  height: 70.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: AppColors.redColor, width: 2)),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                          child: Text(
                            "Log out",
                            style: GoogleFonts.roboto(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.redColor),
                          ),
                        ),
                        IconButton(
                            onPressed: null,
                            icon: SvgPicture.asset(ImageString.signout))
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextFormWidget2 extends StatelessWidget {
  final bool obSecure;
  final String labelText;
  final TextInputType? keyboardType;
  const TextFormWidget2({
    super.key,
    required this.labelText,
    this.keyboardType,
    this.obSecure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obSecure,
      cursorColor: AppColors.redColor,
      style: GoogleFonts.roboto(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.lightoffblack),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: GoogleFonts.roboto(
          color: const Color(0xff808080),
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: const BorderSide(color: Color(0xffE1E1E1), width: 2.0)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(color: Color(0xffE1E1E1), width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: const BorderSide(color: Color(0xffE1E1E1), width: 2.0)),
      ),
    );
  }
}
