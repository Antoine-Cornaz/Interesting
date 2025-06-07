import 'package:flutter/material.dart';
import 'curvePainter.dart';
import 'myBezier.dart';

class Wave extends StatelessWidget {
  const Wave({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final filledColor = Color.lerp(
      Colors.white,
      colorScheme.surfaceTint,
      60.0 / 255,
    )!;
    final borderColor = colorScheme.onPrimaryContainer;

    BezierShape bc = BezierShape();
    bc.addPoint(BezierCurve(0, 29, 0, 29, 0, 29));
    bc.addPoint(BezierCurve(24, 29, 93, -18, 150, -18));
    bc.addPoint(BezierCurve(207, -18, 273, 23, 331, 24));
    bc.addPoint(BezierCurve(393, 24, 434, 0, 496, 0));
    bc.addPoint(BezierCurve(561, 0, 610, 24, 674, 24));
    bc.addPoint(BezierCurve(735, 23, 791, 0, 853, 0));
    bc.addPoint(BezierCurve(928, 0, 1000, 29, 1133, 29));

    return CustomPaint(
      painter: CurvePainter(true, borderColor, bc),
      child: CustomPaint(painter: CurvePainter(false, filledColor, bc)),
    );
  }
}