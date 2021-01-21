import 'package:flutter/material.dart';

class AA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("AA----->"),
          RaisedButton(
            onPressed: (){
            },
          )
        ],
      ),
    );
  }
}
