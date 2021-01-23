import 'package:flutter/animation.dart';

class Point {
  final double x;
  final double y;
  const Point(this.x, this.y);
}

class BezierTween extends Animatable<Point> {
  final Point p1;
  final Point p2;
  final Point p3;

  BezierTween(this.p1, this.p2, this.p3): assert(p1 != null), assert(p2 != null), assert(p3 != null);
  @override
  Point transform(double t) {
    double x = (1-t) * (1-t) * p1.x + 2 * t * (1-t) * p2.x + t* t * p3.x;
    double y = (1-t) * (1-t) * p1.y + 2 * t * (1-t) * p2.y + t* t * p3.y;
    return Point(x, y);
  }
}