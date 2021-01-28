import 'package:flutter/material.dart';
import '../utils/event_bus.dart';

class EventBusDemo extends StatefulWidget {
  @override
  _EventBusDemoState createState() => _EventBusDemoState();
}

class _EventBusDemoState extends State<EventBusDemo> {
  int num = 0;
  EventBus eventBus = EventBus();
  @override
  void initState() {
    super.initState();
    eventBus.on("plus", () {
      this.setState(() {
        num++;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("$num", style: TextStyle(fontSize: 40),),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.palette),
        onPressed: (){
          eventBus.emit("plus");
        },
      ),
    );
  }
}
