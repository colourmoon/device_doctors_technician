import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../color_codes.dart';

class ThemeSpinner extends StatelessWidget {
  final double size;
  const ThemeSpinner({super.key, this.size = 50});

  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(
      color: Colors.black,
      size: size,
    );
  }
}

class ThemeLoadingButton extends StatelessWidget {
  final Color? color;
  final double height;
  const ThemeLoadingButton({super.key, this.color,   this.height = 50});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: () {},
        height: 50,
        minWidth: double.infinity,
        color: color ?? AppthemeColor().appMainColor,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none),
        child: const SizedBox(
            height: 12,
            width: 12,
            child: CircularProgressIndicator(
                color: Colors.white, strokeWidth: 2)));
  }
}
