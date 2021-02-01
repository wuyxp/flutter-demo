import 'package:flutter/material.dart';

import '../utils/inherited_share.dart';

class InheritedDome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _ListWidget(),
        ),
      ),
    );
  }
}

class _ListWidget extends StatefulWidget {
  @override
  __ListWidgetState createState() => __ListWidgetState();
}

class __ListWidgetState extends State<_ListWidget> {
  Map<String, dynamic> data = Map.from({
    "count": 1
  });
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ShareInherited(
      data: data,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ShowData(),
            _OperationData(),
            FlatButton(child: Text("++1"),onPressed: () {
              setState(() {
                data["count"]++;
              });
            })
          ]
      ),
    );
  }
}

class _ShowData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("${ShareInherited.of(context).data["count"] }", style: TextStyle(fontSize: 30),);
  }
}


class _OperationData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add),
      onPressed: () {
        print(context);
      },
    );
  }
}
