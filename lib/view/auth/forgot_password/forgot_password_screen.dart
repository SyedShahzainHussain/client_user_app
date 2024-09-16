import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/bloc/auth/forgot/forgot_bloc.dart';
import 'package:my_app/common/button.dart';
import 'package:my_app/common/custom_appbar.dart';
import 'package:my_app/common/text_field_widget.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/extension/localization_extension.dart';
import 'package:my_app/extension/media_query_extension.dart';
import 'package:my_app/utils/utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                    child: FittedBox(
                      child: Text(
                        context.localizations!.forgotPassword,
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
                    context.localizations!.forgotPasswordSubTitle,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: AppColors.black),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: context.height * 0.20,
                  ),
                  TextFieldWidget(
                      onChanged: (value) =>
                          context.read<ForgotBloc>().add(ChangeEmail(value)),
                      isElevation: false,
                      hintText: context.localizations!.emailIdOrPhoneNumber,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "${context.localizations!.emailIdOrPhoneNumber} is requried";
                        }
                        return null;
                      }),
                  SizedBox(
                    height: context.height * 0.03,
                  ),
                  BlocListener<ForgotBloc, ForgotState>(
                    listenWhen: (previous, current) =>
                        previous.postApiStatus != current.postApiStatus,
                    listener: (context, state) {
                      if (state.postApiStatus == PostApiStatus.success) {
                        Navigator.pushNamed(context, RouteName.otpScreenName);
                        Utils.showToast(state.message);
                      } else if (state.postApiStatus == PostApiStatus.error) {
                        Utils.showToast(state.message);
                      }
                    },
                    child: BlocBuilder<ForgotBloc, ForgotState>(
                      buildWhen: (previous, current) =>
                          previous.postApiStatus != current.postApiStatus,
                      builder: (context, state) {
                        return Button(
                          loading: state.postApiStatus == PostApiStatus.loading,
                          title: context.localizations!.submit,
                          onTap: () {
                            final validate = _formkey.currentState!.validate();
                            if (!validate) return;
                            if (validate) {
                              context.read<ForgotBloc>().add(ForgotButton());
                            }
                          },
                          showRadius: false,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
