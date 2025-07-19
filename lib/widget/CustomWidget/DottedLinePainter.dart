
import 'package:flutter/material.dart';

class DottedLinePainter extends CustomPainter {
  final Color color;

  DottedLinePainter({this.color = const Color(0xffE2E2E2)});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    final dashWidth = 3.0;
    final dashSpace = 3.0;
    double startX = 0.0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
