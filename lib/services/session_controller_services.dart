import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/model/user_model.dart';
import 'package:my_app/services/storage/local_storage.dart';

class SessionController {
  static final SessionController _sessionController =
      SessionController._interval();

  SessionController._interval() {
    isLogin = false;
  }

  factory SessionController() {
    return _sessionController;
  }

  UserModel userModel = UserModel();
  bool? isLogin;
  LocalStorage localStorage = LocalStorage();

  Future<void> saveUserPrefrence(dynamic user) async {
    await localStorage.setValue("token", jsonEncode(user));
    await localStorage.setValue("isLogin", "true");
  }

  Future<void> getUserPrefrences() async {
    try {
      var userData = await localStorage.readValue("token");
      var isLogin = await localStorage.readValue("isLogin");
      if (userData != null) {
        SessionController().userModel =
            UserModel.fromJson(jsonDecode(userData));
      }
      SessionController().isLogin = isLogin == "true" ? true : false;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> logout() async {
    await localStorage.clearValue("token");
    await localStorage.clearValue("isLogin");
    userModel = UserModel();
  }

  Future<bool> checkIsGoogle() async {
    final provider = await localStorage.readValue("provider") ?? "";
    if (provider == "google") {
      return true;
    } else {
      return false;
    }
  }
}
