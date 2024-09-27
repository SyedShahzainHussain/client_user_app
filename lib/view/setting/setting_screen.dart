import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/bloc/auth/profile/profile_bloc.dart';
import 'package:my_app/common/custom_appbar.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/image_string.dart';

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
                child: const  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     SizedBox(
                      height: 10,
                    ),
                     TitleWidget(
                      title: "General",
                    ),
                     SizedBox(
                      height: 10,
                    ),
                     Divider(
                      color: Color(0xffF4F5F7),
                      height: .4,
                    ),
                    Column(
                      children: [
                        SettingListTileWidget(
                          title: "Account information",
                          subTitle: "Change your Account information",
                          image: ImageString.user2,
                        ),
                         Divider(
                          color: Color(0xffF4F5F7),
                          height: .4,
                          endIndent: 20,
                          indent: 20,
                        ),
                         SettingListTileWidget(
                          title: "Password",
                          subTitle: "Change your Password",
                            image: ImageString.lock1,
                        ),
                         Divider(
                          color: Color(0xffF4F5F7),
                          height: .4,
                          endIndent: 20,
                          indent: 20,
                        ),
                         SettingListTileWidget(
                          title: "Payment Methods",
                          subTitle: "Add your Credit & Debit cards",
                          image: ImageString.CreditCard,
                        ),
                         Divider(
                          color: Color(0xffF4F5F7),
                          height: .4,
                          endIndent: 20,
                          indent: 20,
                        ),
                         SettingListTileWidget(
                          title: "Delivery Locations",
                          subTitle: "Change your Delivery Locations",
                          image: ImageString.locationMap,
                        ),
                         Divider(
                          color: Color(0xffF4F5F7),
                          height: .4,
                          endIndent: 20,
                          indent: 20,
                        ),
                         SettingListTileWidget(
                          title: "Invite your friends",
                          subTitle: "Get \$59 for each invitation!",
                          image: ImageString.mention,
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
                icon:SvgPicture.asset(
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
                          trailing: Transform.scale(scale:0.56,child: Switch(value: first, onChanged: (value) {
                            setState(() {
                              first=value;
                            });
                          },
                          activeColor: AppColors.secondaryTextColor,
                            thumbColor: WidgetStatePropertyAll(Colors.white),
                            trackColor: WidgetStatePropertyAll(AppColors.secondaryTextColor),
                            trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
                       )),
                        ),
                        const Divider(
                          color: Color(0xffF4F5F7),
                          height: .4,
                          endIndent: 20,
                          indent: 20,
                        ),
                        ListTile(
                          leading: IconButton(
                            onPressed: () {},
                            icon:SvgPicture.asset(
                              ImageString.notification,
                            ),
                            color: const Color(0xffC1C7D0),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Promotional Notifications",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  color: const Color(0xff172B4D),
                                ),
                              ),
                              Text(
                                "Get notified when promotions",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                  color: const Color(0xff7A869A),
                                ),
                              ),
                            ],
                          ),
                          trailing: Transform.scale(scale:0.56,child: Switch(value: second, onChanged: (value) {
                            setState(() {
                              second=value;
                            });
                          },
                            activeColor: AppColors.secondaryTextColor,
                            thumbColor: WidgetStatePropertyAll(Colors.white),
                            trackColor: WidgetStatePropertyAll(AppColors.secondaryTextColor),
                            trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
                          )),
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
            // Todo More
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      TitleWidget(
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
                              subTitle: "You will receive daily updates",image: ImageString.rateFull,),
                          const Divider(
                            color: Color(0xffF4F5F7),
                            height: .4,
                            endIndent: 20,
                            indent: 20,
                          ),
                          SettingListTileWidget(
                              title: "FAQ",
                              subTitle: "Frequently Asked Questions",image:ImageString.book),
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
                  leading: IconButton(
                    onPressed: () {},
                    icon:SvgPicture.asset(
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
                    onPressed: () {},
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
  final String title, subTitle,image;

  const SettingListTileWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:  IconButton(
        onPressed: () {},
        icon:SvgPicture.asset(
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
