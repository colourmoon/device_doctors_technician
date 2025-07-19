import 'package:flutter/material.dart';

class ScaleTransitions extends PageRouteBuilder {
  final Widget page;

  ScaleTransitions({required this.page})
      : super(
    pageBuilder: (context, animation, anotherAnimation) => page,
    transitionDuration: const Duration(milliseconds:1500),
    reverseTransitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, anotherAnimation, child) {
       animation = CurvedAnimation(
        parent: animation,
        curve: Curves.fastLinearToSlowEaseIn,
        reverseCurve: Curves.fastOutSlowIn,
      );
      return ScaleTransition(
        alignment: Alignment.center,
        scale: animation,
        child: child,
      );
    },
  );
}
