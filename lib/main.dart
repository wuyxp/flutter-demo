import 'package:flutter/material.dart';

import 'utils/route-observer.dart';

import 'pages/home.dart';
import 'pages/trending.dart';
import 'pages/favorite.dart';

import 'pages/detail.dart';
import 'pages/buy.dart';
import 'pages/login.dart';

import 'pages/bottom_tab.dart';

import 'pages/unknown.dart';

import 'animation/base.dart';
import 'animation/bezier.dart';
import 'animation/extend_animated.dart';
import 'animation/animated_container.dart';

import 'animation/hreo_wy.dart';
import 'animation/hreo_detail.dart';

import 'event/pointer.dart';
import 'event/gesture.dart';
import 'event/event_bus_demo.dart';

void main() {
  runApp(
    MyApp()
  );
}
final RouteObserver routeObserver = RouteObserver();

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "测试 Demo",
      theme: ThemeData(
        primaryColor: Colors.orange
      ),
      routes: {
        "/home": (context){
            return Home();
          },
        '/favorite': (context){
          return Favorite();
        },
        '/trending': (context) => Trending(),
        '/detail': (context) => Detail(),
        '/bottomTab':(context) => BottomTab(),
        '/animation/base': (context) => AnimationBase(),
        '/animation/bezier': (context) => AnimationBezier(),
        '/animation/extend_animated': (context) => ExtendAnimated(),
        '/animation/animated_container': (context) => AnimatedContainerEx(),

        '/hreo': (context) => HreoWY(),
        '/hreo/detail': (context) =>HreoDetail(),

        '/event/pointer': (context) => PointerDemo(),
        '/event/gesture': (context) => GestureDemo(),
        '/event/bus': (context) => EventBusDemo(),
      },
      initialRoute: "/event/bus",
      navigatorObservers: [routeObserver, MyRouteObserve()],
      onGenerateRoute: (RouteSettings rs) {
        if (rs.name == '/favorite/detail') {
          return MaterialPageRoute(
            builder: (context){
              return Favorite();
            },
            settings: RouteSettings(
              arguments: rs.arguments
            )
          );
        } else if (rs.name == '/buy') {
          dynamic arg = rs.arguments ?? {};
          if(arg['id'] == null) {
            return MaterialPageRoute(
              builder: (context){
                return Login();
              }
            );
          } else {
            return MaterialPageRoute(
              builder: (context) {
                return Buy();
              },
              settings: RouteSettings(
                arguments: rs.arguments
              )
            );
          }
        }
        return null;
      },
      onUnknownRoute: (RouteSettings rs) {
        return MaterialPageRoute(
          builder: (context) {
            return Unknown();
          }
        );
      },
    );
  }
}
