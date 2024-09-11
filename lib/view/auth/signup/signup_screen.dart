import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_app/common/back_button.dart';
import 'package:my_app/common/button.dart';
import 'package:my_app/common/social_button.dart';
import 'package:my_app/common/text_field_widget.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/image_string.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/extension/localization_extension.dart';
import 'package:my_app/extension/media_query_extension.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  ValueNotifier<bool> passwordNotifier = ValueNotifier<bool>(false);
  ValueNotifier<bool> checkBoxNotifier = ValueNotifier<bool>(false);

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
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  BackButtonWidget(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(context,
                          RouteName.onBoardScreenName, (route) => false);
                    },
                  ),
                  SizedBox(height: context.height * 0.03),
                  Center(
                    child: Text(context.localizations!.signUp,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.secondaryTextColor,
                        )),
                  ),
                  SizedBox(height: context.height * 0.05),
                  TextFieldWidget(
                    
                    hintText: context.localizations!.name,
                    prefixIcon: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(ImageString.user)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "${context.localizations!.signUp} is requried";
                      }
                      return null;
                    },
                    textEditingController: nameController,
                  ),
                  SizedBox(height: context.height * 0.02),
                  TextFieldWidget(
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
                  TextFieldWidget(
                    hintText: context.localizations!.mobile,
                    prefixIcon: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(ImageString.phone)),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "${context.localizations!.mobile} is required";
                      }
                      return null;
                    },
                    textEditingController: phoneNumberController,
                  ),
                  SizedBox(height: context.height * 0.02),
                  ValueListenableBuilder(
                      valueListenable: passwordNotifier,
                      builder: (context, data, _) {
                        return TextFieldWidget(
                          obSecure: passwordNotifier.value,
                          hintText: context.localizations!.password,
                          prefixIcon: IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset(ImageString.lock)),
                          suffixIcon: IconButton(
                              onPressed: () {
                                passwordNotifier.value =
                                    !passwordNotifier.value;
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
                  SizedBox(height: context.height * 0.04),
                  Button(
                    title: context.localizations!.signUp,
                    onTap: () {
                      Navigator.pushNamed(context, RouteName.homeScreenName);
                    },
                    showRadius: true,
                  ),
                  SizedBox(height: context.height * 0.01),
                  Row(
                    children: [
                      ValueListenableBuilder(
                          valueListenable: checkBoxNotifier,
                          builder: (context, data, _) {
                            return Checkbox(
                              visualDensity: VisualDensity.compact,
                              side: const BorderSide(
                                  color: AppColors.secondaryTextColor),
                              activeColor: AppColors.secondaryTextColor,
                              value: checkBoxNotifier.value,
                              onChanged: (value) {
                                checkBoxNotifier.value =
                                    !checkBoxNotifier.value;
                              },
                            );
                          }),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "${context.localizations!.agree} ",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                color: Colors.black)),
                        TextSpan(
                            text: "${context.localizations!.termsCondition} ",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                color: AppColors.secondaryTextColor)),
                        TextSpan(
                            text: "${context.localizations!.and} ",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                color: Colors.black)),
                        TextSpan(
                            text: "${context.localizations!.privacyPolicy} ",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                color: AppColors.secondaryTextColor)),
                      ]))
                    ],
                  ),
                  SizedBox(height: context.height * 0.015),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: Colors.black,
                            endIndent: 20,
                            indent: 20,
                            thickness: 1.0,
                          ),
                        ),
                        Text(
                          context.localizations!.signInWith,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: Colors.black,
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            color: Colors.black,
                            endIndent: 20,
                            indent: 20,
                            thickness: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: context.height * 0.03),
                  const SocialButton(),
                  SizedBox(height: context.height * 0.05),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, RouteName.loginScreenName, (route) => false);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${context.localizations!.alreadyHaveAccount} ",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                        Text(context.localizations!.signIn,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              decorationThickness: 2.0,
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
