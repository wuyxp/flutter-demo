import 'package:flutter/material.dart';

import 'web_view.dart';
import 'input_url.dart';
void main() {
  runApp(
    MaterialApp(
      title: "警务社区",
      routes: {
        "/input": (ctx) => InputUrl(),
        "/webview": (ctx) => WebViewWidget()
      },
      initialRoute: '/input',
      home: Scaffold(
        body: Container(
          child: EntryWidget(),
        ),
      ),
    )
  );
}

class EntryWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EntryState();
  }
}

class EntryState extends State {
  bool isShowWebView = false;
  String address = "aa";
  Widget getCurrentWidget () {
    if (isShowWebView) {
      return WebViewWidget(url: address);
    } else {
      return InputUrl();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: getCurrentWidget(),
    );
  }
}
