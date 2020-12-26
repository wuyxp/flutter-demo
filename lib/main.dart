import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '基础widget',
      home: Scaffold(
        // body: DemoText('我是测试文件'),
        body: EeeText(),
        backgroundColor: Colors.greenAccent,
      ),
    );
  }
}

class EeeText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text.rich(
        TextSpan(text: '咏鹅', children: [
            TextSpan(text: '\n鹅   鹅   鹅  ，'),
            TextSpan(text: '曲项向天歌。'),
            TextSpan(text: '\n白毛浮绿水，'),
            TextSpan(text: '红掌拨清波。'),
          ],
          style: TextStyle(fontSize: 22, color: Colors.deepOrange, fontWeight: FontWeight.bold),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class DemoText extends StatelessWidget {
  final String title;
  DemoText(this.title);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: TextStyle(
          color: Colors.yellow,
          fontSize: 20,
        ),
      ),
    );
  }
}
