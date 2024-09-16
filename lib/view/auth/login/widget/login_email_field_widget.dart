import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/bloc/auth/login/login_bloc.dart';
import 'package:my_app/common/text_field_widget.dart';
import 'package:my_app/config/image_string.dart';
import 'package:my_app/extension/localization_extension.dart';

class LoginEmailFieldWidget extends StatelessWidget {
  const LoginEmailFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      isElevation: false,
      onChanged: (value) => context.read<LoginBloc>().add(EmailChange(value)),
      hintText: context.localizations!.email,
      prefixIcon: IconButton(
          onPressed: () {}, icon: SvgPicture.asset(ImageString.email)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "${context.localizations!.email} is required";
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
    );
  }
}
