import 'package:flutter/material.dart';

class GestureDemo extends StatefulWidget {
  @override
  _GestureDemoState createState() => _GestureDemoState();
}

class _GestureDemoState extends State<GestureDemo> {
  Offset _offset1 = Offset(50, 50);
  Offset _offset2 = Offset(50, 100);
  Offset _offset3 = Offset(50, 150);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('----tap---');
      },
      onDoubleTap: () {
        print('-----double tap-----');
      },
      child: SafeArea(
        child: Container(
          color: Colors.deepOrange,
          child: Stack(
            children: [
              Positioned(
                left: _offset1.dx,
                top: _offset1.dy,
                child: GestureDetector(
                  onHorizontalDragUpdate: (DragUpdateDetails event){
                    setState(() {
                      _offset1 = _offset1 + event.delta;
                    });
                  },
                  child: Icon(
                    Icons.compare_arrows,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                left: _offset2.dx,
                top: _offset2.dy,
                child: GestureDetector(
                  onVerticalDragUpdate: (DragUpdateDetails event){
                    setState(() {
                      _offset2 = _offset2 + event.delta;
                    });
                  },
                  child: Icon(
                    Icons.height,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                left: _offset3.dx,
                top: _offset3.dy,
                child: GestureDetector(
                  onPanDown: (event) {},
                  onPanEnd: (event) {},
                  onPanUpdate: (DragUpdateDetails event) {
                    setState(() {
                      _offset3 = _offset3 + event.delta;
                    });
                  },
                  child: Icon(
                    Icons.add_location,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
