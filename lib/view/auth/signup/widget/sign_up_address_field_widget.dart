import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/bloc/auth/sign_up/sign_up_bloc.dart';
import 'package:my_app/common/text_field_widget.dart';
import 'package:my_app/config/image_string.dart';
import 'package:my_app/extension/localization_extension.dart';

class SignUpAddressFieldWidget extends StatelessWidget {
  const SignUpAddressFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      onChanged: (value) =>
          context.read<SignUpBloc>().add(AddresssChange(value.toString())),
      hintText: context.localizations!.address,
      prefixIcon: IconButton(
          onPressed: () {}, icon: SvgPicture.asset(ImageString.email)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "${context.localizations!.address} is required";
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
    );
  }
}
