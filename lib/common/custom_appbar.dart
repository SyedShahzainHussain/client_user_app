
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/config/colors.dart';

class CustomAppBar extends StatelessWidget   implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      scrolledUnderElevation: 0.0,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.secondaryTextColor,
            size: 18.sp,
          )),
    );
  }
  
  @override
  Size get preferredSize =>const Size.fromHeight(kToolbarHeight);
}
