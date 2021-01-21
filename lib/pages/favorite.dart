import 'package:flutter/material.dart';

import '../main.dart';

class Favorite extends StatefulWidget{

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> with RouteAware  {
  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context));
    super.didChangeDependencies();
  }
  @override
  void didPop() {
    print('didPop-------->');
    super.didPop();
  }

  @override
  void didPush() {
    print('didPush-------->');
    super.didPush();
  }

  @override
  void didPopNext() {
    print('didPopNext-------->');
    super.didPopNext();
  }

  @override
  void didPushNext() {
    print('didPushNext-------->');
    super.didPushNext();
  }

  @override
  Widget build(BuildContext context) {
    Map params = ModalRoute.of(context).settings.arguments;
    print(params);
    String str = params != null ? params['abc'] : '我是默认参数';
    return Scaffold(
      appBar: AppBar(
        title: Text("收藏夹"),
      ),
      body: Container(
        child: Center(
          child: Text("收藏夹---->$str"),
        ),
      ),
    );
  }
}
