import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import 'curvePainter.dart';
import 'myBezier.dart';

void main() => runApp(
  MaterialApp(
    home: Cloud(),
    theme: AppTheme(ThemeData.light().textTheme).light(),
  ),
);

class Cloud extends StatelessWidget {
  final Widget? child;
  const Cloud({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final filledColor = colorScheme.secondaryContainer;
    final borderColor = colorScheme.outline;

    BezierShape bc = BezierShape();
    bc.addPoint(BezierCurve(67, 5, 126, 31, 126, 31));
    bc.addPoint(BezierCurve(126, 31, 204, -2, 255, 0));
    bc.addPoint(BezierCurve(301, 1, 375, 31, 375, 31));
    bc.addPoint(BezierCurve(375, 31, 433, 6, 480, 6));
    bc.addPoint(BezierCurve(529, 5, 578, 31, 578, 31));
    bc.addPoint(BezierCurve(578, 31, 620, -16, 657, 19));
    bc.addPoint(BezierCurve(691, 50, 664, 91, 664, 91));
    bc.addPoint(BezierCurve(664, 91, 685, 131, 685, 164));
    bc.addPoint(BezierCurve(685, 196, 671, 241, 671, 241));
    bc.addPoint(BezierCurve(671, 241, 688, 290, 671, 307));
    bc.addPoint(BezierCurve(655, 323, 567, 304, 567, 304));
    bc.addPoint(BezierCurve(567, 304, 502, 318, 452, 318));
    bc.addPoint(BezierCurve(405, 317, 340, 299, 340, 299));
    bc.addPoint(BezierCurve(340, 299, 261, 327, 213, 326));
    bc.addPoint(BezierCurve(169, 325, 119, 312, 119, 312));
    bc.addPoint(BezierCurve(119, 312, 53, 343, 31, 299));
    bc.addPoint(BezierCurve(16, 268, 43, 241, 43, 241));
    bc.addPoint(BezierCurve(43, 241, 26, 199, 25, 164));
    bc.addPoint(BezierCurve(25, 128, 43, 100, 43, 100));
    bc.addPoint(BezierCurve(43, 100, 20, 56, 43, 31));

    return CustomPaint(
      painter: CurvePainter(true, borderColor, bc),
      child: CustomPaint(
        painter: CurvePainter(false, filledColor, bc),
        child: child,
      ),
    );
  }
}
