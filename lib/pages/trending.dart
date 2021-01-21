import 'package:flutter/material.dart';

class Trending extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: (){
        // Navigator.of(context).pop();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.home),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          title: Text("我是热门列表"),
        ),
        body: Container(
          child: Center(
            child: Text("我是热门"),
          ),
        ),
      ),
    );
  }
}
