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
        body: Column(children: [
          ButtenDemo(),
          EeeText(),
          DemoText(),
          DemoText('我是传递参数'),
        ],),
        backgroundColor: Colors.greenAccent,
      ),
    );
  }
}

class ButtenDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flex(
      mainAxisAlignment: MainAxisAlignment.center,
      direction: Axis.vertical,
      children: [
        FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            print('FloatingActionButton');
          }
        ),
        RaisedButton(
          child: Text("这是普通按钮"),
          onPressed: () {
            print('RaisedButton');
          }
        ),
        FlatButton(onPressed: (){}, child: Text("flat, text")),
        OutlineButton(onPressed: (){}, child: Text('光的按钮', style: TextStyle(color: Colors.deepOrange, fontSize: 23),),),
        RaisedButton.icon(
          onPressed: (){},
          icon: Icon(Icons.print),
          label: Text('有icon的按钮'),
          highlightColor: Colors.yellow,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ],
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
  // DemoText([this.title = '我是默认参数']);
  DemoText([title]): this.title = title ?? '我是默认参数';
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
