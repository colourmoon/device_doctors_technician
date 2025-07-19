import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:device_doctors_technician/Service_professional/commons/color_codes.dart';

CommonToastwidget({required toastmessage}) {
  return Fluttertoast.showToast(
      msg: toastmessage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

CommonSuccessToastwidget({required toastmessage}) {
  return Fluttertoast.showToast(
      msg: toastmessage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppthemeColor().themecolor,
      textColor: Colors.white,
      fontSize: 16.0);
}
