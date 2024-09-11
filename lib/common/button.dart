import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/config/colors.dart';

class Button extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool showRadius;
  const Button({
    super.key,
    required this.title,
    required this.onTap,
    this.showRadius = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: showRadius? BorderRadius.circular(12.r):BorderRadius.zero,
          color: AppColors.buttonColor,
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700, fontSize: 18.sp),
          ),
        ),
      ),
    );
  }
}
