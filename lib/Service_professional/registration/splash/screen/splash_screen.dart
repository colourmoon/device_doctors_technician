import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../baseScreen/base_auth_screen.dart';
import '../../../commons/color_codes.dart';

class SrvicesSplashScreen extends StatefulWidget {
  const SrvicesSplashScreen({super.key});

  @override
  State<SrvicesSplashScreen> createState() => _SrvicesSplashScreenState();
}

class _SrvicesSplashScreenState extends State<SrvicesSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceInOut, // Using 'easeOut' curve for the animation
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut, // Using 'easeOut' curve for the animation
      ),
    );

    _controller.forward();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(
          builder: (context) => const BaseScreen(),
        ),
        (route) => false,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration:   BoxDecoration(
        color: AppthemeColor().appMainColor,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/FoodRestaurant/splash.png",

              fit: BoxFit.cover, // Ensures the image covers the entire screen
            ),
          ),
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Opacity(
                    opacity: _opacityAnimation.value,
                    child: child,
                  ),
                );
              },
              // child: Center(
              //     child: Image.asset(
              //   "",
              //   height: 100,
              //   width: 100,
              // )),
            ),
          ),
        ],
      ),
    ));
  }
}
