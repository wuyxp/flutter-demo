import 'package:flutter/material.dart';

import 'pes-jingwu-app/web_view.dart';
import 'pes-jingwu-app/input_url.dart';
void main() {
  runApp(
    MaterialApp(
      title: "警务社区",
      routes: {
        "/input": (ctx) => InputUrl(),
      },
      onGenerateRoute: (setting){
        if (setting.name == "/webview") {
          return MaterialPageRoute(
            builder: (cxt) {
              return WebViewWidget(url: setting.arguments);
            }
          );
        }
        return null;
      },
      initialRoute: '/input',
    )
  );
}
