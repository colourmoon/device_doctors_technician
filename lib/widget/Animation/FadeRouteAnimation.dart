import 'package:flutter/material.dart';

class FadeRoute extends PageRouteBuilder {
  final Widget page;

  FadeRoute({required this.page})
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 80),
          reverseTransitionDuration: const Duration(milliseconds: 80),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            final fadeAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.fastLinearToSlowEaseIn,
              reverseCurve: Curves.fastOutSlowIn,
            );
            return FadeTransition(
              opacity: fadeAnimation,
              child: child,
            );
          },
        );
}
