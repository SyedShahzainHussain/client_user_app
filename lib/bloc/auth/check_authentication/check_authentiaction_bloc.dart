import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_app/config/routes/route_name.dart';
import 'package:my_app/services/session_controller_services.dart';
import 'package:my_app/services/storage/local_storage.dart';

part 'check_authentiaction_event.dart';
part 'check_authentiaction_state.dart';

class CheckAuthentiactionBloc
    extends Bloc<CheckAuthentiactionEvent, CheckAuthentiactionState> {
  CheckAuthentiactionBloc() : super(CheckAuthentiactionInitial()) {
    on<CheckAuthentiaction>(_checkAuthentication);
  }

  _checkAuthentication(
      CheckAuthentiaction event, Emitter<CheckAuthentiactionState> emit) async {
    final String provider = await LocalStorage().readValue("provider")??"";

    if (provider == "google") {
      Timer(
        const Duration(seconds: 3),
        () {
          Navigator.pushNamedAndRemoveUntil(
              event.context, RouteName.entryScreenName, (route) => false);
        },
      );
    } else {
      await SessionController().getUserPrefrences().then((data) {
        if (SessionController().isLogin ?? false) {
          Timer(
            const Duration(seconds: 3),
            () {
              Navigator.pushNamedAndRemoveUntil(
                  event.context, RouteName.entryScreenName, (route) => false);
            },
          );
        } else {
          Timer(
            const Duration(seconds: 3),
            () {
              Navigator.pushNamedAndRemoveUntil(
                  event.context, RouteName.loginScreenName, (route) => false);
            },
          );
        }
      }).onError((error, _) {
        Timer(
          const Duration(seconds: 3),
          () {
            Navigator.pushNamedAndRemoveUntil(
                event.context, RouteName.loginScreenName, (route) => false);
          },
        );
      });
    }
  }
}
