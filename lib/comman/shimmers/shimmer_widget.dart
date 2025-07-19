import 'package:flutter/material.dart';
import 'package:device_doctors_technician/comman/shimmers/shimmer.dart';

Shimmer buildSimmer1(
    {required double height,
    required double width,
    BorderRadiusGeometry radius =
        const BorderRadius.all(Radius.circular(15.0))}) {
  return Shimmer.fromColors(
    baseColor: const Color(0xffF8F8FF),
    highlightColor: const Color(0xcae7e7ee),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        color: const Color(0xffF8F8FF),
      ),
      height: height,
      width: width,
    ),
  );
}
