import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/utils/notification_provider.dart';
import 'package:provider/provider.dart';

import '../utils/provider_model.dart';

class ProviderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
          create: (_) => MyModel(), lazy: false, child: _MyApp()),
    );
  }
}

class _MyApp extends StatefulWidget {
  @override
  __MyAppState createState() => __MyAppState();
}

class __MyAppState extends State<_MyApp> {
  int index;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: NotificationListener<NotificationProvider>(
          onNotification: (notification) {
            setState(() {
              index = notification.index;
            });
            return true;
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Buttons(),
              Expanded(child: _PersonList()),
              index != null ? _Detail(index) : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Buttons extends StatefulWidget {
  @override
  __ButtonsState createState() => __ButtonsState();
}

class __ButtonsState extends State<_Buttons> {
  TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(),
          ),
        ),
        Consumer(builder: (context, MyModel myModel, child) {
          return RaisedButton(
              onPressed: () {
                myModel.addPerson(PersonModel(
                    textEditingController.value.text, Random().nextInt(255)));
                textEditingController.clear();
              },
              child: Icon(Icons.add));
        }),
      ],
    );
  }
}

class _PersonList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, MyModel myModel, child) {
        return ListView.builder(
          itemCount: myModel.personList.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                NotificationProvider(index).dispatch(context);
              },
              leading: Icon(Icons.person),
              title: Text(myModel.getPerson(index).name),
              subtitle: Text(myModel.getPerson(index).age.toString()),
              trailing: GestureDetector(
                  onTap: () {
                    myModel.removePerson(myModel.getPerson(index));
                  },
                  child: Icon(Icons.delete_forever_outlined, color: Colors.red,))
            );
          },
        );
      },
    );
  }
}
class _Detail extends StatelessWidget {
  final int index;
  _Detail(this.index);
  @override
  Widget build(BuildContext context) {
    return Selector<MyModel, PersonModel>(
      selector: (context, MyModel myModel) {
        return myModel.getPerson(index);
      },
      builder: (context, PersonModel personModel, child) {
        return Card(
          child: Text(personModel.name),
        );
      },
      shouldRebuild: (oldPerson, currentPerson){
        return oldPerson.name != currentPerson.name;
      },
    );
  }
}
