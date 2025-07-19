import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:device_doctors_technician/comman/shimmers/shimmer.dart';

class NetworkImageWidget extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  const NetworkImageWidget(
      {super.key, required this.image, this.height, this.width, this.fit});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      fit: fit ?? BoxFit.cover,
      height: height,
      imageUrl: image.toString(),
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          Shimmer.fromColors(
        baseColor: const Color(0xffF8F8FF),
        highlightColor: const Color(0xcae7e7ee),
        child: Container(
          color: Colors.white,
        ),
      ),
      errorWidget: (context, url, error) => Builder(
        builder: (context) {
          log(url);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/device_doctor.png',
              fit: BoxFit.fill,

            ),
          );
        }
      ),
    );
  }
}
