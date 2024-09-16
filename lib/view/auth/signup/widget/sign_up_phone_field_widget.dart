
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/bloc/auth/sign_up/sign_up_bloc.dart';
import 'package:my_app/common/text_field_widget.dart';
import 'package:my_app/config/image_string.dart';
import 'package:my_app/extension/localization_extension.dart';

class SignUpPhoneNumberFieldWidget extends StatelessWidget {
  const SignUpPhoneNumberFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      onChanged: (value) => context
          .read<SignUpBloc>()
          .add(PhoneNumberChange(value.toString())),
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
    );
  }
}
