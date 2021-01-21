import 'package:flutter/material.dart';

import 'trending.dart';
import 'favorite.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home"),
      ),
      drawer: Drawer(
        child: FlatButton.icon(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.reply_outlined), label: Text("关闭左边")),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("首页中心"),
              FlatButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    fullscreenDialog: false,
                    settings: RouteSettings(
                      arguments: {
                        "abc": "Abc"
                      }
                    ),
                    builder: (context){
                      return Favorite();
                    }
                  )
                );
              }, child: Text("进入收藏页面")),
              FlatButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context){
                    return Trending();
                  }
                ));
              }, child: Text("进入热门页面")),
              RaisedButton(onPressed: (){
                Navigator.of(context).pushNamed('/favorite', arguments: {
                  "abc": "ccccccc----"
                });
              }, child: Text("命名路由-收藏"),),
              RaisedButton(onPressed: (){
                Navigator.of(context).pushNamed('/trending');
              }, child: Text("命名路由-热门"),),
              RaisedButton(onPressed: (){
                Navigator.of(context).pushNamed('/favorite/detail', arguments: {
                  "abc": "ccccccc----",
                  "id": "detail-id"
                });
              }, child: Text("命名路由-收藏-详情"),),
              RaisedButton(onPressed: (){
                Navigator.of(context).pushNamed('/404');
              }, child: Text("未找到页面"),),
              RaisedButton(onPressed: (){
                Navigator.of(context).pushNamed('/detail');
              }, child: Text("进入商品详情页面"),),
              RaisedButton(onPressed: (){
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("ttt"),
                      content: Container(
                        child: Column(
                          children: [
                            Text("chile..."),
                            FlatButton(onPressed: (){
                              Navigator.of(context).pop();
                            }, child: Text("关闭弹窗"))
                          ]
                        ),
                      ),
                    );
                  }
                );
              }, child: Text("打开模态框"),),
            ],
          ),
        ),
      ),
    );
  }
}
