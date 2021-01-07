import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import 'Toast.dart';
import 'request.dart';

class WebViewWidget extends StatefulWidget{
  final String url;
  WebViewWidget({Key key, String url}): this.url = url ?? 'http://m.baidu.com', super(key: key);
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
  var dio;
  _MyAppState({this.url});
  final picker = ImagePicker();


// 上传图片
  Future _uploadImage(String path, String params) async {
    Map<String, dynamic> result = await uploadFile(path);
    result["params"] = params;
    String sResult = jsonEncode(result);
    wvb.evaluateJavascript('window.__showSelectPhotoHandle(\'${sResult}\')');
  }

  // 保存图片
  _saveImage (url) async {
    var isPer = await _requestPermissions();
    if (isPer) {
      var respones = await downloadImage(url);
      var result = await ImageGallerySaver.saveImage(Uint8List.fromList(respones.data), name: '${getRandom(15)}');
      print(result);
      String sResult = jsonEncode(result);
      print(sResult);
      wvb.evaluateJavascript('window.__showSaveImageHandle(\'${sResult}\')');
    } else {
      wvb.evaluateJavascript('window.__showSaveImageHandle("没有相册权限，请重新赋值权限")');
    }
  }

  // 打开相册
  _openPhone (String s) async {
    PickedFile image = await picker.getImage(source: ImageSource.gallery);
    if(image != null){
      print(image.path);
      _uploadImage(image.path, s);
    }
  }

  // 打开相机
  _openCamera(String s) async {
    PickedFile image = await picker.getImage(source: ImageSource.camera);
    if(image != null) {
      print(image.path);
      _uploadImage(image.path, s);
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
        dio = getDio(wvb);
      },
      onPageFinished: (String str) {
        const vConsole = """
          var script = document.createElement('script');
          script.setAttribute('type', 'text/javascript');
          script.setAttribute('src', '/vConsole/3.3.0/vconsole.min.js');
          document.getElementsByTagName('head')[0].appendChild(script);
          script.onload = function(){
            new VConsole();
          };
          """;
        wvb.evaluateJavascript(vConsole);
      },
      onWebResourceError:  (url) {
        if(url.errorType != WebResourceErrorType.hostLookup) {
          Toast.toast(context,
            msg: """
              页面访问错误，访问错误日志如下
              errorCode: ${url.errorCode}
              description: ${url.description}
              domain: ${url.domain}
              errorType: ${url.errorType}
              failingUrl: ${url.failingUrl}
            """,
            position: ToastPostion.top,
            showTime: 3000,
            onFinish: () {
              print('结束展示');
              wvb.goBack();
            }
          );
        }
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
        JavascriptChannel(name: '__f_downloadCapture', onMessageReceived:(JavascriptMessage msg) {
          print('---->开始保存图片地址为 ${msg.message}<----');
          _saveImage(msg.message);
        }),
        JavascriptChannel(name: '__f_openPhone', onMessageReceived:(JavascriptMessage msg) {
          print('---->这里我打开相册 ${msg.message}<----');
          _openPhone(msg.message);
        }),
        JavascriptChannel(name: '__f_openCamera', onMessageReceived:(JavascriptMessage msg) {
          print('---->这里我打开相机 ${msg.message}<----');
          _openCamera(msg.message);
        }),
      },
    );
    // return WebView(initialUrl: 'http://m.baidu.com');
  }
}