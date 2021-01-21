import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("返回到首页"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("我是商品详情"),
              FlatButton.icon(
                onPressed: (){
                  Navigator.of(context).pushNamed('/buy');
                },
                icon: Icon(Icons.baby_changing_station),
                label: Text("开始买")
              )
            ],
          ),
        ),
      ),
    );
  }
}
