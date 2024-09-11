import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/config/colors.dart';

class BackButtonWidget extends StatelessWidget {
  final VoidCallback onTap;

  const BackButtonWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30.w,
        height: 30.h,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              offset: const Offset(0, 1),
              blurRadius: 0.12,
              spreadRadius: 1.5,
            )
          ],
          borderRadius: BorderRadius.circular(8.0),
          color: AppColors.primaryColor,
        ),
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 17,
          color: Colors.black,
        ),
      ),
    );
  }
}
