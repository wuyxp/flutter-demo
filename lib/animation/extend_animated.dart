import 'package:flutter/material.dart';

class _OtherAnimated extends AnimatedWidget {
  _OtherAnimated({Key key, Animation<Offset> animation}): super(key:key, listenable: animation);
  @override
  Widget build(BuildContext context) {
    Animation<Offset> animation = listenable;
    return Positioned(
      left: animation.value.dx,
      top: animation.value.dy,
      child: Icon(Icons.translate),
    );
  }
}

class ExtendAnimated extends StatefulWidget {
  @override
  _ExtendAnimatedState createState() => _ExtendAnimatedState();
}

class _ExtendAnimatedState extends State<ExtendAnimated> with SingleTickerProviderStateMixin {
  AnimationController _animation;
  Animation<Offset> _offset;
  Animation<Color> _color;
  @override
  void initState() {
    _animation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5)
    );
    CurvedAnimation _curved = CurvedAnimation(parent: _animation, curve: Curves.elasticInOut);
    _offset = Tween<Offset>(begin: Offset(200, 200), end: Offset(200, 400)).animate(_curved);
    _color = ColorTween(begin: Colors.green, end: Colors.deepOrange).animate(_curved);
    _animation.forward();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.orange,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          _OtherAnimated(animation: _offset,),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 1.0, end: 10.0),
            duration: Duration(seconds: 4),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Icon(Icons.repeat)
              );
            }
          ),
          AnimatedBuilder(
            animation: _color,
            builder: (context, child) {
              return Container(
                child: Text("aaaa", style: TextStyle(color: _color.value),),
              );
            }
          )
        ],
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animation.dispose();
  }
}
