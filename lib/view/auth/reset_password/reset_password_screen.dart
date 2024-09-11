import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/button.dart';
import 'package:my_app/common/custom_appbar.dart';
import 'package:my_app/common/text_field_widget.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/extension/localization_extension.dart';
import 'package:my_app/extension/media_query_extension.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController newpasswordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();

  ValueNotifier<bool> newPasswordNotifier = ValueNotifier<bool>(false);
  ValueNotifier<bool> confirmPasswordNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
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
              ValueListenableBuilder(
                  valueListenable: newPasswordNotifier,
                  builder: (context, data, _) {
                    return TextFieldWidget(
                        obSecure: newPasswordNotifier.value,
                        suffixIcon: IconButton(
                            onPressed: () {
                              newPasswordNotifier.value =
                                  !newPasswordNotifier.value;
                            },
                            icon: Icon(
                              newPasswordNotifier.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColors.lightGrey,
                            )),
                        isElevation: false,
                        hintText:  context.localizations!.newPassword,
                        textEditingController: newpasswordController,
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
              ValueListenableBuilder(
                  valueListenable: confirmPasswordNotifier,
                  builder: (context, data, _) {
                    return TextFieldWidget(
                        obSecure: confirmPasswordNotifier.value,
                        suffixIcon: IconButton(
                            onPressed: () {
                              confirmPasswordNotifier.value =
                                  !confirmPasswordNotifier.value;
                            },
                            icon: Icon(
                              confirmPasswordNotifier.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: AppColors.lightGrey,
                            )),
                        isElevation: false,
                        hintText: context.localizations!.confirmPassword,
                        textEditingController: confirmpasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "${context.localizations!.confirmPassword} is required";
                          }
                          return null;
                        });
                  }),
              SizedBox(
                height: context.height * 0.02,
              ),
              Button(
                title: context.localizations!.verify,
                onTap: () {
                  Navigator.pushNamed(context, RouteName.successScreenName);
                },
                showRadius: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
