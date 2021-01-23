import 'package:flutter/material.dart';
class AnimationBase extends StatelessWidget {
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
  Animation _scale;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20)
    );
    final Animation<double> curve = CurvedAnimation(parent: _controller, curve: Curves.elasticInOut);
    _scale = Tween(begin: 1.0, end: 10.0).animate(curve);
    _controller.addListener(() {
      this.setState(() {
      });
    });
    _controller.forward();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.green
          ),
          child: Transform.scale(
            scale: _scale.value,
            child: Icon(Icons.emoji_people),
          ),
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
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
}
