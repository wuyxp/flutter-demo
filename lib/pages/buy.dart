import 'package:flutter/material.dart';

class Buy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("购物车"),
      ),
      body: Container(
        child: Center(
          child: FlatButton.icon(
              onPressed: (){
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.icecream),
              label: Text("购买成功，返回详情页面")
          ),
        ),
      ),
    );
  }
}
