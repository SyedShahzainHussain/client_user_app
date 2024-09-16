
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/bloc/auth/sign_up/sign_up_bloc.dart';
import 'package:my_app/common/text_field_widget.dart';
import 'package:my_app/config/image_string.dart';
import 'package:my_app/extension/localization_extension.dart';

class SignUpEmailFieldWidget extends StatelessWidget {
  const SignUpEmailFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      onChanged: (value) =>
          context.read<SignUpBloc>().add(EmailChange(value.toString())),
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
    );
  }
}
