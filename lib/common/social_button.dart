
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/config/image_string.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          elevation: 5.0,
            borderRadius: BorderRadius.circular(27.41),
          child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(27.41),
              ),
              child: Row(
                children: [
                  Image.asset(
                    ImageString.facebookImage,
                    width: 30.w,
                    height: 30.h,
                  ),
                 const  SizedBox(
                    width: 8,
                  ),
                  Text("FACEBOOK",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ))
                ],
              )),
        ),
        const SizedBox(
          width: 20,
        ),
        Material(
           elevation: 5.0,
            borderRadius: BorderRadius.circular(27.41),
          child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(27.41),
              ),
              child: Row(
                children: [
                  Image.asset(
                    ImageString.googleImage,
                    width: 30.w,
                    height: 30.h,
                  ),
                 const  SizedBox(
                    width: 8,
                  ),
                  Text("GOOGLE  ",
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black))
                ],
              )),
        ),
      ],
    );
  }
}
