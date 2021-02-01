import 'package:flutter/material.dart';

class ShareInherited extends InheritedWidget {
  final Map<String, dynamic> data;
  ShareInherited({@required this.data, @required Widget child, Key key}): super(child: child, key: key);

  static ShareInherited of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShareInherited>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}