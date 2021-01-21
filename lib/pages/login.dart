import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: FlatButton.icon(
            onPressed: (){
              // Navigator.of(context).pushNamed('/buy', arguments: {
              //   'id': 'id-----'
              // });

              // 这样可以将当前页面在栈顶替换
              // Navigator.pushReplacementNamed(context, '/buy', arguments: {
              //   'id': 'id++++++++++++++'
              // });

              // 这样可以将当前页面在栈顶替换,只不过会有一个当前页面退出的效果
              Navigator.popAndPushNamed(context, '/buy', arguments: {
                'id': 'id====================='
              });
            },
            icon: Icon(Icons.accessible_sharp),
            label: Text("登录成功，点击再次跳转到付款页面")
          ),
        ),
      ),
    );
  }
}
