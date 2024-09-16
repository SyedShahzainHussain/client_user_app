import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/bloc/auth/check_authentication/check_authentiaction_bloc.dart';
import 'package:my_app/config/image_string.dart';
import 'package:my_app/extension/media_query_extension.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CheckAuthentiactionBloc>().add(CheckAuthentiaction(context));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          alignment: Alignment.center,
          ImageString.logoImage,
          width: context.width * .7,
        ),
      ),
    );
  }
}
