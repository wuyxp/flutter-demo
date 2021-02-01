import 'package:flutter/material.dart';

class NotificationDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NotificationListener(
          onNotification: (notification) {
            switch (notification.runtimeType) {
              case ScrollStartNotification: print("开始滚动"); break;
            }
          },
          child: ListView.builder(
            itemCount: 100,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.call),
                title: Text("$index"),
              );
            },
          ),
        ),
      ),
    );
  }
}
