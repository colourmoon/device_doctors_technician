import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:device_doctors_technician/utility/sharedPref.dart';

class ThemeToast extends Fluttertoast {
  void SuccessToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void ErrorToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

class commonTexts {
  String? accessToken;
  accessTokenFun() async {
    accessToken = await SharedPref().getString("access_token");
  }
}
