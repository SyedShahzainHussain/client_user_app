import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/bloc/auth/profile/profile_bloc.dart';
import 'package:my_app/common/custom_appbar.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/image_string.dart';
import 'package:my_app/config/routes/route_name.dart';

import '../../services/session_controller_services.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool first = false;
  bool second = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: const CustomAppBar(
        backGroundColor: Colors.white,
        title: "Profile",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(
              color: Color(0xffF4F5F7),
              height: .3,
            ),
            // Todo Profile Image & Name
            BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40.r,
                      backgroundImage: NetworkImage(state.profilePic),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      state.name,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff172B4D),
                      ),
                    )
                  ],
                ),
              );
            }),
            SizedBox(
              height: 20.h,
            ),
            // Todo General
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const TitleWidget(
                      title: "General",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      color: Color(0xffF4F5F7),
                      height: .4,
                    ),
                    Column(
                      children: [
                        SettingListTileWidget(
                          title: "Account information",
                          subTitle: "Change your Account information",
                          image: ImageString.user2,
                          onTap: () {
                            Navigator.pushNamed(context,
                                RouteName.accountInformationScreenName);
                          },
                        ),
                        const Divider(
                          color: Color(0xffF4F5F7),
                          height: .4,
                          endIndent: 20,
                          indent: 20,
                        ),
                        SettingListTileWidget(
                          title: "Password",
                          subTitle: "Change your Password",
                          image: ImageString.lock1,
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteName.changePasswordScreenName);
                          },
                        ),
                        const Divider(
                          color: Color(0xffF4F5F7),
                          height: .4,
                          endIndent: 20,
                          indent: 20,
                        ),
                        SettingListTileWidget(
                          title: "Payment Methods",
                          subTitle: "Add your Credit & Debit cards",
                          image: ImageString.CreditCard,
                          onTap: () {},
                        ),
                        const Divider(
                          color: Color(0xffF4F5F7),
                          height: .4,
                          endIndent: 20,
                          indent: 20,
                        ),
                        SettingListTileWidget(
                          title: "Delivery Locations",
                          subTitle: "Change your Delivery Locations",
                          image: ImageString.locationMap,
                          onTap: () {},
                        ),
                        const Divider(
                          color: Color(0xffF4F5F7),
                          height: .4,
                          endIndent: 20,
                          indent: 20,
                        ),
                        SettingListTileWidget(
                          title: "Invite your friends",
                          subTitle: "Get \$59 for each invitation!",
                          image: ImageString.mention,
                          onTap: () {},
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            // Todo Notification
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const TitleWidget(
                      title: "Notifications",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      color: Color(0xffF4F5F7),
                      height: .4,
                    ),
                    Column(
                      children: [
                        ListTile(
                          leading: IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              ImageString.notification,
                            ),
                            color: const Color(0xffC1C7D0),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Notifications",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  color: const Color(0xff172B4D),
                                ),
                              ),
                              Text(
                                "You will receive daily updates",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                  color: const Color(0xff7A869A),
                                ),
                              ),
                            ],
                          ),
                          trailing: Transform.scale(
                              scale: 0.56,
                              child: Switch(
                                value: first,
                                onChanged: (value) {
                                  setState(() {
                                    first = value;
                                  });
                                },
                                activeColor: AppColors.secondaryTextColor,
                                thumbColor:
                                    const WidgetStatePropertyAll(Colors.white),
                                trackColor: const WidgetStatePropertyAll(
                                    AppColors.secondaryTextColor),
                                trackOutlineColor: const WidgetStatePropertyAll(
                                    Colors.transparent),
                              )),
                        ),
                        // const Divider(
                        //   color: Color(0xffF4F5F7),
                        //   height: .4,
                        //   endIndent: 20,
                        //   indent: 20,
                        // ),
                        // ListTile(
                        //   leading: IconButton(
                        //     onPressed: () {},
                        //     icon: SvgPicture.asset(
                        //       ImageString.notification,
                        //     ),
                        //     color: const Color(0xffC1C7D0),
                        //   ),
                        //   title: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text(
                        //         "Promotional Notifications",
                        //         style: TextStyle(
                        //           fontWeight: FontWeight.w500,
                        //           fontSize: 14.sp,
                        //           color: const Color(0xff172B4D),
                        //         ),
                        //       ),
                        //       Text(
                        //         "Get notified when promotions",
                        //         style: TextStyle(
                        //           fontWeight: FontWeight.w500,
                        //           fontSize: 12.sp,
                        //           color: const Color(0xff7A869A),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        //   trailing: Transform.scale(
                        //       scale: 0.56,
                        //       child: Switch(
                        //         value: second,
                        //         onChanged: (value) {
                        //           setState(() {
                        //             second = value;
                        //           });
                        //         },
                        //         activeColor: AppColors.secondaryTextColor,
                        //         thumbColor:
                        //             const WidgetStatePropertyAll(Colors.white),
                        //         trackColor: const WidgetStatePropertyAll(
                        //             AppColors.secondaryTextColor),
                        //         trackOutlineColor: const WidgetStatePropertyAll(
                        //             Colors.transparent),
                        //       )),
                        // ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            // Todo More
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const TitleWidget(
                        title: "More",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        color: Color(0xffF4F5F7),
                        height: .4,
                      ),
                      Column(
                        children: [
                          SettingListTileWidget(
                            title: "Rate Us",
                            subTitle: "You will receive daily updates",
                            image: ImageString.rateFull,
                            onTap: () {},
                          ),
                          const Divider(
                            color: Color(0xffF4F5F7),
                            height: .4,
                            endIndent: 20,
                            indent: 20,
                          ),
                          SettingListTileWidget(
                            title: "FAQ",
                            subTitle: "Frequently Asked Questions",
                            image: ImageString.book,
                            onTap: () {},
                          ),
                        ],
                      )
                    ],
                  ),
                )),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: Text(
                              "Logout",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                            ),
                            content: Text(
                              "Do you Really want to logout?",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Colors.black,
                                  ),
                            ),
                            actionsAlignment: MainAxisAlignment.end,
                            actionsOverflowAlignment: OverflowBarAlignment.end,
                            actions: [
                              SizedBox(
                                width: 10.w,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 0.0,
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.grey,
                                    padding: EdgeInsets.zero),
                                child: Text(
                                  "Cancel",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await SessionController().logout().then((_) {
                                    if (context.mounted) {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          RouteName.splashScreenName,
                                          (route) => false);
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.red,
                                  padding: EdgeInsets.zero,
                                ),
                                child: Text(
                                  "Log Out",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.buttonColor),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  leading: IconButton(
                    onPressed: null,
                    icon: SvgPicture.asset(
                      ImageString.logout,
                    ),
                    color: const Color(0xffC1C7D0),
                  ),
                  title: Text(
                    "Log Out",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: const Color(0xff172B4D),
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      SessionController().logout().then((_) {
                        if (context.mounted) {
                          Navigator.pushNamedAndRemoveUntil(context,
                              RouteName.splashScreenName, (route) => false);
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                    ),
                    color: const Color(0xffC1C7D0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}

class SettingListTileWidget extends StatelessWidget {
  final String title, subTitle, image;
  final VoidCallback onTap;

  const SettingListTileWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: IconButton(
        onPressed: onTap,
        icon: SvgPicture.asset(
          image,
        ),
        color: const Color(0xffC1C7D0),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: const Color(0xff172B4D),
            ),
          ),
          Text(
            subTitle,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: const Color(0xff7A869A),
            ),
          ),
        ],
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 15,
        ),
        color: const Color(0xffC1C7D0),
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  final String title;
  const TitleWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xff172B4D)),
      ),
    );
  }
}
