import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_app/bloc/auth/login/login_bloc.dart';
import 'package:my_app/bloc/auth/social_login_bloc/social_bloc_bloc.dart';
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
import 'package:my_app/view/auth/login/widget/login_email_field_widget.dart';
import 'package:my_app/view/auth/login/widget/login_password_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    loginBloc = LoginBloc(loginRepository: getIt());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => loginBloc,
        child: BlocListener<SocialBlocBloc, SocialBlocState>(
          listener: (context, state) {
            if(state.message.isNotEmpty){

            if(state.postApiStatus==PostApiStatus.success){
              Navigator.pushNamedAndRemoveUntil(context, RouteName.entryScreenName, (route)=>false);
            }else if(state.postApiStatus==PostApiStatus.error){
              Utils.showToast(state.message);
            }
            }
          },
          child: BlocBuilder<SocialBlocBloc, SocialBlocState>(
            builder: (context, state) {
              return ModalProgressHUD(
                inAsyncCall: state.postApiStatus == PostApiStatus.loading,
                progressIndicator: const SpinKitCircle(
                  color: AppColors.redColor,
                ),
                child: PopScope(
                  canPop: false,
                  onPopInvoked: (didPop) {
                    if (!didPop) {
                      Navigator.pushNamedAndRemoveUntil(context,
                          RouteName.onBoardScreenName, (route) => false);
                    }
                  },
                  child: SingleChildScrollView(
                    child: SafeArea(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14.0, vertical: 10.0),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),

                            // Todo Back Button
                            BackButtonWidget(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    RouteName.onBoardScreenName,
                                    (route) => false);
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
                            // Todo Email Field
                            const LoginEmailFieldWidget(),
                            SizedBox(height: context.height * 0.02),
                            // Todo Password Field
                            const LoginPasswordFieldWidget(),
                            SizedBox(height: context.height * 0.01),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouteName.forgotScreenName);
                              },
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                      context.localizations!.forgotPassword,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.sp,
                                          color:
                                              AppColors.secondaryTextColor))),
                            ),
                            SizedBox(height: context.height * 0.04),
                            BlocListener<LoginBloc, LoginState>(
                              listenWhen: (previous, current) =>
                                  previous.postApiStatus !=
                                  current.postApiStatus,
                              listener: (context, state) {
                                if (state.postApiStatus ==
                                    PostApiStatus.success) {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      RouteName.entryScreenName,
                                      (route) => false);
                                  Utils.showToast(state.message);
                                } else if (state.postApiStatus ==
                                    PostApiStatus.error) {
                                  Utils.showToast(state.message);
                                }
                              },
                              child: BlocBuilder<LoginBloc, LoginState>(
                                buildWhen: (previous, current) =>
                                    previous.postApiStatus !=
                                    current.postApiStatus,
                                builder: (context, state) {
                                  return Button(
                                    loading: state.postApiStatus ==
                                        PostApiStatus.loading,
                                    title: context.localizations!.signIn,
                                    onTap: () {
                                      final validate =
                                          _formkey.currentState!.validate();
                                      if (!validate) return;
                                      if (validate) {
                                        context
                                            .read<LoginBloc>()
                                            .add(const LoginButton());
                                      }
                                    },
                                    showRadius: false,
                                  );
                                },
                              ),
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
                                    context,
                                    RouteName.signUpScreenName,
                                    (route) => false);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      "${context.localizations!.dontHaveAnAccount}  ",
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
                      ),
                    )),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
