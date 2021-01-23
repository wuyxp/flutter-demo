import 'package:flutter/material.dart';

class HreoWY extends StatefulWidget {
  @override
  _HreoState createState() => _HreoState();
}

class _HreoState extends State<HreoWY> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepOrange,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("/hreo/detail", arguments: {
                  "id": "aa"
                });
              },
              child: Hero(
                tag: "aa",
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/aa.jpg"
                      )
                    )
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("/hreo/detail", arguments: {
                  "id": "bb"
                });
              },
              child: Hero(
                tag: "bb",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    width: 120,
                    height: 120,
                    child: Image.asset("assets/images/bb.jpg", fit: BoxFit.fitWidth,),
                  )
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("/hreo/detail", arguments: {
                  "id": "cc"
                });
              },
              child: Hero(
                tag: "cc",
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage("assets/images/cc.jpg"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}