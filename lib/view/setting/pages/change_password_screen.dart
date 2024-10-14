import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/bloc/auth/password/password_bloc.dart';
import 'package:my_app/bloc/auth/password/password_event.dart';
import 'package:my_app/bloc/auth/password/password_state.dart';
import 'package:my_app/common/button.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/enums/enums.dart';
import 'package:my_app/extension/localization_extension.dart';
import 'package:my_app/utils/utils.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final currentPassword = TextEditingController();
  final password = TextEditingController();
  final confirmNewPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool obSecure1 = false;
  bool obSecure2 = false;
  bool obSecure3 = false;

  save() {
    final validate = _formKey.currentState!.validate();
    if (!validate) return;
    if (validate) {
      context.read<ChangePasswordBloc>().add(ChangePassword(
          confirmPassword: confirmNewPassword.text,
          currentPassword: currentPassword.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            context.localizations!.change_password,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.black),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.secondaryTextColor,
                size: 18.sp,
              )),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.localizations!.current_password,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.black),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextFormField(
                        obscureText: obSecure1,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "${context.localizations!.password} is required";
                          }
                          return null;
                        },
                        controller: currentPassword,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obSecure1 = !obSecure1;
                                });
                              },
                              icon: Icon(
                                obSecure1
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: AppColors.lightGrey,
                              )),
                          hintText: context.localizations!.current_password,
                          hintStyle:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(),
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(),
                          enabledBorder: const OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        context.localizations!.new_password,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.black),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextFormField(
                        obscureText: obSecure2,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "${context.localizations!.password} is required";
                          }
                          return null;
                        },
                        controller: password,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black),
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obSecure2 = !obSecure2;
                                  });
                                },
                                icon: Icon(
                                  obSecure2
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: AppColors.lightGrey,
                                )),
                            hintText: context.localizations!.new_password,
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(),
                            enabledBorder: const OutlineInputBorder(),
                            isDense: true),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        context.localizations!.confirm_new_password,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.black),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextFormField(
                        obscureText: obSecure3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "${context.localizations!.confirmPassword} is required";
                          } else if (value != password.text) {
                            // Check if the confirm password matches the new password
                            return context.localizations!
                                .passwordDontMatch; // Show an error if they don't match
                          }
                          return null;
                        },
                        controller: confirmNewPassword,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black),
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obSecure3 = !obSecure3;
                                  });
                                },
                                icon: Icon(
                                  obSecure3
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: AppColors.lightGrey,
                                )),
                            hintText:
                                context.localizations!.confirm_new_password,
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(),
                            enabledBorder: const OutlineInputBorder(),
                            isDense: true),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      BlocListener<ChangePasswordBloc, ChangePasswordState>(
                        listener: (context, state) {
                          if (state.postApiStatus == PostApiStatus.success) {
                            Utils.showToast(state.message);
                            currentPassword.clear();
                            confirmNewPassword.clear();
                            password.clear();
                          } else if (state.postApiStatus ==
                              PostApiStatus.error) {
                            Utils.showToast(state.message);
                          }
                        },
                        child: BlocBuilder<ChangePasswordBloc,
                            ChangePasswordState>(
                          builder: (context, state) {
                            return Button(
                              loading:
                                  state.postApiStatus == PostApiStatus.loading,
                              showRadius: true,
                              title: context.localizations!.change_password,
                              onTap: () {
                                save();
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
