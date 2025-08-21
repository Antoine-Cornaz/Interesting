import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class BezierShape {
  final List<BezierCurve> points = [];
  double moveX = 0;
  double scaleX = 1;
  double moveY = 0;
  double scaleY = 1;

  BezierShape();

  void addPoint(BezierCurve point) {
    points.add(point);
  }

  void draw(Path path, size) {
    var minX = points
        .map((p) => p.x3)
        .reduce((value, element) => min(value, element));
    var minY = points
        .map((p) => p.y3)
        .reduce((value, element) => min(value, element));
    var maxX = points
        .map((p) => p.x3)
        .reduce((value, element) => max(value, element));
    var maxY = points
        .map((p) => p.y3)
        .reduce((value, element) => max(value, element));

    moveX = minX;
    moveY = minY;

    scaleX = (maxX - minX) / size.width;
    scaleY = (maxY - minY) / size.height;

    path.moveTo(
      applyTransformationX(points[points.length - 1].getX3()),
      applyTransformationY(points[points.length - 1].getY3()),
    );

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

class BezierCurve {
  final double x1;
  final double y1;
  final double x2;
  final double y2;
  final double x3;
  final double y3;

  double getX1() {
    return x1;
  }

  double getY1() {
    return y1;
  }

  double getX2() {
    return x2;
  }

  double getY2() {
    return y2;
  }

  double getX3() {
    return x3;
  }

  double getY3() {
    return y3;
  }

  BezierCurve(this.x1, this.y1, this.x2, this.y2, this.x3, this.y3);
}
