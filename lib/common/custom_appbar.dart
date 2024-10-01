import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/config/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isLeading;
  final VoidCallback? onLeadingPress;
  final List<Widget>? actions;
  final Color? backGroundColor;
  const CustomAppBar({
    super.key,
    this.title,
    this.isLeading = true,
    this.actions,
    this.backGroundColor,
    this.onLeadingPress,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:backGroundColor?? Colors.transparent,
      elevation: 0.0,
      centerTitle: true,
      scrolledUnderElevation: 0.0,
      title: Text(
        title ?? "",
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.black),
      ),
      leading: isLeading
          ? IconButton(
              onPressed: onLeadingPress?? () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.secondaryTextColor,
                size: 18.sp,
              ))
          : const SizedBox(),
          actions:actions ,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
