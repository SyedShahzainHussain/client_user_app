import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM, // Position at bottom
      backgroundColor: Colors.black45,
      textColor: Colors.white,
    );
  }

  static bool isExtraSmallMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= 350;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= 500 &&
      MediaQuery.of(context).size.width > 350;

  static bool isMobileLarge(BuildContext context) =>
      MediaQuery.of(context).size.width <= 700 &&
      MediaQuery.of(context).size.width >= 500;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width > 700 &&
      MediaQuery.of(context).size.width < 1024;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;



  static hideKeyboard(){
    FocusManager.instance.primaryFocus?.unfocus();
  }

}
