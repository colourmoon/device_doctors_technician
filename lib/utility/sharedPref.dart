import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future<String> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString(key.toString()).toString();
    return stringValue;
  }

  Future<bool> setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    Future<bool> stringValue = prefs.setString(key, value);
    return stringValue;
  }

  Future<bool> remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    Future<bool> stringValue = prefs.remove(key);
    return stringValue;
  }
}
