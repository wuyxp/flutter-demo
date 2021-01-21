import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final widget;
  BottomNavigation(this.widget):super(key: UniqueKey());
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings rs){
        print(widget);
        return MaterialPageRoute(
          builder:(context) {
            return widget;
          }
        );
      },
    );
  }
}
