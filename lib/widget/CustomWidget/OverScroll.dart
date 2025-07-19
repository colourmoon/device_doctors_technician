import 'package:flutter/cupertino.dart';

class OverScrollOff extends StatelessWidget {
  OverScrollOff({super.key, required this.child});
  Widget child;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowIndicator();
          return true;
        },
        child: child);
  }
}
