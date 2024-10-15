import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/image_string.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/extension/localization_extension.dart';
import 'package:my_app/extension/media_query_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../bloc/auth/profile/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      context.read<ProfileBloc>().add(GetProfileData());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        body: Padding(
          padding: MediaQuery.of(context).viewInsets.bottom == 0.0
              ? const EdgeInsets.only(bottom: kBottomNavigationBarHeight)
              : EdgeInsets.zero,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.redColor.withOpacity(0.9),
            ),
            child: SingleChildScrollView(
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    height: context.height - kBottomNavigationBarHeight,
                    width: context.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          ImageString.image16,
                          height: context.height * 0.3,
                          width: context.width * .3,
                          fit: BoxFit.cover,
                          opacity: const AlwaysStoppedAnimation(0.5),
                        ),
                        Image.asset(
                          ImageString.image15,
                          height: context.height * 0.3,
                          width: context.width * .3,
                          fit: BoxFit.cover,
                          opacity: const AlwaysStoppedAnimation(0.5),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      nameController.text = state
                          .name; // Use the appropriate fields from your state
                      emailController.text = state.email;
                      addressController.text = state.address;
                      return Positioned(
                        top: context.height * .20,
                        child: Container(
                          width: context.width,
                          height: context.height,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35.r),
                              topRight: Radius.circular(35.r),
                            ),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 70.h),
                                TextFormWidget2(
                                    labelText: context.localizations!.name,
                                    controller: nameController),
                                SizedBox(height: context.height * 0.03),
                                TextFormWidget2(
                                  labelText: context.localizations!.email,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                ),
                                SizedBox(height: context.height * 0.03),
                                TextFormWidget2(
                                  controller: addressController,
                                  labelText:
                                      context.localizations!.deliveryAddress,
                                  keyboardType: TextInputType.streetAddress,
                                ),
                                SizedBox(height: context.height * 0.03),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Divider(color: Color(0xffE8E8E8)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            context
                                                .localizations!.paymentDetails,
                                            style: GoogleFonts.roboto(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xff808080),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Color(0xff808080),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            context.localizations!.orderhistory,
                                            style: GoogleFonts.roboto(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xff808080),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.pushNamed(context,
                                                  RouteName.getOrdersScreen);
                                            },
                                            icon: const Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Color(0xff808080),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                    ],
                                  ),
                                ),
                                // const Spacer(),
                                // GestureDetector(
                                //   onTap: () async {
                                //     Navigator.pushNamed(context,
                                //         RouteName.editProfileScreenName,
                                //         arguments: {
                                //           "image": state.profilePic.isEmpty
                                //               ? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"
                                //               : state.profilePic,
                                //           "title": nameController.text,
                                //           "address": addressController.text,
                                //         });
                                //   },
                                //   child: Container(
                                //     height: 70.h,
                                //     decoration: BoxDecoration(
                                //       color: AppColors.lightoffblack,
                                //       borderRadius: BorderRadius.circular(20.r),
                                //     ),
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(4.0),
                                //       child: Row(
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.center,
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.center,
                                //         children: [
                                //           SizedBox(width: 10.w),
                                //           Text(
                                //             context.localizations!.editProfile,
                                //             style: GoogleFonts.roboto(
                                //               fontSize: 18.sp,
                                //               fontWeight: FontWeight.w500,
                                //             ),
                                //           ),
                                //           SizedBox(width: 10.w),
                                //           IconButton(
                                //             onPressed: null,
                                //             icon: SvgPicture.asset(
                                //                 ImageString.edit),
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: 20.h,
                                // ),
                                // const Spacer(
                                //   flex: 2,
                                // ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      return Positioned(
                        top: context.height * .10,
                        child: Container(
                          width: 140.w,
                          height: 140.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border:
                                Border.all(color: AppColors.redColor, width: 3),
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.transparent,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: CachedNetworkImage(
                              imageUrl: state.profilePic.isEmpty
                                  ? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"
                                  : state.profilePic,
                              fit: BoxFit.cover,
                              width: 140.w,
                              height: 140.h,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    top: 20,
                    right: 0,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RouteName.settingScreenName);
                        },
                        icon: const Icon(Icons.settings, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextFormWidget2 extends StatelessWidget {
  final bool obSecure;
  final String labelText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool? enabled;

  const TextFormWidget2({
    super.key,
    required this.labelText,
    this.keyboardType,
    this.controller,
    this.obSecure = false,
    this.enabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      obscureText: obSecure,
      cursorColor: AppColors.redColor,
      style: GoogleFonts.roboto(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.lightoffblack,
      ),
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
          borderSide: const BorderSide(color: Color(0xffE1E1E1), width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(color: Color(0xffE1E1E1), width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(color: Color(0xffE1E1E1), width: 2.0),
        ),
      ),
    );
  }
}


   // Expanded(
                                    //   child: GestureDetector(
                                    //     onTap: () async {
                                    //
                                    //     },
                                    //     child: Container(
                                    //       height: 70.h,
                                    //       decoration: BoxDecoration(
                                    //         borderRadius:
                                    //             BorderRadius.circular(20.r),
                                    //         border: Border.all(
                                    //           color: AppColors.redColor,
                                    //           width: 2,
                                    //         ),
                                    //       ),
                                    //       child: Padding(
                                    //         padding: const EdgeInsets.all(4.0),
                                    //         child: Row(
                                    //           mainAxisAlignment:
                                    //               MainAxisAlignment.center,
                                    //           children: [
                                    //             FittedBox(
                                    //               child: Text(
                                    //                 "Log out",
                                    //                 style: GoogleFonts.roboto(
                                    //                   fontSize: 18.sp,
                                    //                   fontWeight:
                                    //                       FontWeight.w500,
                                    //                   color: AppColors.redColor,
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //             IconButton(
                                    //               onPressed: null,
                                    //               icon: SvgPicture.asset(
                                    //                   ImageString.signout),
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),