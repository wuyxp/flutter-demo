import 'package:flutter/material.dart';

import 'utils/route-observer.dart';

import 'pages/home.dart';
import 'pages/trending.dart';
import 'pages/favorite.dart';

import 'pages/detail.dart';
import 'pages/buy.dart';
import 'pages/login.dart';

import 'pages/unknown.dart';

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
      routes: {
        "/home": (context){
            return Home();
          },
        '/favorite': (context){
          return Favorite();
        },
        '/trending': (context) => Trending(),
        '/detail': (context) => Detail()
      },
      initialRoute: "/home",
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
