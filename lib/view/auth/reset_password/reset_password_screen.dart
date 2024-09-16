import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/bloc/auth/forgot/forgot_bloc.dart';
import 'package:my_app/bloc/auth/reset/reset_bloc.dart';
import 'package:my_app/bloc/auth/reset/reset_event.dart';
import 'package:my_app/bloc/auth/reset/reset_state.dart';
import 'package:my_app/common/button.dart';
import 'package:my_app/common/custom_appbar.dart';
import 'package:my_app/common/text_field_widget.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/extension/localization_extension.dart';
import 'package:my_app/extension/media_query_extension.dart';
import 'package:my_app/main.dart';

import '../../../utils/utils.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late ResetBloc resetBloc;

  @override
  void initState() {
    super.initState();
    resetBloc = ResetBloc(apiRepository: getIt());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => resetBloc,
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                    child: FittedBox(
                      child: Text(
                        context.localizations!.resetPassword,
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 24.sp,
                            color: AppColors.secondaryTextColor),
                        maxLines: 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: context.height * 0.02,
                  ),
                  Text(
                    context.localizations!.resetPasswordSubTitle,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: AppColors.black),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: context.height * 0.20),
                  BlocBuilder<ForgotBloc, ForgotState>(
                      buildWhen: (previous, current) =>
                          previous.passwordVisible != current.passwordVisible,
                      builder: (context, state) {
                        return TextFieldWidget(
                            onChanged: (value) => context
                                .read<ForgotBloc>()
                                .add(ChangePassword(value)),
                            obSecure: state.passwordVisible,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  context
                                      .read<ForgotBloc>()
                                      .add(PasswordIsVisible());
                                },
                                icon: Icon(
                                  state.passwordVisible
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: AppColors.lightGrey,
                                )),
                            isElevation: false,
                            hintText: context.localizations!.newPassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "${context.localizations!.newPassword} is required";
                              }
                              return null;
                            });
                      }),
                  SizedBox(
                    height: context.height * 0.02,
                  ),
                  BlocBuilder<ForgotBloc, ForgotState>(
                      buildWhen: (previous, current) =>
                          previous.confirmPasswordVisible !=
                              current.confirmPasswordVisible ||
                          previous.confirmPassword != current.confirmPassword ||
                          previous.password != current.password,
                      builder: (context, state) {
                        return TextFieldWidget(
                            onChanged: (value) => context
                                .read<ForgotBloc>()
                                .add(ChangeConfirmPassword(value)),
                            obSecure: state.confirmPasswordVisible,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  context
                                      .read<ForgotBloc>()
                                      .add(ConfirmPasswordIsVisible());
                                },
                                icon: Icon(
                                  state.confirmPasswordVisible
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: AppColors.lightGrey,
                                )),
                            isElevation: false,
                            hintText: context.localizations!.confirmPassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "${context.localizations!.confirmPassword} is required";
                              } else if (value != state.password) {
                                return context.localizations!.passwordDontMatch;
                              }
                              return null;
                            });
                      }),
                  SizedBox(
                    height: context.height * 0.02,
                  ),
                  BlocListener<ResetBloc, ResetState>(
                    listenWhen: (previous, current) =>
                        previous.postApiStatus != current.postApiStatus &&
                        previous.message != current.message,
                    listener: (context, state) {
                      if (state.message.isNotEmpty) {
                        if (state.postApiStatus == PostApiStatus.success) {
                          Navigator.pushNamedAndRemoveUntil(context,
                              RouteName.successScreenName, (route) => false);
                        } else if (state.postApiStatus == PostApiStatus.error) {
                          Utils.showToast(state.message);
                        }
                      }
                    },
                    child: BlocBuilder<ResetBloc, ResetState>(
                      buildWhen: (previous, current) =>
                          previous.postApiStatus != current.postApiStatus,
                      builder: (context, state) {
                        return Button(
                          loading: state.postApiStatus == PostApiStatus.loading,
                          title: context.localizations!.verify,
                          onTap: () {
                            final validate = _formKey.currentState!.validate();
                            if (!validate) return;
                            if (validate) {
                              context
                                  .read<ResetBloc>()
                                  .add(ResetApiEvent(context));
                            }
                          },
                          showRadius: false,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
