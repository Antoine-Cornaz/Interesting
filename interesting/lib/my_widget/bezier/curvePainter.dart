import 'package:flutter/material.dart';
import 'myBezier.dart';

class CurvePainter extends CustomPainter {
  final Color color2;
  final bool stroke;
  final BezierShape bc;
  CurvePainter(this.stroke, this.color2, this.bc);

  @override
  void paint(Canvas canvas, size) {
    canvas.drawPaint(
      Paint()..color = Color(0x00000000),
    ); // Background color transparent
    var paint = Paint();
    paint.color = color2;
    paint.style = PaintingStyle.fill;
    if (stroke) {
      paint.strokeWidth = 10.0;
      paint.style = PaintingStyle.stroke;
    }

    var path = Path();
    bc.draw(path, size);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
