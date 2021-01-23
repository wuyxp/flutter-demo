import 'package:flutter/material.dart';

class HreoDetail extends StatefulWidget {
  @override
  _HreoDetailState createState() => _HreoDetailState();
}

class _HreoDetailState extends State<HreoDetail> {
  @override
  Widget build(BuildContext context) {
    Map<String, String> params = ModalRoute.of(context).settings.arguments;
    String id = params["id"];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.reply),
        onPressed: (){
          Navigator.of(context).pop();
        },
      ),
      body: Container(
        color: Colors.deepOrange,
        width: double.infinity,
        height: double.infinity,
        child: Hero(
          tag: id,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/$id.jpg")
              )
            ),
          ),
        ),
      ),
    );
  }
}
