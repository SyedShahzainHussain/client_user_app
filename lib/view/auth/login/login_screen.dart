import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/common/back_button.dart';
import 'package:my_app/common/button.dart';
import 'package:my_app/common/social_button.dart';
import 'package:my_app/common/text_field_widget.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/image_string.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/extension/localization_extension.dart';
import 'package:my_app/extension/media_query_extension.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  ValueNotifier<bool> passwordNotifier = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (!didPop) {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteName.onBoardScreenName, (route) => false);
          }
        },
        child: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                BackButtonWidget(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RouteName.onBoardScreenName, (route) => false);
                  },
                ),
                SizedBox(height: context.height * 0.03),
                Center(
                  child: Text(context.localizations!.signIn,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.secondaryTextColor,
                      )),
                ),
                SizedBox(height: context.height * 0.20),
                TextFieldWidget(
                  isElevation: false,
                  hintText: context.localizations!.email,
                  prefixIcon: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(ImageString.email)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "${context.localizations!.email} is required";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  textEditingController: emailController,
                ),
                SizedBox(height: context.height * 0.02),
                ValueListenableBuilder(
                    valueListenable: passwordNotifier,
                    builder: (context, data, _) {
                      return TextFieldWidget(
                        isElevation: false,
                        obSecure: passwordNotifier.value,
                        hintText: context.localizations!.password,
                        prefixIcon: IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(ImageString.lock)),
                        suffixIcon: IconButton(
                            onPressed: () {
                              passwordNotifier.value = !passwordNotifier.value;
                            },
                            icon: Icon(
                              passwordNotifier.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColors.lightGrey,
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "${context.localizations!.password} is required";
                          }
                          return null;
                        },
                        textEditingController: passwordController,
                      );
                    }),
                SizedBox(height: context.height * 0.01),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, RouteName.forgotScreenName);
                  },
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(context.localizations!.forgotPassword,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                              color: AppColors.secondaryTextColor))),
                ),
                SizedBox(height: context.height * 0.04),
                Button(
                  title: context.localizations!.signIn,
                  onTap: () {},
                  showRadius: false,
                ),
                SizedBox(height: context.height * 0.04),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: Colors.black,
                        endIndent: 20,
                        thickness: 1.0,
                      ),
                    ),
                    Text(
                      context.localizations!.orSignInWith,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        color: Colors.black,
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: Colors.black,
                        indent: 20,
                        thickness: 1.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.height * 0.03),
                const SocialButton(),
                SizedBox(height: context.height * 0.05),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RouteName.signUpScreenName, (route) => false);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${context.localizations!.dontHaveAnAccount}  ",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 14.sp)),
                      Text(context.localizations!.signUp,
                          style: TextStyle(
                            color: AppColors.secondaryTextColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 14.sp,
                          )),
                    ],
                  ),
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
