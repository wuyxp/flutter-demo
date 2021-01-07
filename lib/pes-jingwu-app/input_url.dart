import 'package:flutter/material.dart';

class InputUrl extends StatefulWidget {
  @override
  InputUrlState createState() {
    return InputUrlState();
  }
}

class InputUrlState extends State {
  // String url = 'http://';
  String url = 'http://192.168.1.55:8080/';
  @override
  Widget build(BuildContext context) {
    Color c = Colors.orange;
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.ltr,
        child:
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(
                          color: c,
                        ),
                        initialValue: url,
                        decoration: InputDecoration(
                          icon: Icon(Icons.anchor, color: c,),
                          focusColor: c,
                          hoverColor: c,
                          fillColor: c,
                          labelText: '项目地址',
                          labelStyle: TextStyle(color: c),
                        ),
                        onChanged: (value){
                          this.url = value;
                        },
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        height: 50,
                        child: RaisedButton.icon(
                          color: c,
                          icon: Icon(Icons.accessible_forward, color: Colors.white,),
                          label: Text("跳转到 webView", style: TextStyle(color: Colors.white),),
                          onPressed: () {
                            print("需要跳转的url是 ---->  $url");
                            Navigator.of(context).pushNamed('/webview', arguments: url);
                          }
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ,),
    );
  }
}

// stl 快速生成 无状态组件

// stf  快速生成 状态 组件

// alt + enter  使用在组件上面表示快速包裹， 使用在widget上面表示要更换类型

// alt + ctrl + b 通过抽象类，找到实现这个抽象类的子类

// alt + enter + w 抽取build内部的组件形成一个新的Widget ,这个快捷键可能有冲突

// 经过看 image 的统一构造函数，和image.network 构造函数，对Vue和react 组件也有了启发， 比如写一个 BasePanel 作为基础组件，另外写一个 BasePanel.Car 和 BasePanel.Persion 作为应用组件去继承基础组件
// 本地静态 image 在项目中引用是，pubspec中 只需要引入 - asset/images/ 这样的通配符即可

// 使用 ButtonTheme 来包裹 Button 来处理默认样式，尤其是宽高

// 使用Theme ，Theme里面有一个 ThemeData 属性，可以去设置输入边框的颜色和好多样式设置。

// MediaQuery.of(Content).size.width  这样可以获取主屏幕的宽高之类数据

// 特殊的widget ， ListTile  系统自带的滚动列表样式展示, Divider 系统自带的分割线

// Sliver listView 和 girdView 本质都是用的这个widget

// safearea 安全区域 针对于苹果刘海屏

// List.generate(count, (){})  这个生成指定数量的列表

// 在类上 直接点 ctrl + n 可以生成toString


// 适配方案 1. 手动调大小，2. 使用 FittedBox 可伸缩组件，3. 使用类似于 rem 的字体单位