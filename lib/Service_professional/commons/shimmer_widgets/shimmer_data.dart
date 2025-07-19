import 'package:flutter/material.dart';

import '../../../comman/shimmers/shimmer.dart';

Shimmer buildSimmer({required Widget child}) {
  return Shimmer.fromColors(
    baseColor: const Color(0xffF8F8FF),
    highlightColor: const Color(0xcae7e7ee),
    child: child,
  );
}

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

Shimmer orderShimmer(
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

Shimmer buildSimmer2(
    {required double height,
    required double width,
    BorderRadiusGeometry radius =
        const BorderRadius.all(Radius.circular(15.0))}) {
  return Shimmer.fromColors(
    baseColor: const Color(0x9ef8f8ff),
    highlightColor: const Color(0x34e7e7ee),
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
