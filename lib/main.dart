import 'package:flutter/material.dart';

import 'webview.dart';
import 'inputUrl.dart';
void main() {
  runApp(MaterialApp(
    title: "警务社区",
    home: Scaffold(
      body: Container(
        child: EntryWidget(),
      ),
    ),
  ));
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
