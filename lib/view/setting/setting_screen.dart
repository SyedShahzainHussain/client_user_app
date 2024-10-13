import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/bloc/auth/profile/profile_bloc.dart';
import 'package:my_app/common/custom_appbar.dart';
import 'package:my_app/common/shimmer_effect.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/image_string.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/extension/localization_extension.dart';

import '../../services/session_controller_services.dart';
import 'package:share_plus/share_plus.dart';

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
      appBar: CustomAppBar(
        backGroundColor: Colors.white,
        title: context.localizations!.profile,
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),
                      child: CachedNetworkImage(
                        progressIndicatorBuilder: (context, url, progress) =>
                            ShimmerEffect(width: 100.w, height: 100.w),
                        imageUrl: state.profilePic,
                        width: 100.w,
                        height: 100.h,
                        fit: BoxFit.cover,
                      ),
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
                    TitleWidget(
                      title: context.localizations!.general,
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
                          title: context.localizations!.account_information,
                          subTitle: context
                              .localizations!.change_your_account_information,
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
                          title: context.localizations!.password,
                          subTitle: context.localizations!.change_password,
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
                        // SettingListTileWidget(
                        //   title: "Payment Methods",
                        //   subTitle: "Add your Credit & Debit cards",
                        //   image: ImageString.CreditCard,
                        //   onTap: () {},
                        // ),
                        // const Divider(
                        //   color: Color(0xffF4F5F7),
                        //   height: .4,
                        //   endIndent: 20,
                        //   indent: 20,
                        // ),
                        SettingListTileWidget(
                          title: context.localizations!.change_language,
                          subTitle:
                              context.localizations!.change_your_app_language,
                          isIcon: true,
                          icon: Icons.language,
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteName.changeLanguageScreenName);
                          },
                        ),
                        const Divider(
                          color: Color(0xffF4F5F7),
                          height: .4,
                          endIndent: 20,
                          indent: 20,
                        ),
                        SettingListTileWidget(
                          title: context.localizations!.delivery_locations,
                          subTitle: context
                              .localizations!.change_your_delivery_locations,
                          image: ImageString.locationMap,
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteName.addressScreenName);
                          },
                        ),
                        const Divider(
                          color: Color(0xffF4F5F7),
                          height: .4,
                          endIndent: 20,
                          indent: 20,
                        ),
                        SettingListTileWidget(
                          title: context.localizations!.invite_your_friends,
                          subTitle:
                              context.localizations!.send_the_link_to_user,
                          image: ImageString.mention,
                          onTap: () async {
                            try {
                              await Share.shareUri(
                                  Uri.parse("https://www.google.com/"));
                            } catch (e) {
                              rethrow;
                            }
                          },
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
                    TitleWidget(
                      title: context.localizations!.notifications,
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
                                context.localizations!.notifications,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  color: const Color(0xff172B4D),
                                ),
                              ),
                              Text(
                                context.localizations!
                                    .you_will_receive_daily_updates,
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
                      TitleWidget(
                        title: context.localizations!.more,
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
                            title: context.localizations!.rate_us,
                            subTitle: context
                                .localizations!.you_will_receive_daily_updates,
                            image: ImageString.rateFull,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteName.appRateScreenName);
                            },
                          ),
                          const Divider(
                            color: Color(0xffF4F5F7),
                            height: .4,
                            endIndent: 20,
                            indent: 20,
                          ),
                          SettingListTileWidget(
                            title: context.localizations!.faq,
                            subTitle: context
                                .localizations!.frequently_asked_questions,
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
                              context.localizations!.logOut,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                            ),
                            content: Text(
                              context
                                  .localizations!.do_you_really_want_to_logout,
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
                                  context.localizations!.cancel,
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
                                  context.localizations!.log_out,
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
                    context.localizations!.log_out,
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
  final String title, subTitle;
  final String? image;
  final VoidCallback onTap;
  final bool isIcon;
  final IconData? icon;

  const SettingListTileWidget({
    super.key,
    required this.title,
    required this.subTitle,
    this.image,
    required this.onTap,
    this.icon,
    this.isIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: IconButton(
        onPressed: onTap,
        icon: isIcon
            ? Icon(
                icon,
                color: const Color(0xffC1C7D0),
                size: 18.0,
              )
            : SvgPicture.asset(
                image!,
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
