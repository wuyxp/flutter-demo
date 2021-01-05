import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class WebViewWidget extends StatefulWidget{
  String url;
  WebViewWidget({Key key, String url}): super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MyAppState(url: url);
  }
}
// 获取相册权限
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
// 产生保存图片随机名字
String getRandom([int len=30]){
  String alphabet = 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';
  String result = '';
  for (var i = 0; i < len; i++) {
    result = result + alphabet[Random().nextInt(alphabet.length)];
  }
  return result;
}
class _MyAppState extends State {
  WebViewController wvb;
  String url;
  _MyAppState({this.url});

  saveImage (url) async {
    var isPer = await _requestPermissions();
    if (isPer) {
      var respones = await Dio().get(url, options: Options(responseType: ResponseType.bytes));
      var result = await ImageGallerySaver.saveImage(Uint8List.fromList(respones.data), name: '${getRandom(15)}');
      print(result);
      String sResult = jsonEncode(result);
      print(sResult);
      wvb.evaluateJavascript('window.__showSaveImageHandle(\'${sResult}\')');
    } else {
      wvb.evaluateJavascript('window.__showSaveImageHandle("没有相册权限，请重新赋值权限")');
    }
  }

  @override
  void initState() {
    // _requestPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WebView.platform = SurfaceAndroidWebView();
    return WebView(
      // initialUrl: 'http://192.168.34.52:8081/captureStat',
      // initialUrl: 'http://192.168.1.55:8080/captureStat',
      // initialUrl: 'https://m.baidu.com',
      initialUrl: this.url,
      javascriptMode: JavascriptMode.unrestricted,
      onPageStarted: (url) {
        print('on page started ------> $url');
      },
      onWebViewCreated: (webViewController) {
        print('on page created ------> $webViewController');
        wvb = webViewController;
      },
      onPageFinished: (String str) {
        const vConsole = """
          var script = document.createElement('script');
          script.setAttribute('type', 'text/javascript');
          // script.setAttribute('src', 'https://cdn.bootcss.com/vConsole/3.2.0/vconsole.min.js');
          script.setAttribute('src', '/temp-images/vconsole.min.js');
          document.getElementsByTagName('head')[0].appendChild(script);
          script.onload = function(){
            new VConsole();
          };
          """;
        wvb.evaluateJavascript(vConsole);
      },
      onWebResourceError:  (url) {
        print("""
          on page onWebResourceError ------> 
          ${url.errorCode}
          ${url.description}
          ${url.domain}
          ${url.errorType}
          ${url.failingUrl}
          """);
      },
      javascriptChannels: {
        JavascriptChannel(name: 'testFlutter', onMessageReceived:(JavascriptMessage msg) {
          print('---->测试flutter ${msg.message}<----');
        }),
        JavascriptChannel(name: 'downloadCapture', onMessageReceived:(JavascriptMessage msg) {
          print('---->开始保存图片地址为 ${msg.message}<----');
          saveImage(msg.message);
        }),
      },
    );
    // return WebView(initialUrl: 'http://m.baidu.com');
  }
}