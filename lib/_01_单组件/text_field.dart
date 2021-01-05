import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepOrange
      ),
      home:Scaffold(
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FromDemo()
            ],
          ),
        ),
      )
    );
  }
}

class FromDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateFromDemo();
  }
}

class StateFromDemo extends State {
  String username;
  void onChange(value) {
    setState(() {
      username = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFieldDemo(onChange: (value) => this.onChange(value)),
        Container(
          width: double.infinity,
          height: 40,
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: RaisedButton.icon(
              onPressed: () {
                print(username);
              },
              color: Colors.deepOrange,
              icon: Icon(Icons.accessible_forward, color: (Colors.white)),
              label: Text("跳转到新的页面", style: TextStyle(color: Colors.white),)
          ),
        ),
      ],
    );
  }
}

class TextFieldDemo extends StatelessWidget {
  final Function onChange;
  TextFieldDemo({this.onChange});
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        icon: Icon(Icons.emoji_people),
        labelText: 'username',
        hintText: '请输入用户名',
        // border: InputBorder.none
      ),
      onChanged: (value) {
        this.onChange(value);
      }
    );
  }
}
