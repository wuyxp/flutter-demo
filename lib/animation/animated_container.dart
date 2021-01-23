import 'package:flutter/material.dart';

class AnimatedContainerEx extends StatefulWidget {
  @override
  _AnimatedContainerState createState() => _AnimatedContainerState();
}

class _AnimatedContainerState extends State<AnimatedContainerEx> {
  double height = 10;
  double opacity = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.repeat),
        onPressed: (){
          setState(() {
            height = 160;
            opacity = 1;
          });
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(seconds: 2),
              width: 60,
              height: height,
              color: Colors.deepOrange,
            ),
            AnimatedOpacity(
              opacity: opacity,
              duration: Duration(seconds: 3),
              child: Container(
                color: Colors.green,
                width: 120,
                height: 120,
              ),
            )
          ],
        ),
      ),
    );
  }
}
