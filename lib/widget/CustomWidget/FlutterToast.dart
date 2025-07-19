import 'package:flutter/material.dart';

class CustomToast {
  static show(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'ProximaNova',
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Colors.black,
        elevation: 8.0,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      ),
    );
  }
}

noOrdersImage() {
  return Center(
    child: Image.asset(
      "assets/FoodRestaurant/noorders.png",
      height: 200,
      width: 200,
    ),
  );
}
