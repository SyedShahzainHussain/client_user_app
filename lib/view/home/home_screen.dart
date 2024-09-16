import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/image_string.dart';

import 'package:my_app/extension/media_query_extension.dart';
import 'package:my_app/services/session_controller_services.dart';
import 'package:my_app/view/home/widget/product_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? profileImage =
      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png";

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      getProfileData();
    });
  }

  getProfileData() async {
    profileImage = await SessionController().checkIsGoogle() == true
        ? await SessionController().localStorage.readValue("profilePic") ??
            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"
        : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png";

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          scrolledUnderElevation: 0.0,
          leading: Container(
            margin: const EdgeInsets.only(left: 12.0),
            child: Image.asset(ImageString.logoImage),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 12.0),
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: AppColors.primaryColor,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: CachedNetworkImage(
                  imageUrl: profileImage!,
                  fit: BoxFit.cover,
                  width: 50.w,
                  height: 50.h,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: kBottomNavigationBarHeight + 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 22.0),
                  child: Text(
                    "Order your favourite food!",
                    style: TextStyle(
                      color: AppColors.lightblack,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: context.height * 0.05,
                ),
                // Todo Search Food
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 22.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(20.0),
                          child: SizedBox(
                            height: 60.h,
                            child: TextFormField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: "Search",
                                hintStyle: TextStyle(
                                  color: AppColors.lightoffblack,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp,
                                ),
                                prefixIcon: IconButton(
                                    onPressed: null,
                                    icon: SvgPicture.asset(ImageString.search)),
                              ),
                              style: TextStyle(
                                color: AppColors.lightoffblack,
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                              ),
                              cursorColor: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                            color: AppColors.redColor,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: SvgPicture.asset(ImageString.filter),
                        )),
                      )
                    ],
                  ),
                ),

                SizedBox(
                  height: context.height * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 5.0),
                          height: 50,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: AppColors.redColor),
                          child: Center(
                            child: Text(
                              "All",
                              style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: 12,
                    ),
                  ),
                ),
                SizedBox(
                  height: context.height * 0.03,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 22.0),
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 6,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.85,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 20,
                      ),
                      itemBuilder: (context, index) {
                        return ProductTile();
                      }),
                ),
                SizedBox(
                  height: context.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 22.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Popular moods you can get",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18.sp,
                          color: AppColors.black,
                        ),
                      ),
                      Text(
                        "view all",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: AppColors.secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: context.height * 0.03,
                ),
                SizedBox(
                  height: 102.h,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Material(
                          elevation: 5.0,
                          color: Colors.white,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              margin: const EdgeInsets.only(right: 12.0),
                              height: 102.h,
                              width: 134.w,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                    const Color(0xff161616).withOpacity(0),
                                    const Color(0xffFFFFFF).withOpacity(0),
                                    const Color(0xffFF9D01).withOpacity(1),
                                  ],
                                      stops: const [
                                    0,
                                    0,
                                    1
                                  ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter)),
                              child: Column(
                                children: [
                                  SvgPicture.network(
                                    "https://cdn.freebiesupply.com/logos/large/2x/dominos-pizza-4-logo-svg-vector.svg",
                                    width: 50,
                                    height: 50,
                                  ),
                                  const Spacer(),
                                  const Text("Domino’s",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      )),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: 10,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
