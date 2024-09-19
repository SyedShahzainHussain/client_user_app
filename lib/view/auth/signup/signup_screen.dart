import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/bloc/auth/sign_up/sign_up_bloc.dart';
import 'package:my_app/common/back_button.dart';
import 'package:my_app/common/button.dart';
import 'package:my_app/common/social_button.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/extension/localization_extension.dart';
import 'package:my_app/extension/media_query_extension.dart';
import 'package:my_app/main.dart';
import 'package:my_app/utils/utils.dart';
import 'package:my_app/view/auth/signup/widget/sign_up_email_field_widget.dart';
import 'package:my_app/view/auth/signup/widget/sign_up_name_field_widget.dart';
import 'package:my_app/view/auth/signup/widget/sign_up_password_field_widget.dart';
import 'package:my_app/view/auth/signup/widget/sign_up_phone_field_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late SignUpBloc signUpBloc;

  @override
  void initState() {
    super.initState();
    signUpBloc = SignUpBloc(loginRepository: getIt());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => signUpBloc,
        child: PopScope(
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 14.0, vertical: 10.0),
                child: Form(
                  key: _formKey,
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
                      // Todo SignUp Name Field Widget
                      const SignUpNameFieldWidget(),
                      SizedBox(height: context.height * 0.02),
                      // Todo SignUp Email Field Widget
                      const SignUpEmailFieldWidget(),
                      SizedBox(height: context.height * 0.02),
                      // Todo SignUp Phone Number Field Widget
                      const SignUpPhoneNumberFieldWidget(),
                      SizedBox(height: context.height * 0.02),
                      // Todo SignUp Password Field Widget
                      const SignUpPasswordFieldWidget(),
                      SizedBox(height: context.height * 0.04),
                      BlocListener<SignUpBloc, SignUpState>(
                        listenWhen: (previous, current) =>
                            previous.postApiStatus != current.postApiStatus,
                        listener: (context, state) {
                          if (state.postApiStatus == PostApiStatus.success) {
                            Navigator.pushNamedAndRemoveUntil(context,
                                RouteName.loginScreenName, (route) => false);
                            Utils.showToast(state.message);
                          } else if (state.postApiStatus ==
                              PostApiStatus.error) {
                            Utils.showToast(state.message);
                          }
                        },
                        child: BlocBuilder<SignUpBloc, SignUpState>(
                            buildWhen: (previous, current) =>
                                previous.postApiStatus != current.postApiStatus,
                            builder: (context, state) {
                              return Button(
                                loading: state.postApiStatus ==
                                    PostApiStatus.loading,
                                title: context.localizations!.signUp,
                                onTap: () {
                                  final validate =
                                      _formKey.currentState!.validate();
                                  if (!validate) return;
                                  if (validate) {
                                    Utils.hideKeyboard();
                                    context
                                        .read<SignUpBloc>()
                                        .add(const SignUpButton());
                                  }
                                },
                                showRadius: true,
                              );
                            }),
                      ),
                      SizedBox(height: context.height * 0.01),
                      Row(
                        children: [
                          BlocBuilder<SignUpBloc, SignUpState>(
                              builder: (context, state) {
                            return Checkbox(
                              visualDensity: VisualDensity.compact,
                              side: const BorderSide(
                                  color: AppColors.secondaryTextColor),
                              activeColor: AppColors.secondaryTextColor,
                              value: state.isCheckBox,
                              onChanged: (value) {
                                context
                                    .read<SignUpBloc>()
                                    .add(const CheckBoxVisibleOrNot());
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
                                text:
                                    "${context.localizations!.termsCondition} ",
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
                                text:
                                    "${context.localizations!.privacyPolicy} ",
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
                          Navigator.pushNamedAndRemoveUntil(context,
                              RouteName.loginScreenName, (route) => false);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                "${context.localizations!.alreadyHaveAccount} ",
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
        ),
      ),
    );
  }
}
