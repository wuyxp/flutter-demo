import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  // var bool = await _requestPermissions();
  // print(bool);
  // if (!bool) {
  //   await AppUtils.popApp();
  // } else {
    runApp(new MyApp());
  // }
}
class AppUtils {
  static Future<void> popApp() async {
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  static Future checkUpgrade() async {
    try {
      final bool result =
      await ApplicationMethodChannel.main.invokeMethod('checkUpgrade');
      print('result=$result');
    } on PlatformException {
      print('faied');
    }
  }
}
Future<bool> _requestPermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.storage,
  ].request();
  Map<Permission, PermissionStatus> requests = await statuses.keys.toList().request();
  List<bool> results = requests.values.toList().map((status) {
    if (Platform.isAndroid) {
      return status == PermissionStatus.granted;
    }else{
      return true;
    }

  }).toList();
  return !results.contains(false);
}

class ApplicationMethodChannel {
  static MethodChannel main = MethodChannel('main');
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.yellow,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: '测试图片滚动1222'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var timeout = const Duration(seconds: 3);
  int _counter = 0;

  var images = [];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _subtractionCounter() {
    setState(() {
      _counter--;
    });
  }



  Future<void> getDiskDirectory(Function callback) async {
    var bool = await _requestPermissions();
    if (!bool) {
      await AppUtils.popApp();
    } else {
      Directory directory = new Directory("/sdcard/SmartGuardTestData/3");
      directory.listSync().forEach((file) {
        print(file.path);
        images.add(file.path);
      });
      callback();
    }
  }
  TimeFunction () {
    Timer(timeout, () {
      _incrementCounter();
      TimeFunction();
    });
  }
  @override
  void initState() {
    super.initState();
    getDiskDirectory((){
      TimeFunction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            images.length > 0 ? Image.file(
              File(images[_counter.abs() % images.length]),
              width: 400,
              height: 400,
            ) : Text('请稍等'),
            false ? Text(
              'You have pushed the button this many times:',
            ) : Container(),
            false ? Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ) : Container(),
            Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: FloatingActionButton(
                    onPressed: _subtractionCounter,
                    child: Icon(Icons.remove),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text('共${images.length}张,当前是第${_counter}张'),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: _incrementCounter,
                    child: Icon(Icons.add),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
