import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/bloc/auth/login/login_bloc.dart';
import 'package:my_app/common/text_field_widget.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/image_string.dart';
import 'package:my_app/extension/localization_extension.dart';

class LoginPasswordFieldWidget extends StatelessWidget {
  const LoginPasswordFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFieldWidget(
        isElevation: false,
        onChanged: (value) =>
            context.read<LoginBloc>().add(PasswordChange(value)),
        obSecure: state.isObsecure,
        hintText: context.localizations!.password,
        prefixIcon: IconButton(
            onPressed: () {}, icon: SvgPicture.asset(ImageString.lock)),
        suffixIcon: IconButton(
            onPressed: () {
              context.read<LoginBloc>().add(const PasswordVisibleOrNot());
            },
            icon: Icon(
              state.isObsecure
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: AppColors.lightGrey,
            )),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "${context.localizations!.password} is required";
          }
          return null;
        },
      );
    });
  }
}
