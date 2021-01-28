import 'package:flutter/material.dart';

class PointerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Listener(
        onPointerCancel: (event) {
          print("------>out---onPointerCancel---->");
        },
        onPointerDown: (event) {
          print("------>out---onPointerDown---->");
        },
        onPointerMove: (event) {
          print("------>out---onPointerMove---->");
        },
        onPointerSignal: (event) {
          print("------>out---onPointerSignal---->");
        },
        onPointerUp: (event) {
          print("------>out---onPointerUp---->");
        },
        child: Container(
          width: 300,
          height: 300,
          color: Colors.green,
          child: Stack(
            children: [
              Center(
                child: Listener(
                  onPointerCancel: (event) {
                    print("------>in---onPointerCancel---->");
                  },
                  onPointerDown: (event) {
                    print(event.toStringFull());
                    print("------>in---onPointerDown---->");
                  },
                  onPointerMove: (event) {
                    print("------>in---onPointerMove---->");
                  },
                  onPointerSignal: (event) {
                    print("------>in---onPointerSignal---->");
                  },
                  onPointerUp: (event) {
                    print("------>in---onPointerUp---->");
                  },
                  behavior: HitTestBehavior.opaque,
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tight(Size(150, 150)),
                    child: Center(
                      child: Text("TExt"),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Listener(
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Listener(
                  // AbsorbPointer 这个可以出发外部事件
                  // IgnorePointer 则都会禁止事件
                  child: IgnorePointer(
              // child: AbsorbPointer(
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.amber,
                      child: Listener(
                        child: Center(
                          child: Container(
                            width: 50,
                            height: 50,
                            color: Colors.lightBlue,
                          ),
                        ),
                        onPointerDown: (event) {
                          print("--ignore----inner-down-->");
                        },
                      ),
                    ),
                  ),
                  onPointerDown: (event) {
                    print("--ignore----out-down-->");
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
