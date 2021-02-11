import 'package:encourage_you/MyTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StarPainter extends CustomPainter {
  PaintingStyle style;

  StarPainter({this.style});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final edgeSize = size.width / 2 * 0.6;

    Paint paint = Paint()
      ..color = myColor.orange
      ..style = style
      ..strokeWidth = 1.0;

    Path path = Path();
    path.moveTo(centerX, centerY - edgeSize);
    path.quadraticBezierTo(size.width, 0, centerX + edgeSize, centerY);
    path.quadraticBezierTo(
        size.width, size.height, centerX, centerY + edgeSize);
    path.quadraticBezierTo(0, size.height, centerX - edgeSize, centerY);
    path.quadraticBezierTo(0, 0, centerX, centerY - edgeSize);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}