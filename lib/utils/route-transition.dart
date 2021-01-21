import 'package:flutter/material.dart';

class RouteTransition {
  static PageRouteBuilder type1({ @required Widget child}) {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return child;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return child;
      }
    );
  }
  static PageRouteBuilder type2({ @required Widget child}) {
    return PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          return child;
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
          Offset begin = Offset(-1.0, 0.0);
          Offset end = Offset.zero;
          dynamic tween = Tween(begin: begin, end: end);
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        }
    );
  }

  static PageRouteBuilder type3({ @required Widget child}) {
    return PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          return child;
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
          var rotation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animation, curve: Curves.ease));
          return ScaleTransition(
            scale: rotation,
            child: RotationTransition(
              turns: rotation,
              child: child,
            ),
          );
        }
    );
  }

  static PageRouteBuilder type4({ @required Widget current, @required Widget next}) {
    return PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          return next;
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
          var currentTween = Tween(begin: Offset.zero, end: Offset(-1.0, 0)).animate(animation);
          var nextTween = Tween(begin: Offset(1.0, 0), end: Offset.zero).animate(animation);
          return Stack(
            children: <Widget>[
              SlideTransition(
                position: currentTween,
                child: current,
              ),
              SlideTransition(
                position: nextTween,
                child: next,
              )
            ],
          );
        }
    );
  }
}