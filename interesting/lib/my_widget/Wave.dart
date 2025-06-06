import 'dart:math';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';


class Wave extends StatelessWidget{
  const Wave({super.key});


  @override
  Widget build(BuildContext context) {

    final colorScheme = Theme.of(context).colorScheme;
    final filledColor = colorScheme.surfaceTint.withAlpha(60);
    final borderColor = colorScheme.onPrimaryContainer;

   return CustomPaint(
     painter: CurvePainter(true, borderColor),
     child: CustomPaint(painter: CurvePainter(false, filledColor),),
   );
  }
}

class CurvePainter extends CustomPainter {

  final Color color2;
  final bool stroke;
  CurvePainter(this.stroke, this.color2);

  @override
  void paint(Canvas canvas, size) {
    canvas.drawPaint(Paint()..color = Color(0x00000000)); // Background color
    var paint = Paint();
    paint.color = color2;
    paint.style = PaintingStyle.fill;
    if (stroke){
      paint.strokeWidth = 10.0;
      paint.style = PaintingStyle.stroke;
    }


    var path = Path();
    path.moveTo(0, size.height);


    BezierCurves bc = BezierCurves();
    bc.addPoint(BezierPoint(0, 29, 0, 29, 0, 29));
    bc.addPoint(BezierPoint(24, 29, 93, -18, 150, -18));
    bc.addPoint(BezierPoint(207, -18, 273, 23, 331, 24));
    bc.addPoint(BezierPoint(393, 24, 434, 0, 496, 0));
    bc.addPoint(BezierPoint(561, 0, 610, 24, 674, 24));
    bc.addPoint(BezierPoint(735, 23, 791, 0, 853, 0));
    bc.addPoint(BezierPoint(928, 0, 1000, 29, 1133, 29));

    bc.draw(path, size);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class BezierCurves {
  final List<BezierPoint> points = [];
  double moveX = 0;
  double scaleX = 1;
  double moveY = 0;
  double scaleY = 1;

  BezierCurves();
  //BezierCurves(this.moveX, this.scaleX, this.moveY, this.scaleY);

  void addPoint(BezierPoint point) {
    points.add(point);
  }

  void draw(Path path, size) {

    var minX = points.map((p) => p.x3).reduce((value, element) => min(value, element));
    var minY = points.map((p) => p.y3).reduce((value, element) => min(value, element));
    var maxX = points.map((p) => p.x3).reduce((value, element) => max(value, element));
    var maxY = points.map((p) => p.y3).reduce((value, element) => max(value, element));

    moveX = minX;
    moveY = minY;

    scaleX = (maxX - minX) / size.width;
    scaleY = (maxY - minY) / size.height;



    for (var point in points) {
      path.cubicTo(
        applyTransformationX(point.getX1()),
        applyTransformationY(point.getY1()),
        applyTransformationX(point.getX2()),
        applyTransformationY(point.getY2()),
        applyTransformationX(point.getX3()),
        applyTransformationY(point.getY3()),
      );
    }
  }

  double applyTransformationX(double x) {
    return (x - moveX) / scaleX;
  }

  double applyTransformationY(double y) {
    return (y - moveY) / scaleY;
  }
}

class BezierPoint {
  final double x1;
  final double y1;
  final double x2;
  final double y2;
  final double x3;
  final double y3;

  double getX1(){ return x1; }
  double getY1(){ return y1; }
  double getX2(){ return x2; }
  double getY2(){ return y2; }
  double getX3(){ return x3; }
  double getY3(){ return y3; }


  BezierPoint(this.x1, this.y1, this.x2, this.y2, this.x3, this.y3);
}
