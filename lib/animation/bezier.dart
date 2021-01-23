import 'package:flutter/material.dart';

import '../utils/animation_bezier.dart';

class AnimationBezier extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _Base base = _Base();
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: base,
        ),
      ),
    );
  }
}

class _Base extends StatefulWidget {
  @override
  __BaseState createState() => __BaseState();
}

class __BaseState extends State<_Base> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Point> _scale;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5)
    );
    final Animation<double> curve = CurvedAnimation(parent: _controller, curve: Curves.elasticInOut);
    _scale = BezierTween(Point(300.0, 300.0), Point(100.0, 200.0), Point(200.0, 500.0)).animate(curve);
    _controller.addListener(() {
      this.setState(() {
      });
    });
    _controller.forward();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          color: Colors.green
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(
            left: _scale.value.x,
            top: _scale.value.y,
            child: Icon(Icons.emoji_people),
          ),
          Positioned(
            bottom: 0,
            child: Row(
              children: [
                IconButton(icon: Icon(Icons.arrow_back_ios), iconSize: 40, onPressed: (){
                  _controller.forward();
                }),
                IconButton(icon: Icon(Icons.play_circle_fill), iconSize: 40,onPressed: (){
                  if(_controller.status == AnimationStatus.forward) {
                    _controller.forward();
                  } else if (_controller.status == AnimationStatus.reverse) {
                    _controller.reverse();
                  }
                }),
                IconButton(icon: Icon(Icons.stop_outlined), iconSize: 40,onPressed: (){
                  _controller.stop();
                }),
                IconButton(icon: Icon(Icons.arrow_forward_ios), iconSize: 40,onPressed: (){
                  _controller.reverse();
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
}
